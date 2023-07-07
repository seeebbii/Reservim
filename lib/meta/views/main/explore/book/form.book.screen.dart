import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../../../../../components/BottomSheets/custom_bottom_sheet.dart';
import '../../../../utils/app_theme.dart';
import 'add_more_service.widget.dart';

class FormBookScreen extends StatefulWidget {
  const FormBookScreen({Key? key}) : super(key: key);

  @override
  State<FormBookScreen> createState() => _FormBookScreenState();
}

class _FormBookScreenState extends State<FormBookScreen> {
  bool checkedValue = false;
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final noteController = TextEditingController();
  int? groupValue;

  late List<int?>? selectedValue;

  @override
  void initState() {
    // PRE SELECTING GENDER VALUE
    groupValue = 1;
    context.read<AppointmentsNotifier>().bookAppointmentModel.gender = "Male";

    super.initState();
    selectedValue = context.read<ExplorePageViewNotifier>().shopDetailsModel.staffs?.map((e) => e.id ?? 0).toList();
    List<StaffName> defaultSelectedStaffIds = <StaffName>[];
    for (int i = 0;
        i <
            context
                .read<AppointmentsNotifier>()
                .bookAppointmentModel
                .service!
                .length;
        i++) {
      print(i);
      defaultSelectedStaffIds.add(StaffName(
          id: context
              .read<ExplorePageViewNotifier>()
              .shopDetailsModel
              .staffs?[0]
              .id!));
    }
    context.read<AppointmentsNotifier>().addStaffName(defaultSelectedStaffIds);
    context.read<AppointmentsNotifier>().bookAppointmentModel.homeServiceCheck =
        checkedValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppbar(title: ""),
        body: Consumer<AppointmentsNotifier>(
          builder: (ctx, notifier, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    notifier.bookAppointmentModel.service!.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                notifier.bookAppointmentModel.service?.length ??
                                    0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return _createService(
                                  notifier
                                      .bookAppointmentModel.jsonService![index],
                                  index);
                            })
                        : const SizedBox.shrink(),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.sp),
                      onTap: () {
                        // SHOW BOTTOM SHEET WITH SERVICES
                        Get.bottomSheet(
                            CustomBottomSheet(
                              widget: const AddMoreServiceWidget(),
                            ),
                            isDismissible: false,
                            enableDrag: false,
                            useRootNavigator: true,
                            isScrollControlled: false);
                      },
                      leading: const Icon(
                        Icons.control_point,
                        color: AppTheme.blackColor,
                      ),
                      title: Text(
                        "Add another service",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppTheme.blackColor),
                      ),
                      minLeadingWidth: 30.sp,
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Home service",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppTheme.blackColor),
                      ),
                      value: checkedValue,
                      checkColor: AppTheme.whiteColor,
                      activeColor: AppTheme.primaryColor,
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkedValue = newValue!;
                        });
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .homeServiceCheck = newValue.toString();
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                        child: Text(
                          "Home service charges are Rs:500",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: AppTheme.blackColor),
                        )),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                      child: Row(
                        children: [
                          Text(
                            "Address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: AppTheme.blackColor),
                          ),
                          SizedBox(
                            width: 0.05.sw,
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppTheme.subtitleLightGreyColor,
                                    width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppTheme.subtitleLightGreyColor,
                                    width: 3),
                              ),
                            ),
                            onChanged: (str) {
                              context
                                  .read<AppointmentsNotifier>()
                                  .bookAppointmentModel
                                  .homeAddress = str;
                            },
                            controller: addressController,
                            maxLength: null,
                            keyboardType: TextInputType.multiline,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Age",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: AppTheme.blackColor),
                          ),
                          SizedBox(
                            width: 0.12.sw,
                          ),
                          Container(
                            width: 0.25.sw,
                            height: 65,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: AppTheme.subtitleLightGreyColor,
                                      width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: AppTheme.subtitleLightGreyColor,
                                      width: 3),
                                ),
                              ),
                              onChanged: (str) {
                                context
                                    .read<AppointmentsNotifier>()
                                    .bookAppointmentModel
                                    .age = str;
                              },
                              controller: ageController,
                              maxLength: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: groupValue,
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value as int;
                                    });
                                    context
                                        .read<AppointmentsNotifier>()
                                        .bookAppointmentModel
                                        .gender = "Male";
                                  }),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    groupValue = 1;
                                  });
                                  context
                                      .read<AppointmentsNotifier>()
                                      .bookAppointmentModel
                                      .gender = "Male";
                                },
                                child: Text(
                                  "Male",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(color: AppTheme.blackColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: groupValue,
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value as int;
                                    });
                                    context
                                        .read<AppointmentsNotifier>()
                                        .bookAppointmentModel
                                        .gender = "Female";
                                  }),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    groupValue = 2;
                                  });
                                  context
                                      .read<AppointmentsNotifier>()
                                      .bookAppointmentModel
                                      .gender = "Female";
                                },
                                child: Text(
                                  "Female",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(color: AppTheme.blackColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Note",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: AppTheme.blackColor),
                              ),
                              Text(
                                "(Optional)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: AppTheme.subtitleLightGreyColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 0.05.sw,
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppTheme.subtitleLightGreyColor,
                                    width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppTheme.subtitleLightGreyColor,
                                    width: 3),
                              ),
                            ),
                            onChanged: (str) {
                              context
                                  .read<AppointmentsNotifier>()
                                  .bookAppointmentModel
                                  .note = str;
                            },
                            controller: noteController,
                            maxLength: null,
                            keyboardType: TextInputType.multiline,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Price: ${context.read<AppointmentsNotifier>().calculateTotalPrice(checkedValue)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: AppTheme.blackColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                            ),
                            checkedValue
                                ? Text(
                                    "Home service charges also included",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          color:
                                              AppTheme.subtitleLightGreyColor,
                                          fontSize: 12.sp,
                                        ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.1.sh,
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
                                onPressed: () {
                                  setState(() {
                                    ageController.clear();
                                    addressController.clear();
                                    noteController.clear();
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1.0.sp,
                                      color: AppTheme.blackColor),
                                  primary: AppTheme.primaryColor,
                                ),
                                child: Text(
                                  'Clear all',
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
                                          borderRadius:
                                              BorderRadius.circular(3.r))),
                                  onPressed: () {
                                    if (HiveDatabase.getValue(
                                            HiveDatabase.loginCheck) ==
                                        true) {
                                      AuthenticationNotifier authNotifier =
                                          Provider.of<AuthenticationNotifier>(
                                              context,
                                              listen: false);
                                      AppointmentsNotifier appointmentNotifier =
                                          Provider.of<AppointmentsNotifier>(
                                              context,
                                              listen: false);
                                      appointmentNotifier
                                              .bookAppointmentModel.clientName =
                                          authNotifier.currentUser.data?.name;
                                      appointmentNotifier.bookAppointmentModel
                                              .clientUserId =
                                          authNotifier.currentUser.data?.id
                                              .toString();
                                      appointmentNotifier.bookAppointmentModel
                                              .homeAddress =
                                          authNotifier
                                              .currentUser.data?.completeAddress
                                              .toString();
                                      navigationController.navigateToNamed(
                                          RouteGenerator.confirmBookScreen);
                                    } else {
                                      navigationController.navigateToNamed(
                                          RouteGenerator.loginScreen);
                                    }
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
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _createService(
    JsonService service,
    int index,
  ) {
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
                    }
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
                          Container(
                            width: 0.3.sw,
                            height: 0.07.sh,
                            child: DropdownButtonFormField(
                                iconSize: 15.sp,
                                focusColor: AppTheme.primaryColor,
                                decoration: InputDecoration(
                                  isDense: true,
                                  focusColor: AppTheme.primaryColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppTheme.primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppTheme.primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                ),
                                autofocus: false,
                                dropdownColor: AppTheme.whiteColor,
                                value: selectedValue?[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: AppTheme.blackColor,
                                      fontSize: 11.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                selectedItemBuilder: (ctx) => context
                                    .read<ExplorePageViewNotifier>()
                                    .shopDetailsModel
                                    .staffs!
                                    .map((e) => DropdownMenuItem(
                                        child: SizedBox(
                                            width: 0.15.sw,
                                            child: Text(
                                              "${e.name}",
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            )),
                                        value: e.id))
                                    .toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedValue?[index] = newValue!;
                                  });
                                  context.read<AppointmentsNotifier>().bookAppointmentModel.staffName?.elementAt(index).id = selectedValue?[index];
                                  print(context.read<AppointmentsNotifier>().bookAppointmentModel.toJson());
                                },
                                items: context
                                    .read<ExplorePageViewNotifier>()
                                    .shopDetailsModel
                                    .staffs!
                                    .map((e) => DropdownMenuItem(
                                        child: Text(
                                          "${e.name}",
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                        value: e.id))
                                    .toList()),
                          )
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
}
