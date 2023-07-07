import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reservim/components/widgets/app_appbar.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/app_theme.dart';

class TermsOfServiceProfileScreen extends StatefulWidget {
  const TermsOfServiceProfileScreen({Key? key}) : super(key: key);

  @override
  State<TermsOfServiceProfileScreen> createState() => _TermsOfServiceProfileScreenState();
}

class _TermsOfServiceProfileScreenState extends State<TermsOfServiceProfileScreen> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppAppbar(
        title: "Terms of service",
      ),
      body: const WebView(
        initialUrl: 'https://reservim.com/privacy',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
