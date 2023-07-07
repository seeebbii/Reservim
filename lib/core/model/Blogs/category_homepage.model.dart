class CategoryHomePageModel {
  List<CategoryData>? data;
  String? imagePath;
  String? status;
  int? statusCode;
  String? message;

  CategoryHomePageModel(
      {this.data, this.imagePath, this.status, this.statusCode, this.message});

  CategoryHomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
    imagePath = json['image_path'];
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['image_path'] = imagePath;
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class CategoryData {
  int? id;
  String? name;
  String? slug;
  String? vertexImage;
  bool? isSelected = false;

  CategoryData({this.id, this.name, this.slug, this.vertexImage});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    vertexImage = json['app_vertex_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['app_vertex_image'] = vertexImage;
    return data;
  }
}
