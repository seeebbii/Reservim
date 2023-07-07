import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:reservim/core/model/shops/review.model.dart';
import 'package:reservim/core/model/shops/reviews.model.dart';
import 'package:reservim/meta/views/main/profile/widgets/reviews_widget.dart';

import '../../../../core/notifier/appointments.notifier.dart';
import '../../../utils/app_theme.dart';

class ReviewsProfileScreen extends StatefulWidget {
  ReviewsProfileScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsProfileScreen> createState() => _ReviewsProfileScreenState();
}

class _ReviewsProfileScreenState extends State<ReviewsProfileScreen> {

  Future<ReviewsModel>? loadReviews;

  @override
  void initState() {
    loadReviews = context.read<AppointmentsNotifier>().getUserReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppAppbar(
        title: "Reviews",
      ),
      body: _createReviews(),
    );
  }

  Widget _createReviews() {
    return Consumer<AppointmentsNotifier>(builder: (ctx, notifier, child){
      return FutureBuilder(future: loadReviews, builder: (_, AsyncSnapshot<ReviewsModel> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor,),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && notifier.reviewsModel.reviews == null ){
          return const Center(
            child: Text("No Reviews"),
          );
        }else{
          return ListView.separated(
              itemCount: notifier.reviewsModel.reviews?.length ?? 0,
              itemBuilder: (ctx, index) {
                ReviewModel obj = notifier.reviewsModel.reviews![index];
                return ReviewsWidget(review: obj, path: notifier.reviewsModel.imagePath ?? "");
              },

              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
                  child: AppDivider(thickness: 1.5,),
                );
              });
        }
      });
    });
  }
}
