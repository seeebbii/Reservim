import 'package:reservim/core/model/user/userprofile.model.dart';

import '../payment.model.dart';
import '../shops/services.model.dart';

class PaymentsModel {
  List<Payment>? payments;
  String? message;
  int? statusCode;
  String? status;

  PaymentsModel({this.payments, this.message, this.statusCode, this.status});

  PaymentsModel.fromJson(Map<String, dynamic> json) {
    if (json['payments'] != null) {
      payments = <Payment>[];
      json['payments'].forEach((v) {
        payments!.add(Payment.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['status'] = status;
    return data;
  }
}
