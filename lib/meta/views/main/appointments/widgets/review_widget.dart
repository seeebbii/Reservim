import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../core/model/user/appointments.model.dart';
import '../../../../utils/base_helper.dart';

class ReviewWidget extends StatefulWidget {
  final FinishedAppointment appointment;

  const ReviewWidget({Key? key, required this.appointment}) : super(key: key);

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final reviewController = TextEditingController();
  List<XFile> images = <XFile>[];
  double ratingValue = 0.0;
  bool pressed = false;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();


    if (ratingValue <= 0.0) {
      BaseHelper.showSnackBar("Please rate before posting");
    } else {
      if (isValid) {
        setState(() {
          pressed = true;
        });

        List uploadFileList = [];
        for (var file in images) {
          if (file.path != '') {
            var multipartFile = await MultipartFile.fromFile(file.path);
            uploadFileList.add(multipartFile);
          }
        }


        // TODO :: REQUEST CALL
        var formData = {
          "picture[]": uploadFileList,
          "text": reviewController.text.trim(),
          'rating': ratingValue,
        };

        var response = await ApiService.request(
            ApiPaths.addUserReview + widget.appointment.id.toString(),
            method: RequestMethod.POST,
            data: formData);

        if (response?['statusCode'] == 200) {
          navigationController.goBack();
          BaseHelper.showSnackBar('Review Added');
        }

        setState(() {
          pressed = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Leave a review',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(
                    color: AppTheme.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    navigationController.goBack();
                  },
                  splashRadius: 1,
                  icon: const Icon(Icons.highlight_off)),
            ],
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemSize: 30.sp,
            itemCount: 5,
            itemBuilder: (context, _) =>
                Icon(
                  Icons.star,
                  size: 10.sp,
                  color: AppTheme.reviewStarColor,
                ),
            onRatingUpdate: (rating) {
              ratingValue = rating;
            },
          ),
          SizedBox(
            height: 0.02.sh,
          ),
          Text(
            "Describe your experience what do you think of ${widget.appointment
                .user?.salonName} atmosphere and service ? Let's hear it!",
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .bodyText1
                ?.copyWith(
              color: AppTheme.blackColor,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(
            height: 0.02.sh,
          ),
          TextFormField(
            validator: (str) {
              if (str == '' || str == null) {
                return "Please add your message";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: "Share your thoughts!",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: AppTheme.subtitleLightGreyColor, width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: AppTheme.subtitleLightGreyColor, width: 3),
              ),
            ),
            controller: reviewController,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(
            height: 0.03.sh,
          ),
          images.isEmpty ? SizedBox(
            height: 0.05.sh,
            child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.photo_camera,
                  color: AppTheme.whiteColor,
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: AppTheme.primaryColor,
                    primary: AppTheme.primaryColor,
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.sp, vertical: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.r))),
                onPressed: !pressed
                    ? showAlertDialog
                    : () {},
                label: Text(
                  "Add Image",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 13.sp),
                )),
          ) : Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
            child: SizedBox(
              height: 0.08.sh,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          if (index <= 3) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.sp),
                              child: Container(
                                width: 55.sp,
                                child: Image.memory(
                                  // review.picture![index],
                                  File(images[index].path).readAsBytesSync(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else if (index == 4) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 55.sp,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(
                                          // review.picture![index],
                                          File(images[index].path)
                                              .readAsBytesSync(),
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  width: 55.sp,
                                  color: AppTheme.blackColor.withOpacity(0.7),
                                ),
                                GestureDetector(
                                  onTap: showAlertDialog,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${images.length - 4}+",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                            color: AppTheme.whiteColor),
                                      ),
                                      Text(
                                        "More",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                            color: AppTheme.whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                  ),
                  images.length >= 4 ? const SizedBox.shrink() : Container(
                    width: 55.sp,
                    height: double.infinity,
                    color: AppTheme.blackColor.withOpacity(0.4),
                    child: IconButton(splashRadius: 1,
                      icon: const Icon(Icons.add),
                      onPressed: showAlertDialog,),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 0.05.sh,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: !pressed
                        ? AppTheme.reviewPostColor
                        : AppTheme.subtitleLightGreyColor,
                    primary: !pressed
                        ? AppTheme.reviewPostColor
                        : AppTheme.subtitleLightGreyColor,
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.r))),
                onPressed: !pressed ? _trySubmit : null,
                child: Text(
                  "Post",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 13.sp),
                )),
          )
        ],
      ),
    );
  }

  void showAlertDialog() {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: Text("Select your source", style: Theme
            .of(context)
            .textTheme
            .headline2
            ?.copyWith(color: AppTheme.blackColor),),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  height: 0.05.sh,
                  child: OutlinedButton(
                    onPressed: () async {
                      navigationController.goBack();
                      final XFile? image = await _picker
                          .pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          images.add(image);
                        });
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 1.0.sp,
                          color: AppTheme.blackColor),
                      primary: AppTheme.primaryColor,
                    ),
                    child: Text(
                      'Camera',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: AppTheme.blackColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 0.03.sw,
              ),
              Expanded(
                child: SizedBox(
                  height: 0.05.sh,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppTheme.primaryColor,
                          primary: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.sp, vertical: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  3.r))),
                      onPressed: () async {
                        navigationController.goBack();
                        final List<XFile>? image = await _picker
                            .pickMultiImage();
                        if (image != null) {
                          setState(() {
                            images.addAll(image);
                          });
                        }
                      },
                      child: Text(
                        "Gallery",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(
                            color: AppTheme.whiteColor),
                      )),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
