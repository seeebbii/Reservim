import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/model/cities.model.dart';
import 'package:reservim/core/model/shops/city.model.dart';
import 'package:reservim/core/notifier/homepage.notifier.dart';
import 'package:reservim/meta/utils/app_theme.dart';

import '../../../../../core/notifier/authentication.notifier.dart';

class SelectCityWidget extends StatefulWidget {
  final CityModel selectedCity;
  final CitiesModel allCities;

  const SelectCityWidget(
      {Key? key, required this.allCities, required this.selectedCity})
      : super(key: key);

  @override
  State<SelectCityWidget> createState() => _SelectCityWidgetState();
}

class _SelectCityWidgetState extends State<SelectCityWidget> {
  int? value;
  int? selectedCityId;

  @override
  void initState() {
    int? selectedIndex = widget.allCities.cities
        ?.indexWhere((element) => element.id == widget.selectedCity.id);
    value = selectedIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change your city',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppTheme.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    navigationController.goBack();
                  },
                  splashRadius: 1,
                  icon: const Icon(Icons.highlight_off)),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.allCities.cities?.length ?? 0,
              itemBuilder: (_, index) {
                CityModel obj = widget.allCities.cities![index];
                return RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    groupValue: value,
                    value: index,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (val) async {
                      setState(() {
                        value = val as int;
                        selectedCityId = obj.id;
                      });

                      var formData = {
                        "city": selectedCityId.toString(),
                      };

                      bool response = await context
                          .read<AuthenticationNotifier>()
                          .updateUserProfile(formData);
                      if (response) {
                        context.read<HomePageNotifier>().updateCity(obj);
                        navigationController.goBack();
                      }
                    },
                    title: Text(
                      "${obj.name}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppTheme.blackColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ));
              })
        ],
      ),
    );
  }
}
