import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../core/router/router_generator.dart';
import '../../../../utils/app_theme.dart';

class ConfirmBookScreen extends StatefulWidget {
  const ConfirmBookScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmBookScreen> createState() => _ConfirmBookScreenState();
}

class _ConfirmBookScreenState extends State<ConfirmBookScreen> {
  final noteController = TextEditingController();

  bool homeCheckVar = false;
  bool pressed = false;
  @override
  void initState() {
    super.initState();
    if (context
            .read<AppointmentsNotifier>()
            .bookAppointmentModel
            .homeServiceCheck ==
        "true") {
      homeCheckVar = true;
    } else {
      homeCheckVar = false;
    }
  }

  void _cashOnDelivery() async {
    EasyLoading.show(status: 'loading...');

    setState(() {
      pressed = true;
    });

    context.read<AppointmentsNotifier>().bookAppointmentModel.userId =
        context.read<AppointmentsNotifier>().bookAppointmentModel.shopId;

    log("${context.read<AppointmentsNotifier>().bookAppointmentModel.toJson()}");

    bool success = await context
        .read<AppointmentsNotifier>()
        .bookAppointmentCashOnDelivery();

    if (success) {
      navigationController.getOffAll(RouteGenerator.homePageRoot);
      BaseHelper.showSnackBar("Appointment Created Successfully");
    } else {
      BaseHelper.showSnackBar("Error creating appointment");
    }

    setState(() {
      pressed = false;
    });
    EasyLoading.dismiss();
  }

  void _payByCard() async {
    setState(() {
      pressed = true;
    });

    context.read<AppointmentsNotifier>().bookAppointmentModel.userId =
        context.read<AuthenticationNotifier>().currentUser.data!.id.toString();

    bool success =
        await context.read<AppointmentsNotifier>().bookAppointmentPayByCard();

    if (success) {
      // NOTHING
    } else {
      BaseHelper.showSnackBar("Error creating appointment");
    }

    setState(() {
      pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: "Confirm detail",
        bgColor: AppTheme.appointmentsCardColor,
      ),
      body: SingleChildScrollView(child: Consumer<AppointmentsNotifier>(
        builder: (context, notifier, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppTheme.appointmentsCardColor,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(0.9.sw, 100.0))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            '${formatWeekDay(notifier.bookAppointmentModel.dateTime!)}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: AppTheme.blackColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                            )),
                        SizedBox(width: 0.03.sw,),
                        Text(
                          "Rs, ${notifier.bookAppointmentModel.totalAmount!}",
                          style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: AppTheme.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Text(
                        '${formatDate(notifier.bookAppointmentModel.dateTime!)}, ${notifier.bookAppointmentModel.startTime?.first}-${notifier.bookAppointmentModel.endTime?.first}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: AppTheme.blackColor,
                            )),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(18.sp),
                  decoration: BoxDecoration(
                      color: AppTheme.appointmentsCardColor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Text(
                    "${context.read<ExplorePageViewNotifier>().shopDetailsModel.shop!.salonName}",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blackColor),
                  ),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                )),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 3.sp),
                  child: ListView.builder(
                      itemCount:
                          notifier.bookAppointmentModel.service?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return _createService(
                            notifier.bookAppointmentModel.jsonService![index],
                            index);
                      }),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Text(
                  "Leave a note (optional)",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(color: AppTheme.blackColor),
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: TextField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.subtitleLightGreyColor, width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.subtitleLightGreyColor, width: 3),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (str) {
                    context
                        .read<AppointmentsNotifier>()
                        .bookAppointmentModel
                        .homeServiceNote = str;
                  },
                  controller: noteController,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Terms of services",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 0.01.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: !pressed
                              ? AppTheme.primaryColor
                              : AppTheme.subtitleLightGreyColor,
                          primary: !pressed
                              ? AppTheme.primaryColor
                              : AppTheme.subtitleLightGreyColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.sp, vertical: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r))),
                      onPressed: !pressed ? showAlertDialog : () => {},
                      child: Text(
                        "Confirm",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 12.sp),
                      )),
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
            ],
          );
        },
      )),
    );
  }

  Widget _createService(JsonService service, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.02.sh),
      decoration: BoxDecoration(
          color: AppTheme.appointmentsCardColor,
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    AppointmentsNotifier notifier =
                        Provider.of<AppointmentsNotifier>(context,
                            listen: false);
                    context.read<AppointmentsNotifier>().removeService(index);
                    if (notifier.bookAppointEmpty()) {
                      navigationController.goBack();
                      navigationController.goBack();
                      navigationController.goBack();
                    }
                    notifier.calculateTotalPrice(homeCheckVar);
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.02.sw, vertical: 3.sp),
                      child: Icon(
                        Icons.highlight_off,
                        size: 15.sp,
                      )))
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 0.03.sw, right: 0.03.sw, bottom: 0.02.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1} - ${service.name!.first}",
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(color: AppTheme.blackColor),
                      ),
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      Row(
                        children: [
                          // SizedBox(
                          //   width: 0.05.sw,
                          // ),
                          Text(
                            "Staff id: ${context.read<AppointmentsNotifier>().bookAppointmentModel.staffName?[index].id}",
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: AppTheme.blackColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rs ${service.price?.first}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.blackColor, fontSize: 11.sp),
                      ),
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      Text(
                        "${context.read<AppointmentsNotifier>().bookAppointmentModel.startTime?[index]}-${context.read<AppointmentsNotifier>().bookAppointmentModel.endTime?[index]}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.blackColor, fontSize: 10.sp),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Choose your payment method",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: AppTheme.blackColor),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 0.05.sh,
                      child: OutlinedButton(
                        onPressed: () async {
                          navigationController.goBack();
                          _cashOnDelivery();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0.sp, color: AppTheme.blackColor),
                          primary: AppTheme.primaryColor,
                        ),
                        child: Text(
                          'COD',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: AppTheme.blackColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.03.sw,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 0.05.sh,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: AppTheme.primaryColor,
                              primary: AppTheme.primaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.sp, vertical: 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r))),
                          onPressed: () async {
                            navigationController.goBack();
                            _payByCard();
                          },
                          child: Text(
                            "Pay Now",
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: AppTheme.whiteColor),
                          )),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
