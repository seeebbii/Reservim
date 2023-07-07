import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/core/model/opening_closing_hours.model.dart';
import 'package:reservim/core/model/timeslot.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../utils/app_theme.dart';

class CalenderBookScreen extends StatefulWidget {
  final int durationHour;
  final int durationMinute;
  const CalenderBookScreen({
    Key? key,
    required this.durationHour,
    required this.durationMinute,
  }) : super(key: key);

  @override
  State<CalenderBookScreen> createState() => _CalenderBookScreenState();
}

class _CalenderBookScreenState extends State<CalenderBookScreen> {
  String? currentFormattedDate;
  String? startTimeSlot;
  String? endTimeSlot;
  DateTime currentDate = DateTime.now();
  OpeningClosingHours selectedOpeningClosingHour = OpeningClosingHours();
  late ScrollController controller;
  late Future<List<TimeSlotModel>> loadSlots;

  @override
  void initState() {
    selectedOpeningClosingHour = checkDay(DateTime.now().weekday);
    currentFormattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    loadSlots = context.read<AppointmentsNotifier>().shopSlots(
        selectedOpeningClosingHour.start?.first ?? "",
        selectedOpeningClosingHour.end?.first ?? "",
        currentFormattedDate!);
    super.initState();
  }

  OpeningClosingHours checkDay(int weekDay) {
    String weekDayCheck = '';

    switch (weekDay) {
      case 1:
        weekDayCheck = "Monday";
        break;
      case 2:
        weekDayCheck = "Tuesday";
        break;
      case 3:
        weekDayCheck = "Wednesday";
        break;
      case 4:
        weekDayCheck = "Thursday";
        break;
      case 5:
        weekDayCheck = "Friday";
        break;
      case 6:
        weekDayCheck = "Saturday";
        break;
      case 7:
        weekDayCheck = "Sunday";
        break;
    }
    return context
        .read<ExplorePageViewNotifier>()
        .shopModel
        .openingClosingHours!
        .firstWhere((element) => element.day == weekDayCheck);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppAppbar(title: ''),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0.01.sh,
                ),
                CalendarTimeline(
                  showYears: true,
                  initialDate: currentDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 250)),
                  onDateSelected: (DateTime? dateSelected) {
                    setState(() {
                      startTimeSlot = null;
                      currentDate = dateSelected ?? DateTime.now();
                      currentFormattedDate =
                          DateFormat("yyyy-MM-dd").format(dateSelected!);
                      selectedOpeningClosingHour =
                          checkDay(dateSelected.weekday);
                      loadSlots = context
                          .read<AppointmentsNotifier>()
                          .shopSlots(
                              selectedOpeningClosingHour.start?.first ?? "",
                              selectedOpeningClosingHour.end?.first ?? "",
                              currentFormattedDate!);
                      context
                          .read<AppointmentsNotifier>()
                          .bookAppointmentModel
                          .dateTime = currentDate;
                    });
                  },
                  leftMargin: 20,
                  monthColor: Colors.blueGrey,
                  dayColor: AppTheme.primaryColor,
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: AppTheme.primaryColor,
                  locale: 'en_ISO',
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     _createListTile("Morning", Assets.morning),
                //     _createListTile("After Noon", Assets.afterNoon),
                //     _createListTile("Evening", Assets.evening),
                //   ],
                // ),
                // SizedBox(
                //   height: 0.02.sh,
                // ),
                Consumer<AppointmentsNotifier>(
                  builder: (ctx, notifier, child) {
                    return FutureBuilder(
                      future: loadSlots,
                      builder:
                          (_, AsyncSnapshot<List<TimeSlotModel>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryColor,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.hasData &&
                            notifier.timeSlots.isEmpty) {
                          return const Center(
                            child: Text("Error occurred while fetching data"),
                          );
                        } else {
                          return Column(
                            children: [
                              GridView.builder(
                                itemCount: notifier.timeSlots.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 0.05.sw,
                                        mainAxisSpacing: 0.02.sh,
                                        childAspectRatio: 5 / 2),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  TimeSlotModel obj = notifier.timeSlots[index];
                                  if(obj.timeSlot!.contains('pm')){
                                    obj.timeSlot = obj.timeSlot!.replaceAll('pm', 'PM');
                                  }else{
                                    obj.timeSlot = obj.timeSlot!.replaceAll('am', 'AM');
                                  }
                                  // print("API SLOT: ${obj.timeSlot}");
                                  // ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}
                                  DateTime slotDate = DateFormat.jm().parse("${obj.timeSlot!}");
                                  DateTime currentSlotDate = DateTime(currentDate.year, currentDate.month, currentDate.day, slotDate.hour, slotDate.minute, slotDate.second);
                                  print("Parsed Time: ${currentSlotDate}");

                                  if(currentSlotDate.isBefore(DateTime.now())){
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8.r),
                                          color: AppTheme.subtitleLightGreyColor
                                              .withOpacity(0.1)),
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.01.sw),
                                          child: Text(
                                            "${obj.timeSlot}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                ?.copyWith(
                                                color:AppTheme.blackColor.withOpacity(0.2)),
                                          )),
                                    );
                                  }else{
                                    return InkWell(
                                      onTap: () {
                                        notifier.updateSlotsUi(index);
                                        startTimeSlot = obj.timeSlot;
                                        var splitStr = startTimeSlot?.split(':');
                                        // ADDING HOUR / MINUTES INTERVAL
                                        DateTime endTimeDate = DateTime(
                                            currentDate.year,
                                            currentDate.month,
                                            currentDate.weekday,
                                            int.parse(splitStr![0]),
                                            int.parse(splitStr[1].split(' ')[0]));
                                        endTimeDate = endTimeDate.add(Duration(
                                            hours: widget.durationHour,
                                            minutes: widget.durationMinute));
                                        // APPENDING TO STRING
                                        endTimeSlot =
                                        "${DateFormat('HH:mm').format(endTimeDate)} ${splitStr[1].split(' ')[1]}";
                                        // SAVING TIME SLOTS TO BOOKING MODEL
                                        notifier.bookAppointmentModel.startTime =
                                        [startTimeSlot!];
                                        notifier.bookAppointmentModel.endTime = [
                                          endTimeSlot!
                                        ];
                                        notifier.bookAppointmentModel.date =
                                            currentFormattedDate;

                                        log("${notifier.bookAppointmentModel.toJson()}");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8.r),
                                            color: obj.isSelected!
                                                ? AppTheme.primaryColor
                                                : AppTheme.subtitleLightGreyColor
                                                .withOpacity(0.4)),
                                        alignment: Alignment.center,
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.01.sw),
                                            child: Text(
                                              "${obj.timeSlot}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  ?.copyWith(
                                                  color: obj.isSelected!
                                                      ? AppTheme.whiteColor
                                                      : AppTheme.blackColor),
                                            )),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 0.03.sh,
                              ),
                            ],
                          );
                        }
                      },
                    );
                  },
                ),

                // const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 0.03.sh, horizontal: 0.02.sw),
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 0.05.sh,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onPrimary: AppTheme.primaryColor,
                            primary: AppTheme.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.sp, vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r))),
                        onPressed: () {
                          AppointmentsNotifier appointmentNotifier =
                              context.read<AppointmentsNotifier>();
                          if (startTimeSlot == null) {
                            BaseHelper.showSnackBar("Select time slot first");
                            return;
                          }

                          // IF THE SERVICES IS LIST IS MORE THAN 1, CALCULATE SCHEDULE ON TAP
                          if (appointmentNotifier
                                  .bookAppointmentModel.service!.length >
                              1) {
                            for (int i = 0;
                                i <
                                    appointmentNotifier.bookAppointmentModel
                                            .service!.length -
                                        1;
                                i++) {
                              String startTimeSlot = appointmentNotifier
                                  .bookAppointmentModel.endTime!.last;

                              var splitStr = startTimeSlot.split(':');

                              var currentDate = appointmentNotifier
                                  .bookAppointmentModel.date!
                                  .split('-');

                              // ADDING HOUR / MINUTES INTERVAL
                              DateTime endTimeDate = DateTime(
                                  int.parse(currentDate[0]),
                                  int.parse(currentDate[1]),
                                  int.parse(currentDate[2]),
                                  int.parse(splitStr[0]),
                                  int.parse(splitStr[1].split(' ')[0]));
                              endTimeDate = endTimeDate.add(Duration(
                                  hours: appointmentNotifier
                                      .bookAppointmentModel.durationHour![i],
                                  minutes: appointmentNotifier
                                      .bookAppointmentModel
                                      .durationMinute![i]));
                              // APPENDING TO STRING
                              String endTimeSlot =
                                  "${DateFormat('HH:mm').format(endTimeDate)} ${splitStr[1].split(' ')[1]}";

                              // // SAVING TIME SLOTS TO BOOKING MODEL
                              appointmentNotifier
                                  .bookAppointmentModel.startTime!
                                  .add(startTimeSlot);
                              appointmentNotifier.bookAppointmentModel.endTime!
                                  .add(endTimeSlot);
                              debugPrint(
                                  "${appointmentNotifier.bookAppointmentModel.toJson()}");
                            }
                          }
                          navigationController
                              .navigateToNamed(RouteGenerator.formBookScreen);
                        },
                        child: Text(
                          "Continue",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: AppTheme.whiteColor),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createListTile(String text, String iconPath) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(
          width: 0.01.sw,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: AppTheme.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
