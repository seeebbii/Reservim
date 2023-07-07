import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:reservim/components/widgets/app_elevated_button.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String phoneNumber;
  String verificationId;
  ForgotPasswordScreen({Key? key, required this.phoneNumber, required this.verificationId}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final otpController = OtpFieldController();

  Timer? _timer;
  int _totalTimer = 60;
  bool showResendButton = false;
  bool verified = false;
  String finalPin = '';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_totalTimer == 0) {
          _timer?.cancel();
          setState(() {
            // timer.cancel();
            showResendButton = true;
          });
        } else {
          setState(() {
            _totalTimer--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.2.sh,
            ),
            Text(
              'An OTP has been sent to your mobile number please verify it below',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppTheme.blackColor),
            ),
            SizedBox(
              height: 0.1.sh,
            ),
        OTPTextField(
            controller: otpController,
            length: 6,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 50,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 0,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppTheme.blackColor),
            onChanged: (pin) {
              finalPin = pin;
              if(pin.length == 6){
                setState(() {
                  verified = true;
                });
              }else{
                setState(() {
                  verified = false;
                });
              }
            },
            onCompleted: (pin) {
              finalPin = pin;
            }),
            SizedBox(
              height: 0.1.sh,
            ),
            AppElevatedButton(
                horizontalPadding: 0.2.sw,
                onPressed: verified ? (){
                  context.read<AuthenticationNotifier>().verifyOtp(context, otpController.toString(), widget.verificationId, widget.phoneNumber);
                } : ()=>null,
                buttonText: "Submit",
                textColor: AppTheme.whiteColor,
                buttonColor: verified ? AppTheme.primaryColor : AppTheme.subtitleLightGreyColor,
                textFontWeight: FontWeight.w600,
                fontSize: 13.sp),
            SizedBox(height: 0.05.sh,),
            Text(
              '$_totalTimer',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppTheme.blackColor, fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0.08.sh,),
            RichText(
              text: TextSpan(
                  text: 'Didn\'t received otp?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: AppTheme.blackColor,  fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: ' Resend',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: showResendButton ? AppTheme.primaryColor : AppTheme.unSelectedNavBarItemColor, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          if(showResendButton){
                            setState(() {
                              _totalTimer = 60;
                              startTimer();
                              showResendButton = false;
                            });
                            setState(() {
                              otpController.clear();
                            });
                            context.read<AuthenticationNotifier>().verifyPhoneNo(context, widget.phoneNumber, isFromOtpPage: true);
                          }
                          })
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
