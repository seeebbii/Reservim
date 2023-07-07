import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  final double horizontalPadding;
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  final FontWeight textFontWeight;
  final double fontSize;
  final Color buttonColor;

  const AppElevatedButton({
    Key? key,
    required this.horizontalPadding,
    required this.onPressed,
    required this.buttonText,
    required this.textColor,
    required this.buttonColor,
    required this.textFontWeight,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.sp),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: MaterialStateProperty.all(buttonColor)),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: textColor,
                    fontWeight: textFontWeight,
                    fontSize: fontSize),
              ))),
    );
  }
}
