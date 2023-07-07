import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

class PageViewCategoryWidget extends StatelessWidget {
  const PageViewCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categories = <String>[
      "SERVICES",
      "REVIEWS",
      "GALLERY",
      "DETAILS",
    ];

    return Consumer<ExplorePageViewNotifier>(
        builder: (context, pageViewNotifier, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categories
            .asMap()
            .entries
            .map((e) => _createCategoryText(
                e.value, pageViewNotifier.currentPage, e.key, context))
            .toList(),
      );
    });
  }

  Widget _createCategoryText(
      String text, int currentPageIndex, int childIndex, BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<ExplorePageViewNotifier>().animateToIndex(childIndex);
      },
      child: Text(
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
      ),
    );
  }
}
