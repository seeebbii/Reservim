import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/categories.model.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../../core/model/Blogs/category_homepage.model.dart';
import '../../../../../core/notifier/homepage.notifier.dart';
import '../../../../utils/app_theme.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  Future<CategoryHomePageModel>? loadCategories;

  @override
  void initState() {
    loadCategories = context.read<HomePageNotifier>().getHomePageCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.homeScreenHorizontalListviewBg,
      height: 0.15.sh,
      child:
          Consumer<HomePageNotifier>(builder: (ctx, homePageNotifier, child) {
        return FutureBuilder(
            future: loadCategories,
            builder: (_, AsyncSnapshot<CategoryHomePageModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 0.15.sh,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  homePageNotifier.categoryHomePageModel.data == null) {
                return Container(
                  height: 0.15.sh,
                  child: const Center(
                    child: Text("Empty"),
                  ),
                );
              } else {
                return Container(
                  height: 0.53.sh,
                  child: ListView.builder(
                      itemCount:
                          homePageNotifier.categoryHomePageModel.data?.length ??
                              0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        CategoryData obj = homePageNotifier
                                .categoryHomePageModel.data?[index] ??
                            CategoryData();
                        return InkWell(
                          onTap: () {
                            homePageNotifier.updateCategoryModel(index);
                          },
                          child: Center(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.015.sh, horizontal: 0.023.sw),
                            margin: EdgeInsets.symmetric(
                                horizontal: 3.sp, vertical: 0.015.sh),
                            decoration: BoxDecoration(
                                color: obj.isSelected!
                                    ? AppTheme.selectedYellowColor
                                    : AppTheme.unSelectedCategoryColor,
                                borderRadius: BorderRadius.circular(12.sp)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // BaseHelper.loadNetworkImage(ApiPaths.imageBaseUrl + homePageNotifier.categoryHomePageModel.imagePath! + obj.vertexImage!, BoxFit.cover),
                                obj.vertexImage == null
                                    ? SvgPicture.asset(Assets.faceCat)
                                    : BaseHelper.loadNetworkImage(
                                        ApiPaths.imageBaseUrl +
                                            homePageNotifier
                                                .categoryHomePageModel
                                                .imagePath! +
                                            obj.vertexImage!,
                                        BoxFit.cover),
                                SizedBox(
                                  height: 0.01.sh,
                                ),
                                SizedBox(
                                  width: 0.18.sw,
                                  child: Text(
                                    "${obj.name}",
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          fontSize: 10.sp,
                                          color: obj.isSelected!
                                              ? AppTheme.blackColor
                                              : AppTheme.whiteColor
                                                  .withOpacity(0.6),
                                        ),
                                  ),
                                )
                              ],
                            ),
                          )),
                        );
                      }),
                );
              }
            });
      }),
    );
  }
}
