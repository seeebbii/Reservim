import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../core/notifier/homepage.notifier.dart';
import '../../../../utils/app_theme.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  navigationController.goBack();
                },
                splashRadius: 1,
                icon: const Icon(Icons.highlight_off)),
          ],
        ),
        Consumer<HomePageNotifier>(builder: (ctx, notifier, child){
          return Wrap(
            children: notifier.filterModel
              .asMap().entries.map((e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
              child: InkWell(
                onTap: ()=> notifier.updateChip(e.key),
                child: Chip(
                  side: const BorderSide(
                    color: AppTheme.primaryColor,
                    width: 1
                  ),
                    backgroundColor: !e.value.isSelected! ? AppTheme.whiteColor : AppTheme.primaryColor,
                    label: Text(
                      "${e.value.name}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: e.value.isSelected!
                              ? AppTheme.whiteColor
                              : AppTheme.blackColor),
                    )),
              ),
            ))
                .toList(),
          );
        }),
        SizedBox(height: 0.2.sh,),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: 0.03.sh, horizontal: 0.02.sw),
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 0.05.sh,
                  child: OutlinedButton(
                    onPressed: () => context.read<HomePageNotifier>().allChips(false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 1.0.sp, color: AppTheme.blackColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)
                      ),
                      primary: AppTheme.primaryColor,
                    ),
                    child: Text(
                      'Clear all',
                      style: Theme.of(context)
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
                              borderRadius: BorderRadius.circular(20.r))),
                      onPressed: () => context.read<HomePageNotifier>().allChips(true),
                      child: Text(
                        "Select all",
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(color: AppTheme.whiteColor),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
