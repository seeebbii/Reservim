import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../core/model/shops/recommended.model.dart';
import '../../../../utils/app_theme.dart';
import '../../../../utils/base_helper.dart';

class ExploreRecommended extends StatefulWidget {
  const ExploreRecommended({Key? key}) : super(key: key);

  @override
  _ExploreRecommendedState createState() => _ExploreRecommendedState();
}

class _ExploreRecommendedState extends State<ExploreRecommended> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageNotifier>(builder: (ctx, notifier, child) {
      if (notifier.recommendedModel.shop == null) {
        return const SizedBox.shrink();
      } else {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifier.recommendedModel.shop?.length ?? 0,
            itemBuilder: (ctx, index) {
              ShopModel obj = notifier.recommendedModel.shop![index];
              return InkWell(
                onTap: (){
                  context.read<ExplorePageViewNotifier>().currentModel(obj);
                  navigationController.navigateToNamed(RouteGenerator.recommendedServiceExploreScreen);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.05.sw, vertical: 0.01.sh),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Column(
                      children: [
                        Container(
                          height: 0.25.sh,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: BaseHelper.loadNetworkImageObject(
                                      ApiPaths.imageBaseUrl +
                                          notifier.recommendedModel.logoPath
                                              .toString() +
                                          obj.logo.toString()),
                                  fit: BoxFit.cover)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppTheme.shadowColorHomePage
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(6.r))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 2.sp),
                                  child: Column(
                                    children: [
                                      Text(
                                        double.parse(obj.reviewAvgRating ?? "0.0")
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
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
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 0.06.sh,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppTheme.shadowColorHomePage
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8.r))),
                                child: Padding(
                                    padding: EdgeInsets.all(9.sp),
                                    child: Text(
                                      "Reservim Recommended",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                              color: AppTheme.whiteColor,
                                              fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: AppTheme.selectedNavBarBackgroundColor,
                          padding: EdgeInsets.symmetric(horizontal: 0.sp),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5.sp, vertical: 3.sp),
                                dense: true,
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 5.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 0.8.sw,
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
                                      GestureDetector(
                                          onTap: () {
                                            if (context
                                                    .read<
                                                        AuthenticationNotifier>()
                                                    .currentUser
                                                    .data
                                                    ?.id !=
                                                null) {
                                              if (obj.isLiked == true) {
                                                notifier.updateRecommendedModel(
                                                    index, false);
                                              } else {
                                                notifier.updateRecommendedModel(
                                                    index, true);
                                              }
                                            } else {
                                              navigationController
                                                  .navigateToNamed(
                                                      RouteGenerator.loginScreen);
                                            }
                                          },
                                          child: obj.isLiked!
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: AppTheme.primaryColor,
                                                  size: 25.sp,
                                                )
                                              : Icon(Icons.favorite_border,
                                                  color: AppTheme.primaryColor,
                                                  size: 25.sp)),
                                    ],
                                  ),
                                ),
                                subtitle: Text(
                                  "${obj.address}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                          fontSize: 10.sp,
                                          color: AppTheme.whiteColor),
                                ),
                              ),
                              _buildAppDivider(),
                              obj.shopServiceForValid!.isEmpty
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0.1.sh),
                                      child: Text(
                                        "No Services available",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(
                                                fontSize: 10.sp,
                                                color: AppTheme.whiteColor),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          obj.shopServiceForValid!.length >= 3
                                              ? 3
                                              : 1,
                                      itemBuilder: (_, index) {
                                        ShopServiceForValid pack =
                                            obj.shopServiceForValid![index];
                                        return ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5.sp),
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${pack.defaultService!.name}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1
                                                      ?.copyWith(
                                                          fontSize: 10.sp,
                                                          color: AppTheme
                                                              .whiteColor),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Rs ${pack.price}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              fontSize: 10.sp,
                                                              color: AppTheme
                                                                  .whiteColor),
                                                    ),
                                                    Text(
                                                      pack.durationHour != 0
                                                          ? pack.durationMinute !=
                                                                  0
                                                              ? " ${pack.durationHour}h ${pack.durationMinute}min"
                                                              : " ${pack.durationHour}h"
                                                          : "${pack.durationMinute}min",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              fontSize: 10.sp,
                                                              color: AppTheme
                                                                  .whiteColor),
                                                    ),
                                                    SizedBox(
                                                      width: 5.sp,
                                                    ),
                                                    SizedBox(
                                                      height: 0.03.sh,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              onPrimary: AppTheme
                                                                  .primaryColor,
                                                              primary: AppTheme
                                                                  .primaryColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15.sp,
                                                                      vertical:
                                                                          0),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.r))),
                                                          onPressed: () {
                                                            AuthenticationNotifier
                                                                authNotifier =
                                                                Provider.of<
                                                                        AuthenticationNotifier>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            context
                                                                    .read<
                                                                        AppointmentsNotifier>()
                                                                    .bookAppointmentModel
                                                                    .shopId =
                                                                pack.shopId
                                                                    .toString();
                                                            context
                                                                .read<
                                                                    AppointmentsNotifier>()
                                                                .addServices(
                                                                    Service(
                                                                        serviceId: pack
                                                                            .serviceId
                                                                            .toString(),
                                                                        price: pack
                                                                            .price
                                                                            .toString()),
                                                                    JsonService(
                                                                        name: [
                                                                          pack.defaultService!
                                                                              .name
                                                                              .toString()
                                                                        ],
                                                                        price: [
                                                                          pack.price!
                                                                        ]));
                                                            context
                                                                .read<
                                                                    ExplorePageViewNotifier>()
                                                                .currentModel(
                                                                    obj);
                                                            navigationController
                                                                .navigateToNamed(
                                                                    RouteGenerator
                                                                        .recommendedServiceExploreScreen);
                                                            navigationController
                                                                .navigateToNamedWithArg(
                                                                    RouteGenerator
                                                                        .calenderBookScreen,
                                                                    {
                                                                  'durationHour':
                                                                      pack.durationHour,
                                                                  'durationMinute':
                                                                      pack.durationMinute,
                                                                });
                                                          },
                                                          child: Text(
                                                            "Book",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        10.sp),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return _buildAppDivider();
                                      }),
                              _buildAppDivider(),
                              SizedBox(height: 0.015.sh),
                              SizedBox(
                                height: 0.03.sh,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        onPrimary: AppTheme.primaryColor,
                                        primary: AppTheme.primaryColor,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.sp, vertical: 0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.r))),
                                    onPressed: () {
                                      context.read<ExplorePageViewNotifier>().currentModel(obj);
                                      navigationController.navigateToNamed(RouteGenerator.recommendedServiceExploreScreen);
                                    },
                                    child: Text(
                                      "View all services",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(fontSize: 10.sp),
                                    )),
                              ),
                              SizedBox(height: 0.012.sh),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    });
  }

  Widget _buildAppDivider() {
    return Padding(
        padding: EdgeInsets.only(left: 5.sp),
        child: AppDivider(
          thickness: 1.5,
          dividerColor: AppTheme.dividerColor,
        ));
  }
}
