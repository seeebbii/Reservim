import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/shops/deal_details_model.dart';
import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/notifier/all_deals.notifier.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/core/notifier/authentication.notifier.dart';
import 'package:reservim/core/notifier/explore.pageview.notifier.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../../../components/widgets/app_divider.dart';

class OffDealsDetails extends StatefulWidget {
  final DealsModel obj;
  const OffDealsDetails({Key? key, required this.obj}) : super(key: key);

  @override
  State<OffDealsDetails> createState() => _OffDealsDetailsState();
}

class _OffDealsDetailsState extends State<OffDealsDetails> {

  Future<DealDetailsModel>? loadDealDetails;

  @override
  void initState() {
    loadDealDetails = context.read<AllDealsNotifier>().getHomePageCategory(dealId: widget.obj.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllDealsNotifier>(
      builder: (_, notifier, child){
        return FutureBuilder(future: loadDealDetails, builder: (_, AsyncSnapshot<DealDetailsModel> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryColor,),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && notifier.dealDetailsModel.deal?.services == null ){
            return const Center(
              child: Text("No Payments"),
            );
          }else{
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            navigationController.goBack();
                          },
                          splashRadius: 1,
                          icon: const Icon(Icons.highlight_off)),
                    ],
                  ),
                  SizedBox(height: 0.01.sh,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${notifier.dealDetailsModel.deal?.name}", style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                              fontSize: 18.sp,
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Text("Duration ", style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme
                                      .blackColor),),
                              Text(
                                notifier.dealDetailsModel.deal?.durationHour != 0
                                    ? notifier.dealDetailsModel.deal?.durationMinute !=
                                    0
                                    ? " ${notifier.dealDetailsModel.deal?.durationHour}h ${notifier.dealDetailsModel.deal?.durationMinute}min"
                                    : " ${notifier.dealDetailsModel.deal?.durationHour}h"
                                    : "${notifier.dealDetailsModel.deal?.durationMinute}min",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                    fontSize: 12.sp,
                                    color: AppTheme
                                        .blackColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Expiry ", style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme
                                      .blackColor),),
                              Text("${notifier.dealDetailsModel.deal?.expiryDate}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                    fontSize: 12.sp,
                                    color: AppTheme
                                        .blackColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.01.sh,),
                      Row(
                        children: [
                          Text("${notifier.dealDetailsModel.deal?.discount}",  style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                              fontSize: 50.sp,
                              color: AppTheme.blackColor,
                              fontWeight: FontWeight.bold),),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                    fontSize: 30.sp,
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "OFF",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(width: 0.035.sw,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notifier.dealDetailsModel.deal?.user?.salonName  == "null" ? "" : '${notifier.dealDetailsModel.deal?.user?.salonName }',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                      color: AppTheme.blackColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),

                                ),
                                SizedBox(
                                  height: 0.005.sh,
                                ),
                                Text(
                                  notifier.dealDetailsModel.deal?.user?.completeAddress  == "null" ? "" : '${ notifier.dealDetailsModel.deal?.user?.completeAddress}',
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                      color: AppTheme.blackColor,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 0.01.sh,),
                  AppDivider(
                    thickness: 1.5,
                    dividerColor: AppTheme.dividerColor,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notifier.dealDetailsModel.deal?.services?.length ?? 0,
                      itemBuilder: (_, index) {
                        Services serviceModel = notifier.dealDetailsModel.deal!.services![index];
                        print(serviceModel.toJson());
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 5.sp),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${serviceModel.name}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                      fontSize: 12.sp,
                                      color: AppTheme
                                          .blackColor),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "Rs ${serviceModel.shopService?.price}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                          fontSize: 12.sp,
                                          color: AppTheme
                                              .blackColor),
                                    ),
                                    Text(
                                      serviceModel.shopService?.durationHour != 0
                                          ? serviceModel.shopService?.durationMinute !=
                                          0
                                          ? " ${serviceModel.shopService?.durationHour}h ${serviceModel.shopService?.durationMinute}min"
                                          : " ${serviceModel.shopService?.durationHour}h"
                                          : "${serviceModel.shopService?.durationMinute}min",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                          fontSize: 12.sp,
                                          color: AppTheme
                                              .blackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return AppDivider(
                          thickness: 1.5,
                          dividerColor: AppTheme.dividerColor,
                        );
                      }),
                  AppDivider(
                    thickness: 1.5,
                    dividerColor: AppTheme.dividerColor,
                  ),
                  SizedBox(height: 0.01.sh,),
                  SizedBox(
                    height: 0.045.sh,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onPrimary: AppTheme.primaryColor,
                            primary: AppTheme.primaryColor,
                            padding:
                            EdgeInsets.symmetric(horizontal: 20.sp, vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r))),
                        onPressed: (){
                          print("DEAL ID: ${widget.obj.id}");

                          navigationController.goBack();
                          context.read<AppointmentsNotifier>().bookAppointmentModel.shopId = widget.obj.shopId.toString();
                          context.read<ExplorePageViewNotifier>().currentModel(ShopModel(id: widget.obj.user?.id, salonName:widget.obj.user?.salonName, address: widget.obj.user?.address, logo: widget.obj.user?.logo, openingClosingHours:widget.obj.user?.openingClosingHours));

                          for(int i = 0; i < widget.obj.services!.length; i++){
                            context.read<AppointmentsNotifier>().addServices(Service(serviceId: widget.obj.services![i].id.toString(), price: widget.obj.discountPrice.toString()), JsonService(name: [widget.obj.services![i].name.toString()], price: [widget.obj.discountPrice ?? 0]));
                            context.read<AppointmentsNotifier>().bookAppointmentModel.durationHour!.add(widget.obj.services![i].shopService!.durationHour!);
                            context.read<AppointmentsNotifier>().bookAppointmentModel.durationMinute!.add(widget.obj.services![i].shopService!.durationMinute!);
                          }

                          print( context.read<AppointmentsNotifier>().bookAppointmentModel.durationMinute);
                          navigationController.navigateToNamed(RouteGenerator.recommendedServiceExploreScreen);
                          navigationController.navigateToNamedWithArg(RouteGenerator.calenderBookScreen,
                              {'durationHour': widget.obj.services!.first.shopService?.durationHour,
                                'durationMinute': widget.obj.services!.first.shopService?.durationMinute,}
                          );
                        },
                        child: Text(
                          "Book",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 13.sp),
                        )),
                  ),


                ],
              ),
            );
          }
        });
      },
    );

  }
}
