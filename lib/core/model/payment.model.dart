import 'appointment/appointment.model.dart';
import 'user/userprofile.model.dart';

class Payment {
  int? id;
  String? createdAt;
  String? amount;
  String? method;
  int? userId;
  int? appointmentId;
  UserModel? users;
  Appointment? appointment;

  Payment(
      {this.id,
        this.createdAt,
        this.amount,
        this.method,
        this.userId,
        this.appointmentId,
        this.users,
        this.appointment});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    amount = json['amount'];
    method = json['method'];
    userId = json['user_id'];
    appointmentId = json['appointment_id'];
    users = json['users'] != null ? UserModel.fromJson(json['users']) : null;
    appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['amount'] = amount;
    data['method'] = method;
    data['user_id'] = userId;
    data['appointment_id'] = appointmentId;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    if (appointment != null) {
      data['appointment'] = appointment!.toJson();
    }
    return data;
  }
}