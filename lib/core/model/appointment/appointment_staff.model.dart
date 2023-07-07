import '../user/userprofile.model.dart';

class AppointmentStaffs {
  int? id;
  int? appointmentId;
  int? staffId;
  String? createdAt;
  String? updatedAt;
  String? date;
  List<UserModel>? users;

  AppointmentStaffs(
      {this.id,
        this.appointmentId,
        this.staffId,
        this.createdAt,
        this.updatedAt,
        this.date,
        this.users});

  AppointmentStaffs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    staffId = json['staff_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    date = json['date'];
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add( UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['appointment_id'] = appointmentId;
    data['staff_id'] = staffId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['date'] = date;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}