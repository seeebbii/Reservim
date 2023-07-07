import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/core/model/shops/special_offers.model.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/model/shops/recommended.model.dart';
import '../../../../../core/notifier/explore.pageview.notifier.dart';
import '../../../../../core/router/router_generator.dart';

class SpecialOffersListView extends StatefulWidget {
  const SpecialOffersListView({Key? key}) : super(key: key);

  @override
  State<SpecialOffersListView> createState() => _SpecialOffersListViewState();
}

class _SpecialOffersListViewState extends State<SpecialOffersListView> {
  Future<SpecialOffersModel>? loadSpecialOffers;

  @override
  void initState() {
    loadSpecialOffers = context.read<HomePageNotifier>().getSpecialOffersList();
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
            "Special Offers",
            style: Theme.of(context).textTheme.headline2?.copyWith(
                color: AppTheme.blackColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 0.02.sh,
        ),
        Consumer<HomePageNotifier>(builder: (ctx, notifier, child) {
          return FutureBuilder(
              future: loadSpecialOffers,
              builder: (_, AsyncSnapshot<SpecialOffersModel> snapshot) {
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
                    notifier.specialOffersModel.shops == null) {
                  return Container(
                    height: 0.3.sh,
                    child: const Center(
                      child: Text("No offers yet"),
                    ),
                  );
                } else {
                  return Container(
                    height: 0.3.sh,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            notifier.specialOffersModel.shops?.length ?? 0,
                        itemBuilder: (ctx, index) {
                          ShopModel obj =
                              notifier.specialOffersModel.shops?[index] ??
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
                              print(ApiPaths.imageBaseUrl +
                                  notifier.specialOffersModel.logoPath! +
                                  obj.shopLogo!);
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
                                                    notifier.specialOffersModel
                                                        .logoPath! +
                                                    obj.shopLogo!),
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
                                                          .updateSpecialOffers(
                                                              index, false);
                                                    } else {
                                                      notifier
                                                          .updateSpecialOffers(
                                                              index, true);
                                                    }
                                                  } else {
                                                    navigationController
                                                        .navigateToNamed(
                                                            RouteGenerator
                                                                .loginScreen);
                                                  }
                                                  context
                                                      .read<HomePageNotifier>()
                                                      .getUserLiked();
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
                                              "${obj.completeAddress}",
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
