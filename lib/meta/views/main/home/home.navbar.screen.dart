import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/assets.constant.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/core/notifier/all_deals.notifier.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/core/notifier/map.notifier.dart';
import 'package:reservim/core/notifier/navbar.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/utils/hive_database.dart';
import 'package:reservim/meta/views/main/home/widgets/blog_listview.dart';
import 'package:reservim/meta/views/main/home/widgets/categories_list_view.dart';
import 'package:reservim/meta/views/main/home/widgets/deals_listview.dart';
import 'package:reservim/meta/views/main/home/widgets/favorite_listview.dart';
import 'package:reservim/meta/views/main/home/widgets/recommended_listview.dart';
import 'package:reservim/meta/views/main/home/widgets/special_offers_listview.dart';

import '../../../../app/constants/strings.constant.dart';
import '../../../../components/dialog/custom_dialogs.dart';

class HomeNavBarScreen extends StatefulWidget {
  const HomeNavBarScreen({Key? key}) : super(key: key);

  @override
  State<HomeNavBarScreen> createState() => _HomeNavBarScreenState();
}

class _HomeNavBarScreenState extends State<HomeNavBarScreen> {
  final TextEditingController textEditingController = TextEditingController();

  Future? loadLatestUserAppointments;
  Future<List<DealsModel>>? loadBestDeals;

  @override
  void initState() {
    // ASKING FOR USER LOCATION PERMISSION
    context.read<MapNotifier>().listenToUserLocation();

    loadLatestUserAppointments =
        context.read<AppointmentsNotifier>().getUserLatestAppointment();
    loadBestDeals = context.read<HomePageNotifier>().getBestDeals();
    // loadCityDeals = context.read<HomePageNotifier>().getCityDeals(int.parse(HiveDatabase.getValue(HiveDatabase.userCityId).toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.screenBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.sp),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
              padding: EdgeInsets.only(bottom: 3.sp),
              child: Row(
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
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppTheme.selectedYellowColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          Icons.phone,
                          color: AppTheme.blackColor,
                          size: 20.sp,
                        ),
                        onPressed: () => BaseHelper.openDialPad(phoneNumber),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.02.sh,
              ),
              _buildHomeServiceContainer(),
              SizedBox(
                height: 0.02.sh,
              ),
              const CategoriesListView(),
              SizedBox(
                height: 0.02.sh,
              ),
              _createStatusContainer(),
              context.watch<HomePageNotifier>().dealsModel.isEmpty
                  ? SizedBox.shrink()
                  : SizedBox(
                      height: 0.02.sh,
                    ),
              Consumer<HomePageNotifier>(builder: (context, notifier, child) {
                return FutureBuilder(
                    future: loadBestDeals,
                    builder: (_, AsyncSnapshot<List<DealsModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox.shrink();
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData &&
                          notifier.dealsModel.isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigationController.navigateToNamed(
                                    RouteGenerator.allDealsScreen);
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 0.04.sw),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Deals",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                              color: AppTheme.blackColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "VIEW MORE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                        decoration: TextDecoration.underline,
                                        color: Colors.transparent,
                                        decorationColor: AppTheme.blackColor,
                                        decorationThickness: 4,
                                        fontSize: 11.sp,
                                        fontWeight: null,
                                        shadows: [
                                          const Shadow(
                                              color: AppTheme.blackColor,
                                              offset: Offset(0, -5))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.02.sh,
                            ),
                            DealsListView(
                              dealsModel: notifier.dealsModel,
                            ),
                          ],
                        );
                      }
                    });
              }),
              SizedBox(
                height: 0.02.sh,
              ),
              const RecommendedListView(),
              SizedBox(
                height: 0.02.sh,
              ),
              const FavoriteListView(),
              SizedBox(
                height: 0.02.sh,
              ),
              const SpecialOffersListView(),
              SizedBox(
                height: 0.02.sh,
              ),
              const BlogListView(),
              SizedBox(
                height: 0.02.sh,
              ),
            ],
          ),
        ));
  }

  bool ignore = true;

  Widget _bookYourServicesFormField() {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).unfocus();
        CustomDialogs.displaySearchDialog(context);
      },
      enabled: true,
      controller: textEditingController,
      obscureText: false,
      decoration: InputDecoration(
        fillColor: AppTheme.whiteColor,
        filled: true,
        isDense: true,
        hintText: "Book your service...",
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

  Widget _buildHomeServiceContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.05.sw),
      decoration: BoxDecoration(
        // color: Colors.red
        gradient: AppTheme.homeServiceLinearGradient,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(2, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Home Service',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  Text(
                    'It is a long established fact that a of a page when looking at its layout.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 11.sp, color: AppTheme.blackColor),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppTheme.primaryColor,
                          primary: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r))),
                      onPressed: () =>
                          context.read<NavBarNotifier>().updatePageIndex(1),
                      child: Text(
                        "Explore",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Image.asset(
              Assets.man,
              scale: 2.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createStatusContainer() {
    return Consumer<AppointmentsNotifier>(builder: (ctx, notifier, child) {
      return FutureBuilder(
          future: loadLatestUserAppointments,
          builder: (_, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                notifier.userLatestAppointment.appointment == null) {
              return const SizedBox.shrink();
            } else {
              var obj = notifier.userLatestAppointment;
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.04.sw),
                  decoration: BoxDecoration(
                      color: AppTheme.unSelectedCategoryColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 0.02.sh),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Your appointments",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 0.1.sw,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: checkStatus(
                                        obj.appointment?.status ?? "")['color'],
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7.0.sp, vertical: 1.0.sp),
                                    child: Text(
                                      '${checkStatus(obj.appointment?.status ?? "")['status']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: AppTheme.blackColor,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.015.sh,
                            ),
                            Text(
                              "${obj.appointment?.user?.salonName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 0.015.sh,
                            ),
                            Text(
                              "${obj.appointment?.services?.map((e) => e.name)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 0.05.sw,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                formatMonth(DateTime.parse(
                                    obj.appointment?.date ??
                                        DateTime.now().toIso8601String())),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        fontSize: 13.sp,
                                        color: AppTheme.whiteColor,
                                        fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 0.01.sw,
                              ),
                              Text(
                                formatDay(DateTime.parse(
                                    obj.appointment?.date ??
                                        DateTime.now().toIso8601String())),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        fontSize: 18.sp,
                                        color: AppTheme.whiteColor,
                                        fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 0.01.sw,
                              ),
                              Text(
                                formatTime(DateTime.parse(
                                    obj.appointment?.date ??
                                        DateTime.now().toIso8601String())),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        fontSize: 13.sp,
                                        color: AppTheme.whiteColor,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }
          });
    });
  }
}
