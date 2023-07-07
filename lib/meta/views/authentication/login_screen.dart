import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/components/widgets/app_textform_field.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../app/constants/assets.constant.dart';
import '../../../app/constants/controller.constant.dart';
import '../../../app/constants/strings.constant.dart';
import '../../../components/widgets/app_elevated_button.dart';
import '../../../core/router/router_generator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool toggleObSecure = true;
  final _formKey = GlobalKey<FormState>();
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((duration) {
    //   showSheet(context);
    // });
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // TODO :: REQUEST CALL
      EasyLoading.show(status: 'loading...');

      setState(() {
        pressed = true;
      });

      bool success = await context
          .read<AuthenticationNotifier>()
          .login(emailController.text.trim(), passwordController.text.trim());

      if (success) {
        navigationController.goBack();
        // navigationController.getOffAll(RouteGenerator.homePageRoot);
      }

      setState(() {
        pressed = false;
      });
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            Assets.authBackground,
            fit: BoxFit.cover,
            height: 1.sh,
            width: 1.sw,
          ),
          Positioned(
              top: 0.15.sh,
              left: 0.03.sw,
              child: Text("Sign in",
                  style: Theme.of(context).textTheme.headline1)),
          Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0.1.sh,
                          ),
                          _buildEmailWidget(),
                          SizedBox(
                            height: 0.06.sh,
                          ),
                          _buildPassword(),
                          SizedBox(
                            height: 0.05.sh,
                          ),
                          AppElevatedButton(
                            onPressed: !pressed ? _trySubmit : () => {},
                            buttonText: 'Sign in',
                            horizontalPadding: 12,
                            buttonColor: !pressed
                                ? AppTheme.primaryColor
                                : AppTheme.subtitleLightGreyColor,
                            textColor: AppTheme.whiteColor,
                            textFontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          GestureDetector(
                            onTap: () => navigationController.navigateToNamed(
                                RouteGenerator.enterPhoneNumberScreen),
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: AppTheme.blackColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 0.22.sh,
                          ),
                          _buildSignUp(),
                          SizedBox(
                            height: 0.22.sh,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 15.sp),
          child: Text(
            "Email/Phonenumber",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        AppTextFormField(
          hintText: "",
          controller: emailController,
          obSecureText: false,
          validator: (str) {
            if (str == '' || str == null) {
              return "Required*";
            }
            if (double.tryParse(str) != null) {
              if (str.toString().length < 11) {
                return "Invalid number";
              }
              if (str.toString().length > 11) {
                return "Invalid number";
              }
              return null;
            }
            if (!emailValidate.hasMatch(str)) {
              return "Invalid email address";
            }
            return null;
          },
          action: TextInputAction.next,
          keyType: TextInputType.text,
        )
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 15.sp),
          child: Text(
            "Password",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        AppTextFormField(
          hintText: "",
          controller: passwordController,
          obSecureText: toggleObSecure,
          validator: (str) {
            if (str == '' || str == null) {
              return "Required*";
            }
            if (str.toString().length < 8) {
              return "The password must be at least 8 characters";
            }
            return null;
          },
          suffixIcon: toggleObSecure
              ? IconButton(
                  icon: const Icon(Icons.visibility_off),
                  color: AppTheme.primaryColor,
                  onPressed: () =>
                      setState(() => toggleObSecure = !toggleObSecure),
                )
              : IconButton(
                  icon: const Icon(Icons.visibility),
                  color: AppTheme.primaryColor,
                  onPressed: () =>
                      setState(() => toggleObSecure = !toggleObSecure),
                ),
          action: TextInputAction.done,
          keyType: TextInputType.text,
        )
      ],
    );
  }

  Widget _buildSignUp() {
    return RichText(
      text: TextSpan(
          text: 'Don\'t have an account?',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: AppTheme.blackColor),
          children: [
            TextSpan(
                text: ' Sign up',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppTheme.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    navigationController
                        .navigateToNamed(RouteGenerator.signupScreen);
                  })
          ]),
    );
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
                text: 'Don\'t have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppTheme.blackColor),
                children: [
                  TextSpan(
                      text: ' Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppTheme.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigationController
                              .navigateToNamed(RouteGenerator.signupScreen);
                        })
                ]),
          ),
          SizedBox(
            height: 0.02.sh,
          )
        ],
      ),
    );
  }

  void showSheet(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 0,
        barrierColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        context: ctx,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              navigationController.goBack();
              navigationController.goBack();
              return false;
            },
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(ctx).size.height * 0.75,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        // height: 1.sh,
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 0.1.sh,
                              ),
                              _buildEmailWidget(),
                              SizedBox(
                                height: 0.06.sh,
                              ),
                              _buildPassword(),
                              SizedBox(
                                height: 0.05.sh,
                              ),
                              AppElevatedButton(
                                onPressed: _trySubmit,
                                buttonText: 'Sign in',
                                horizontalPadding: 12,
                                buttonColor: AppTheme.primaryColor,
                                textColor: AppTheme.whiteColor,
                                textFontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    navigationController.navigateToNamed(
                                        RouteGenerator.forgotPasswordScreen),
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: AppTheme.blackColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              _buildSignUp(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
