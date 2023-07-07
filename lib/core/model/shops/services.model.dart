import 'package:reservim/core/model/shops/pivot.model.dart';

import 'client_services.model.dart';

class Services {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? topService;
  String? slug;
  String? description;
  var shopId;
  Pivot? pivot;
  Clientservices? clientservices;
  Clientservices? shopService;

  Services(
      {this.id,
        this.name,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.topService,
        this.slug,
        this.description,
        this.shopId,
        this.pivot,
        this.clientservices});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topService = json['top_service'];
    slug = json['slug'];
    description = json['description'];
    shopId = json['shop_id'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    clientservices = json['clientservices'] != null
        ? Clientservices.fromJson(json['clientservices'])
        : null;
    shopService = json['shop_service'] != null
        ? Clientservices.fromJson(json['shop_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_service'] = topService;
    data['slug'] = slug;
    data['description'] = description;
    data['shop_id'] = shopId;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (clientservices != null) {
      data['clientservices'] = clientservices!.toJson();
    }
    if (shopService != null) {
      data['shop_service'] = clientservices!.toJson();
    }
    return data;
  }
}