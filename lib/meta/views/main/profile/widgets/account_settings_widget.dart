import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class AccountSettingsWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  const AccountSettingsWidget({Key? key, required this.title, this.trailing = const SizedBox.shrink(), required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.blackColor, fontSize: 15.sp, fontWeight: FontWeight.w500),),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
