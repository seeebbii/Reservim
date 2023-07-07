import 'package:flutter/material.dart';
import 'package:reservim/meta/views/main/appointments/widgets/appointments_listview.dart';

import '../../../utils/app_theme.dart';

class AppointmentsNavBarScreen extends StatelessWidget {
  const AppointmentsNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Appointments",
          style: Theme.of(context).textTheme.headline2?.copyWith(
              color: AppTheme.blackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const AppointmentsListView(),
    );
  }
}
