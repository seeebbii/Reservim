import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/review.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/views/main/appointments/widgets/review_widget.dart';
import 'package:reservim/meta/views/main/profile/widgets/reviews_widget.dart';

import '../../../../../app/constants/assets.constant.dart';
import '../../../../../components/dialog/custom_dialogs.dart';
import '../../../../../core/model/shops/reviews.model.dart';
import '../../../../../core/model/shops/shop_details.model.dart';
import '../../../../utils/app_theme.dart';
import '../widgets/explore.review.widget.dart';
import '../widgets/pageview_category_widget.dart';

class ReviewsPageViewScreen extends StatefulWidget {
  const ReviewsPageViewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsPageViewScreen> createState() => _ReviewsPageViewScreenState();
}

class _ReviewsPageViewScreenState extends State<ReviewsPageViewScreen> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.sp),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
            padding: EdgeInsets.only(bottom: 3.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ExplorePageViewNotifier>().onPageChange(0);
                    context
                        .read<AppointmentsNotifier>()
                        .bookAppointmentModel =
                        BookAppointmentModel(
                            service: [],
                            jsonService: [],
                            staffName: [],
                            startTime: [],
                            endTime: [],
                            durationHour: [],
                            durationMinute: []);

                    navigationController.goBack();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: 0.055.sh,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: _bookYourServicesFormField())),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric(
                          horizontal: 2.sp, vertical: 3.5.sp),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          Icons.phone,
                          color: AppTheme.whiteColor,
                          size: 18.sp,
                        ),
                        onPressed: () => BaseHelper.openDialPad(phoneNumber),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.03.sh,
            ),
            const PageViewCategoryWidget(),
            SizedBox(
              height: 0.02.sh,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
              child: AppDivider(
                dividerColor: AppTheme.primaryColor,
                thickness: 1.5,
              ),
            ),

            // TODO :: EXPLORE -> SHOP PAGE VIEW -> REVIEWS
            Consumer<ExplorePageViewNotifier>(builder: (ctx, notifier, child) {
              return notifier.shopDetailsModel.reviews?.isEmpty ?? false
                  ? Center(
                      child: Text("No review added yet",
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: AppTheme.blackColor)),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notifier.shopDetailsModel.reviews?.length ?? 0,
                      itemBuilder: (ctx, index) {
                        ReviewModel obj =
                            notifier.shopDetailsModel.reviews![index];
                        return ExploreReviewWidget(
                          review: obj,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 5.sp),
                          child: AppDivider(
                            thickness: 1.5,
                          ),
                        );
                      });
            })
          ],
        ),
      ),
    );
  }

  Widget _bookYourServicesFormField() {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).unfocus();
        CustomDialogs.displaySearchDialog(context);
      },
      controller: textEditingController,
      obscureText: false,
      decoration: InputDecoration(
        fillColor: AppTheme.whiteColor,
        filled: true,
        isDense: true,
        hintText: "Book your services...",
        hintStyle: Theme.of(context)
            .inputDecorationTheme
            .hintStyle
            ?.copyWith(color: AppTheme.blackColor.withOpacity(0.6)),
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.blackColor.withOpacity(0.6),
          size: 30.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.blackColor.withOpacity(0.6),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.hintColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50.0.r),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
