import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../components/widgets/app_appbar.dart';
import '../../../../../core/router/router_generator.dart';
import '../../../../utils/base_helper.dart';

class PaymentScreen extends StatefulWidget {
  final String appointmentId;
  final String totalAmount;
  PaymentScreen({Key? key, required this.appointmentId, required this.totalAmount}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppAppbar(
        title: "Confirm Payment",
      ),
      body: Stack(
        children: [
          WebView(
            key: _key,
            initialUrl: 'https://reservim.com/alpha/handshake/${widget.appointmentId}/${widget.totalAmount}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller){
              _controller = controller;
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
              readResponse(finish);
            },
          ),
          isLoading ? Center( child: CircularProgressIndicator(color: AppTheme.primaryColor,),)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  void readResponse (String response) async {
    if(response.contains('/SuccessPayment/')){
      navigationController.getOffAll(RouteGenerator.homePageRoot);
      BaseHelper.showSnackBar("Appointment Created Successfully");
    }
  }
}
