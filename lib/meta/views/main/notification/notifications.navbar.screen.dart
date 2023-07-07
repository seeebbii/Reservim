import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservim/core/model/notifications.model.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/views/main/notification/widgets/notifications_listview.dart';

class NotificationsNavBarScreen extends StatefulWidget {
  const NotificationsNavBarScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsNavBarScreen> createState() =>
      _NotificationsNavBarScreenState();
}

class _NotificationsNavBarScreenState extends State<NotificationsNavBarScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Notification",
          style: Theme.of(context).textTheme.headline2?.copyWith(
              color: AppTheme.blackColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NotificationsListView(),
    );
  }
}
