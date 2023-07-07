import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class AppAppbar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  Color? bgColor = AppTheme.whiteColor;

  AppAppbar({Key? key, required this.title, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: bgColor,
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(color: AppTheme.blackColor)),
      leading: InkWell(
        onTap: (){
          navigationController.goBack();
        },
          child: Icon(
        Icons.arrow_back_ios,
        color: AppTheme.primaryColor,
        size: 20.sp,
      )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
