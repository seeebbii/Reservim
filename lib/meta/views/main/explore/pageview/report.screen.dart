import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';

class ReportScreen extends StatefulWidget {
  final String shopId;
  String? clientId;
  String? reviewId;

  ReportScreen({Key? key, required this.shopId, this.clientId, this.reviewId})
      : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? reportReason;
  int? value;
  final otherReportController = TextEditingController();

  List<String> reportString = <String>[
    'Sexual content',
    'Violent and repulsive content',
    'Hateful and abusive content',
    'Harmful dangerous content',
    'Child abuse',
    'Infringes my rights',
    'Promote terrorism',
    'Spam and misleading',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: "Report",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return RadioListTile(
                    onChanged: (val) {
                      setState(() {
                        value = val as int;
                        reportReason = reportString[val];
                        if(val == 8){
                          reportReason = null;
                        }
                      });
                    },
                    groupValue: value,
                    value: index,
                    title: Text(
                      reportString[index],
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: AppTheme.blackColor),
                    ),
                    activeColor: AppTheme.primaryColor,
                  );
                }),
            value == 8
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 0.03.sh),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Your response",
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
                      onChanged: (str) {
                        reportReason = str;
                      },
                      controller: otherReportController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.02.sw),
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 0.05.sh,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            value = null;
                            reportReason = null;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0.sp, color: AppTheme.blackColor),
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
                                  borderRadius: BorderRadius.circular(3.r))),
                          onPressed: () {
                            if(reportReason == null || reportReason == ''){
                              BaseHelper.showSnackBar("Report reason is required");
                              return;
                            }
                            context.read<AppointmentsNotifier>().reportShop(
                                reportReason: reportReason,
                                shopId: widget.shopId,
                                clientId: widget.clientId,
                                reviewId: widget.clientId);
                          },
                          child: Text(
                            "Report",
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
        ),
      ),
    );
  }
}
