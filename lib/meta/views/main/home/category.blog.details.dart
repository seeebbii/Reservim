import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/components/widgets/view_photo.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/Blogs/blogs_homepage.model.dart';
import 'package:reservim/core/model/blog_model.dart';
import 'package:reservim/core/model/blogs_category.model.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../utils/app_theme.dart';

class CategoryBlogDetails extends StatefulWidget {
  BlogsData? blogData;
  String? category;
  String? imagePath;
  BlogsCategoryModel? categorySelected;

  CategoryBlogDetails({Key? key, this.blogData, this.categorySelected, this.imagePath, this.category})
      : super(key: key);

  @override
  _CategoryBlogDetailsState createState() => _CategoryBlogDetailsState();
}

class _CategoryBlogDetailsState extends State<CategoryBlogDetails> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppAppbar(
        title: "Blogs",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.02.sh,
              ),
              Text(
                "${widget.category}",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: AppTheme.blackColor, fontSize: 17.sp),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Get.dialog(ViewPhoto(
                        galleryItems: [widget.blogData!.image!],
                        path: ApiPaths.imageBaseUrl + widget.imagePath!,
                      ));
                    },
                    child: Container(
                        height: 0.3.sh,
                        width: double.infinity,
                        child: BaseHelper.loadNetworkImage(
                            ApiPaths.imageBaseUrl + widget.imagePath! + widget.blogData!.image!, BoxFit.cover )),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _createListTile(
                          DateFormat.LLLL()
                              .format(DateTime.parse(widget.blogData?.createdAt ?? DateTime.now().toIso8601String())),
                          Icons.calendar_today_outlined),
                      SizedBox(
                        width: 0.05.sw,
                      ),
                      _createListTile(
                          "${widget.blogData?.minutes} min read",
                          Icons.access_time_outlined),
                      SizedBox(
                        width: 0.05.sw,
                      ),
                      _createListTile(
                          "${widget.blogData?.views} views",
                          Icons.visibility),
                    ],
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Text(
                    "${widget.blogData?.title}",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: AppTheme.blackColor,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  Text(
                    "${widget.blogData?.littleDescription}",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: AppTheme.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: widget.placeholdersBlog?.length ?? 0,
              //     itemBuilder: (ctx, index) {
              //       BlogModel obj = widget.placeholdersBlog![index];
              //       return _buildWidget(obj);
              //     })
            ],
          ),
        ),
      ),
    );
  }
  Widget _createListTile(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.sp,
        ),
        SizedBox(
          width: 0.01.sw,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: AppTheme.blackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildWidget(BlogModel obj) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.02.sh),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.r),
        child: Container(
          width: 0.8.sw,
          child: Card(
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(obj.imagePath!),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${obj.title}",
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Text(
                        "${obj.subtitle}",
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: AppTheme.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _createListTile(
                              DateFormat.LLLL().format(obj.dateTime!),
                              Icons.calendar_today_outlined),
                          _createListTile("${obj.readDuration} min read",
                              Icons.access_time_outlined),
                          _createListTile(
                              "${obj.views} views", Icons.visibility),
                        ],
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 0.15.sw,
                            height: 8.sp,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(
                            width: 0.03.sw,
                          ),
                          Text(
                            "READ MORE",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: AppTheme.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
