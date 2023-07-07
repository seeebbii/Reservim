import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/components/widgets/app_elevated_button.dart';
import 'package:reservim/components/widgets/view_photo.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/utils/hive_database.dart';
import 'package:reservim/meta/views/main/profile/widgets/option_list_tile.dart';

import '../../../../app/constants/controller.constant.dart';

class ProfileNavBarScreen extends StatefulWidget {
  const ProfileNavBarScreen({Key? key}) : super(key: key);

  @override
  State<ProfileNavBarScreen> createState() => _ProfileNavBarScreenState();
}

class _ProfileNavBarScreenState extends State<ProfileNavBarScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.screenBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.08.sh,
              ),
              context.watch<AuthenticationNotifier>().currentUser.data?.id !=
                      null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                context
                                            .read<AuthenticationNotifier>()
                                            .currentUser
                                            .data
                                            ?.logo ==
                                        null
                                    ? Get.dialog(ViewPhoto(
                                        galleryItems: [Assets.placeholderBg],
                                        path: null,
                                      ))
                                    : Get.dialog(ViewPhoto(
                                        galleryItems: [
                                          context
                                              .read<AuthenticationNotifier>()
                                              .currentUser
                                              .data
                                              ?.logo
                                        ],
                                        path: ApiPaths.imageBaseUrl +
                                            "${context.read<AuthenticationNotifier>().currentUser.logoPath}",
                                      ));
                              },
                              child: context
                                          .watch<AuthenticationNotifier>()
                                          .currentUser
                                          .data
                                          ?.logo ==
                                      null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage(Assets.placeholderBg))
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          BaseHelper.loadNetworkImageObject(
                                        "${ApiPaths.imageBaseUrl}${context.watch<AuthenticationNotifier>().currentUser.logoPath}${context.watch<AuthenticationNotifier>().currentUser.data?.logo}",
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: showAlertDialog,
                                child: Container(
                                  height: 23,
                                  width: 23,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Colors.grey,
                                    size: 12.sp,
                                  ),
                                  decoration: const BoxDecoration(
                                      color: AppTheme.screenBackgroundColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        Text(
                          "${context.watch<AuthenticationNotifier>().currentUser.data?.name}",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                                  color: AppTheme.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp),
                        ),
                        SizedBox(height: 3.sp),
                        Text(
                          "${context.watch<AuthenticationNotifier>().currentUser.data?.phone}",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                                  color: AppTheme.unSelectedCategoryColor,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 11.sp),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              context.watch<AuthenticationNotifier>().currentUser.data?.id !=
                      null
                  ? SizedBox(
                      height: 0.05.sh,
                    )
                  : SizedBox(height: 0.01.sh),
              context.watch<AuthenticationNotifier>().currentUser.data?.id !=
                      null
                  ? OptionListTile(
                      onTap: () {
                        navigationController
                            .navigateToNamed(RouteGenerator.accountsScreen);
                      },
                      title: 'Account Settings',
                    )
                  : const SizedBox.shrink(),
              context.watch<AuthenticationNotifier>().currentUser.data?.id !=
                      null
                  ? OptionListTile(
                      onTap: () {
                        print(HiveDatabase.getValue(HiveDatabase.authToken));
                        navigationController
                            .navigateToNamed(RouteGenerator.reviewsScreen);
                      },
                      title: 'Reviews',
                    )
                  : const SizedBox.shrink(),
              context.watch<AuthenticationNotifier>().currentUser.data?.id !=
                      null
                  ? OptionListTile(
                      onTap: () {
                        navigationController
                            .navigateToNamed(RouteGenerator.profilePayment);
                      },
                      title: 'Payments',
                    )
                  : const SizedBox.shrink(),
              OptionListTile(
                onTap: () {
                  navigationController
                      .navigateToNamed(RouteGenerator.termsOfService);
                },
                title: 'Terms of service',
              ),
              OptionListTile(
                onTap: () {
                  navigationController
                      .navigateToNamed(RouteGenerator.privacyPolicy);
                },
                title: 'Privacy policy',
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              context.watch<AuthenticationNotifier>().currentUser.data?.id !=
                      null
                  ? SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary: AppTheme.primaryColor,
                                primary: AppTheme.primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r))),
                            onPressed: () {
                              context.read<AuthenticationNotifier>().logout();
                            },
                            child: Text(
                              "Logout",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 12.sp),
                            )),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary: AppTheme.primaryColor,
                                primary: AppTheme.primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r))),
                            onPressed: () {
                              navigationController
                                  .navigateToNamed(RouteGenerator.loginScreen);
                            },
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 12.sp),
                            )),
                      ),
                    )
            ],
          ),
        ));
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Select your source",
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
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            context
                                .read<AuthenticationNotifier>()
                                .updateUserProfileLogo(
                                    File(image.path),
                                    context
                                        .read<AuthenticationNotifier>()
                                        .currentUser
                                        .data!
                                        .id!);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0.sp, color: AppTheme.blackColor),
                          primary: AppTheme.primaryColor,
                        ),
                        child: Text(
                          'Camera',
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
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              context
                                  .read<AuthenticationNotifier>()
                                  .updateUserProfileLogo(
                                      File(image.path),
                                      context
                                          .read<AuthenticationNotifier>()
                                          .currentUser
                                          .data!
                                          .id!);
                            }
                          },
                          child: Text(
                            "Gallery",
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
