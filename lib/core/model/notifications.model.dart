import 'package:reservim/core/model/shops/recommended.model.dart';

import 'appointment/appointment.model.dart';

class NotificationsModel {
  List<Notifications>? notifications;
  String? message;
  int? statusCode;
  String? status;

  NotificationsModel(
      {this.notifications, this.message, this.statusCode, this.status});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['status'] = status;
    return data;
  }
}

class Notifications {
  int? id;
  int? appointmentId;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? status;
  int? alert;
  int? clientId;
  int? toDisplay;
  Appointment? appointments;
  ShopModel? shop;

  Notifications(
      {this.id,
      this.appointmentId,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.status,
      this.alert,
      this.clientId,
      this.toDisplay,
      this.appointments,
      this.shop});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    status = json['status'];
    alert = json['alert'];
    clientId = json['client_id'];
    toDisplay = json['to_display'];
    appointments = json['appointments'] != null
        ? Appointment.fromJson(json['appointments'])
        : null;
    shop = json['shop'] != null ? ShopModel.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['appointment_id'] = appointmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    data['status'] = status;
    data['alert'] = alert;
    data['client_id'] = clientId;
    data['to_display'] = toDisplay;
    if (appointments != null) {
      data['appointments'] = appointments!.toJson();
    }
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    return data;
  }
}