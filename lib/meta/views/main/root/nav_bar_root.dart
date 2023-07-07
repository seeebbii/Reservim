import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/navbar.notifier.dart';
import 'package:reservim/meta/views/main/root/widgets/custom_bottom_nav_bar.dart';

import '../../../../app/constants/assets.constant.dart';
import '../../../utils/app_theme.dart';

class NavBarRoot extends StatefulWidget {
  const NavBarRoot({Key? key}) : super(key: key);

  @override
  State<NavBarRoot> createState() => _NavBarRootState();
}

class _NavBarRootState extends State<NavBarRoot> {

  @override
  void initState() {
    // INITIALIZING EMPTY LISTS FOR BOOKING MODEL
    context.read<AppointmentsNotifier>().bookAppointmentModel.service = <Service>[];
    context.read<AppointmentsNotifier>().bookAppointmentModel.jsonService = <JsonService>[];
    context.read<AppointmentsNotifier>().bookAppointmentModel.staffName = <StaffName>[];
    context.read<AppointmentsNotifier>().bookAppointmentModel.startTime = <String>[];
    context.read<AppointmentsNotifier>().bookAppointmentModel.endTime = <String>[];
    context.read<AppointmentsNotifier>().bookAppointmentModel.durationHour = <int>[];
    context.read<AppointmentsNotifier>().bookAppointmentModel.durationMinute = <int>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<NavBarNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        // body: notifier.bottomNavBarScreens[notifier.currentPageIndex],
        body: IndexedStack(
          children: notifier.bottomNavBarScreens,
          index: notifier.currentPageIndex,
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: (index){
        //     notifier.updatePageIndex(index);
        //   },
        //   showSelectedLabels: true,
        //   showUnselectedLabels: true,
        //   selectedLabelStyle: TextStyle(color: AppTheme.primaryColor),
        //   selectedItemColor: AppTheme.selectedNavBarBackgroundColor,
        //   backgroundColor: Colors.red,
        //   items: [
        //     _createBottomNavBarItem("Home", Assets.home),
        //     _createBottomNavBarItem("Explore",  Assets.explore),
        //     _createBottomNavBarItem("Appointments", Assets.appointments),
        //     _createBottomNavBarItem("Profile", Assets.profile),
        //     _createBottomNavBarItem("Notifications", Assets.notifications),
        //   ],
        // ),
      );
    });
  }

  BottomNavigationBarItem _createBottomNavBarItem(String label, String iconPath){
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(iconPath, height: 25.sp,),
      label: label
    );
  }
}
