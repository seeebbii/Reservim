import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import 'app/constants/controller.constant.dart';
import 'app/providers/multi_providers.dart';
import 'core/controller/navigation_controller.dart';
import 'core/notifications/notification_service.dart';
import 'core/notifier/authentication.notifier.dart';
import 'core/notifier/connection.notifier.dart';
import 'core/router/router_generator.dart';
import 'meta/utils/app_theme.dart';
import 'meta/utils/shared_pref.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // INITIALIZING IMPORTANT DEPENDENCIES
  Get.put(NavigationController());
  await SharedPref.init();
  await ConnectionNotifier().initConnectivity();
  await HiveDatabase.init();
  await Firebase.initializeApp();
  NotificationInitilization.initializePushNotifications();
  // FOR GOOGLE MAPS
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  // FlutterNativeSplash.removeAfter((p)=> initialization());
  // FlutterNativeSplash.remove();

  // ENTRY POINT TO THE APP
  runApp(const Reservim());
}

Future<void> initialization() async {
  await Future.delayed(const Duration(seconds: 3), () {
    return;
  });
}

class Reservim extends StatefulWidget {
  const Reservim({Key? key}) : super(key: key);

  @override
  _ReservimState createState() => _ReservimState();
}

class _ReservimState extends State<Reservim> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: ScreenUtilInit(
          builder: () => MultiProviders(
                GetMaterialApp(
                  title: "Reservim",
                  debugShowCheckedModeBanner: false,
                  initialRoute: RouteGenerator.welcomeScreen,
                  onGenerateRoute: RouteGenerator.onGeneratedRoutes,
                  theme: AppTheme.lightTheme,
                  builder: EasyLoading.init(),
                ),
              )),
    );
  }
}
