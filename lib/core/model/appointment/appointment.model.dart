import 'package:reservim/core/model/shops/service_price_history.model.dart';
import 'package:reservim/core/model/shops/services.model.dart';
import 'package:reservim/core/model/shops/staff.model.dart';
import 'package:reservim/core/model/user/userprofile.model.dart';

class Appointment {
  int? id;
  int? userId;
  int? clientUserId;
  var service;
  String? clientName;
  var staffName;
  String? date;
  String? startTime;
  String? endTime;
  var message;
  var note;
  String? status;
  int? serviceBefore;
  var homeAddress;
  var gender;
  var age;
  int? totalAmount;
  var reserveStaffName;
  var reserveDate;
  var reserveStartTime;
  var reserveEndTime;
  var reservationReason;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var reservationId;
  int? type;
  var staffId;
  var price;
  var noOfRepeating;
  var noOfRepeatingDay;
  int? cityId;
  int? usedServiceBefore;
  var homeServiceNote;
  int? homeService;
  int? discount;
  var servicePriceHistory;
  String? startAppointment;
  String? appointmentId;
  var dealId;
  var dealName;
  List<Services>? services;
  List<StaffModel>? staffs;
  UserModel? user;

  Appointment(
      {this.id,
      this.userId,
      this.clientUserId,
      this.service,
      this.clientName,
      this.staffName,
      this.date,
      this.startTime,
      this.endTime,
      this.message,
      this.note,
      this.status,
      this.serviceBefore,
      this.homeAddress,
      this.gender,
      this.age,
      this.totalAmount,
      this.reserveStaffName,
      this.reserveDate,
      this.reserveStartTime,
      this.reserveEndTime,
      this.reservationReason,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.reservationId,
      this.type,
      this.user,
      this.staffId,
      this.price,
      this.noOfRepeating,
      this.noOfRepeatingDay,
      this.cityId,
      this.usedServiceBefore,
      this.homeServiceNote,
      this.homeService,
      this.discount,
      this.servicePriceHistory,
      this.startAppointment,
      this.appointmentId,
      this.dealId,
      this.dealName,
      this.services,
      this.staffs});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clientUserId = json['client_user_id'];
    service = json['service'];
    clientName = json['client_name'];
    staffName = json['staff_name'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    message = json['message'];
    note = json['note'];
    status = json['status'];
    serviceBefore = json['service_before'];
    homeAddress = json['home_address'];
    gender = json['gender'];
    age = json['age'];
    totalAmount = json['total_amount'];
    reserveStaffName = json['reserve_staff_name'];
    reserveDate = json['reserve_date'];
    reserveStartTime = json['reserve_start_time'];
    reserveEndTime = json['reserve_end_time'];
    reservationReason = json['reservation_reason'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reservationId = json['reservation_id'];
    type = json['type'];
    staffId = json['staff_id'];
    price = json['price'];
    noOfRepeating = json['no_of_repeating'];
    noOfRepeatingDay = json['no_of_repeating_day'];
    cityId = json['city_id'];
    usedServiceBefore = json['used_service_before'];
    homeServiceNote = json['home_service_note'];
    homeService = json['home_service'];
    discount = json['discount'];
    // servicePriceHistory = json['service_price_history'] != null
    //     ? ServicePriceHistory.fromJson(json['service_price_history'])
    //     : servicePriceHistory = json['service_price_history'];;
    servicePriceHistory = json['service_price_history'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    startAppointment = json['start_appointment'];
    appointmentId = json['appointment_id'];
    dealId = json['deal_id'];
    dealName = json['deal_name'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['staffs'] != null) {
      staffs = <StaffModel>[];
      json['staffs'].forEach((v) {
        staffs!.add(StaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['client_user_id'] = clientUserId;
    data['service'] = service;
    data['client_name'] = clientName;
    data['staff_name'] = staffName;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['message'] = message;
    data['note'] = note;
    data['status'] = status;
    data['service_before'] = serviceBefore;
    data['home_address'] = homeAddress;
    data['gender'] = gender;
    data['age'] = age;
    data['total_amount'] = totalAmount;
    data['reserve_staff_name'] = reserveStaffName;
    data['reserve_date'] = reserveDate;
    data['reserve_start_time'] = reserveStartTime;
    data['reserve_end_time'] = reserveEndTime;
    data['reservation_reason'] = reservationReason;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reservation_id'] = reservationId;
    data['type'] = type;
    data['staff_id'] = staffId;
    data['price'] = price;
    data['no_of_repeating'] = noOfRepeating;
    data['no_of_repeating_day'] = noOfRepeatingDay;
    data['city_id'] = cityId;
    data['used_service_before'] = usedServiceBefore;
    data['home_service_note'] = homeServiceNote;
    data['home_service'] = homeService;
    data['discount'] = discount;
    data['service_price_history'] = servicePriceHistory;
    // if (servicePriceHistory != null) {
    //   data['service_price_history'] = servicePriceHistory!.toJson();
    // }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['start_appointment'] = startAppointment;
    data['appointment_id'] = appointmentId;
    data['deal_id'] = dealId;
    data['deal_name'] = dealName;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (staffs != null) {
      data['staffs'] = staffs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
