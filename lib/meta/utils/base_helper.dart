import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseHelper {
  static void showSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void openDialPad(String phoneNumber) async {
    if (!await launch("tel:$phoneNumber")) {
      throw 'Could not launch $phoneNumber';
    }
  }

  static void launchUrl(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }

  // CACHE NETWORK WIDGET HERE
  static Widget loadNetworkImage(String url, BoxFit fit, {double? height, double? width}) {
    return CachedNetworkImage(
      imageUrl: url,
      fadeInCurve: Curves.easeIn,
      fit: fit,
      height: height,
      width: width,
      fadeInDuration: const Duration(milliseconds: 300),
      errorWidget: (context, url, error) => Center(
          child: CachedNetworkImage(imageUrl: ApiPaths.defaultImage, fadeInCurve: Curves.easeIn,
            fit: fit, height: height,
            width: width,)),
    );
  }

  static CachedNetworkImageProvider loadNetworkImageObject(
    String url,
  ) {
    return CachedNetworkImageProvider(url, errorListener: () {
      url = ApiPaths.defaultImage;
    });
  }
}
