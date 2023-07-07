import '../shops/services.model.dart';

class AppointmentServices {
  int? id;
  int? appointmentId;
  int? serviceId;
  String? createdAt;
  String? updatedAt;
  String? startTime;
  String? endTime;
  int? price;
  int? staffId;
  var commission;
  var commissionType;
  String? date;
  List<Services>? services;

  AppointmentServices(
      {this.id,
        this.appointmentId,
        this.serviceId,
        this.createdAt,
        this.updatedAt,
        this.startTime,
        this.endTime,
        this.price,
        this.staffId,
        this.commission,
        this.commissionType,
        this.date,
        this.services});

  AppointmentServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    staffId = json['staff_id'];
    commission = json['commission'];
    commissionType = json['commission_type'];
    date = json['date'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add( Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['appointment_id'] = appointmentId;
    data['service_id'] = serviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['price'] = price;
    data['staff_id'] = staffId;
    data['commission'] = commission;
    data['commission_type'] = commissionType;
    data['date'] = date;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}