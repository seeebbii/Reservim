import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/BottomSheets/custom_bottom_sheet.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../app/constants/strings.constant.dart';
import '../../../../components/widgets/render_map.dart';
import '../../../../core/model/appointment/user_appointment_details.model.dart';
import '../../../../core/model/shops/services.model.dart';
import '../../../../core/model/user/appointments.model.dart';
import '../../../utils/app_theme.dart';
import 'widgets/review_widget.dart';

class AppointmentDetails extends StatefulWidget {
  final FinishedAppointment appointment;

  const AppointmentDetails({Key? key, required this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  void initState() {
    context
        .read<AppointmentsNotifier>()
        .getUserAppointmentDetails(appId: widget.appointment.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentsNotifier appointmentNotifier =
        Provider.of<AppointmentsNotifier>(context);
    return Scaffold(
      appBar: AppAppbar(
        title: "Appointment detail",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
          child: Column(
            children: [
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                "${checkStatus(widget.appointment.status!)['status']}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppTheme.blackColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                "Address: ${widget.appointment.user?.address ?? "Not specified"}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: AppTheme.blackColor),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDate(DateTime.parse(widget.appointment.date!)),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: AppTheme.blackColor),
                    ),
                    const VerticalDivider(
                      thickness: 1.5,
                      color: AppTheme.blackColor,
                    ),
                    Text(
                      formatTime(DateTime.parse(widget.appointment.date!)),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: AppTheme.blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Container(
                  height: 0.2.sh,
                  width: double.infinity,
                  // child: RenderMap(
                  //   latitude: 0.0,
                  //   longitude: 0.0,
                  // ),
                  child: RenderMap(
                    latitude: widget.appointment.user?.latitude != null &&
                            widget.appointment.user?.latitude != "null"
                        ? double.parse(
                            widget.appointment.user?.latitude.toString() ??
                                "0.0")
                        : 0.0,
                    longitude: widget.appointment.user?.longitude != null &&
                            widget.appointment.user?.longitude != "null"
                        ? double.parse(
                            widget.appointment.user?.longitude.toString() ??
                                "0.0")
                        : 0.0,
                  )),
              SizedBox(
                height: 0.01.sh,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.appointment.services?.length ?? 0,
                  itemBuilder: (_, index) {
                    Services service = widget.appointment.services![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                Assets.placeholderBg,
                                height: 50,
                                fit: BoxFit.contain,
                              )),
                          SizedBox(
                            width: 0.01.sw,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Service Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.blackColor),
                                    ),
                                    Container(
                                      width: 0.2.sw,
                                      child: Text(
                                        "${service.name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: AppTheme.blackColor),
                                      ),
                                    ),
                                    Text(
                                      "Price: Rs ${service.clientservices!.price}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.blackColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0.01.sh,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Time & Date",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.blackColor),
                                    ),
                                    Text(
                                      formatDate(DateTime.parse(
                                          widget.appointment.date!)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.blackColor),
                                    ),
                                    Text(
                                      formatTime(DateTime.parse(
                                          widget.appointment.date!)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.blackColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                width: 0.01.sw,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 0.03.sh, horizontal: 0.02.sw),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 0.05.sh,
                        child: OutlinedButton(
                          onPressed: () async {
                            var response = await ApiService.request(
                              ApiPaths.cancelUserAppointment +
                                  "${widget.appointment.id}/" +
                                  widget.appointment.userId.toString(),
                              method: RequestMethod.GET,
                            );
                            BaseHelper.showSnackBar("${response?['message']}");
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                width: 1.0.sp, color: AppTheme.blackColor),
                            primary: AppTheme.primaryColor,
                          ),
                          child: Text(
                            'Cancel',
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
                            onPressed: () {
                              Get.bottomSheet(
                                  CustomBottomSheet(
                                    widget: ReviewWidget(
                                        appointment: widget.appointment),
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
                                  .headline2
                                  ?.copyWith(color: AppTheme.whiteColor),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.03.sw,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppTheme.primaryColor,
                        primary: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.sp, vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.r))),
                    onPressed: () {
                      context
                              .read<AppointmentsNotifier>()
                              .bookAppointmentModel
                              .shopId =
                          appointmentNotifier
                              .userAppointmentDetails.appointment?.user?.id
                              .toString();
                      context.read<ExplorePageViewNotifier>().currentModel(ShopModel(
                          id: appointmentNotifier
                              .userAppointmentDetails.appointment?.user?.id,
                          salonName: appointmentNotifier.userAppointmentDetails
                              .appointment?.user?.salonName,
                          address: appointmentNotifier.userAppointmentDetails
                              .appointment?.user?.address,
                          logo: appointmentNotifier
                              .userAppointmentDetails.appointment?.user?.logo,
                          openingClosingHours: appointmentNotifier
                              .userAppointmentDetails
                              .appointment
                              ?.user
                              ?.openingClosingHours));

                      for (int i = 0;
                          i <
                              appointmentNotifier.userAppointmentDetails
                                  .appointment!.services!.length;
                          i++) {
                        context.read<AppointmentsNotifier>().addServices(
                            Service(
                                serviceId: appointmentNotifier
                                    .userAppointmentDetails
                                    .appointment
                                    ?.services![i]
                                    .id
                                    .toString(),
                                price: appointmentNotifier
                                    .userAppointmentDetails
                                    .appointment
                                    ?.services![i]
                                    .clientservices!
                                    .price
                                    .toString()),
                            JsonService(name: [
                              appointmentNotifier.userAppointmentDetails
                                  .appointment!.services![i].name
                                  .toString()
                            ], price: [
                              appointmentNotifier
                                      .userAppointmentDetails
                                      .appointment
                                      ?.services![i]
                                      .clientservices!
                                      .price ??
                                  0
                            ]));
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .durationHour!
                            .add(appointmentNotifier
                                .userAppointmentDetails
                                .appointment!
                                .services![i]
                                .clientservices!
                                .durationHour!);
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .durationMinute!
                            .add(appointmentNotifier
                                .userAppointmentDetails
                                .appointment!
                                .services![i]
                                .clientservices!
                                .durationMinute!);
                      }

                      print(context
                          .read<AppointmentsNotifier>()
                          .bookAppointmentModel
                          .durationMinute);
                      navigationController.navigateToNamed(
                          RouteGenerator.recommendedServiceExploreScreen);
                      navigationController.navigateToNamedWithArg(
                          RouteGenerator.calenderBookScreen, {
                        'durationHour': appointmentNotifier
                            .userAppointmentDetails
                            .appointment!
                            .services!
                            .first
                            .clientservices
                            ?.durationHour,
                        'durationMinute': appointmentNotifier
                            .userAppointmentDetails
                            .appointment!
                            .services!
                            .first
                            .clientservices
                            ?.durationMinute,
                      });
                    },
                    child: Text(
                      "Book again",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 12.sp),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
