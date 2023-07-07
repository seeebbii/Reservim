import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  String? hintText;

  bool obSecureText;
  dynamic validator;
  TextInputAction action;
  TextInputType keyType;

  Widget suffixIcon;
  List<TextInputFormatter>? formatter;

  AutovalidateMode? validateMode = AutovalidateMode.disabled;

  AppTextFormField({
    Key? key,
    required this.controller,
    required this.obSecureText,
    required this.validator,
    required this.action,
    required this.keyType,
    this.suffixIcon = const SizedBox.shrink(),
    this.hintText,
    this.formatter = const [],
    this.validateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.blackColor, fontSize: 15.sp),
        controller: controller,
        cursorWidth: 1,
        textInputAction: action,
        keyboardType: keyType,
        autovalidateMode: validateMode,
        inputFormatters: formatter,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          suffixIcon: suffixIcon,
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
        obscureText: obSecureText,
        cursorColor: Colors.red.shade400,
        validator: validator,
      ),
    );
  }
}
