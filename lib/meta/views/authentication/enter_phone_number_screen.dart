import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import '../../../app/constants/assets.constant.dart';
import '../../../components/widgets/app_elevated_button.dart';
import '../../../components/widgets/app_textform_field.dart';
import '../../utils/app_theme.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  int? clientId;
  EnterPhoneNumberScreen({Key? key, this.clientId = -1}) : super(key: key);

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  final phoneController = TextEditingController();
  String completeNumber = '';
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

      await context.read<AuthenticationNotifier>().verifyPhoneNo(context, completeNumber);


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
              child: Text(widget.clientId != -1 ? "Verify your Phone" : "Recover your password", style: Theme.of(context).textTheme.headline1)),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
                          child: IntlPhoneField(
                            controller: phoneController,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.blackColor, fontSize: 15.sp),
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                              border: InputBorder.none,
                              focusColor: AppTheme.primaryColor,
                              labelText: 'Enter your phone number',
                              focusedBorder:  UnderlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.textFieldUnderline, width: 1.0.sp),
                              ),
                              errorBorder:  const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 2.0),
                              ),
                              enabledBorder:  UnderlineInputBorder(
                                borderSide: BorderSide(color:  AppTheme.textFieldUnderline, width: 1.0.sp),
                              ),
                            ),
                            initialCountryCode: 'PK',
                            onChanged: (phone) {
                              completeNumber = phone.completeNumber;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 0.05.sh,
                        ),
                        AppElevatedButton(
                          onPressed: !pressed ? _trySubmit : () => {},
                          buttonText: 'Receive otp',
                          horizontalPadding: 12,
                          buttonColor:!pressed ?  AppTheme.primaryColor : AppTheme.subtitleLightGreyColor,
                          textColor: AppTheme.whiteColor,
                          textFontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
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
}
