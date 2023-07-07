import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../meta/views/main/appointments/appointments.navbar.screen.dart';
import '../../meta/views/main/explore/explore.navbar.screen.dart';
import '../../meta/views/main/home/home.navbar.screen.dart';
import '../../meta/views/main/notification/notifications.navbar.screen.dart';
import '../../meta/views/main/profile/profile.navbar.screen.dart';


class NavBarNotifier extends ChangeNotifier{

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  List<Widget> bottomNavBarScreens = const <Widget> [
    HomeNavBarScreen(),
    ExploreNavBarScreen(),
    AppointmentsNavBarScreen(),
    ProfileNavBarScreen(),
    NotificationsNavBarScreen(),
  ];

  void updatePageIndex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }


}