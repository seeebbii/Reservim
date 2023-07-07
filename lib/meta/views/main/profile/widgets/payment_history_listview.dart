import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/core/model/payment.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../../../components/widgets/app_divider.dart';
import '../../../../../core/model/user/payments.model.dart';

class PaymentHistoryListview extends StatefulWidget {
  const PaymentHistoryListview({Key? key}) : super(key: key);

  @override
  _PaymentHistoryListviewState createState() => _PaymentHistoryListviewState();
}

class _PaymentHistoryListviewState extends State<PaymentHistoryListview> {


  Future<PaymentsModel>? loadPayments;
  @override
  void initState() {
    loadPayments = context.read<AppointmentsNotifier>().getUserPayments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsNotifier>(builder: (ctx, notifier, child){
      return FutureBuilder(future: loadPayments, builder: (_, AsyncSnapshot<PaymentsModel> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor,),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && notifier.paymentModel.payments == null ){
          return const Center(
            child: Text("No Payments"),
          );
        }else{
          return ListView.separated( itemBuilder: (ctx, index) {
            Payment obj = notifier.paymentModel.payments![index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs ${obj.amount}', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.blackColor),),
                  Text('${formatDatePayments(DateTime.parse(obj.createdAt!))} / ${formatTime(DateTime.parse(obj.createdAt!))}', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.blackColor),),
                  Text('${obj.users?.salonName}', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.blackColor),),
                  Text('${checkStatus(obj.appointment!.status!)['status']}', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: checkStatus(obj.appointment!.status!)['color']),),
                ],
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
                child: AppDivider(thickness: 1.5,)
            );
          }, itemCount: notifier.paymentModel.payments?.length ?? 0,);
        }
      });
    });

  }
}
