import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/model/user/appointments.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../../../app/constants/strings.constant.dart';
import '../../../../../components/BottomSheets/custom_bottom_sheet.dart';
import 'review_widget.dart';

class AppointmentsListView extends StatefulWidget {
  const AppointmentsListView({Key? key}) : super(key: key);

  @override
  State<AppointmentsListView> createState() => _AppointmentsListViewState();
}

class _AppointmentsListViewState extends State<AppointmentsListView> {
  Future<AppointmentsModel>? loadAppointments;

  @override
  void initState() {
    loadAppointments =
        context.read<AppointmentsNotifier>().getUserAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsNotifier>(builder: (ctx, notifier, child) {
      return FutureBuilder(
          future: loadAppointments,
          builder: (_, AsyncSnapshot<AppointmentsModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                notifier.appointmentsModel.finishedAppointment == null) {
              return const Center(
                child: Text("No appointments yet"),
              );
            } else {
              return ListView.builder(
                  itemCount:
                      notifier.appointmentsModel.finishedAppointment?.length ??
                          0,
                  itemBuilder: (ctx, index) {
                    FinishedAppointment obj = notifier
                            .appointmentsModel.finishedAppointment?[index] ??
                        FinishedAppointment();
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 4.sp),
                      child: Card(
                          elevation: 5,
                          color: AppTheme.appointmentsCardColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.red,
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 15.sp,
                                          right: 2.sp,
                                          top: 25.sp,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              formatMonth(DateTime.parse(
                                                  obj.date ??
                                                      DateTime.now()
                                                          .toIso8601String())),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.copyWith(
                                                      fontSize: 13.sp,
                                                      color:
                                                          AppTheme.blackColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 0.01.sw,
                                            ),
                                            Text(
                                              formatDay(DateTime.parse(
                                                  obj.date ??
                                                      DateTime.now()
                                                          .toIso8601String())),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.copyWith(
                                                      fontSize: 18.sp,
                                                      color:
                                                          AppTheme.blackColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 0.01.sw,
                                            ),
                                            Text(
                                              formatTime(DateTime.parse(
                                                  obj.date ??
                                                      DateTime.now()
                                                          .toIso8601String())),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.copyWith(
                                                      fontSize: 13.sp,
                                                      color: AppTheme.blackColor
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.sp, vertical: 20.sp),
                                        child: VerticalDivider(
                                          indent: 0.013.sh,
                                          endIndent: 0.013.sh,
                                          thickness: 1.2.sp,
                                          color: AppTheme.blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 0.015.sw,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.sp, vertical: 25.sp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Your appointments",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.copyWith(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppTheme.blackColor),
                                            ),
                                            SizedBox(
                                              height: 0.02.sw,
                                            ),
                                            Container(
                                              width: 0.35.sw,
                                              child: Text(
                                                "${obj.user?.salonName}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .blackColor),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.02.sw,
                                            ),
                                            Container(
                                              width: 0.35.sw,
                                              child: Text(
                                                "${obj.services?.map((e) => e.name)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    ?.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .blackColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0.02.sh,
                                            horizontal: 10.sp),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: checkStatus(
                                                    obj.status!)['color'],
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7.0.sp,
                                                    vertical: 1.0.sp),
                                                child: Text(
                                                  '${checkStatus(obj.status!)['status']}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(
                                                        color:
                                                            AppTheme.whiteColor,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: 5.sp, right: 10.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 0.035.sh,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              onPrimary: AppTheme.primaryColor,
                                              primary: AppTheme.primaryColor,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.sp,
                                                  vertical: 0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.r))),
                                          onPressed: () {
                                            navigationController
                                                .navigateToNamedWithArg(
                                                    RouteGenerator
                                                        .appointmentDetails,
                                                    {'appointmentModel': obj});
                                          },
                                          child: Text(
                                            "View details",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(fontSize: 10.sp),
                                          )),
                                    ),
                                    SizedBox(width: 0.02.sw),
                                    SizedBox(
                                      height: 0.035.sh,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              onPrimary: AppTheme.blackColor,
                                              primary: AppTheme.blackColor,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.sp,
                                                  vertical: 0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.r))),
                                          onPressed: () {
                                            Get.bottomSheet(
                                                CustomBottomSheet(
                                                  widget: ReviewWidget(
                                                      appointment: obj),
                                                ),
                                                isDismissible: false,
                                                enableDrag: false,
                                                useRootNavigator: true,
                                                isScrollControlled: true);
                                          },
                                          child: Text(
                                            "Add review",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(fontSize: 10.sp),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  });
            }
          });
    });
  }
}
