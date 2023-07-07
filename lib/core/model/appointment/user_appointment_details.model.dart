import 'appointment.model.dart';

class UserAppointmentDetails {
  String? message;
  int? statusCode;
  String? status;
  Appointment? appointment;

  UserAppointmentDetails(
      {this.message, this.statusCode, this.status, this.appointment});

  UserAppointmentDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.toJson();
    }
    return data;
  }
}
