import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/model/shops/shop_details.model.dart';
import 'package:reservim/meta/views/main/explore/pageview/details.pageview.screen.dart';
import 'package:reservim/meta/views/main/explore/pageview/gallery.pageview.screen.dart';
import 'package:reservim/meta/views/main/explore/pageview/services.pageview.screen.dart';

import '../../meta/views/main/explore/pageview/reviews.pageview.screen.dart';

class ExplorePageViewNotifier extends ChangeNotifier {
  ShopModel shopModel = ShopModel();
  ShopDetailsModel shopDetailsModel = ShopDetailsModel();
  List<GroupedServicesModel> groupedServicesModel = <GroupedServicesModel>[];
  int currentPage = 0;
  PageController pageViewController = PageController();

  void currentModel(ShopModel obj) {
    shopModel = obj;
    notifyListeners();
  }

  void onPageChange(int index) {
    currentPage = index;
    notifyListeners();
  }

  void animateToIndex(int pageIndex) {
    pageViewController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
    currentPage = pageIndex;
    notifyListeners();
  }

  Future<ShopDetailsModel> getShopDetails(int id) async {
    shopDetailsModel = ShopDetailsModel();
    log("Fetching shop details for ID: $id");
    var response = await ApiService.request(
        ApiPaths.shopDetails + id.toString(),
        method: RequestMethod.GET);
    log("$response");
    shopDetailsModel = ShopDetailsModel.fromJson(response!);
    log("Shop Details:  ${shopDetailsModel.toJson()}");
    notifyListeners();
    await groupServiceList();
    return shopDetailsModel;
  }

  Future<void> groupServiceList() async {
    var set = <String>{};
    List<AllServices> uniqueList = shopDetailsModel.allServices!
        .where((e) => set.add(e.category!.name!))
        .toList();
    var catList = uniqueList.map((e) => e.category!.name);
    groupedServicesModel = catList
        .map((e) => GroupedServicesModel(categoryName: e, services: []))
        .toList();
    notifyListeners();
    for (int i = 0; i < shopDetailsModel.allServices!.length; i++) {
      for (int j = 0; j < groupedServicesModel.length; j++) {
        if (shopDetailsModel.allServices![i].category!.name ==
            groupedServicesModel[j].categoryName) {
          groupedServicesModel[j]
              .services!
              .add(shopDetailsModel.allServices![i]);
          notifyListeners();
        }
      }
    }
  }

  final List<Widget> pages = const [
    ServicesPageViewScreen(),
    ReviewsPageViewScreen(),
    GalleryPageViewScreen(),
    DetailsPageViewScreen(),
  ];
}
