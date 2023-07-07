import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../core/notifier/explore.pageview.notifier.dart';
import '../../../../utils/base_helper.dart';

class RecommendedListView extends StatefulWidget {
  const RecommendedListView({Key? key}) : super(key: key);

  @override
  State<RecommendedListView> createState() => _RecommendedListViewState();
}

class _RecommendedListViewState extends State<RecommendedListView> {
  Future<RecommendedModel>? loadRecommended;

  @override
  void initState() {
    loadRecommended = context.read<HomePageNotifier>().getRecommendedList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
          child: Text(
            "Recommended",
            style: Theme.of(context).textTheme.headline2?.copyWith(
                color: AppTheme.blackColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 0.02.sh,
        ),
        Consumer<HomePageNotifier>(builder: (ctx, notifier, child) {
          return FutureBuilder(
              future: loadRecommended,
              builder: (_, AsyncSnapshot<RecommendedModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 0.3.sh,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    notifier.recommendedModel.shop == null) {
                  return Container(
                    height: 0.3.sh,
                    child: const Center(
                      child: Text("No data uploaded"),
                    ),
                  );
                } else {
                  return Container(
                    height: 0.3.sh,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: notifier.recommendedModel.shop?.length ?? 0,
                        itemBuilder: (ctx, index) {
                          ShopModel obj =
                              notifier.recommendedModel.shop?[index] ??
                                  ShopModel();
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              context
                                  .read<ExplorePageViewNotifier>()
                                  .currentModel(obj);
                              navigationController.navigateToNamed(
                                  RouteGenerator
                                      .recommendedServiceExploreScreen);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.sp),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Container(
                                  width: 0.6.sw,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: obj.logo == null ||
                                                obj.logo == "null"
                                            ? BaseHelper.loadNetworkImageObject(
                                                ApiPaths.defaultImage)
                                            : BaseHelper.loadNetworkImageObject(
                                                ApiPaths.imageBaseUrl +
                                                    notifier.recommendedModel
                                                        .logoPath
                                                        .toString() +
                                                    obj.logo.toString()),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme
                                                    .shadowColorHomePage
                                                    .withOpacity(0.6),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(12.r))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp,
                                                  vertical: 2.sp),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    double.parse(
                                                            obj.reviewAvgRating ??
                                                                "0.0")
                                                        .toStringAsFixed(2),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 0.01.sh,
                                                  ),
                                                  Text(
                                                    "${obj.reviewCount} reviews",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 15.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.sp),
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (context
                                                          .read<
                                                              AuthenticationNotifier>()
                                                          .currentUser
                                                          .data
                                                          ?.id !=
                                                      null) {
                                                    if (obj.isLiked == true) {
                                                      notifier
                                                          .updateRecommendedModel(
                                                              index, false);
                                                    } else {
                                                      notifier
                                                          .updateRecommendedModel(
                                                              index, true);
                                                    }
                                                  } else {
                                                    navigationController
                                                        .navigateToNamed(
                                                            RouteGenerator
                                                                .loginScreen);
                                                  }

                                                },
                                                child: obj.isLiked!
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        size: 25.sp,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        size: 25.sp)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.sp,
                                                    vertical: 3.sp),
                                            dense: true,
                                            title: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5.sp),
                                              child: Text(
                                                "${obj.salonName}",
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.copyWith(fontSize: 12.sp),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${obj.address}",
                                              softWrap: false,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  ?.copyWith(
                                                      fontSize: 10.sp,
                                                      color:
                                                          AppTheme.blackColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              });
        })
      ],
    );
  }
}
