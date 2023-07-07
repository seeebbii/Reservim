import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/Blogs/blogs_homepage.model.dart';
import 'package:reservim/core/model/blog_model.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../../app/constants/assets.constant.dart';
import '../../../../utils/app_theme.dart';

class BlogListView extends StatefulWidget {
  const BlogListView({Key? key}) : super(key: key);

  @override
  State<BlogListView> createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  Future<BlogsHomePageModel>? loadBlogs;

  @override
  void initState() {
    loadBlogs = context.read<HomePageNotifier>().getHomePageBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
          child: Text(
            "Our Blog Post",
            style: Theme.of(context).textTheme.headline2?.copyWith(
                color: AppTheme.blackColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 0.02.sh,
        ),
        Consumer<HomePageNotifier>(builder: (ctx, blogsNotifier, child) {
          return FutureBuilder(
              future: loadBlogs,
              builder: (_, AsyncSnapshot<BlogsHomePageModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 0.5.sh,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    blogsNotifier.blogsHomePage.data == null) {
                  return Container(
                    height: 0.5.sh,
                    child: const Center(
                      child: Text("No blogs uploaded"),
                    ),
                  );
                } else {
                  return Container(
                    height: 0.53.sh,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            blogsNotifier.blogsHomePage.data?.length ?? 0,
                        itemBuilder: (ctx, index) {
                          BlogsData obj =
                              blogsNotifier.blogsHomePage.data?[index] ??
                                  BlogsData();
                          return _buildWidget(
                              obj, blogsNotifier.blogsHomePage.imagePath!);
                        }),
                  );
                }
              });
        })
      ],
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

  Widget _buildWidget(BlogsData obj, String imagePath) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        navigationController
            .navigateToNamedWithArg(RouteGenerator.blogDetails, {
          'blogs': context.read<HomePageNotifier>().blogsHomePage.data!,
          'imagePath': imagePath
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.sp),
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
                        image: BaseHelper.loadNetworkImageObject(
                            ApiPaths.imageBaseUrl + imagePath + obj.image!),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
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
                                DateFormat.LLLL().format(DateTime.parse(
                                    obj.createdAt ??
                                        DateTime.now().toIso8601String())),
                                Icons.calendar_today_outlined),
                            _createListTile("${obj.minutes} min read",
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
      ),
    );
  }
}
