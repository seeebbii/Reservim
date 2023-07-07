import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/model/user/appointments.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/notifier/map.notifier.dart';
import 'package:reservim/core/notifier/navbar.notifier.dart';

import '../../core/notifier/all_deals.notifier.dart';
import '../../core/notifier/authentication.notifier.dart';
import '../../core/notifier/connection.notifier.dart';

class MultiProviders extends StatelessWidget {
  const MultiProviders(this.child, {Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<ConnectionNotifier>(
          create: (BuildContext context) => ConnectionNotifier(),
        ),

        ChangeNotifierProvider<NavBarNotifier>(
          create: (BuildContext context) => NavBarNotifier(),
        ),

        ChangeNotifierProvider<ExplorePageViewNotifier>(
          create: (BuildContext context) => ExplorePageViewNotifier(),
        ),

        ChangeNotifierProvider<AuthenticationNotifier>(
          create: (BuildContext context) => AuthenticationNotifier(),
        ),

        ChangeNotifierProvider<HomePageNotifier>(
          create: (BuildContext context) => HomePageNotifier(),
        ),

        ChangeNotifierProvider<AppointmentsNotifier>(
          create: (BuildContext context) => AppointmentsNotifier(),
        ),

        ChangeNotifierProvider<MapNotifier>(
          create: (BuildContext context) => MapNotifier(),
        ),

        ChangeNotifierProvider<AllDealsNotifier>(
          create: (BuildContext context) => AllDealsNotifier(),
        ),

      ],
      child: child,
    );
  }
}