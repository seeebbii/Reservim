import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:reservim/core/model/Blogs/category_homepage.model.dart';
import 'package:reservim/core/model/blogs_category.model.dart';
import 'package:reservim/core/model/cities.model.dart';
import 'package:reservim/core/model/shops/all_deals_model.dart';
import 'package:reservim/core/model/shops/city.model.dart';
import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/core/model/shops/search_query.model.dart';
import 'package:reservim/core/model/shops/user_liked_shops.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';

import '../model/Blogs/blogs_homepage.model.dart';
import '../model/filter.model.dart';
import '../model/shops/recommended.model.dart';
import '../model/shops/special_offers.model.dart';

class HomePageNotifier extends ChangeNotifier {
  BlogsHomePageModel blogsHomePage = BlogsHomePageModel();
  BlogsHomePageModel categoryBlogs = BlogsHomePageModel();
  BlogsCategoryModel blogsCategoryModel = BlogsCategoryModel();
  CategoryHomePageModel categoryHomePageModel = CategoryHomePageModel();
  RecommendedModel recommendedModel = RecommendedModel();
  SpecialOffersModel specialOffersModel = SpecialOffersModel();
  UserLikedShopsModel userLikedShopsModel = UserLikedShopsModel();
  CitiesModel citiesModel = CitiesModel();
  CityModel selectedCity = CityModel();
  List<DealsModel> dealsModel = <DealsModel>[];
  SearchQueryModel searchQueryModel = SearchQueryModel();

  List<FilterModel> filterModel = <FilterModel>[
    FilterModel(name: "Loest fee", isSelected: false),
    FilterModel(name: "Ladies", isSelected: false),
    FilterModel(name: "Babies", isSelected: false),
    FilterModel(name: "Men’s", isSelected: false),
    FilterModel(name: "Available today", isSelected: false),
    FilterModel(name: "Under 300", isSelected: false),
    FilterModel(name: "Under 500", isSelected: false),
    FilterModel(name: "Top rated", isSelected: false),
  ];

  void updateCategoryModel(int index) {
    for (var element in categoryHomePageModel.data!) {
      element.isSelected = false;
    }
    categoryHomePageModel.data![index].isSelected = true;
    debugPrint(categoryHomePageModel.data![index].slug);
    notifyListeners();
    filterQuery(type: "category");
  }

  CategoryData? getSelectedCategory() {
    return categoryHomePageModel.data
        ?.firstWhere((element) => element.isSelected == true);
  }

  Future<void> updateRecommendedModel(int index, bool value) async {
    recommendedModel.shop![index].isLiked = value;
    notifyListeners();
    String shopId = recommendedModel.shop![index].id.toString();
    if (value) {
      var response = await ApiService.request(ApiPaths.likeShop + shopId,
          method: RequestMethod.GET);
    } else {
      await ApiService.request(ApiPaths.unLikeShop + shopId,
          method: RequestMethod.GET);
    }
    getUserLiked();
  }

  Future<void> updateFavouritesModel(int index, bool value) async {
    userLikedShopsModel.shop![index].isLiked = value;
    notifyListeners();
    String shopId = userLikedShopsModel.shop![index].id.toString();
    if (value) {
      await ApiService.request(ApiPaths.likeShop + shopId,
          method: RequestMethod.GET);
    } else {
      await ApiService.request(ApiPaths.unLikeShop + shopId,
          method: RequestMethod.GET);
    }
    getUserLiked();
  }

  Future<void> updateSpecialOffers(int index, bool value) async {
    specialOffersModel.shops![index].isLiked = value;
    notifyListeners();
    String shopId = specialOffersModel.shops![index].id.toString();
    if (value) {
      await ApiService.request(ApiPaths.likeShop + shopId,
          method: RequestMethod.GET);
    } else {
      await ApiService.request(ApiPaths.unLikeShop + shopId,
          method: RequestMethod.GET);
    }
    getUserLiked();
  }

  Future<BlogsHomePageModel> getHomePageBlogs() async {
    var response = await ApiService.request(ApiPaths.homePageBlogs,
        method: RequestMethod.GET);

    blogsHomePage = BlogsHomePageModel.fromJson(response!);
    notifyListeners();

    return blogsHomePage;
  }

  Future<BlogsHomePageModel> getCategoryBlogs({required int id}) async {
    var response = await ApiService.request(ApiPaths.categoryBlogs + "$id",
        method: RequestMethod.GET);

    categoryBlogs = BlogsHomePageModel.fromJson(response!);
    notifyListeners();

    return categoryBlogs;
  }

  Future<BlogsCategoryModel> getBlogsCategories() async {
    var response = await ApiService.request(ApiPaths.getBlogCategories,
        method: RequestMethod.GET);

    blogsCategoryModel = BlogsCategoryModel.fromJson(response!);
    notifyListeners();

    return blogsCategoryModel;
  }

  Future<List<DealsModel>> getBestDeals() async {
    var response =
        await ApiService.request(ApiPaths.allDeals, method: RequestMethod.GET);

    Iterable obj = response!['bestdeals'];

    List<DealsModel> temp = obj.map((e) => DealsModel.fromJson(e)).toList();

    dealsModel = temp;
    notifyListeners();

    return dealsModel;
  }

