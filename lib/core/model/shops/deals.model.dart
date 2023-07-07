import 'package:reservim/core/model/user/userprofile.model.dart';

import 'services.model.dart';

class DealsModel {
  int? id;
  String? name;
  int? shopId;
  List<Services>? services;
  int? totalPrice;
  int? discount;
  String? expiryDate;
  int? durationHour;
  int? durationMinute;
  int? discountPrice;
  int? status;
  String? createdAt;
  String? updatedAt;
  var minPrice;
  var maxPrice;
  String? shortDescription;
  String? type;
  int? best;
  int? bestPosition;
  int? bestWomen;
  int? bestMen;
  int? bestWomenPosition;
  int? bestMenPosition;
  UserModel? user;
  List<YourServices>? yourServices;


  DealsModel(
      {this.id,
      this.name,
      this.shopId,
      this.services,
      this.totalPrice,
      this.discount,
      this.expiryDate,
      this.durationHour,
      this.durationMinute,
      this.discountPrice,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.minPrice,
      this.maxPrice,
      this.shortDescription,
      this.type,
      this.best,
      this.bestPosition,
      this.bestWomen,
      this.bestMen,
      this.bestWomenPosition,
      this.bestMenPosition,
      this.user,
      this.yourServices});

  DealsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopId = json['shop_id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    discount = json['discount'];
    expiryDate = json['expiry_date'];
    durationHour = json['duration_hour'];
    durationMinute = json['duration_minute'];
    discountPrice = json['discount_price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    shortDescription = json['short_description'];
    best = json['best'];
    bestPosition = json['best_position'];
    bestWomen = json['best_women'];
    bestMen = json['best_men'];
    bestWomenPosition = json['best_women_position'];
    bestMenPosition = json['best_men_position'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    type = json['type'];
    if (json['your_services'] != null) {
      yourServices = <YourServices>[];
      json['your_services'].forEach((v) {
        yourServices!.add(YourServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['shop_id'] = shopId;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = totalPrice;
    data['discount'] = discount;
    data['expiry_date'] = expiryDate;
    data['duration_hour'] = durationHour;
    data['duration_minute'] = durationMinute;
    data['discount_price'] = discountPrice;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['short_description'] = shortDescription;
    data['type'] = type;
    data['best'] = this.best;
    data['best_position'] = this.bestPosition;
    data['best_women'] = this.bestWomen;
    data['best_men'] = this.bestMen;
    data['best_women_position'] = this.bestWomenPosition;
    data['best_men_position'] = this.bestMenPosition;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (yourServices != null) {
      data['your_services'] = yourServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopService {
  int? id;
  int? price;
  int? status;
  int? shopId;
  String? createdAt;
  int? serviceId;
  String? updatedAt;
  int? categoryId;
  String? description;
  var subServices;
  int? durationHour;
  int? durationMinute;
  String? noteDescription;

  ShopService(
      {this.id,
      this.price,
      this.status,
      this.shopId,
      this.createdAt,
      this.serviceId,
      this.updatedAt,
      this.categoryId,
      this.description,
      this.subServices,
      this.durationHour,
      this.durationMinute,
      this.noteDescription});

  ShopService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    status = json['status'];
    shopId = json['shop_id'];
    createdAt = json['created_at'];
    serviceId = json['service_id'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    description = json['description'];
    subServices = json['sub_services'];
    durationHour = json['duration_hour'];
    durationMinute = json['duration_minute'];
    noteDescription = json['note_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['price'] = price;
    data['status'] = status;
    data['shop_id'] = shopId;
    data['created_at'] = createdAt;
    data['service_id'] = serviceId;
    data['updated_at'] = updatedAt;
    data['category_id'] = categoryId;
    data['description'] = description;
    data['sub_services'] = subServices;
    data['duration_hour'] = durationHour;
    data['duration_minute'] = durationMinute;
    data['note_description'] = noteDescription;
    return data;
  }
}

class YourServices {
  String? code;
  String? name;

  YourServices({this.code, this.name});

  YourServices.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
