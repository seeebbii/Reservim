class Pivot {
  int? appointmentId;
  int? serviceId;
  String? startTime;
  String? endTime;
  int? price;

  Pivot(
      {this.appointmentId,
        this.serviceId,
        this.startTime,
        this.endTime,
        this.price});

  Pivot.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    serviceId = json['service_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['appointment_id'] = appointmentId;
    data['service_id'] = serviceId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['price'] = price;
    return data;
  }
}