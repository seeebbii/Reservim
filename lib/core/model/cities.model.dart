import 'shops/city.model.dart';

class CitiesModel {
  List<CityModel>? cities;
  String? status;
  int? statusCode;
  String? message;

  CitiesModel({this.cities, this.status, this.statusCode, this.message});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <CityModel>[];
      json['cities'].forEach((v) {
        cities!.add(CityModel.fromJson(v));
      });
    }
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}
