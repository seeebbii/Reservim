import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../components/widgets/app_appbar.dart';
import '../../../utils/app_theme.dart';

class PrivacyPolicyProfileScreen extends StatefulWidget {
  const PrivacyPolicyProfileScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyProfileScreen> createState() => _PrivacyPolicyProfileScreenState();
}

class _PrivacyPolicyProfileScreenState extends State<PrivacyPolicyProfileScreen> {

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
        title: "Privacy Policy",
      ),
      body: const WebView(
        initialUrl: 'https://reservim.com/privacy',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
