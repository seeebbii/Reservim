import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/model/shops/all_deals_model.dart';
import 'package:reservim/core/model/shops/city.model.dart';
import 'package:reservim/core/notifier/all_deals.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/views/main/home/widgets/deals_categories.widget.dart';

import '../../../../../app/constants/strings.constant.dart';

class AllDealsListView extends StatefulWidget {
  const AllDealsListView({Key? key}) : super(key: key);

  @override
  State<AllDealsListView> createState() => _AllDealsListViewState();
}

class _AllDealsListViewState extends State<AllDealsListView> {
  final textEditingController = TextEditingController();
  Future<AllDealsModel>? loadAllDeals;

  @override
  void initState() {
    super.initState();
    AllDealsNotifier allDealsNotifier =
        Provider.of<AllDealsNotifier>(context, listen: false);
    loadAllDeals = allDealsNotifier.getAllDeals();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AllDealsNotifier>().updateCategoryIndex(0);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppTheme.screenBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.sp),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
              padding: EdgeInsets.only(bottom: 3.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigationController.goBack();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: 0.055.sh,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: _bookYourServicesFormField())),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Container(
                        height: 42,
                        width: 42,
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.sp, vertical: 3.5.sp),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.phone,
                            color: AppTheme.whiteColor,
                            size: 18.sp,
                          ),
                          onPressed: () => BaseHelper.openDialPad(phoneNumber),
                        ),
                      ),
                    ],
                  ),
                  const DealsCategoriesWidget(),
                ],
              ),
            ),
          ),
        ),
        body: Consumer<AllDealsNotifier>(builder: (ctx, notifier, child) {
          return FutureBuilder(
              future: loadAllDeals,
              builder: (_, AsyncSnapshot<AllDealsModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    notifier.allDealsModel.bestDeals == null) {
                  return const Center(
                    child: Text("Error occurred while fetching data"),
                  );
                } else {
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: notifier.pages,
                    onPageChanged: notifier.updateCategoryIndex,
                    controller: notifier.pageViewController,
                  );
                }
              });
        }),
      ),
    );
  }

  Widget _bookYourServicesFormField() {
    return Consumer<HomePageNotifier>(builder: (ctx, notifier, child) {
      return TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: TextEditingController(text: notifier.selectedCity.name),
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(color: AppTheme.blackColor),
          decoration: InputDecoration(
            fillColor: AppTheme.whiteColor,
            filled: true,
            isDense: true,
            hintText: "Search in your city...",
            hintStyle: Theme.of(context)
                .inputDecorationTheme
                .hintStyle
                ?.copyWith(color: AppTheme.blackColor.withOpacity(0.6)),
            prefixIcon: Icon(
              Icons.search,
              color: AppTheme.blackColor.withOpacity(0.6),
              size: 30.sp,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.blackColor.withOpacity(0.6),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50.0.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50.0.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50.0.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.hintColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50.0.r),
            ),
          ),
        ),
        hideOnEmpty: true,
        hideSuggestionsOnKeyboardHide: false,
        suggestionsCallback: (pattern) async {
          return notifier.citiesModel.cities!
              .where((element) =>
                  element.name!.toLowerCase().contains(pattern.toLowerCase()))
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
          context
              .read<AllDealsNotifier>()
              .getAllCityDeals(cityId: suggestion.id.toString());
          notifier.updateCity(suggestion);
        },
      );
    });
  }
}
