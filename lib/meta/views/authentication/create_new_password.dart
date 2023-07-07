import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/assets.constant.dart';
import '../../../app/constants/controller.constant.dart';
import '../../../components/widgets/app_elevated_button.dart';
import '../../../components/widgets/app_textform_field.dart';
import '../../../core/notifier/authentication.notifier.dart';
import '../../../core/router/router_generator.dart';
import '../../utils/app_theme.dart';

class CreateNewPassword extends StatefulWidget {
  bool? isFromProfile = false;
  CreateNewPassword({Key? key, this.isFromProfile}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final previousPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool togglePassword = true;
  bool toggleConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  bool pressed = false;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // TODO :: REQUEST CALL

      setState(() {
        pressed = true;
      });

      bool success = await context.read<AuthenticationNotifier>().resetPassword(previousPasswordController.text.trim(), newPasswordController.text.trim());



      setState(() {
        pressed = false;
      });


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
              child: Text("Create new password",
                  style: Theme.of(context).textTheme.headline1)),
          Column(
            children: [
              const Spacer(),
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
                        _buildPassword(),
                        SizedBox(
                          height: 0.06.sh,
                        ),
                        _buildConfirmPassword(),
                        SizedBox(
                          height: 0.05.sh,
                        ),
                        AppElevatedButton(
                          onPressed: !pressed ? _trySubmit : () => {},
                          buttonText: 'Reset',
                          horizontalPadding: 12,
                          buttonColor:!pressed ?  AppTheme.primaryColor : AppTheme.subtitleLightGreyColor,
                          textColor: AppTheme.whiteColor,
                          textFontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                        !widget.isFromProfile! ? _buildSignUp() : const SizedBox.shrink(),
                      ],
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

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 15.sp),
          child: Text(
            "Previous Password",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        AppTextFormField(
          hintText: "",
          controller: previousPasswordController,
          obSecureText: togglePassword,
          validator: (str) {
            if (str == '' || str == null) {
              return "Required*";
            }
            if(str.toString().length < 8){
              return "The password must be at least 8 characters";
            }
            return null;
          },
          suffixIcon: togglePassword
              ? IconButton(
            icon: const Icon(Icons.visibility_off),
            color: AppTheme.primaryColor,
            onPressed: () =>
                setState(() => togglePassword = !togglePassword),
          )
              : IconButton(
            icon: const Icon(Icons.visibility),
            color: AppTheme.primaryColor,
            onPressed: () =>
                setState(() => togglePassword = !togglePassword),
          ),
          action: TextInputAction.done,
          keyType: TextInputType.text,
        )
      ],
    );
  }

  Widget _buildConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 15.sp),
          child: Text(
            "New Password",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        AppTextFormField(
          hintText: "",
          controller: newPasswordController,
          obSecureText: toggleConfirmPassword,
          validator: (str) {
            if (str == '' || str == null) {
              return "Required*";
            }
            if(str.toString().length < 8){
              return "The password must be at least 8 characters";
            }
            if(str == previousPasswordController.text){
              return "Previous password is same";
            }
            return null;
          },
          suffixIcon: toggleConfirmPassword
              ? IconButton(
            icon: const Icon(Icons.visibility_off),
            color: AppTheme.primaryColor,
            onPressed: () =>
                setState(() => toggleConfirmPassword = !toggleConfirmPassword),
          )
              : IconButton(
            icon: const Icon(Icons.visibility),
            color: AppTheme.primaryColor,
            onPressed: () =>
                setState(() => toggleConfirmPassword = !toggleConfirmPassword),
          ),
          action: TextInputAction.done,
          keyType: TextInputType.text,
        )
      ],
    );
  }

  Widget _buildSignUp() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
                text: 'Already have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppTheme.blackColor),
                children: [
                  TextSpan(
                      text: ' Sign in',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppTheme.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigationController.goBack();
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
}
