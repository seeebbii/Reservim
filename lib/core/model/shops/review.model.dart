import 'package:reservim/core/model/user/userprofile.model.dart';

import '../appointment/appointment.model.dart';

class ReviewModel {
  int? id;
  List<String>? picture;
  int? rating;
  int? appointmentId;
  int? clientId;
  int? shopId;
  String? text;
  String? createdAt;
  String? updatedAt;
  String? status;
  UserModel? user;
  Appointment? appointment;

  ReviewModel(
      {this.id,
      this.picture,
      this.rating,
      this.appointmentId,
      this.clientId,
      this.shopId,
      this.text,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.user,
      this.appointment});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'].cast<String>();
    rating = json['rating'];
    appointmentId = json['appointment_id'];
    clientId = json['client_id'];
    shopId = json['shop_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['picture'] = this.picture;
    data['rating'] = this.rating;
    data['appointment_id'] = this.appointmentId;
    data['client_id'] = this.clientId;
    data['shop_id'] = this.shopId;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
