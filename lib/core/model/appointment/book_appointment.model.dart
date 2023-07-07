class BookAppointmentModel {
  List<Service>? service = <Service>[];
  List<StaffName>? staffName = <StaffName>[];
  List<String>? startTime = <String>[];
  List<String>? endTime= <String>[];
  List<JsonService>? jsonService = <JsonService>[];
  List<int>? durationHour = [];
  List<int>? durationMinute = [];
  String? clientName;
  String? clientUserId;
  String? date;
  String? userId;
  String? note;
  String? totalAmount;
  String? usedServiceBefore;
  String? homeServiceCheck;
  String? homeAddress;
  String? age;
  String? gender;
  String? homeServiceNote;
  String? shopId;
  DateTime? dateTime = DateTime.now();

  BookAppointmentModel(
      {this.service,
        this.staffName,
        this.startTime,
        this.endTime,
        this.jsonService,
        this.durationMinute,
        this.durationHour,
        this.clientName,
        this.clientUserId,
        this.date,
        this.userId,
        this.note,
        this.totalAmount,
        this.usedServiceBefore,
        this.homeServiceCheck,
        this.homeAddress,
        this.age,
        this.gender,
        this.homeServiceNote,
        this.shopId});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add( Service.fromJson(v));
      });
    }
    if (json['staff_name'] != null) {
      staffName = <StaffName>[];
      json['staff_name'].forEach((v) {
        staffName!.add( StaffName.fromJson(v));
      });
    }
    startTime = json['start_time'].cast<String>();
    endTime = json['end_time'].cast<String>();
    if (json['jsonService'] != null) {
      jsonService = <JsonService>[];
      json['jsonService'].forEach((v) {
        jsonService!.add( JsonService.fromJson(v));
      });
    }
    clientName = json['client_name'];
    clientUserId = json['client_user_id'];
    date = json['date'];
    userId = json['user_id'];
    note = json['note'];
    totalAmount = json['total_amount'];
    usedServiceBefore = json['used_service_before'];
    homeServiceCheck = json['home_service_check'];
    homeAddress = json['home_address'];
    age = json['age'];
    gender = json['gender'];
    homeServiceNote = json['home_service_note'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    if (service != null) {
      data['service'] = service!.map((v) => v.toJson()).toList();
    }
    if (staffName != null) {
      data['staff_name'] = staffName!.map((v) => v.toJson()).toList();
    }
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    if (jsonService != null) {
      data['jsonService'] = jsonService!.map((v) => v.toJson()).toList();
    }
    data['client_name'] = clientName;
    data['client_user_id'] = clientUserId;
    data['date'] = date;
    data['user_id'] = userId;
    data['note'] = note;
    data['total_amount'] = totalAmount;
    data['used_service_before'] = usedServiceBefore;
    data['home_service_check'] = homeServiceCheck;
    data['home_address'] = homeAddress;
    data['age'] = age;
    data['gender'] = gender;
    data['home_service_note'] = homeServiceNote;
    data['shop_id'] = shopId;
    return data;
  }
}

class Service {
  String? serviceId;
  String? price;

  Service({this.serviceId, this.price});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['service_id'] = serviceId;
    data['price'] = price;
    return data;
  }
}

class StaffName {
  int? id;

  StaffName({this.id});

  StaffName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    return data;
  }
}

class JsonService {
  List<String>? name;
  List<int>? price;

  JsonService({this.name, this.price});

  JsonService.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    price = json['price'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
