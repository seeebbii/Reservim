import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/widgets/view_photo.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:readmore/readmore.dart';
import '../../../../../core/model/shops/review.model.dart';
import '../../../../../core/router/router_generator.dart';
import '../../../../utils/app_theme.dart';

class ExploreReviewWidget extends StatelessWidget {
  final ReviewModel review;

  const ExploreReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("${review.user?.toJson()}");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.03.sw.sp, vertical: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      review.user?.logo == null
                          ? Get.dialog(ViewPhoto(
                              galleryItems: [Assets.placeholderBg],
                              path: null,
                            ))
                          : Get.dialog(ViewPhoto(
                              galleryItems: [review.user?.logo],
                              path: ApiPaths.imageBaseUrl +
                                  "/uploads/client_images/",
                            ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: review.user?.logo == null
                          ? Image.asset(Assets.placeholderBg,
                              height: 100, width: 50)
                          : BaseHelper.loadNetworkImage(
                              ApiPaths.imageBaseUrl +
                                  "/uploads/client_images/${review.user?.logo}",
                              BoxFit.cover,
                              height: 50,
                              width: 50),
                    ),
                  ),
                  SizedBox(
                    width: 0.03.sw,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${review.user?.name}",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${review.rating}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RatingBar.builder(
                    initialRating: double.parse(review.rating.toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemSize: 22.sp,
                    itemCount: 5,
                    updateOnDrag: false,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      size: 10.sp,
                      color: AppTheme.reviewStarColor,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  SizedBox(
                    height: 0.03.sh,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onPrimary: AppTheme.primaryColor,
                            primary: AppTheme.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.sp, vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r))),
                        onPressed: () {
                          if (context
                                  .read<AuthenticationNotifier>()
                                  .currentUser
                                  .data
                                  ?.id !=
                              null) {
                            navigationController.navigateToNamedWithArg(
                                RouteGenerator.reportScreen, {
                              "shopId": context
                                  .read<ExplorePageViewNotifier>()
                                  .shopModel
                                  .id
                                  .toString(),
                              "clientId": null,
                              "reviewId": review.id.toString(),
                            });
                          } else {
                            navigationController
                                .navigateToNamed(RouteGenerator.loginScreen);
                          }
                        },
                        child: Text(
                          "Report",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 10.sp),
                        )),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          ReadMoreText(
            "${review.text}",
            trimCollapsedText: "Show More",
            trimExpandedText: "Show Less",
            trimMode: TrimMode.Line,
            trimLines: 3,
            lessStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: AppTheme.blackColor,
                  fontWeight: FontWeight.bold,
                ),
            moreStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: AppTheme.blackColor,
                  fontWeight: FontWeight.bold,
                ),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: AppTheme.subtitleLightGreyColor,
                ),
          ),
          review.picture!.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 0.01.sh,
                ),
          review.picture!.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 0.08.sh,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: review.picture!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        if (index <= 3) {
                          return InkWell(
                            onTap: () {
                              Get.dialog(ViewPhoto(
                                  galleryItems: review.picture!,
                                  path: ApiPaths.imageBaseUrl +
                                      "/uploads/reviews_picture/",
                                  currentPage: index));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.sp),
                              child: Container(
                                width: 55.sp,
                                child: BaseHelper.loadNetworkImage(
                                  ApiPaths.imageBaseUrl +
                                      "/uploads/reviews_picture/" +
                                      review.picture![index],
                                  BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        } else if (index == 4) {
                          return InkWell(
                            onTap: () {
                              Get.dialog(ViewPhoto(
                                  galleryItems: review.picture!,
                                  path: ApiPaths.imageBaseUrl +
                                      "/uploads/reviews_picture/",
                                  currentPage: index));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 55.sp,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            BaseHelper.loadNetworkImageObject(
                                          ApiPaths.imageBaseUrl +
                                              "/uploads/reviews_picture/" +
                                              review.picture![index],
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  width: 55.sp,
                                  color: AppTheme.blackColor.withOpacity(0.7),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${review.picture!.length - 4}+",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.whiteColor),
                                    ),
                                    Text(
                                      "More",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.whiteColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ),
        ],
      ),
    );
  }
}
