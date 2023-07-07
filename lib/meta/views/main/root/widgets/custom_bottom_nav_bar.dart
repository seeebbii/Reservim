import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/navbar.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import 'nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavBarNotifier navBarNotifier =
        Provider.of<NavBarNotifier>(context, listen: false);
    return Container(
      height: 0.115.sh,
      color: AppTheme.bottomNavBarBackground,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: NavBarItem(
                currentIndex: 0,
                iconPath: Assets.home,
                itemName: "Home",
                onTap: () {
                  navBarNotifier.updatePageIndex(0);
                }),
          ),
          Expanded(
            child: NavBarItem(
                currentIndex: 1,
                iconPath: Assets.explore,
                itemName: "Explore",
                onTap: () {
                  navBarNotifier.updatePageIndex(1);
                }),
          ),
          Expanded(
            child: NavBarItem(
                currentIndex: 2,
                iconPath: Assets.appointments,
                itemName: "Appointments",
                onTap: () {
                  navBarNotifier.updatePageIndex(2);
                  context.read<AppointmentsNotifier>().getUserAppointments();
                }),
          ),
          Expanded(
            child: NavBarItem(
                currentIndex: 3,
                iconPath: Assets.profile,
                itemName: "Profile",
                onTap: () {
                  navBarNotifier.updatePageIndex(3);
                }),
          ),
          context.watch<AuthenticationNotifier>().currentUser.data?.id != null
              ? Expanded(
                  child: NavBarItem(
                      currentIndex: 4,
                      iconPath: Assets.notifications,
                      itemName: "Notifications",
                      onTap: () {
                        navBarNotifier.updatePageIndex(4);
                        AuthenticationNotifier authProvider =
                            Provider.of<AuthenticationNotifier>(context,
                                listen: false);
                        context
                            .read<AppointmentsNotifier>()
                            .getUserNotifications(
                                authProvider.currentUser.data?.id.toString() ??
                                    "");
                      }),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
