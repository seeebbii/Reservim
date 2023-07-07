import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../../core/model/shops/shop_details.model.dart';
import '../../../../core/notifier/explore.pageview.notifier.dart';

class RecommendedServiceExploreScreen extends StatefulWidget {
  const RecommendedServiceExploreScreen({Key? key}) : super(key: key);

  @override
  _RecommendedServiceExploreScreenState createState() =>
      _RecommendedServiceExploreScreenState();
}

class _RecommendedServiceExploreScreenState extends State<RecommendedServiceExploreScreen> {
  Future<ShopDetailsModel>? loadShopDetails;

  @override
  void initState() {
    super.initState();
    ExplorePageViewNotifier exploreNotifier = Provider.of<ExplorePageViewNotifier>(context, listen: false);
    loadShopDetails = exploreNotifier.getShopDetails(exploreNotifier.shopModel.id ?? 0);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async {
        context.read<ExplorePageViewNotifier>().onPageChange(0);
        context.read<AppointmentsNotifier>().bookAppointmentModel = BookAppointmentModel(service: [], jsonService: [], staffName: [], startTime: [], endTime: [], durationHour: [], durationMinute: []);
        return true;
      },
      child: Scaffold(
        body: Consumer<ExplorePageViewNotifier>(
          builder: (ctx, notifier, child) {
            return FutureBuilder(
              future: loadShopDetails,
              builder: (_, AsyncSnapshot<ShopDetailsModel> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(color: AppTheme.primaryColor,),
                  );
                }
                else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && notifier.shopDetailsModel.reviews == null ){
                  return const Center(
                    child: Text("Error occurred while fetching data"),
                  );
                }else{
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: notifier.pages,
                    onPageChanged: notifier.onPageChange,
                    controller: notifier.pageViewController,
                  );
                }
              }
            );
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
