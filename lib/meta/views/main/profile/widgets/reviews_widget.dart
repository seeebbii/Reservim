import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/shops/review.model.dart';
import 'package:reservim/core/model/shops/reviews.model.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../../app/constants/strings.constant.dart';
import '../../../../../components/widgets/view_photo.dart';
import '../../../../utils/app_theme.dart';

class ReviewsWidget extends StatelessWidget {
  final ReviewModel review;
  final String path;
  const ReviewsWidget({Key? key, required this.review, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: InkWell(
              onTap: () {
                context.read<AuthenticationNotifier>().currentUser.data?.logo ==
                        null
                    ? Get.dialog(ViewPhoto(
                        galleryItems: [Assets.placeholderBg],
                        path: null,
                      ))
                    : Get.dialog(ViewPhoto(
                        galleryItems: [
                          context
                              .read<AuthenticationNotifier>()
                              .currentUser
                              .data
                              ?.logo
                        ],
                        path: ApiPaths.imageBaseUrl +
                            "${context.read<AuthenticationNotifier>().currentUser.logoPath}",
                      ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: context
                            .watch<AuthenticationNotifier>()
                            .currentUser
                            .data
                            ?.logo ==
                        null
                    ? Image.asset(Assets.placeholderBg, height: 100, width: 50)
                    : BaseHelper.loadNetworkImage(
                        ApiPaths.imageBaseUrl +
                            "${context.read<AuthenticationNotifier>().currentUser.logoPath}${context.read<AuthenticationNotifier>().currentUser.data?.logo}",
                        BoxFit.cover,
                        height: 100,
                        width: 50),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${review.appointment?.clientName}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 6.sp,
                    ),
                    Text(
                      "${review.rating}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "${formatDatePayments(DateTime.parse(review.appointment?.startAppointment ?? DateTime.now().toIso8601String()))} / ${formatTime(DateTime.parse(review.appointment?.startAppointment ?? DateTime.now().toIso8601String()))}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppTheme.blackColor,
                      ),
                ),
              ],
            ),
            subtitle: Text(
              "${review.text}",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppTheme.subtitleLightGreyColor,
                  ),
            ),
          ),
          review.picture!.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 0.02.sh,
                ),
          review.picture!.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: SizedBox(
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
                                    path: ApiPaths.imageBaseUrl + path,
                                    currentPage: index));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                child: Container(
                                    width: 55.sp,
                                    child: BaseHelper.loadNetworkImage(
                                        ApiPaths.imageBaseUrl +
                                            path +
                                            review.picture![index],
                                        BoxFit.cover)),
                              ),
                            );
                          } else if (index == 4) {
                            return InkWell(
                              onTap: () {
                                Get.dialog(ViewPhoto(
                                    galleryItems: review.picture!,
                                    path: ApiPaths.imageBaseUrl + path,
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
                                                path +
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
                ),
        ],
      ),
    );
  }
}
