import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../../../core/notifier/connection.notifier.dart';
import '../../utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectionNotifier>(context, listen: false).initConnectivity();
    Timer(const Duration(seconds: 3), () => checkState());
  }

  void checkState() {
    // TODO :: CHECK USER STATE HERE

    // LOGGED IN ? HOME PAGE : AUTH SCREEN
    if(HiveDatabase.getValue(HiveDatabase.loginCheck) == true){
      navigationController.getOffAll(RouteGenerator.homePageRoot);
      context.read<AuthenticationNotifier>().loadUserProfile();
    }else{
      // navigationController.getOffAll(RouteGenerator.welcomeScreen);
      navigationController.getOffAll(RouteGenerator.homePageRoot);
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen', style: Theme.of(context).textTheme.headline1,),
      ),
    );
  }
}
