import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:reservim/components/widgets/render_map.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/opening_closing_hours.model.dart';
import 'package:reservim/core/model/shops/shop_details.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../components/dialog/custom_dialogs.dart';
import '../../../../utils/app_theme.dart';
import '../widgets/pageview_category_widget.dart';

class DetailsPageViewScreen extends StatefulWidget {
  const DetailsPageViewScreen({Key? key}) : super(key: key);

  @override
  State<DetailsPageViewScreen> createState() => _DetailsPageViewScreenState();
}

class _DetailsPageViewScreenState extends State<DetailsPageViewScreen> {
  final textEditingController = TextEditingController();

  String formatShopHours(List<String> start, List<String> end) {
    String formattedTime = '';
    for (var time in start) {
      formattedTime += time + " ";
    }
    formattedTime += "to";

    for (var time in end) {
      formattedTime += " " + time;
    }

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExplorePageViewNotifier>(builder: (ctx, notifier, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.sp),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
              padding: EdgeInsets.only(bottom: 3.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ExplorePageViewNotifier>().onPageChange(0);
                      context
                              .read<AppointmentsNotifier>()
                              .bookAppointmentModel =
                          BookAppointmentModel(
                              service: [],
                              jsonService: [],
                              staffName: [],
                              startTime: [],
                              endTime: [],
                              durationHour: [],
                              durationMinute: []);

                      navigationController.goBack();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: 0.055.sh,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: _bookYourServicesFormField())),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.sp, vertical: 3.5.sp),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.phone,
                            color: AppTheme.whiteColor,
                            size: 18.sp,
                          ),
                          onPressed: () => BaseHelper.openDialPad(phoneNumber),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.03.sh,
              ),
              const PageViewCategoryWidget(),
              SizedBox(
                height: 0.02.sh,
              ),
              // MAP HERE
              Container(
                  height: 0.2.sh,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: RenderMap(
                    latitude: notifier.shopModel.latitude != "null"
                        ? double.parse(notifier.shopModel.latitude ?? "0.0")
                        : 0.0,
                    longitude: notifier.shopModel.longitude != "null"
                        ? double.parse(notifier.shopModel.longitude ?? "0.0")
                        : 0.0,
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                color: AppTheme.screenBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                      child: Text(
                        "Staff",
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    AppDivider(
                      dividerColor: AppTheme.primaryColor,
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Container(
                      height: 0.18.sh,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              notifier.shopDetailsModel.staffs?.length ?? 0,
                          itemBuilder: (_, index) {
                            Staffs obj =
                                notifier.shopDetailsModel.staffs![index];
                            return Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 0.015.sw),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      child: Image.asset(
                                        // obj.image!,
                                        Assets.placeholderBg,
                                        height: 60,
                                        fit: BoxFit.contain,
                                      )),
                                  SizedBox(
                                    height: 0.01.sh,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 0.2.sw,
                                    child: Text(
                                      '${obj.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: AppTheme.blackColor,
                                              overflow: TextOverflow.fade),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                      child: Text(
                        "Contact and business hours",
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    AppDivider(
                      dividerColor: AppTheme.primaryColor,
                      thickness: 1.5,
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      leading: SvgPicture.asset(
                        Assets.mobileIcon,
                        height: 25,
                      ),
                      title: Text(
                        "$phoneNumber",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: AppTheme.blackColor,
                            ),
                      ),
                      trailing: SizedBox(
                        height: 0.03.sh,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary: AppTheme.primaryColor,
                                primary: AppTheme.primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r))),
                            onPressed: () => BaseHelper.openDialPad(
                                phoneNumber),
                            child: Text(
                              "Call",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 14.sp),
                            )),
                      ),
                    ),
                    AppDivider(
                      dividerColor: AppTheme.primaryColor,
                      thickness: 1.5,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notifier.shopDetailsModel.amenities?[0]
                                .openingClosingHours?.length ??
                            0,
                        itemBuilder: (_, index) {
                          OpeningClosingHours obj = notifier.shopDetailsModel
                              .amenities![0].openingClosingHours![index];
                          return ListTile(
                            title: Text(
                              "${obj.day}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: AppTheme.blackColor),
                            ),
                            trailing: Container(
                              width: 0.4.sw,
                              child: Text(
                                formatShopHours(obj.start!, obj.end!),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: AppTheme.blackColor),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Text(
                  "Social media and share",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppTheme.blackColor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: AppDivider(
                  dividerColor: AppTheme.primaryColor,
                  thickness: 1.5,
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        BaseHelper.launchUrl(
                            '${notifier.shopModel.instagramLink}');
                      },
                      child: SvgPicture.asset(
                        Assets.instaIcon,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 0.01.sh,
                    ),
                    InkWell(
                      onTap: () {
                        BaseHelper.launchUrl(
                            '${notifier.shopModel.facebookLink}');
                      },
                      child: SvgPicture.asset(
                        Assets.fbIcon,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 0.01.sh,
                    ),
                    InkWell(
                      onTap: () {
                        BaseHelper.launchUrl(
                            '${notifier.shopModel.websiteLink}');
                      },
                      child: SvgPicture.asset(
                        Assets.wwwIcon,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 0.01.sh,
                    ),
                    InkWell(
                      onTap: () {
                        Share.share('${notifier.shopModel.websiteLink}',
                            subject: "${notifier.shopModel.salonName}");
                      },
                      child: SvgPicture.asset(
                        Assets.shareIcon,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: SizedBox(
                  height: 0.03.sh,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppTheme.primaryColor,
                          primary: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.sp, vertical: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r))),
                      onPressed: () {
                        navigationController.navigateToNamedWithArg(
                            RouteGenerator.reportScreen, {
                          "shopId": notifier.shopModel.id.toString(),
                          "clientId": null,
                          "reviewId": null,
                        });
                      },
                      child: Text(
                        "Report",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 14.sp),
                      )),
                ),
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Text(
                  "Health and Safety rules",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notifier.shopDetailsModel.healthSafetyRule?[0]
                          .healthSafetyRule?.length ??
                      0,
                  itemBuilder: (_, index) {
                    HealthSafetyRule obj = notifier.shopDetailsModel
                        .healthSafetyRule![0].healthSafetyRule![index];
                    return ListTile(
                      minLeadingWidth: 0,
                      title: Text(
                        "${obj.name}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.blackColor, fontSize: 15.sp),
                      ),
                      leading: SvgPicture.asset(
                        Assets.verifiedIcon,
                        height: 25,
                      ),
                    );
                  }),
              SizedBox(
                height: 0.01.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Text(
                  "Amenities",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notifier
                          .shopDetailsModel.amenities?[0].amenitie?.length ??
                      0,
                  itemBuilder: (_, index) {
                    Amenitie obj = notifier
                        .shopDetailsModel.amenities![0].amenitie![index];
                    return ListTile(
                      minLeadingWidth: 0,
                      title: Text(
                        "${obj.name}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.blackColor, fontSize: 15.sp),
                      ),
                      leading: SvgPicture.network(
                        ApiPaths.imageBaseUrl +
                            notifier.shopDetailsModel.amenityImagePath
                                .toString() +
                            obj.pic.toString(),
                        height: 25,
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }

  Widget _bookYourServicesFormField() {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).unfocus();
        CustomDialogs.displaySearchDialog(context);
      },
      controller: textEditingController,
      obscureText: false,
      decoration: InputDecoration(
        fillColor: AppTheme.whiteColor,
        filled: true,
        isDense: true,
        hintText: "Book your services...",
        hintStyle: Theme.of(context)
            .inputDecorationTheme
            .hintStyle
            ?.copyWith(color: AppTheme.blackColor.withOpacity(0.6)),
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.blackColor.withOpacity(0.6),
          size: 30.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.blackColor.withOpacity(0.6),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.hintColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50.0.r),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
