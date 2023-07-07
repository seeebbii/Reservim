import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/notifier/navbar.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class NavBarItem extends StatelessWidget {

  final String iconPath;
  final String itemName;
  final VoidCallback onTap;
  final int currentIndex;

  const NavBarItem({Key? key, required this.currentIndex, required this.iconPath, required this.itemName, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Consumer<NavBarNotifier>(
        builder: (ctx, notifier, child){
          return Tooltip(
            message: itemName,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.015.sh, horizontal: 0.023.sw),
              margin:  EdgeInsets.symmetric(horizontal: 4.sp, vertical: 0.01.sh),
              decoration: notifier.currentPageIndex == currentIndex ? BoxDecoration(
                  color: AppTheme.selectedNavBarBackgroundColor,
                  borderRadius: BorderRadius.circular(8.sp)
              ) : const BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(iconPath, height: 22.sp, color: notifier.currentPageIndex == currentIndex ? AppTheme.selectedNavBarItemColor :  AppTheme.unSelectedNavBarItemColor,),
                  SizedBox(height: 0.01.sh,),
                  Text(itemName, textAlign: TextAlign.center, softWrap: false, overflow: TextOverflow.fade, maxLines: 1,  style:  Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 10.sp,
                    color: notifier.currentPageIndex == currentIndex ? AppTheme.selectedNavBarItemColor :  AppTheme.unSelectedNavBarItemColor
                  ),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
