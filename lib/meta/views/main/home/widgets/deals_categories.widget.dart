import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/model/shops/deals_categories.model.dart';
import 'package:reservim/core/notifier/all_deals.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class DealsCategoriesWidget extends StatelessWidget {
  const DealsCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AllDealsNotifier>(builder: (context, notifier, child){
      return Container(
        height: 0.06.sh,
        child: ListView.builder(
            itemCount: notifier.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              DealsCategoriesModel obj = notifier.categories[index];
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  notifier.animateToIndex(index);
                },
                child: Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 0.02.sh), child: _createCategoryText(obj.name.toString(), notifier.currentSelectedCategory, index, context))),
              );
            }),
      );
    });
  }

  Widget _createCategoryText(
      String text, int currentPageIndex, int childIndex, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2?.copyWith(
        decoration: childIndex == currentPageIndex
            ? TextDecoration.underline
            : null,
        color: Colors.transparent,
        decorationColor: AppTheme.blackColor,
        decorationThickness: 4,
        fontSize: 11.sp,
        fontWeight: childIndex == currentPageIndex ? FontWeight.bold : null, shadows: [
        Shadow(
            color: AppTheme.blackColor,
            offset: Offset(0, -5))
      ],),
    );
  }
}
