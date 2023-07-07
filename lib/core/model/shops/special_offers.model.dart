import 'package:reservim/core/model/shops/recommended.model.dart';

import '../opening_closing_hours.model.dart';

// class SpecialOffersModel {
//   String? status;
//   String? logoPath;
//   int? statusCode;
//   String? message;
//   List<ShopModel>? shops;
//
//   SpecialOffersModel(
//       {this.status, this.logoPath, this.statusCode, this.message, this.shops});
//
//   SpecialOffersModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     logoPath = json['logo_path'];
//     statusCode = json['statusCode'];
//     message = json['message'];
//     if (json['shops'] != null) {
//       shops = <ShopModel>[];
//       json['shops'].forEach((v) {
//         shops!.add( ShopModel.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = status;
//     data['logo_path'] = logoPath;
//     data['statusCode'] = statusCode;
//     data['message'] = message;
//     if (shops != null) {
//       data['shops'] = shops!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class SpecialOffersModel {
  String? status;
  String? logoPath;
  int? statusCode;
  String? message;
  List<ShopModel>? shops;

  SpecialOffersModel(
      {this.status, this.logoPath, this.statusCode, this.message, this.shops});

  SpecialOffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    logoPath = json['logo_path'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['shops'] != null) {
      shops = <ShopModel>[];
      json['shops'].forEach((v) {
        shops!.add( ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['status'] = status;
    data['logo_path'] = logoPath;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (shops != null) {
      data['shops'] = shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

