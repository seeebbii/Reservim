class CityModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? topCity;
  String? slug;
  int? shopExist;

  CityModel(
      {this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.topCity,
        this.slug,
        this.shopExist});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topCity = json['top_city'];
    slug = json['slug'];
    shopExist = json['shop_exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_city'] = topCity;
    data['slug'] = slug;
    data['shop_exist'] = shopExist;
    return data;
  }
}