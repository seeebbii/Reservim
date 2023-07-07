import 'review.model.dart';

class ReviewsModel {
  List<ReviewModel>? reviews;
  String? imagePath;
  String? message;
  int? statusCode;
  String? status;

  ReviewsModel(
      {this.reviews,
        this.imagePath,
        this.message,
        this.statusCode,
        this.status});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ReviewModel.fromJson(v));
      });
    }
    imagePath = json['image_path'];
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['image_path'] = this.imagePath;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    return data;
  }
}


