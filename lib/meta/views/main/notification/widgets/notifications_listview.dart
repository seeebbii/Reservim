import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/meta/utils/time_ago.dart';

import '../../../../../core/model/notifications.model.dart';
import '../../../../../core/model/shops/services.model.dart';
import '../../../../../core/model/shops/staff.model.dart';
import '../../../../utils/app_theme.dart';

class NotificationsListView extends StatefulWidget {
  const NotificationsListView({Key? key}) : super(key: key);

  @override
  _NotificationsListViewState createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {

  Future<NotificationsModel>? loadNotifications;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      AuthenticationNotifier authProvider = Provider.of<AuthenticationNotifier>(context, listen: false);
      loadNotifications = context.read<AppointmentsNotifier>().getUserNotifications(authProvider.currentUser.data?.id.toString() ?? "");
    });
  }

  String formatServices(List<String> services){
    String formattedString = '';

    for(int i = 0; i < services.length; i++){
      print(services[i]);
      print(i);
      if(i >= 1){
        formattedString += ", ${services[i]}";
      }else{
        formattedString += services[i];
      }

    }

    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsNotifier>(builder: (ctx, notifier, child){
      return FutureBuilder(future: loadNotifications, builder: (_, AsyncSnapshot<NotificationsModel> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor,),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && notifier.notificationsModel.notifications == null ){
          return const Center(
            child: Text("No new notifications yet"),
          );
        }else{
          return ListView.builder(
              itemCount: notifier.notificationsModel.notifications?.length ?? 0,
              itemBuilder: (ctx, index) {
                Notifications obj = notifier.notificationsModel.notifications![index];
                if(notifier.notificationsModel.notifications!.isEmpty){
                  return const Center(
                    child: Text("No new notifications yet"),
                  );
                }
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.001.sh),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sh),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${obj.shop?.salonName} (${getTimeAgo(DateTime.parse(obj.createdAt ?? DateTime.now().toIso8601String()))})",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: checkStatus(
                                      obj.appointments!.status!)['color'],
                                  borderRadius:
                                  BorderRadius.circular(15.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.0.sp,
                                      vertical: 1.0.sp),
                                  child: Text(
                                    '${checkStatus(obj.appointments!.status!)['status']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                      color:
                                      AppTheme.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  String userId = context.read<AuthenticationNotifier>().currentUser.data!.id.toString();
                                  notifier.removeUserNotification(userId, obj.id.toString(), index);
                                },
                                child: const Icon(
                                  Icons.highlight_off,
                                  color: AppTheme.blackColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.015.sh,
                          ),
                          ListView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemBuilder: (_, index){
                            Services serviceModel = obj.appointments!.services![index];
                            StaffModel staffModel = obj.appointments!.staffs![index];
                            return Text(
                              "${serviceModel.name} > ${staffModel.name} (${serviceModel.clientservices!.durationHour} hour ${serviceModel.clientservices!.durationMinute} minute)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.black, fontSize: 12.sp),
                            );
                          }, itemCount: obj.appointments?.services?.length ?? 0,),

                          SizedBox(
                            height: 0.02.sh,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 0.04.sh,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          onPrimary: AppTheme.approveNotificationColor,
                                          primary: AppTheme.approveNotificationColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13.sp, vertical: 0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(6.r))),
                                      onPressed: () {},
                                      child: Text(
                                        "Approve",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(color: AppTheme.whiteColor),
                                      )),
                                ),
                                SizedBox(
                                  width: 0.03.sw,
                                ),
                                SizedBox(
                                  height: 0.04.sh,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          onPrimary: AppTheme.declineNotificationColor,
                                          primary: AppTheme.declineNotificationColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13.sp, vertical: 0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(6.r))),
                                      onPressed: () {},
                                      child: Text(
                                        "Decline",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(color: AppTheme.whiteColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      });
    });

  }
}
