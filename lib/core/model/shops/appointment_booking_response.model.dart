class AppointmentBookingResponseModel {
  String? message;
  Null? appointment;
  Recipent? recipent;
  City? city;

  AppointmentBookingResponseModel(
      {this.message, this.appointment, this.recipent, this.city});

  AppointmentBookingResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    appointment = json['appointment'];
    recipent = json['recipent'] != null
        ? new Recipent.fromJson(json['recipent'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['appointment'] = this.appointment;
    if (this.recipent != null) {
      data['recipent'] = this.recipent!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Recipent {
  int? id;
  int? userId;
  String? clientName;
  int? clientUserId;
  String? date;
  String? startAppointment;
  String? endTime;
  int? totalAmount;
  Null? dealId;
  Null? dealName;
  int? homeService;
  List<AppointmentServices>? appointmentServices;
  Null? deals;
  Shop? shop;
  Client? client;

  Recipent(
      {this.id,
        this.userId,
        this.clientName,
        this.clientUserId,
        this.date,
        this.startAppointment,
        this.endTime,
        this.totalAmount,
        this.dealId,
        this.dealName,
        this.homeService,
        this.appointmentServices,
        this.deals,
        this.shop,
        this.client});

  Recipent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clientName = json['client_name'];
    clientUserId = json['client_user_id'];
    date = json['date'];
    startAppointment = json['start_appointment'];
    endTime = json['end_time'];
    totalAmount = json['total_amount'];
    dealId = json['deal_id'];
    dealName = json['deal_name'];
    homeService = json['home_service'];
    if (json['appointment_services'] != null) {
      appointmentServices = <AppointmentServices>[];
      json['appointment_services'].forEach((v) {
        appointmentServices!.add(new AppointmentServices.fromJson(v));
      });
    }
    deals = json['deals'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['client_name'] = this.clientName;
    data['client_user_id'] = this.clientUserId;
    data['date'] = this.date;
    data['start_appointment'] = this.startAppointment;
    data['end_time'] = this.endTime;
    data['total_amount'] = this.totalAmount;
    data['deal_id'] = this.dealId;
    data['deal_name'] = this.dealName;
    data['home_service'] = this.homeService;
    if (this.appointmentServices != null) {
      data['appointment_services'] =
          this.appointmentServices!.map((v) => v.toJson()).toList();
    }
    data['deals'] = this.deals;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

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
  Null? commission;
  Null? commissionType;
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
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['service_id'] = this.serviceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['price'] = this.price;
    data['staff_id'] = this.staffId;
    data['commission'] = this.commission;
    data['commission_type'] = this.commissionType;
    data['date'] = this.date;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? topService;
  String? slug;
  String? description;
  Null? shopId;

  Services(
      {this.id,
        this.name,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.topService,
        this.slug,
        this.description,
        this.shopId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topService = json['top_service'];
    slug = json['slug'];
    description = json['description'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['top_service'] = this.topService;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['shop_id'] = this.shopId;
    return data;
  }
}

class Shop {
  int? id;
  String? salonName;
  String? address;
  String? shopLogo;
  String? city;
  String? area;
  int? homeServiceCharges;

  Shop(
      {this.id,
        this.salonName,
        this.address,
        this.shopLogo,
        this.city,
        this.area,
        this.homeServiceCharges});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonName = json['salon_name'];
    address = json['address'];
    shopLogo = json['shop_logo'];
    city = json['city'];
    area = json['area'];
    homeServiceCharges = json['home_service_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salon_name'] = this.salonName;
    data['address'] = this.address;
    data['shop_logo'] = this.shopLogo;
    data['city'] = this.city;
    data['area'] = this.area;
    data['home_service_charges'] = this.homeServiceCharges;
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? logo;

  Client({this.id, this.name, this.logo});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
