import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/model/shops/city.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/model/shops/search_query.model.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../../core/model/shops/services.model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              splashRadius: 1,
              onPressed: () => navigationController.goBack(),
              icon: const Icon(
                Icons.highlight_off,
                color: AppTheme.blackColor,
              ))
        ],
      ),
      body: Consumer<HomePageNotifier>(
        builder: (context, notifier, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
              child: Column(
                children: [
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: TextEditingController(
                          text: notifier.selectedCity.name),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: AppTheme.blackColor),
                      decoration: InputDecoration(
                        fillColor:
                            AppTheme.subtitleLightGreyColor.withOpacity(0.2),
                        filled: true,
                        hintText: "City",
                        hintStyle: Theme.of(context)
                            .inputDecorationTheme
                            .hintStyle
                            ?.copyWith(
                                color: AppTheme.blackColor.withOpacity(0.6)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                        ),
                      ),
                    ),
                    hideOnEmpty: true,
                    hideSuggestionsOnKeyboardHide: false,
                    suggestionsCallback: (pattern) async {
                      return notifier.citiesModel.cities!
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                      // return await BackendService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, CityModel suggestion) {
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(suggestion.name!),
                      );
                    },
                    onSuggestionSelected: (CityModel suggestion) {
                      EasyLoading.show(status: 'loading...');
                      notifier.updateCity(suggestion);
                      navigationController.goBack();
                    },
                  ),
                  SizedBox(
                    height: 0.1.sh,
                  ),
                  TextField(
                    controller: searchController,
                    onChanged: (String val) {
                      notifier.searchQuery(val);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor:
                          AppTheme.subtitleLightGreyColor.withOpacity(0.2),
                      filled: true,
                      hintText: "Hair trim",
                      hintStyle: Theme.of(context)
                          .inputDecorationTheme
                          .hintStyle
                          ?.copyWith(
                              color: AppTheme.blackColor.withOpacity(0.6)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  searchController.text.trim().isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Services",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.bold)),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    notifier.searchQueryModel.services?.length,
                                itemBuilder: (_, index) {
                                  Services obj = notifier
                                      .searchQueryModel.services![index];
                                  return ListTile(
                                    onTap: () async {
                                      EasyLoading.show(status: 'loading...');
                                      FocusScope.of(context).unfocus();
                                      navigationController.goBack();
                                      await notifier.searchServicesShops(
                                          query: "${obj.name}");
                                      EasyLoading.dismiss();
                                    },
                                    minLeadingWidth: 0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.search),
                                    title: Text("${obj.name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontSize: 14.sp,
                                              color: AppTheme.blackColor,
                                            )),
                                  );
                                }),
                            Text("Shops",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.bold)),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    notifier.searchQueryModel.shops?.length,
                                itemBuilder: (_, index) {
                                  ShopModel obj =
                                      notifier.searchQueryModel.shops![index];
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 0.01.sh),
                                    child: InkWell(
                                      onTap: () {
                                        print(obj.id);
                                        context
                                            .read<ExplorePageViewNotifier>()
                                            .currentModel(obj);
                                        navigationController.navigateToNamed(
                                            RouteGenerator
                                                .recommendedServiceExploreScreen);
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.shopComb,
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: 0.01.sw,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0.01.sh,
                                                    horizontal: 0.05.sw),
                                                child: Text("${obj.name}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        ?.copyWith(
                                                          color: AppTheme
                                                              .blackColor,
                                                          fontSize: 14.sp,
                                                        )),
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.shopLocation,
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: 0.01.sw,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0.01.sh,
                                                    horizontal: 0.05.sw),
                                                child: Text("${obj.address}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        ?.copyWith(
                                                          color: AppTheme
                                                              .unSelectedCategoryColor,
                                                          fontSize: 14.sp,
                                                        )),
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
