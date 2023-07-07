import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/model/shops/user_liked_shops.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../../../../../app/constants/assets.constant.dart';
import '../../../../../app/constants/controller.constant.dart';
import '../../../../../core/notifier/explore.pageview.notifier.dart';
import '../../../../../core/notifier/homepage.notifier.dart';
import '../../../../../core/router/router_generator.dart';
import '../../../../utils/app_theme.dart';
import '../../../../utils/base_helper.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({Key? key}) : super(key: key);

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  Future<UserLikedShopsModel>? loadFavourites;

  @override
  void initState() {
    loadFavourites = context.read<HomePageNotifier>().getUserLiked();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageNotifier>(builder: (ctx, notifier, child) {
      return (context.watch<AuthenticationNotifier>().currentUser.data?.id !=
              null)
          ? FutureBuilder(
              future: loadFavourites,
              builder: (_, AsyncSnapshot<UserLikedShopsModel> snapshot) {
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
                    notifier.userLikedShopsModel.shop!.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
                        child: Text(
                          "Favorite",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Container(
                        height: 0.3.sh,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                notifier.userLikedShopsModel.shop?.length ?? 0,
                            itemBuilder: (ctx, index) {
                              UserLikedShopsModel obj =
                                  notifier.userLikedShopsModel;
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  context
                                      .read<ExplorePageViewNotifier>()
                                      .currentModel(obj.shop![index]);
                                  navigationController.navigateToNamed(
                                      RouteGenerator
                                          .recommendedServiceExploreScreen);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.sp),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Container(
                                      width: 0.6.sw,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: obj.logoPath == null ||
                                                      obj.logoPath == "null"
                                                  ? BaseHelper
                                                      .loadNetworkImageObject(
                                                          ApiPaths.defaultImage)
                                                  : BaseHelper
                                                      .loadNetworkImageObject(
                                                          ApiPaths.imageBaseUrl +
                                                              notifier
                                                                  .userLikedShopsModel
                                                                  .logoPath! +
                                                              obj.shop![index]
                                                                  .shopLogo!),
                                              fit: BoxFit.cover)),
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
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12.r))),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp,
                                                      vertical: 2.sp),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${obj.rating![index]}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    15.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                      Text(
                                                        "${obj.review![index]} reviews",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize:
                                                                    15.sp),
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
                                                      if (obj.shop![index]
                                                              .isLiked! ==
                                                          true) {
                                                        notifier
                                                            .updateFavouritesModel(
                                                                index, false);
                                                      } else {
                                                        notifier
                                                            .updateFavouritesModel(
                                                                index, true);
                                                      }
                                                      context
                                                          .read<
                                                              HomePageNotifier>()
                                                          .getUserLiked();
                                                    },
                                                    child: obj.shop?[index]
                                                                .isLiked ??
                                                            false
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color: AppTheme
                                                                .primaryColor,
                                                            size: 25.sp,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .favorite_border,
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
                                                  padding: EdgeInsets.only(
                                                      bottom: 5.sp),
                                                  child: Text(
                                                    "${obj.shop?[index].salonName}",
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1
                                                        ?.copyWith(
                                                            fontSize: 12.sp),
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "${obj.shop?[index].address}",
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1
                                                      ?.copyWith(
                                                          fontSize: 10.sp,
                                                          color: AppTheme
                                                              .blackColor),
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
                      ),
                    ],
                  );
                }
              })
          : const SizedBox.shrink();
    });
  }
}
