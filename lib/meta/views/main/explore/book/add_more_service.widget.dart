
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/shop_details.model.dart';
import '../../../../../app/constants/controller.constant.dart';
import '../../../../../components/widgets/app_divider.dart';
import '../../../../../core/notifier/appointments.notifier.dart';
import '../../../../../core/notifier/authentication.notifier.dart';
import '../../../../../core/notifier/explore.pageview.notifier.dart';
import '../../../../../core/router/router_generator.dart';
import '../../../../utils/app_theme.dart';

class AddMoreServiceWidget extends StatefulWidget {
  const AddMoreServiceWidget({Key? key}) : super(key: key);

  @override
  State<AddMoreServiceWidget> createState() => _AddMoreServiceWidgetState();
}

class _AddMoreServiceWidgetState extends State<AddMoreServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExplorePageViewNotifier>(builder: (context, exploreNotifier, child){
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      navigationController.goBack();
                    },
                    splashRadius: 1,
                    icon: const Icon(Icons.highlight_off)),
              ],
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.read<ExplorePageViewNotifier>().shopDetailsModel.topServices?.length ?? 0,
                itemBuilder: (_, index) {
                  TopServices topService = context.read<ExplorePageViewNotifier>().shopDetailsModel.topServices![index];
                  if (index == 0) {
                    return Column(
                      children: [
                        AppDivider(
                          thickness: 1.5,
                          dividerColor: AppTheme.dividerColor,
                        ),
                        _createListTileForTopServices(topService)
                      ],
                    );
                  } else {
                    return _createListTileForTopServices(topService);
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return AppDivider(
                    thickness: 1.5,
                    dividerColor: AppTheme.dividerColor,
                  );
                }),
            AppDivider(
              thickness: 1.5,
              dividerColor: AppTheme.dividerColor,
            ),
            ...exploreNotifier.groupedServicesModel.map(
                  (e) =>
                  ExpansionTile(
                    iconColor: AppTheme.blackColor,
                    collapsedIconColor: AppTheme.blackColor,
                    tilePadding: EdgeInsets.zero,
                    initiallyExpanded: true,
                    title: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${e.categoryName}",
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.sp),
                      ),
                    ),
                    children:e.services!
                        .asMap()
                        .entries
                        .map((e) => Column(
                      children: [
                        AppDivider(
                          thickness: 1.5,
                          dividerColor: AppTheme.dividerColor,
                        ),
                        _createListTileForAllServices(e.value),
                      ],
                    ))
                        .toList(),
                  ),
            ).toList(),

            AppDivider(
              thickness: 1.5,
              dividerColor: AppTheme.dividerColor,
            ),
          ],
        ),
      );
    });
  }

  Widget _createListTileForTopServices(TopServices pack) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.sp),
      title: Row(
        children: [
          Container(
            width: 0.2.sh,
            margin: EdgeInsets.only(right: 0.03.sw),
            child: Text(
              "${pack.defaultService!.name}",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(
                  fontSize: 13.sp,
                  color: AppTheme.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs ${pack.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(
                      fontSize: 12.sp,
                      color: AppTheme.blackColor),
                ),
                Text(
                  pack.durationHour != 0 ? pack.durationMinute != 0 ? " ${pack.durationHour}h ${pack.durationMinute}min" : " ${pack.durationHour}h" : "${pack.durationMinute}min",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(
                      fontSize: 12.sp,
                      color: AppTheme.blackColor),
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
                          primary:
                          AppTheme.primaryColor,
                          padding:
                          EdgeInsets.symmetric(
                              horizontal: 15.sp,
                              vertical: 0),
                          shape:
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  3.r))),
                      onPressed: () {
                        AppointmentsNotifier appointmentNotifier = Provider.of<AppointmentsNotifier>(context, listen: false);
                        ExplorePageViewNotifier exploreNotifier = Provider.of<ExplorePageViewNotifier>(context, listen: false);
                        appointmentNotifier.addServices(Service(serviceId: pack.serviceId.toString(), price: pack.price.toString()), JsonService(name: [pack.defaultService!.name.toString()] , price: [pack.price!]));
                        appointmentNotifier.bookAppointmentModel.staffName!.add(StaffName(id: exploreNotifier.shopDetailsModel.staffs?[0].id));


                        // notifier.updateSlotsUi(index);
                        String startTimeSlot = appointmentNotifier.bookAppointmentModel.endTime!.last;
                        var splitStr = startTimeSlot.split(':');

                       var currentDate = appointmentNotifier.bookAppointmentModel.date!.split('-');

                        // ADDING HOUR / MINUTES INTERVAL
                        DateTime endTimeDate = DateTime(int.parse(currentDate[0]), int.parse(currentDate[1]), int.parse(currentDate[2]),int.parse( splitStr[0]), int.parse(splitStr[1].split(' ')[0]));
                        endTimeDate = endTimeDate.add(Duration(hours: pack.durationHour!, minutes: pack.durationMinute!));

                        // APPENDING TO STRING
                        String endTimeSlot = "${DateFormat('HH:mm').format(endTimeDate)} ${splitStr[1].split(' ')[1]}";

                        // SAVING TIME SLOTS TO BOOKING MODEL
                        appointmentNotifier.bookAppointmentModel.startTime!.add(startTimeSlot);
                        appointmentNotifier.bookAppointmentModel.endTime!.add(endTimeSlot);

                        debugPrint("${appointmentNotifier.bookAppointmentModel.toJson()}");

                        navigationController.goBack();
                      },
                      child: Text(
                        "Book",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                            fontSize: 10.sp),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createListTileForAllServices(AllServices pack) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.sp),
      title: Row(
        children: [
          Container(
            width: 0.2.sh,
            margin: EdgeInsets.only(right: 0.03.sw),
            child: Text(
              "${pack.defaultService!.name}",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(
                  fontSize: 13.sp,
                  color: AppTheme.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs ${pack.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(
                      fontSize: 12.sp,
                      color: AppTheme.blackColor),
                ),
                Text(
                  pack.durationHour != 0 ? pack.durationMinute != 0 ? " ${pack.durationHour}h ${pack.durationMinute}min" : " ${pack.durationHour}h" : "${pack.durationMinute}min",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(
                      fontSize: 12.sp,
                      color: AppTheme.blackColor),
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
                          primary:
                          AppTheme.primaryColor,
                          padding:
                          EdgeInsets.symmetric(
                              horizontal: 15.sp,
                              vertical: 0),
                          shape:
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  3.r))),
                      onPressed: () {
                        AppointmentsNotifier appointmentNotifier = Provider.of<AppointmentsNotifier>(context, listen: false);
                        ExplorePageViewNotifier exploreNotifier = Provider.of<ExplorePageViewNotifier>(context, listen: false);
                        appointmentNotifier.addServices(Service(serviceId: pack.serviceId.toString(), price: pack.price.toString()), JsonService(name: [pack.defaultService!.name.toString()] , price: [pack.price!]));
                        appointmentNotifier.bookAppointmentModel.staffName!.add(StaffName(id: exploreNotifier.shopDetailsModel.staffs?[0].id));


                        // notifier.updateSlotsUi(index);
                        String startTimeSlot = appointmentNotifier.bookAppointmentModel.endTime!.last;
                        var splitStr = startTimeSlot.split(':');

                        var currentDate = appointmentNotifier.bookAppointmentModel.date!.split('-');

                        // ADDING HOUR / MINUTES INTERVAL
                        DateTime endTimeDate = DateTime(int.parse(currentDate[0]), int.parse(currentDate[1]), int.parse(currentDate[2]),int.parse( splitStr[0]), int.parse(splitStr[1].split(' ')[0]));
                        endTimeDate = endTimeDate.add(Duration(hours: pack.durationHour!, minutes: pack.durationMinute!));

                        // APPENDING TO STRING
                        String endTimeSlot = "${DateFormat('HH:mm').format(endTimeDate)} ${splitStr[1].split(' ')[1]}";

                        // SAVING TIME SLOTS TO BOOKING MODEL
                        appointmentNotifier.bookAppointmentModel.startTime!.add(startTimeSlot);
                        appointmentNotifier.bookAppointmentModel.endTime!.add(endTimeSlot);

                        debugPrint("${appointmentNotifier.bookAppointmentModel.toJson()}");

                        navigationController.goBack();
                      },
                      child: Text(
                        "Book",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                            fontSize: 10.sp),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
