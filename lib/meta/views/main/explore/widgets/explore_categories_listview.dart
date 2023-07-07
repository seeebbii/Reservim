import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../app/constants/assets.constant.dart';
import '../../../../../core/model/Blogs/category_homepage.model.dart';
import '../../../../../core/model/categories.model.dart';
import '../../../../../core/notifier/homepage.notifier.dart';
import '../../../../utils/app_theme.dart';

class ExploreCategoriesListView extends StatefulWidget {
  const ExploreCategoriesListView({Key? key}) : super(key: key);

  @override
  _ExploreCategoriesListViewState createState() => _ExploreCategoriesListViewState();
}

class _ExploreCategoriesListViewState extends State<ExploreCategoriesListView> {

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageNotifier>(builder: (ctx, homePageNotifier, child){
      if(homePageNotifier.categoryHomePageModel.data == null){
        return const SizedBox.shrink();
      }else{
        return Container(
          height: 0.08.sh,
          child: ListView.builder(
              itemCount: homePageNotifier.categoryHomePageModel.data?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                CategoryData obj = homePageNotifier.categoryHomePageModel.data![index];
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    homePageNotifier.updateCategoryModel(index);
                  },
                  child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.015.sh, horizontal: 0.04.sw),
                        margin:
                        EdgeInsets.symmetric(horizontal: 3.sp,),
                        decoration: BoxDecoration(
                            color: obj.isSelected!
                                ? AppTheme.primaryColor
                                : AppTheme.blackColor,
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: Text(
                          obj.name!,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 10.sp,
                            color: obj.isSelected!
                                ? AppTheme.whiteColor
                                : AppTheme.whiteColor.withOpacity(0.6),
                          ),
                        ),
                      )),
                );
              }),
        );
      }
    });
  }
}