  Future<CategoryHomePageModel> getHomePageCategory() async {
    var response = await ApiService.request(ApiPaths.getSelectedCategories,
        method: RequestMethod.GET);

    categoryHomePageModel = CategoryHomePageModel.fromJson(response!);
    categoryHomePageModel.data?[0].isSelected = true;
    notifyListeners();

    return categoryHomePageModel;
  }

  Future<RecommendedModel> getRecommendedList() async {
    var response = await ApiService.request(ApiPaths.recommendedList,
        method: RequestMethod.GET);

    print(response);

    recommendedModel = RecommendedModel.fromJson(response!);
    notifyListeners();

    return recommendedModel;
  }

  Future<SpecialOffersModel> getSpecialOffersList() async {
    var response = await ApiService.request(ApiPaths.specialOffers,
        method: RequestMethod.GET);
    print(response);
    specialOffersModel = SpecialOffersModel.fromJson(response!);
    notifyListeners();

    return specialOffersModel;
  }

  Future<UserLikedShopsModel> getUserLiked() async {
    var response = await ApiService.request(ApiPaths.getUserLikedShops,
        method: RequestMethod.GET);

    userLikedShopsModel = UserLikedShopsModel.fromJson(response!);
    userLikedShopsModel.shop?.forEach((element) {
      element.isLiked = true;
      notifyListeners();
    });
    notifyListeners();

    log("USER LIKED: ${userLikedShopsModel.toJson()}");

    return userLikedShopsModel;
  }

  Future<CitiesModel> getCities(BuildContext context) async {
    var response =
        await ApiService.request(ApiPaths.getCities, method: RequestMethod.GET);

    citiesModel = CitiesModel.fromJson(response!);
    if (citiesModel.cities != null) {
      selectedCity = citiesModel.cities!.firstWhere(
          (element) =>
              element.id.toString() ==
              context
                  .read<AuthenticationNotifier>()
                  .currentUser
                  .data
                  ?.city
                  .toString(),
          orElse: () => CityModel(
                id: null,
              ));
    }
    notifyListeners();

    return citiesModel;
  }

  void updateCity(CityModel? city) async {
    selectedCity = city!;
    notifyListeners();

    await filterQuery(type: "category");
    EasyLoading.dismiss();
  }

  Future<void> searchQuery(String query) async {
    var response = await ApiService.request(
      ApiPaths.getSearchedServices + query,
      method: RequestMethod.GET,
    );
    // print(response);
    if (response != null) {
      searchQueryModel = SearchQueryModel.fromJson(response);
      notifyListeners();
      log("SEARCHED: ${searchQueryModel.toJson()}");
    }
  }

  void updateChip(int index) {
    if (filterModel.elementAt(index).isSelected == true) {
      filterModel.elementAt(index).isSelected = false;
      notifyListeners();
    } else {
      filterModel.elementAt(index).isSelected = true;
      notifyListeners();
    }
    var checks = filterModel.where((element) => element.isSelected != false);
    if (checks.isEmpty) {
      getRecommendedList();
    } else {
      filterQuery(type: "service");
    }
  }

  void allChips(bool select) {
    for (var val in filterModel) {
      val.isSelected = select;
      notifyListeners();
    }
    if (select == false) {
      getRecommendedList();
    } else {
      filterQuery(type: "service");
    }
  }

  Future<void> filterQuery({
    required String type,
  }) async {
    EasyLoading.show(status: 'loading...');
    var cat = categoryHomePageModel.data!
        .where((element) => element.isSelected ?? false);
    String catSelected = "hair-salon";
    if (cat.isNotEmpty) {
      catSelected = cat.first.slug!;
      log("FILTERING: $catSelected");
    }

    var response = await ApiService.request(
        ApiPaths.baseURL +
            "filter-search/lowest_price=${filterModel[0].isSelected}&/ladies=${filterModel[1].isSelected}&/babies=${filterModel[2].isSelected}&/mens=${filterModel[3].isSelected}&/today=${filterModel[4].isSelected}&/under_300=${filterModel[5].isSelected}&/under_500=${filterModel[6].isSelected}&/toprated=${filterModel[7].isSelected}/$type/$catSelected/${selectedCity.name}/null/15",
        method: RequestMethod.GET);
    // log("$response");
    recommendedModel = RecommendedModel.fromJson(response!);
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> searchServicesShops({
    required String query,
  }) async {
    var response = await ApiService.request(
        ApiPaths.baseURL +
            "filter-search/lowest_price=${filterModel[0].isSelected}&/ladies=${filterModel[1].isSelected}&/babies=${filterModel[2].isSelected}&/mens=${filterModel[3].isSelected}&/today=${filterModel[4].isSelected}&/under_300=${filterModel[5].isSelected}&/under_500=${filterModel[6].isSelected}&/toprated=${filterModel[7].isSelected}/service/$query/${selectedCity.name}/null/15",
        method: RequestMethod.GET);
    // log("$response");
    recommendedModel = RecommendedModel.fromJson(response!);
    notifyListeners();
  }
}
