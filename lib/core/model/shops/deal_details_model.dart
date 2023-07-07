import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/core/model/user/userprofile.model.dart';

class DealDetailsModel {
  String? status;
  int? statusCode;
  String? message;
  Deal? deal;

  DealDetailsModel({this.status, this.statusCode, this.message, this.deal});

  DealDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    deal = json['deal'] != null ? new Deal.fromJson(json['deal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.deal != null) {
      data['deal'] = this.deal!.toJson();
    }
    return data;
  }
}

class Deal {
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
  Null? minPrice;
  Null? maxPrice;
  Null? shortDescription;
  String? type;
  List<YourServices>? yourServices;
  int? best;
  int? bestPosition;
  int? bestWomen;
  int? bestMen;
  int? bestWomenPosition;
  int? bestMenPosition;
  UserModel? user;

  Deal(
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
        this.yourServices,
        this.best,
        this.bestPosition,
        this.bestWomen,
        this.bestMen,
        this.bestWomenPosition,
        this.bestMenPosition,
        this.user});

  Deal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopId = json['shop_id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
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
    type = json['type'];
    if (json['your_services'] != null) {
      yourServices = <YourServices>[];
      json['your_services'].forEach((v) {
        yourServices!.add(new YourServices.fromJson(v));
      });
    }
    best = json['best'];
    bestPosition = json['best_position'];
    bestWomen = json['best_women'];
    bestMen = json['best_men'];
    bestWomenPosition = json['best_women_position'];
    bestMenPosition = json['best_men_position'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shop_id'] = this.shopId;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['discount'] = this.discount;
    data['expiry_date'] = this.expiryDate;
    data['duration_hour'] = this.durationHour;
    data['duration_minute'] = this.durationMinute;
    data['discount_price'] = this.discountPrice;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['short_description'] = this.shortDescription;
    data['type'] = this.type;
    if (this.yourServices != null) {
      data['your_services'] =
          this.yourServices!.map((v) => v.toJson()).toList();
    }
    data['best'] = this.best;
    data['best_position'] = this.bestPosition;
    data['best_women'] = this.bestWomen;
    data['best_men'] = this.bestMen;
    data['best_women_position'] = this.bestWomenPosition;
    data['best_men_position'] = this.bestMenPosition;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? slug;
  Null? shopId;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? description;
  int? topService;
  ShopService? shopService;

  Services(
      {this.id,
        this.name,
        this.slug,
        this.shopId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.description,
        this.topService,
        this.shopService});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shopId = json['shop_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    description = json['description'];
    topService = json['top_service'];
    shopService = json['shop_service'] != null
        ? new ShopService.fromJson(json['shop_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['shop_id'] = this.shopId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['top_service'] = this.topService;
    if (this.shopService != null) {
      data['shop_service'] = this.shopService!.toJson();
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
  Null? description;
  Null? subServices;
  int? durationHour;
  int? durationMinute;
  Null? noteDescription;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['status'] = this.status;
    data['shop_id'] = this.shopId;
    data['created_at'] = this.createdAt;
    data['service_id'] = this.serviceId;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['sub_services'] = this.subServices;
    data['duration_hour'] = this.durationHour;
    data['duration_minute'] = this.durationMinute;
    data['note_description'] = this.noteDescription;
    return data;
  }
}