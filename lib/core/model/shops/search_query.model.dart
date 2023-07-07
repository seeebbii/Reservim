
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/model/shops/services.model.dart';

class SearchQueryModel {
  List<Services>? services;
  List<ShopModel>? shops;
  int? statusCode;
  String? status;
  String? message;

  SearchQueryModel(
      {this.services, this.shops, this.statusCode, this.status, this.message});

  SearchQueryModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['shops'] != null) {
      shops = <ShopModel>[];
      json['shops'].forEach((v) {
        shops!.add(new ShopModel.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

