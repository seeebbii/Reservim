import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/BottomSheets/custom_bottom_sheet.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:reservim/components/widgets/render_map.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/views/main/profile/widgets/account_settings_widget.dart';
import 'package:reservim/meta/views/main/profile/widgets/select_city_widget.dart';

class AccountSettingsProfileScreen extends StatefulWidget {
  const AccountSettingsProfileScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsProfileScreen> createState() =>
      _AccountSettingsProfileScreenState();
}

class _AccountSettingsProfileScreenState
    extends State<AccountSettingsProfileScreen> {
  bool notifications = false;

  int genderIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppAppbar(
        title: "Account settings",
      ),
      body: SingleChildScrollView(
        child: Consumer<AuthenticationNotifier>(builder: (ctx, authNotifier, child){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.02.sh,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Account details",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(color: AppTheme.blackColor),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "Name",
                trailing: Text(
                  "${authNotifier.currentUser.data?.name}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppTheme.subtitleLightGreyColor, fontSize: 14.sp),
                ),
                onTap: () => showAlertDialog("name", authNotifier.currentUser.data?.name ?? ""),
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "Email",
                trailing: Text(
                  "Change",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppTheme.subtitleLightGreyColor, fontSize: 14.sp),
                ),
                onTap: () => showAlertDialog("email", authNotifier.currentUser.data?.email ?? ""),
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "Phone Number",
                trailing: Text(
                  "${authNotifier.currentUser.data?.phone}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppTheme.subtitleLightGreyColor, fontSize: 14.sp),
                ),
                onTap: () => showAlertDialog("phone", authNotifier.currentUser.data?.phone ?? ""),
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "Change Password",
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  navigationController
                      .navigateToNamedWithArg(RouteGenerator.createNewPassword, {'isFromProfile': true});
                },
              ),
              _buildDivider(),
              SizedBox(
                height: 0.1.sh,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal:0.08.sw),
                  child: Text(
                    "Show me services for",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                  )),
              SizedBox(
                height: 0.02.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(color: AppTheme.blackColor)),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              genderIndex = 1;
                            });
                            authNotifier.updateUserProfile({
                              "show_service_for" : genderIndex
                            });
                          },
                          child: Container(
                            decoration: genderIndex == 1 ? BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(5.r)
                            ) : const BoxDecoration(),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric( vertical: 0.015.sh, horizontal: 0.015.sh),
                            child: Text(
                              'Men',
                              style: Theme.of(context).textTheme.headline2?.copyWith(
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              genderIndex = 2;
                            });
                            authNotifier.updateUserProfile({
                            "show_service_for" : genderIndex
                            });
                          },
                          child: Container(
                            decoration: genderIndex == 2 ? BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(5.r)
                            ) : const BoxDecoration(),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 0.015.sh, horizontal: 0.015.sh),
                            child: Text(
                              'Women',
                              style: Theme.of(context).textTheme.headline2?.copyWith(
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              genderIndex = 3;
                            });
                            authNotifier.updateUserProfile({
                            "show_service_for" : genderIndex
                            });
                          },
                          child: Container(
                            decoration: genderIndex == 3 ? BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(5.r)
                            ) : const BoxDecoration(),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 0.015.sh, horizontal: 0.015.sh),
                            child: Text(
                              'Both',
                              style: Theme.of(context).textTheme.headline2?.copyWith(
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0.08.sh,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: Text(
                    "Change Address",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                  )),
              SizedBox(
                height: 0.02.sh,
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "City",
                trailing: IconButton(onPressed: null, icon: Icon(Icons.arrow_drop_down),),
                onTap: () {
                  Get.bottomSheet(CustomBottomSheet(widget: SelectCityWidget(selectedCity: context.read<HomePageNotifier>().selectedCity, allCities: context.read<HomePageNotifier>().citiesModel,)),
                      isDismissible: false,
                      enableDrag: false,
                      useRootNavigator: true,
                      isScrollControlled: false);
                },
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "City address",
                trailing: Text(
                  "Change",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppTheme.subtitleLightGreyColor, fontSize: 14.sp),
                ),
                onTap: () => showAlertDialog("address", authNotifier.currentUser.data?.address ?? ""),
              ),
              _buildDivider(),
              SizedBox(
                height: 0.05.sh,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: Text(
                    "Map Location",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                  )),
              SizedBox(
                height: 0.02.sh,
              ),
              // MAP HERE
              Container(
                  height: 0.2.sh,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: RenderMap(
                    latitude: authNotifier.currentUser.data?.latitude != "null"
                        ? double.parse(authNotifier.currentUser.data?.latitude ?? "0.0")
                        : 0.0,
                    longitude: authNotifier.currentUser.data?.longitude != "null"
                        ? double.parse(authNotifier.currentUser.data?.longitude ?? "0.0")
                        : 0.0,
                  )),
              SizedBox(
                height: 0.02.sh,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: Text(
                    "Receive notification from us? Notify by me",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold, color: AppTheme.blackColor),
                  )),
              SizedBox(
                height: 0.02.sh,
              ),
              _buildDivider(),
              AccountSettingsWidget(
                title: "Email",
                trailing: CupertinoSwitch(
                  activeColor: AppTheme.primaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                  value: notifications,
                ),
                onTap: () {
                  setState(() {
                    notifications = !notifications;
                  });
                },
              ),
              _buildDivider(),
              SizedBox(
                height: 0.02.sh,
              ),
            ],
          );
        })
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
        ),
        child: AppDivider(thickness: 1.5,));
  }

  void showAlertDialog(String key, String text){
    showDialog(context: context, builder: (ctx) {
      final controller = TextEditingController(text: text);
      return AlertDialog(
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Your $key",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: AppTheme.primaryColor, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: AppTheme.primaryColor, width: 3),
            ),
          ),
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
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 1.0.sp,
                          color: AppTheme.blackColor),
                      primary: AppTheme.primaryColor,
                    ),
                    child: Text(
                      'Cancel',
                      style: Theme
                          .of(context)
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
                              borderRadius: BorderRadius.circular(
                                  3.r))),
                      onPressed: () async {
                        if(controller.text.trim().isEmpty){
                          BaseHelper.showSnackBar("Cannot be empty");
                        }else{
                          var formData = {
                            key : controller.text,
                          };
                          bool response = await context.read<AuthenticationNotifier>().updateUserProfile(formData);
                          if(response){
                            navigationController.goBack();
                            BaseHelper.showSnackBar("Profile updated");
                          }
                        }
                      },
                      child: Text(
                        "Update",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(
                            color: AppTheme.whiteColor),
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
