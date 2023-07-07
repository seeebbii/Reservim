import 'package:flutter/material.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/meta/views/main/profile/widgets/payment_history_listview.dart';

class PaymentsProfileScreen extends StatelessWidget {
  const PaymentsProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: "Payment & History",),
      body: PaymentHistoryListview(),
    );
  }
}
