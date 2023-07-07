import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/components/widgets/view_photo.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../../components/dialog/custom_dialogs.dart';
import '../../../../../core/model/shops/review.model.dart';
import '../../../../../core/model/shops/shop_details.model.dart';
import '../../../../utils/app_theme.dart';
import '../widgets/pageview_category_widget.dart';

class GalleryPageViewScreen extends StatefulWidget {
  const GalleryPageViewScreen({Key? key}) : super(key: key);

  @override
  State<GalleryPageViewScreen> createState() => _GalleryPageViewScreenState();
}

class _GalleryPageViewScreenState extends State<GalleryPageViewScreen> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ExplorePageViewNotifier notifier =
        Provider.of<ExplorePageViewNotifier>(context);
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
            MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifier.shopDetailsModel.gallery?.length ?? 0,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              // the number of columns
              crossAxisCount: 2,
              // vertical gap between two items
              mainAxisSpacing: 3,
              // horizontal gap between two items
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                // display each item with a card
                ShopDetailsModel shopDetails = notifier.shopDetailsModel;
                String obj = notifier.shopDetailsModel.gallery![index];
                return GestureDetector(
                  onTap: () {
                    print(index);
                    Get.dialog(ViewPhoto(
                      galleryItems: notifier.shopDetailsModel.gallery!,
                      path:
                          ApiPaths.imageBaseUrl + shopDetails.galleryImagePath!,
                      currentPage: index,
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: BaseHelper.loadNetworkImageObject(ApiPaths.imageBaseUrl +
                            shopDetails.galleryImagePath! +
                            obj,),
                        fit: BoxFit.cover
                      )
                    ),
                    key: ValueKey(obj),
                    child: SizedBox(
                      height: 150 + Random().nextInt(250 - 150) * 2.5,
                    ),
                  ),
                );
              },
            )
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
