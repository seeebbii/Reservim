import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:reservim/core/model/shops/all_deals_model.dart';
import 'package:reservim/core/model/shops/deal_details_model.dart';
import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/meta/views/main/home/widgets/all_deals_pageview/best_deals.pageview.dart';
import 'package:reservim/meta/views/main/home/widgets/all_deals_pageview/best_deals_women.pageview.dart';
import 'package:reservim/meta/views/main/home/widgets/all_deals_pageview/fifty_percentage.pageview.dart';
import 'package:reservim/meta/views/main/home/widgets/all_deals_pageview/twenty_percentage.pageview.dart';

import '../../meta/views/main/home/widgets/all_deals_pageview/best_deals_male.pageview.dart';
import '../model/shops/deals_categories.model.dart';

class AllDealsNotifier extends ChangeNotifier {
  int currentSelectedCategory = 0;
  PageController pageViewController = PageController();
  AllDealsModel allDealsModel = AllDealsModel();
  DealDetailsModel dealDetailsModel = DealDetailsModel();

  List<Widget> pages = <Widget>[
    BestDealsPageView(),
    BestDealsWomenPageView(),
    BeastDealsMalePageView(),
    FiftyPercentagePageView(),
    TwentyPercentagePageView(),
  ];

  List<DealsCategoriesModel> categories = <DealsCategoriesModel>[
    DealsCategoriesModel(name: "BEST DEALS", slug: "bestdeals"),
    DealsCategoriesModel(name: "BEST DEALS WOMEN", slug: "bestdealswomen"),
    DealsCategoriesModel(name: "BEST DEALS MEN", slug: "bestdealsmen"),
    DealsCategoriesModel(name: "50% DEALS", slug: "fiftypercentdeals"),
    DealsCategoriesModel(name: "20% DEALS", slug: "twentypercentdeals"),
  ];

  Future<DealDetailsModel> getHomePageCategory({required int dealId}) async {
    var response = await ApiService.request("${ApiPaths.dealDetails}$dealId",
        method: RequestMethod.GET);

    dealDetailsModel = DealDetailsModel.fromJson(response!);
    notifyListeners();
    return dealDetailsModel;
  }

  Future<AllDealsModel> getAllDeals() async {
    var response =
        await ApiService.request(ApiPaths.allDeals, method: RequestMethod.GET);
    Iterable bestDeals = response!['bestdeals'];
    Iterable bestDealsWomen = response['bestdealswomen'];
    Iterable bestDealsMen = response['bestdealsmen'];
    Iterable fiftyDeals = response['fiftypercentdeals'];
    Iterable twentyDeals = response['twentypercentdeals'];

    AllDealsModel temp = AllDealsModel();

    temp.bestDeals = bestDeals.map((e) => DealsModel.fromJson(e)).toList();
    temp.bestDealsWomen =
        bestDealsWomen.map((e) => DealsModel.fromJson(e)).toList();
    temp.bestDealsMen =
        bestDealsMen.map((e) => DealsModel.fromJson(e)).toList();
    temp.fiftyPercentDeals =
        fiftyDeals.map((e) => DealsModel.fromJson(e)).toList();
    temp.twentyPercentDeals =
        twentyDeals.map((e) => DealsModel.fromJson(e)).toList();

    allDealsModel = temp;
    notifyListeners();

    return allDealsModel;
  }

  Future<AllDealsModel> getAllCityDeals({required String cityId}) async {
    var response = await ApiService.request(ApiPaths.cityDeals + "$cityId",
        method: RequestMethod.GET);
    Iterable bestDeals = response!['bestdeals'];
    Iterable bestDealsWomen = response['bestdealswomen'];
    Iterable bestDealsMen = response['bestdealsmen'];
    Iterable fiftyDeals = response['fiftypercentdeals'];
    Iterable twentyDeals = response['twentypercentdeals'];

    AllDealsModel temp = AllDealsModel();

    temp.bestDeals = bestDeals.map((e) => DealsModel.fromJson(e)).toList();
    temp.bestDealsWomen =
        bestDealsWomen.map((e) => DealsModel.fromJson(e)).toList();
    temp.bestDealsMen =
        bestDealsMen.map((e) => DealsModel.fromJson(e)).toList();
    temp.fiftyPercentDeals =
        fiftyDeals.map((e) => DealsModel.fromJson(e)).toList();
    temp.twentyPercentDeals =
        twentyDeals.map((e) => DealsModel.fromJson(e)).toList();

    allDealsModel = temp;
    notifyListeners();

    return allDealsModel;
  }

  void updateCategoryIndex(int index) {
    currentSelectedCategory = index;
    notifyListeners();
  }

  void animateToIndex(int pageIndex) {
    pageViewController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
    currentSelectedCategory = pageIndex;
    notifyListeners();
  }
}
