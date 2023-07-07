import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/components/BottomSheets/custom_bottom_sheet.dart';
import 'package:reservim/core/model/cities.model.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/utils/hive_database.dart';
import 'package:reservim/meta/views/main/explore/widgets/explore_categories_listview.dart';
import 'package:reservim/meta/views/main/explore/widgets/explore_recommended.dart';
import 'package:reservim/meta/views/main/explore/widgets/filter_widget.dart';

import '../../../../components/dialog/custom_dialogs.dart';
import '../../../../core/model/shops/city.model.dart';
import '../../../../core/notifier/homepage.notifier.dart';
import '../../../utils/app_theme.dart';
import '../home/widgets/recommended_listview.dart';

class ExploreNavBarScreen extends StatefulWidget {
  const ExploreNavBarScreen({Key? key}) : super(key: key);

  @override
  State<ExploreNavBarScreen> createState() => _ExploreNavBarScreenState();
}

class _ExploreNavBarScreenState extends State<ExploreNavBarScreen> {
  final textEditingController = TextEditingController();
  Future<CitiesModel>? loadCities;

  @override
  void initState() {
    loadCities = context.read<HomePageNotifier>().getCities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screenBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.sp),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
            padding: EdgeInsets.only(bottom: 3.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                const ExploreCategoriesListView(),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                        CustomBottomSheet(
                          widget: const FilterWidget(),
                        ),
                        isDismissible: false,
                        enableDrag: false,
                        useRootNavigator: true,
                        isScrollControlled: true);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 0.01.sh),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.05.sw, vertical: 0.01.sh),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Filter",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(
                          width: 0.03.sw,
                        ),
                        SvgPicture.asset(
                          Assets.filterIcon,
                          height: 20.sp,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            context.watch<HomePageNotifier>().selectedCity.name == null
                ? const SizedBox.shrink()
                : ListTile(
                    title: Text(
                      "${context.watch<HomePageNotifier>().getSelectedCategory()?.name} salon in ${context.watch<HomePageNotifier>().selectedCity.name} Pakistan(5549)",
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: AppTheme.blackColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Last Updated On  ${formatDate(DateTime.parse(context.watch<HomePageNotifier>().selectedCity.updatedAt.toString()))}",
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: AppTheme.blackColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400),
                    )),
            _createAreaTextField(),
            SizedBox(
              height: 0.02.sh,
            ),
            const RecommendedListView(),
            SizedBox(
              height: 0.02.sh,
            ),
            const ExploreRecommended()
          ],
        ),
      ),
    );
  }

  Widget _createAreaTextField() {
    return Consumer<HomePageNotifier>(builder: (ctx, homePageNotifier, child) {
      return context.watch<AuthenticationNotifier>().currentUser.data?.id !=
              null
          ? FutureBuilder(
              future: loadCities,
              builder: (_, AsyncSnapshot<CitiesModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        homePageNotifier.citiesModel.cities == null ||
                    homePageNotifier.selectedCity.id == null) {
                  return const SizedBox.shrink();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: SizedBox(
                      height: 0.07.sh,
                      child: DropdownButtonFormField<CityModel>(
                          hint: Text(
                            "Select area",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: AppTheme.blackColor),
                          ),
                          focusColor: AppTheme.textFieldUnderline,
                          decoration: InputDecoration(
                            isDense: true,
                            focusColor: AppTheme.textFieldUnderline,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppTheme.textFieldUnderline, width: 2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppTheme.textFieldUnderline, width: 2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            filled: true,
                            fillColor: AppTheme.whiteColor,
                          ),
                          autofocus: false,
                          dropdownColor: AppTheme.whiteColor,
                          value: homePageNotifier.selectedCity,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: AppTheme.blackColor, fontSize: 13.sp),
                          onChanged: homePageNotifier.updateCity,
                          items: homePageNotifier.citiesModel.cities!
                              .map((e) => DropdownMenuItem<CityModel>(
                                    child: Text(e.name!),
                                    value: e,
                                  ))
                              .toList()),
                    ),
                  );
                }
              })
          : const SizedBox.shrink();
    });
  }

  Widget _bookYourServicesFormField() {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).unfocus();
        CustomDialogs.displaySearchDialog(context);
      },
      controller: textEditingController,
      obscureText: false,
      decoration: InputDecoration(
        fillColor: AppTheme.whiteColor,
        filled: true,
        isDense: true,
        hintText: "Book your services...",
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
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
