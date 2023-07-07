import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/views/main/home/widgets/off_deals_details.dart';

import '../../../../../components/BottomSheets/custom_bottom_sheet.dart';
import '../../../../utils/app_theme.dart';

class DealsListView extends StatefulWidget {
  List<DealsModel> dealsModel;
  Axis? axis;
  bool? shrinkWrap;
  DealsListView(
      {Key? key,
      required this.dealsModel,
      this.axis = Axis.horizontal,
      this.shrinkWrap = false})
      : super(key: key);

  @override
  _DealsListViewState createState() => _DealsListViewState();
}

class _DealsListViewState extends State<DealsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.21.sh,
      child: ListView.builder(
          shrinkWrap: widget.shrinkWrap!,
          scrollDirection: widget.axis!,
          itemCount: widget.dealsModel.length,
          itemBuilder: (ctx, index) {
            DealsModel obj = widget.dealsModel[index];
            return Container(
              margin: EdgeInsets.only(left: 0.025.sw, right: 0.01.sw),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: AppTheme.getRandomLinearGradient()),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.005.sw),
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.65.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                obj.name ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2.sp,
                              ),
                              Text(
                                "${obj.discount}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35.sp),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "OFF",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            obj.user?.salonName == "null"
                                ? ""
                                : '${obj.user?.salonName}',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(
                                    color: AppTheme.blackColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Text(
                            obj.user?.address == "null"
                                ? ""
                                : '${obj.user?.address}',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Text(
                            "Duration: ${obj.durationHour} Hour ${obj.durationMinute} Minute",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Text(
                            "Expiry: ${formatDate(DateTime.parse(obj.expiryDate ?? DateTime.now().toIso8601String()))}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Rs: ${obj.discountPrice ?? 0}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2.sp,
                            ),
                            Text(
                              "Rs: ${obj.totalPrice ?? 0}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        AppTheme.declineNotificationColor,
                                    decorationThickness: 2.5,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 0.04.sh,
                              width: 0.22.sw,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      onPrimary: AppTheme.blackColor,
                                      primary: AppTheme.blackColor,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.sp, vertical: 0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r))),
                                  onPressed: () {
                                    Get.bottomSheet(
                                        CustomBottomSheet(
                                          widget: OffDealsDetails(
                                            obj: obj,
                                          ),
                                        ),
                                        isDismissible: false,
                                        enableDrag: false,
                                        useRootNavigator: true,
                                        isScrollControlled: false);
                                  },
                                  child: Text(
                                    "View Detail",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(color: AppTheme.whiteColor),
                                  )),
                            ),
                            SizedBox(
                              height: 0.01.sh,
                            ),
                            SizedBox(
                              height: 0.04.sh,
                              width: 0.22.sw,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      onPrimary: AppTheme.blackColor,
                                      primary: AppTheme.blackColor,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.sp, vertical: 0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r))),
                                  onPressed: () {
                                    context
                                        .read<AppointmentsNotifier>()
                                        .bookAppointmentModel
                                        .shopId = obj.shopId.toString();
                                    context
                                        .read<ExplorePageViewNotifier>()
                                        .currentModel(ShopModel(
                                            id: obj.user?.id,
                                            salonName: obj.user?.salonName,
                                            address: obj.user?.address,
                                            logo: obj.user?.logo,
                                            openingClosingHours:
                                                obj.user?.openingClosingHours));

                                    for (int i = 0;
                                        i < obj.services!.length;
                                        i++) {
                                      context
                                          .read<AppointmentsNotifier>()
                                          .addServices(
                                              Service(
                                                  serviceId: obj.services![i].id
                                                      .toString(),
                                                  price: obj.discountPrice
                                                      .toString()),
                                              JsonService(name: [
                                                obj.services![i].name.toString()
                                              ], price: [
                                                obj.discountPrice ?? 0
                                              ]));
                                      context
                                          .read<AppointmentsNotifier>()
                                          .bookAppointmentModel
                                          .durationHour!
                                          .add(obj.services![i].shopService!
                                              .durationHour!);
                                      context
                                          .read<AppointmentsNotifier>()
                                          .bookAppointmentModel
                                          .durationMinute!
                                          .add(obj.services![i].shopService!
                                              .durationMinute!);
                                    }

                                    print(context
                                        .read<AppointmentsNotifier>()
                                        .bookAppointmentModel
                                        .durationMinute);
                                    navigationController.navigateToNamed(
                                        RouteGenerator
                                            .recommendedServiceExploreScreen);
                                    navigationController.navigateToNamedWithArg(
                                        RouteGenerator.calenderBookScreen, {
                                      'durationHour': obj.services!.first
                                          .shopService?.durationHour,
                                      'durationMinute': obj.services!.first
                                          .shopService?.durationMinute,
                                    });
                                  },
                                  child: Text(
                                    "Book",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(color: AppTheme.whiteColor),
                                  )),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}