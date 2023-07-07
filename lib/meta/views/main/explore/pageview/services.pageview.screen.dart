import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/strings.constant.dart';
import 'package:reservim/components/widgets/app_divider.dart';
import 'package:reservim/components/widgets/view_photo.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/model/shops/shop_details.model.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';

import '../../../../../app/constants/controller.constant.dart';
import '../../../../../components/dialog/custom_dialogs.dart';
import '../../../../../core/notifier/appointments.notifier.dart';
import '../../../../../core/notifier/authentication.notifier.dart';
import '../../../../../core/router/router_generator.dart';
import '../../../../utils/app_theme.dart';
import '../../home/widgets/deals_listview.dart';
import '../widgets/pageview_category_widget.dart';

class ServicesPageViewScreen extends StatefulWidget {
  const ServicesPageViewScreen({Key? key}) : super(key: key);

  @override
  State<ServicesPageViewScreen> createState() => _ServicesPageViewScreenState();
}

class _ServicesPageViewScreenState extends State<ServicesPageViewScreen> {
  final textEditingController = TextEditingController();
  bool isSearchEmpty = true;
  List<AllServices> searchedServices = <AllServices>[];

  void searchedQuery(String query) {
    ExplorePageViewNotifier exploreNotifier =
        Provider.of<ExplorePageViewNotifier>(context, listen: false);

    var value = exploreNotifier.shopDetailsModel.allServices
        ?.where((e) =>
            e.defaultService?.name
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false)
        .toList();

    setState(() {
      searchedServices = value ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.screenBackgroundColor,
      body: Consumer<ExplorePageViewNotifier>(
          builder: (_, exploreNotifier, child) {
        ShopModel obj = exploreNotifier.shopModel;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: true,
              collapsedHeight: 200,
              automaticallyImplyLeading: false,
              flexibleSpace: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(ViewPhoto(
                        galleryItems: [obj.logo!],
                        path: ApiPaths.imageBaseUrl +
                            "/uploads/business/hair-salon-shopList/",
                      ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(ApiPaths.imageBaseUrl +
                              "/uploads/business/hair-salon-shopList/" +
                              obj.logo.toString()),
                          fit: BoxFit.fill),
                    )),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(horizontal: 0.010.sw, vertical: 0.035.sh),
                    padding: EdgeInsets.only(bottom: 3.sp, left: 35.sp, right: 20.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              height: 40,
                              width: 40,
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
                                onPressed: () =>
                                    BaseHelper.openDialPad(phoneNumber),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              expandedHeight: 250,
              leading: GestureDetector(
                onTap: () {
                  context.read<ExplorePageViewNotifier>().onPageChange(0);
                  context
                      .read<AppointmentsNotifier>()
                      .bookAppointmentModel =
                      BookAppointmentModel(
                          service: [],
                          jsonService: [],
                          staffName: [],
                          startTime: [],
                          endTime: [],
                          durationHour: [],
                          durationMinute: []);

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
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Text(
                      "${obj.salonName}",
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Text(
                      "${obj.address}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppTheme.blackColor),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    exploreNotifier.shopDetailsModel.deals?.isEmpty ?? true
                        ? const SizedBox.shrink()
                        : DealsListView(
                            dealsModel:
                                exploreNotifier.shopDetailsModel.deals ?? [],
                          ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    const PageViewCategoryWidget(),
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    Text(
                      isSearchEmpty ? "Services" : "Searched services",
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    AppDivider(
                      dividerColor: AppTheme.primaryColor,
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    Container(
                        height: 0.055.sh,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: _searchForServiceFormField()),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    isSearchEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: context
                                    .read<ExplorePageViewNotifier>()
                                    .shopDetailsModel
                                    .topServices
                                    ?.length ??
                                0,
                            itemBuilder: (_, index) {
                              TopServices topService = context
                                  .read<ExplorePageViewNotifier>()
                                  .shopDetailsModel
                                  .topServices![index];
                              if (index == 0) {
                                return Column(
                                  children: [
                                    AppDivider(
                                      thickness: 1.5,
                                      dividerColor: AppTheme.dividerColor,
                                    ),
                                    _createListTileForTopServices(topService)
                                  ],
                                );
                              } else {
                                return _createListTileForTopServices(
                                    topService);
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return AppDivider(
                                thickness: 1.5,
                                dividerColor: AppTheme.dividerColor,
                              );
                            })
                        : const SizedBox.shrink(),
                    isSearchEmpty
                        ? AppDivider(
                            thickness: 1.5,
                            dividerColor: AppTheme.dividerColor,
                          )
                        : const SizedBox.shrink(),
                    ...isSearchEmpty
                        ? exploreNotifier.groupedServicesModel
                            .map(
                              (e) => ExpansionTile(
                                iconColor: AppTheme.blackColor,
                                collapsedIconColor: AppTheme.blackColor,
                                tilePadding: EdgeInsets.zero,
                                initiallyExpanded: true,
                                title: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "${e.categoryName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(
                                            color: AppTheme.blackColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18.sp),
                                  ),
                                ),
                                children: e.services!
                                    .asMap()
                                    .entries
                                    .map((e) => Column(
                                          children: [
                                            AppDivider(
                                              thickness: 1.5,
                                              dividerColor:
                                                  AppTheme.dividerColor,
                                            ),
                                            _createListTileForAllServices(
                                                e.value),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            )
                            .toList()
                        : [],
                    !isSearchEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchedServices.length,
                            itemBuilder: (_, index) {
                              AllServices allServices = searchedServices[index];
                              if (index == 0) {
                                return Column(
                                  children: [
                                    AppDivider(
                                      thickness: 1.5,
                                      dividerColor: AppTheme.dividerColor,
                                    ),
                                    _createListTileForAllServices(allServices)
                                  ],
                                );
                              } else {
                                return _createListTileForAllServices(
                                    allServices);
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return AppDivider(
                                thickness: 1.5,
                                dividerColor: AppTheme.dividerColor,
                              );
                            })
                        : const SizedBox.shrink(),
                    AppDivider(
                      thickness: 1.5,
                      dividerColor: AppTheme.dividerColor,
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _createListTileForTopServices(TopServices pack) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.sp),
      title: Row(
        children: [
          Container(
            width: 0.2.sh,
            margin: EdgeInsets.only(right: 0.03.sw),
            child: Text(
              "${pack.defaultService!.name}",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 13.sp, color: AppTheme.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs ${pack.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 12.sp, color: AppTheme.blackColor),
                ),
                Text(
                  pack.durationHour != 0
                      ? pack.durationMinute != 0
                          ? " ${pack.durationHour}h ${pack.durationMinute}min"
                          : " ${pack.durationHour}h"
                      : "${pack.durationMinute}min",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 12.sp, color: AppTheme.blackColor),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                SizedBox(
                  height: 0.03.sh,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppTheme.primaryColor,
                          primary: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r))),
                      onPressed: () {
                        AppointmentsNotifier appointmentNotifier =
                            Provider.of<AppointmentsNotifier>(context,
                                listen: false);

                        appointmentNotifier.bookAppointmentModel.shopId =
                            pack.shopId.toString();
                        appointmentNotifier.addServices(
                            Service(
                                serviceId: pack.serviceId.toString(),
                                price: pack.price.toString()),
                            JsonService(
                                name: [pack.defaultService!.name.toString()],
                                price: [pack.price!]));
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .durationHour!
                            .add(pack.durationHour!);
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .durationMinute!
                            .add(pack.durationMinute!);
                        navigationController.navigateToNamedWithArg(
                            RouteGenerator.calenderBookScreen, {
                          'durationHour': pack.durationHour,
                          'durationMinute': pack.durationMinute,
                        });
                        debugPrint(
                            "${appointmentNotifier.bookAppointmentModel.toJson()}");
                      },
                      child: Text(
                        "Book",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 10.sp),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createListTileForAllServices(AllServices pack) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.sp),
      title: Row(
        children: [
          Container(
            width: 0.2.sh,
            margin: EdgeInsets.only(right: 0.03.sw),
            child: Text(
              "${pack.defaultService!.name}",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 13.sp, color: AppTheme.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs ${pack.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 12.sp, color: AppTheme.blackColor),
                ),
                Text(
                  pack.durationHour != 0
                      ? pack.durationMinute != 0
                          ? " ${pack.durationHour}h ${pack.durationMinute}min"
                          : " ${pack.durationHour}h"
                      : "${pack.durationMinute}min",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 12.sp, color: AppTheme.blackColor),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                SizedBox(
                  height: 0.03.sh,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppTheme.primaryColor,
                          primary: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r))),
                      onPressed: () {
                        AppointmentsNotifier appointmentNotifier =
                            Provider.of<AppointmentsNotifier>(context,
                                listen: false);
                        appointmentNotifier.bookAppointmentModel.shopId =
                            pack.shopId.toString();

                        appointmentNotifier.addServices(
                            Service(
                                serviceId: pack.serviceId.toString(),
                                price: pack.price.toString()),
                            JsonService(
                                name: [pack.defaultService!.name.toString()],
                                price: [pack.price!]));
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .durationHour!
                            .add(pack.durationHour!);
                        context
                            .read<AppointmentsNotifier>()
                            .bookAppointmentModel
                            .durationMinute!
                            .add(pack.durationMinute!);
                        navigationController.navigateToNamedWithArg(
                            RouteGenerator.calenderBookScreen, {
                          'durationHour': pack.durationHour,
                          'durationMinute': pack.durationMinute,
                        });
                        debugPrint(
                            "${appointmentNotifier.bookAppointmentModel.toJson()}");
                      },
                      child: Text(
                        "Book",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 10.sp),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchForServiceFormField() {
    return TextFormField(
      controller: textEditingController,
      obscureText: false,
      onChanged: (str) {
        if (str.isEmpty) {
          setState(() {
            isSearchEmpty = true;
          });
        } else {
          setState(() {
            isSearchEmpty = false;
          });
          searchedQuery(str);
        }
      },
      decoration: InputDecoration(
        isDense: true,
        fillColor: AppTheme.whiteColor,
        filled: true,
        hintText: "Search for a service",
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
        fillColor: AppTheme.whiteColor.withOpacity(0.8),
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
