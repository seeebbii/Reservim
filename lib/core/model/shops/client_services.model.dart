class Clientservices {
  int? id;
  int? serviceId;
  int? categoryId;
  int? shopId;
  int? price;
  int? durationHour;
  int? durationMinute;
  int? status;
  String? createdAt;
  String? updatedAt;
  var subServices;
  var description;
  var noteDescription;

  Clientservices(
      {this.id,
        this.serviceId,
        this.categoryId,
        this.shopId,
        this.price,
        this.durationHour,
        this.durationMinute,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subServices,
        this.description,
        this.noteDescription});

  Clientservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    shopId = json['shop_id'];
    price = json['price'];
    durationHour = json['duration_hour'];
    durationMinute = json['duration_minute'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subServices = json['sub_services'];
    description = json['description'];
    noteDescription = json['note_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['shop_id'] = shopId;
    data['price'] = price;
    data['duration_hour'] = durationHour;
    data['duration_minute'] = durationMinute;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sub_services'] = subServices;
    data['description'] = description;
    data['note_description'] = noteDescription;
    return data;
  }
}
