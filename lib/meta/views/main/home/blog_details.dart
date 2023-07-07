import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/Blogs/blogs_homepage.model.dart';
import 'package:reservim/core/model/blog_model.dart';
import 'package:reservim/core/model/blogs_category.model.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../utils/app_theme.dart';

class BlogDetails extends StatefulWidget {

  List<BlogsData>? blogData;
  String? imagePath;

  BlogDetails({Key? key, this.blogData, this.imagePath}) : super(key: key);

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  final textEditingController = TextEditingController();

  Future<BlogsCategoryModel>? loadCategories ;

  @override
  void initState() {
    loadCategories = context.read<HomePageNotifier>().getBlogsCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppAppbar(
          title: 'Blogs',
        ),
        body: Consumer<HomePageNotifier>(builder: (ctx, notifier, child){
          return FutureBuilder(
              future: loadCategories,
              builder: (_, AsyncSnapshot<BlogsCategoryModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 0.3.sh,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          Text(
                            "Categories",
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: AppTheme.blackColor, fontSize: 17.sp),
                          ),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          Container(
                            height: 0.15.sh,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                Categories obj = notifier.blogsCategoryModel.categories![index];
                                return InkWell(
                                  onTap: () {
                                    navigationController.navigateToNamedWithArg(
                                        RouteGenerator.blogCategoryList, {
                                      'id': obj.id  ,
                                      'categoryName': obj.name
                                    });
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 0.03.sw,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              image: DecorationImage(
                                                image: BaseHelper.loadNetworkImageObject("${ApiPaths.imageBaseUrl}${notifier.blogsCategoryModel.imagePath}${obj.image}"),
                                                fit: BoxFit.cover,
                                              )
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.01.sh,
                                          ),
                                          Text(
                                            "${obj.name}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                ?.copyWith(
                                                fontSize: 13.sp,
                                                color: AppTheme.blackColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: notifier.blogsCategoryModel.categories?.length,
                            ),
                          ),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.blogData!.length,
                              itemBuilder: (ctx, index) {
                                BlogsData obj = widget.blogData![index];
                                return _buildWidget(obj, widget.imagePath!);
                              })
                        ],
                      ),
                    ),
                  );
                }
              });
        },));
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

  Widget _buildWidget(BlogsData obj, String imagePath){
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: (){
        navigationController.navigateToNamedWithArg(RouteGenerator.categoryBlogDetails, {'blogs': obj, 'category' : "", 'imagePath': imagePath});
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: Container(
            width: 0.8.sw,
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:  BaseHelper.loadNetworkImageObject(ApiPaths.imageBaseUrl + imagePath + obj.image!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.sp, vertical: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${obj.title}",
                          softWrap: false,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                              color: AppTheme.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        Text(
                          "${obj.littleDescription}",
                          softWrap: false,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
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
                                DateFormat.LLLL()
                                    .format(DateTime.parse(obj.createdAt ?? DateTime.now().toIso8601String())),
                                Icons.calendar_today_outlined),
                            _createListTile(
                                "${obj.minutes} min read",
                                Icons.access_time_outlined),
                            _createListTile("${obj.views} views",
                                Icons.visibility),
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
                            SizedBox(width: 0.03.sw,),
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
      ),
    );
  }
}
