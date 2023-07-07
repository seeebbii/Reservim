class Area {
  int? id;
  int? cityId;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? slug;
  int? topArea;
  int? shopExist;

  Area(
      {this.id,
        this.cityId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.topArea,
        this.shopExist});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    topArea = json['top_area'];
    shopExist = json['shop_exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['slug'] = slug;
    data['top_area'] = topArea;
    data['shop_exist'] = shopExist;
    return data;
  }
}