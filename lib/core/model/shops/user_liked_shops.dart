import 'package:reservim/core/model/shops/city.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';

import 'area.model.dart';

class UserLikedShopsModel {
  List<ShopModel>? shop;
  List<int>? review;
  List<double>? rating;
  String? logoPath;
  String? message;
  int? statusCode;
  String? status;

  UserLikedShopsModel(
      {this.shop,
      this.review,
      this.rating,
      this.logoPath,
      this.message,
      this.statusCode,
      this.status});

  UserLikedShopsModel.fromJson(Map<String, dynamic> json) {
    if (json['shop'] != null) {
      shop = <ShopModel>[];
      json['shop'].forEach((v) {
        shop!.add(ShopModel.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <int>[];
      json['review'].forEach((v) {
        review!.add(v);
      });
    }
    if (json['rating'] != null) {
      rating = <double>[];
      json['rating'].forEach((v) {
        rating!.add(double.parse(v.toString()));
      });
    }
    logoPath = json['logo_path'];
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (shop != null) {
      data['shop'] = shop!.map((v) => v.toJson()).toList();
    }
    data['review'] = review;
    data['rating'] = rating;
    data['logo_path'] = logoPath;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['status'] = status;
    return data;
  }
}