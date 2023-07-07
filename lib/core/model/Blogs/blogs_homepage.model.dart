class BlogsHomePageModel {
  List<BlogsData>? data;
  String? status;
  int? statusCode;
  String? message;
  String? imagePath;

  BlogsHomePageModel({this.data, this.status, this.statusCode, this.message});

  BlogsHomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BlogsData>[];
      json['data'].forEach((v) {
        data!.add(BlogsData.fromJson(v));
      });
    }
    status = json['status'];
    imagePath = json['image_path'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['image_path'] = imagePath;
    data['message'] = message;
    return data;
  }
}

class BlogsData {
  int? id;
  String? title;
  String? image;
  int? views;
  String? slug;
  String? createdAt;
  String? littleDescription;
  int? minutes;

  BlogsData(
      {this.id,
        this.title,
        this.image,
        this.views,
        this.slug,
        this.createdAt,
        this.littleDescription,
        this.minutes});

  BlogsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    views = json['views'];
    slug = json['slug'];
    createdAt = json['created_at'];
    littleDescription = json['little_description'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['views'] = views;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['little_description'] = littleDescription;
    data['minutes'] = minutes;
    return data;
  }
}
