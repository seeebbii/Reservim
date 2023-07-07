import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/connection.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/hive_database.dart';
import '../../../components/widgets/app_elevated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    Provider.of<ConnectionNotifier>(context, listen: false).initConnectivity();
    // Timer(const Duration(milliseconds: 3000), () => checkState());

    super.initState();
    Future.delayed(Duration.zero, (){
      checkState();
    });
  }

  void checkState() {
    FlutterNativeSplash.remove();
    // TODO :: CHECK USER STATE HERE

    // LOGGED IN ? HOME PAGE : AUTH SCREEN
    if(HiveDatabase.getValue(HiveDatabase.loginCheck) == true){
      navigationController.getOffAll(RouteGenerator.homePageRoot);
      context.read<AuthenticationNotifier>().loadUserProfile();
    }else{
      // navigationController.getOffAll(RouteGenerator.welcomeScreen);
      navigationController.getOffAll(RouteGenerator.homePageRoot);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.authBackground,
                ),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: SvgPicture.asset(Assets.appLogoText),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: 0.02.sh),
                  Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 0.08.sh),
                  AppElevatedButton(
                    onPressed: () {
                      navigationController.navigateToNamed(RouteGenerator.loginScreen);
                    },
                    buttonText: 'Sign in',
                    horizontalPadding: 12,
                    buttonColor: AppTheme.whiteColor,
                    textColor: AppTheme.blackColor,
                    textFontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: Theme.of(context).textTheme.bodyText1,
                        children: [
                          TextSpan(
                              text: ' Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: AppTheme.primaryColor),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                navigationController.navigateToNamed(RouteGenerator.signupScreen);
                              })
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
