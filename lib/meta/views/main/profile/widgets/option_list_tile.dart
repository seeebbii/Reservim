import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class OptionListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const OptionListTile({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.r)),
        tileColor: AppTheme.profileListTileColor,
         title: Padding(
           padding: EdgeInsets.symmetric(vertical: 15.sp),
           child: Text(title, style: Theme.of(context).textTheme.headline2?.copyWith(color: AppTheme.selectedNavBarBackgroundColor, fontWeight: FontWeight.w500),),
         ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
