import 'package:reservim/core/model/payment.model.dart';
import 'package:reservim/core/model/user/userprofile.model.dart';

import '../shops/services.model.dart';
import '../shops/review.model.dart';

class AppointmentsModel {
  List<FinishedAppointment>? finishedAppointment;
  List<UpcomingAppointment>? upcomingAppointment;
  String? message;
  int? statusCode;
  String? status;

  AppointmentsModel(
      {this.finishedAppointment,
        this.upcomingAppointment,
        this.message,
        this.statusCode,
        this.status});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['finished_appointment'] != null) {
      finishedAppointment = <FinishedAppointment>[];
      json['finished_appointment'].forEach((v) {
        finishedAppointment!.add(new FinishedAppointment.fromJson(v));
      });
    }
    if (json['upcoming_appointment'] != null) {
      upcomingAppointment = <UpcomingAppointment>[];
      json['upcoming_appointment'].forEach((v) {
        upcomingAppointment!.add(new UpcomingAppointment.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (finishedAppointment != null) {
      data['finished_appointment'] =
          finishedAppointment!.map((v) => v.toJson()).toList();
    }
    if (upcomingAppointment != null) {
      data['upcoming_appointment'] =
          upcomingAppointment!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['status'] = status;
    return data;
  }
}

class FinishedAppointment {
  int? id;
  String? status;
  String? date;
  int? userId;
  int? homeService;
  String? startTime;
  Null? dealId;
  UserModel? user;
  List<Services>? services;
  List<Payment>? payment;
  Null? deals;
  ReviewModel? reviews;

  FinishedAppointment(
      {this.id,
        this.status,
        this.date,
        this.userId,
        this.homeService,
        this.startTime,
        this.dealId,
        this.user,
        this.services,
        this.payment,
        this.deals,
        this.reviews});

  FinishedAppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    userId = json['user_id'];
    homeService = json['home_service'];
    startTime = json['start_time'];
    dealId = json['deal_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add( Services.fromJson(v));
      });
    }
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add( Payment.fromJson(v));
      });
    }
    deals = json['deals'];
    reviews =
    json['reviews'] != null ? ReviewModel.fromJson(json['reviews']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['status'] = status;
    data['date'] = date;
    data['user_id'] = userId;
    data['home_service'] = homeService;
    data['start_time'] = startTime;
    data['deal_id'] = dealId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    data['deals'] = deals;
    if (reviews != null) {
      data['reviews'] = reviews!.toJson();
    }
    return data;
  }
}

class UpcomingAppointment {
  int? id;
  String? status;
  String? date;
  int? userId;
  int? homeService;
  String? startTime;
  Null? dealId;
  UserModel? user;
  List<Services>? services;
  List<Payment>? payment;
  Null? deals;
  ReviewModel? reviews;

  UpcomingAppointment(
      {this.id,
        this.status,
        this.date,
        this.userId,
        this.homeService,
        this.startTime,
        this.dealId,
        this.user,
        this.services,
        this.payment,
        this.deals,
        this.reviews});

  UpcomingAppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    userId = json['user_id'];
    homeService = json['home_service'];
    startTime = json['start_time'];
    dealId = json['deal_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add( Services.fromJson(v));
      });
    }
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add( Payment.fromJson(v));
      });
    }
    deals = json['deals'];
    reviews = json['reviews'] != null ? ReviewModel.fromJson(json['reviews']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['status'] = status;
    data['date'] = date;
    data['user_id'] = userId;
    data['home_service'] = homeService;
    data['start_time'] = startTime;
    data['deal_id'] = dealId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    data['deals'] = deals;
    data['reviews'] = reviews!.toJson();
    return data;
  }
}

