import 'package:flutter/cupertino.dart';
import 'package:reservim/core/model/shops/deals.model.dart';
import 'package:reservim/core/model/shops/recommended.model.dart';
import 'package:reservim/core/model/shops/review.model.dart';
import 'package:reservim/core/model/shops/services.model.dart';

import '../opening_closing_hours.model.dart';
import 'pivot.model.dart';

class ShopDetailsModel {
  List<Staffs>? staffs;
  ShopModel? shop;
  List<String>? gallery;
  String? galleryImagePath;
  String? healthImagePath;
  String? amenityImagePath;
  List<TopServices>? topServices;
  List<AllServices>? allServices;
  List<DealsModel>? deals;
  List<ReviewModel>? reviews;
  List<Amenities>? amenities;
  List<HealthSafetyRule>? healthSafetyRule;
  List<TodayAppointments>? todayAppointments;
  List<OffDays>? offDays;
  List<OwnerOffdays>? ownerOffdays;
  List<ShopOffdays>? shopOffdays;
  String? status;
  int? statusCode;
  String? message;

  ShopDetailsModel(
      {this.staffs,
      this.shop,
      this.gallery,
      this.galleryImagePath,
      this.healthImagePath,
      this.amenityImagePath,
      this.topServices,
      this.allServices,
      this.deals,
      this.reviews,
      this.amenities,
      this.healthSafetyRule,
      this.todayAppointments,
      this.offDays,
      this.ownerOffdays,
      this.shopOffdays,
      this.status,
      this.statusCode,
      this.message});

  ShopDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['staffs'] != null) {
      staffs = <Staffs>[];
      json['staffs'].forEach((v) {
        staffs!.add(Staffs.fromJson(v));
      });
    }
    shop = json['shop'] != null ? ShopModel.fromJson(json['shop']) : null;
    if (json['gallery'] != null) {
      gallery = <String>[];
      json['gallery'].forEach((v) {
        gallery!.add(v.toString());
      });
    }
    galleryImagePath = json['gallery_image_path'];
    healthImagePath = json['health_image_path'];
    amenityImagePath = json['amenity_image_path'];
    if (json['top_services'] != null) {
      topServices = <TopServices>[];
      json['top_services'].forEach((v) {
        topServices!.add(TopServices.fromJson(v));
      });
    }
    if (json['all_services'] != null) {
      allServices = <AllServices>[];
      json['all_services'].forEach((v) {
        allServices!.add(AllServices.fromJson(v));
      });
    }
    if (json['deals'] != null) {
      deals = <DealsModel>[];
      json['deals'].forEach((v) {
        deals!.add(DealsModel.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewModel.fromJson(v));
      });
    }
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(Amenities.fromJson(v));
      });
    }
    if (json['health_safety_rule'] != null) {
      healthSafetyRule = <HealthSafetyRule>[];
      json['health_safety_rule'].forEach((v) {
        healthSafetyRule!.add(HealthSafetyRule.fromJson(v));
      });
    }
    if (json['today_appointments'] != null) {
      todayAppointments = <TodayAppointments>[];
      json['today_appointments'].forEach((v) {
        todayAppointments!.add(TodayAppointments.fromJson(v));
      });
    }
    if (json['off_days'] != null) {
      offDays = <OffDays>[];
      json['off_days'].forEach((v) {
        offDays!.add(OffDays.fromJson(v));
      });
    }
    if (json['owner_offdays'] != null) {
      ownerOffdays = <OwnerOffdays>[];
      json['owner_offdays'].forEach((v) {
        ownerOffdays!.add(OwnerOffdays.fromJson(v));
      });
    }
    if (json['shop_offdays'] != null) {
      shopOffdays = <ShopOffdays>[];
      json['shop_offdays'].forEach((v) {
        shopOffdays!.add(ShopOffdays.fromJson(v));
      });
    }
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (staffs != null) {
      data['staffs'] = staffs!.map((v) => v.toJson()).toList();
    }
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    data['gallery'] = gallery;
    data['gallery_image_path'] = galleryImagePath;
    data['health_image_path'] = healthImagePath;
    data['amenity_image_path'] = amenityImagePath;
    if (topServices != null) {
      data['top_services'] = topServices!.map((v) => v.toJson()).toList();
    }
    if (allServices != null) {
      data['all_services'] = allServices!.map((v) => v.toJson()).toList();
    }
    if (deals != null) {
      data['deals'] = deals!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }
    if (healthSafetyRule != null) {
      data['health_safety_rule'] =
          healthSafetyRule!.map((v) => v.toJson()).toList();
    }
    if (todayAppointments != null) {
      data['today_appointments'] =
          todayAppointments!.map((v) => v.toJson()).toList();
    }
    if (offDays != null) {
      data['off_days'] = offDays!.map((v) => v.toJson()).toList();
    }
    if (ownerOffdays != null) {
      data['owner_offdays'] = ownerOffdays!.map((v) => v.toJson()).toList();
    }
    if (shopOffdays != null) {
      data['shop_offdays'] = shopOffdays!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class AllServices {
  int? id;
  int? serviceId;
  int? categoryId;
  int? shopId;
  int? price;
  int? durationHour;
  int? durationMinute;
  int? status;
  String? createdAt;
  String? updatedAt;
  var subServices;
  var description;
  var noteDescription;
  DefaultService? defaultService;
  Category? category;

  AllServices(
      {this.id,
      this.serviceId,
      this.categoryId,
      this.shopId,
      this.price,
      this.durationHour,
      this.durationMinute,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subServices,
      this.description,
      this.noteDescription,
      this.defaultService,
      this.category});

  AllServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    shopId = json['shop_id'];
    price = json['price'];
    durationHour = json['duration_hour'];
    durationMinute = json['duration_minute'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subServices = json['sub_services'];
    description = json['description'];
    noteDescription = json['note_description'];
    defaultService = json['default_service'] != null
        ? DefaultService.fromJson(json['default_service'])
        : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['shop_id'] = shopId;
    data['price'] = price;
    data['duration_hour'] = durationHour;
    data['duration_minute'] = durationMinute;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sub_services'] = subServices;
    data['description'] = description;
    data['note_description'] = noteDescription;
    if (defaultService != null) {
      data['default_service'] = defaultService!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Staffs {
  int? id;
  String? logo;
  String? name;
  List<Staffservices>? staffservices;

  Staffs({this.id, this.logo, this.name, this.staffservices});

  Staffs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    if (json['staffservices'] != null) {
      staffservices = <Staffservices>[];
      json['staffservices'].forEach((v) {
        staffservices!.add(Staffservices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['logo'] = logo;
    data['name'] = name;
    if (staffservices != null) {
      data['staffservices'] = staffservices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Staffservices {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? topService;
  String? slug;
  String? description;
  var shopId;
  Pivot? pivot;

  Staffservices(
      {this.id,
      this.name,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.topService,
      this.slug,
      this.description,
      this.shopId,
      this.pivot});

  Staffservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topService = json['top_service'];
    slug = json['slug'];
    description = json['description'];
    shopId = json['shop_id'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_service'] = topService;
    data['slug'] = slug;
    data['description'] = description;
    data['shop_id'] = shopId;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class TopServices {
  int? id;
  int? serviceId;
  int? categoryId;
  int? shopId;
  int? price;
  int? durationHour;
  int? durationMinute;
  int? status;
  String? createdAt;
  String? updatedAt;
  var subServices;
  String? description;
  String? noteDescription;
  DefaultService? defaultService;
  Category? category;

  TopServices(
      {this.id,
      this.serviceId,
      this.categoryId,
      this.shopId,
      this.price,
      this.durationHour,
      this.durationMinute,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subServices,
      this.description,
      this.noteDescription,
      this.defaultService,
      this.category});

  TopServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    shopId = json['shop_id'];
    price = json['price'];
    durationHour = json['duration_hour'];
    durationMinute = json['duration_minute'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subServices = json['sub_services'];
    description = json['description'];
    noteDescription = json['note_description'];
    defaultService = json['default_service'] != null
        ? DefaultService.fromJson(json['default_service'])
        : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['shop_id'] = shopId;
    data['price'] = price;
    data['duration_hour'] = durationHour;
    data['duration_minute'] = durationMinute;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sub_services'] = subServices;
    data['description'] = description;
    data['note_description'] = noteDescription;
    if (defaultService != null) {
      data['default_service'] = defaultService!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class DefaultService {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? topService;
  String? slug;
  String? description;
  var shopId;

  DefaultService(
      {this.id,
      this.name,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.topService,
      this.slug,
      this.description,
      this.shopId});

  DefaultService.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_service'] = topService;
    data['slug'] = slug;
    data['description'] = description;
    data['shop_id'] = shopId;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  var shopId;
  String? status;
  int? position;
  String? selected;
  String? slug;
  String? image;
  String? vertexImage;
  int? type;
  var categoryType;

  Category(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.shopId,
      this.status,
      this.position,
      this.selected,
      this.slug,
      this.image,
      this.vertexImage,
      this.type,
      this.categoryType});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shopId = json['shop_id'];
    status = json['status'];
    position = json['position'];
    selected = json['selected'];
    slug = json['slug'];
    image = json['image'];
    vertexImage = json['vertex_image'];
    type = json['type'];
    categoryType = json['category_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['shop_id'] = shopId;
    data['status'] = status;
    data['position'] = position;
    data['selected'] = selected;
    data['slug'] = slug;
    data['image'] = image;
    data['vertex_image'] = vertexImage;
    data['type'] = type;
    data['category_type'] = categoryType;
    return data;
  }
}

class Amenities {
  int? id;
  int? ownerId;
  String? name;
  var firstName;
  var lastName;
  var businessName;
  String? email;
  var emailVerifiedAt;
  String? phone;
  String? address;
  var about;
  String? logo;
  var portfolioId;
  int? mainCategoryId;
  String? businessDesc;
  String? salonName;
  String? city;
  String? area;
  int? userId;
  var zipCode;
  var shopCatId;
  var totalEarning;
  var services;
  int? status;
  String? ntn;
  var payPeriod;
  String? ecommerceLink;
  String? facebookLink;
  String? instagramLink;
  var websiteLink;
  var twitterLink;
  List<OpeningClosingHours>? openingClosingHours;
  var offDays;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var googleId;
  var clientType;
  var daymonth;
  var year;
  var internalNote;
  var allergens;
  var files;
  var photos;
  var discount;
  var clientOwnerId;
  int? showService;
  var favouriteShopId;
  int? shopDisable;
  var offDaysStart;
  var offDaysEnd;
  var verificationCode;
  var userVerified;
  var note;
  int? defaultConfirmAppointment;
  int? homeService;
  int? homeServiceCharges;
  String? healthNote;
  int? staffCommissionPrice;
  var staffCommissionPercentage;
  var exceedTime;
  String? amenitieNote;
  int? completedStep;
  String? latitude;
  String? longitude;
  var verifiedUser;
  String? cnic;
  var mapUrl;
  var tokenForInviteClient;
  String? shopLogo;
  var unverifyReason;
  var flagReason;
  var unfeatureReason;
  int? flagStatus;
  int? featureStatus;
  var cnicPhotoFront;
  var cnicPhotoBack;
  String? slug;
  var landLineNumber;
  int? gImport;
  var cancelBeforeAppointment;
  int? autoCompleteAppointment;
  var mapAddress;
  int? showStaff;
  List<String>? selectedShopType;
  String? alfaPayment;
  String? completeAddress;
  String? visitPayment;
  int? shopDiscountPercentage;
  var parent;
  var child;
  List<Amenitie>? amenitie;

  Amenities(
      {this.id,
      this.ownerId,
      this.name,
      this.firstName,
      this.lastName,
      this.businessName,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.address,
      this.about,
      this.logo,
      this.portfolioId,
      this.mainCategoryId,
      this.businessDesc,
      this.salonName,
      this.city,
      this.area,
      this.userId,
      this.zipCode,
      this.shopCatId,
      this.totalEarning,
      this.services,
      this.status,
      this.ntn,
      this.payPeriod,
      this.ecommerceLink,
      this.facebookLink,
      this.instagramLink,
      this.websiteLink,
      this.twitterLink,
      this.openingClosingHours,
      this.offDays,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.googleId,
      this.clientType,
      this.daymonth,
      this.year,
      this.internalNote,
      this.allergens,
      this.files,
      this.photos,
      this.discount,
      this.clientOwnerId,
      this.showService,
      this.favouriteShopId,
      this.shopDisable,
      this.offDaysStart,
      this.offDaysEnd,
      this.verificationCode,
      this.userVerified,
      this.note,
      this.defaultConfirmAppointment,
      this.homeService,
      this.homeServiceCharges,
      this.healthNote,
      this.staffCommissionPrice,
      this.staffCommissionPercentage,
      this.exceedTime,
      this.amenitieNote,
      this.completedStep,
      this.latitude,
      this.longitude,
      this.verifiedUser,
      this.cnic,
      this.mapUrl,
      this.tokenForInviteClient,
      this.shopLogo,
      this.unverifyReason,
      this.flagReason,
      this.unfeatureReason,
      this.flagStatus,
      this.featureStatus,
      this.cnicPhotoFront,
      this.cnicPhotoBack,
      this.slug,
      this.landLineNumber,
      this.gImport,
      this.cancelBeforeAppointment,
      this.autoCompleteAppointment,
      this.mapAddress,
      this.showStaff,
      this.selectedShopType,
      this.alfaPayment,
      this.completeAddress,
      this.visitPayment,
      this.shopDiscountPercentage,
      this.parent,
      this.child,
      this.amenitie});

  Amenities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    businessName = json['business_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    address = json['address'];
    about = json['about'];
    logo = json['logo'];
    portfolioId = json['portfolio_id'];
    mainCategoryId = json['main_category_id'];
    businessDesc = json['business_desc'];
    salonName = json['salon_name'];
    city = json['city'];
    area = json['area'];
    userId = json['user_id'];
    zipCode = json['zip_code'];
    shopCatId = json['shop_cat_id'];
    totalEarning = json['total_earning'];
    services = json['services'];
    status = json['status'];
    ntn = json['ntn'];
    payPeriod = json['pay_period'];
    ecommerceLink = json['ecommerce_link'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    websiteLink = json['website_link'];
    twitterLink = json['twitter_link'];
    if (json['opening_closing_hours'] != null) {
      openingClosingHours = <OpeningClosingHours>[];
      json['opening_closing_hours'].forEach((v) {
        openingClosingHours!.add(OpeningClosingHours.fromJson(v));
      });
    }
    offDays = json['off_days'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    googleId = json['google_id'];
    clientType = json['client_type'];
    daymonth = json['daymonth'];
    year = json['year'];
    internalNote = json['internal_note'];
    allergens = json['allergens'];
    files = json['files'];
    photos = json['photos'];
    discount = json['discount'];
    clientOwnerId = json['client_owner_id'];
    showService = json['show_service'];
    favouriteShopId = json['favourite_shop_id'];
    shopDisable = json['shop_disable'];
    offDaysStart = json['off_days_start'];
    offDaysEnd = json['off_days_end'];
    verificationCode = json['verification_code'];
    userVerified = json['user_verified'];
    note = json['note'];
    defaultConfirmAppointment = json['default_confirm_appointment'];
    homeService = json['home_service'];
    homeServiceCharges = json['home_service_charges'];
    healthNote = json['health_note'];
    staffCommissionPrice = json['staff_commission_price'];
    staffCommissionPercentage = json['staff_commission_percentage'];
    exceedTime = json['exceed_time'];
    amenitieNote = json['amenitie_note'];
    completedStep = json['completed_step'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    verifiedUser = json['verified_user'];
    cnic = json['cnic'];
    mapUrl = json['map_url'];
    tokenForInviteClient = json['token_for_invite_client'];
    shopLogo = json['shop_logo'];
    unverifyReason = json['unverify_reason'];
    flagReason = json['flag_reason'];
    unfeatureReason = json['unfeature_reason'];
    flagStatus = json['flag_status'];
    featureStatus = json['feature_status'];
    cnicPhotoFront = json['cnic_photo_front'];
    cnicPhotoBack = json['cnic_photo_back'];
    slug = json['slug'];
    landLineNumber = json['land_line_number'];
    gImport = json['g_import'];
    cancelBeforeAppointment = json['cancel_before_appointment'];
    autoCompleteAppointment = json['auto_complete_appointment'];
    mapAddress = json['map_address'];
    showStaff = json['show_staff'];
    if (json['selected_shop_type'] != null) {
      selectedShopType = <String>[];
      json['selected_shop_type'].forEach((v) {
        selectedShopType!.add(v.toString());
      });
    }
    alfaPayment = json['alfa_payment'];
    completeAddress = json['complete_address'];
    visitPayment = json['visit_payment'];
    shopDiscountPercentage = json['shop_discount_percentage'];
    parent = json['parent'];
    child = json['child'];
    if (json['amenitie'] != null) {
      amenitie = <Amenitie>[];
      json['amenitie'].forEach((v) {
        amenitie!.add(Amenitie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['name'] = name;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['business_name'] = businessName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone'] = phone;
    data['address'] = address;
    data['about'] = about;
    data['logo'] = logo;
    data['portfolio_id'] = portfolioId;
    data['main_category_id'] = mainCategoryId;
    data['business_desc'] = businessDesc;
    data['salon_name'] = salonName;
    data['city'] = city;
    data['area'] = area;
    data['user_id'] = userId;
    data['zip_code'] = zipCode;
    data['shop_cat_id'] = shopCatId;
    data['total_earning'] = totalEarning;
    data['services'] = services;
    data['status'] = status;
    data['ntn'] = ntn;
    data['pay_period'] = payPeriod;
    data['ecommerce_link'] = ecommerceLink;
    data['facebook_link'] = facebookLink;
    data['instagram_link'] = instagramLink;
    data['website_link'] = websiteLink;
    data['twitter_link'] = twitterLink;
    if (openingClosingHours != null) {
      data['opening_closing_hours'] =
          openingClosingHours!.map((v) => v.toJson()).toList();
    }
    data['off_days'] = offDays;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['google_id'] = googleId;
    data['client_type'] = clientType;
    data['daymonth'] = daymonth;
    data['year'] = year;
    data['internal_note'] = internalNote;
    data['allergens'] = allergens;
    data['files'] = files;
    data['photos'] = photos;
    data['discount'] = discount;
    data['client_owner_id'] = clientOwnerId;
    data['show_service'] = showService;
    data['favourite_shop_id'] = favouriteShopId;
    data['shop_disable'] = shopDisable;
    data['off_days_start'] = offDaysStart;
    data['off_days_end'] = offDaysEnd;
    data['verification_code'] = verificationCode;
    data['user_verified'] = userVerified;
    data['note'] = note;
    data['default_confirm_appointment'] = defaultConfirmAppointment;
    data['home_service'] = homeService;
    data['home_service_charges'] = homeServiceCharges;
    data['health_note'] = healthNote;
    data['staff_commission_price'] = staffCommissionPrice;
    data['staff_commission_percentage'] = staffCommissionPercentage;
    data['exceed_time'] = exceedTime;
    data['amenitie_note'] = amenitieNote;
    data['completed_step'] = completedStep;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['verified_user'] = verifiedUser;
    data['cnic'] = cnic;
    data['map_url'] = mapUrl;
    data['token_for_invite_client'] = tokenForInviteClient;
    data['shop_logo'] = shopLogo;
    data['unverify_reason'] = unverifyReason;
    data['flag_reason'] = flagReason;
    data['unfeature_reason'] = unfeatureReason;
    data['flag_status'] = flagStatus;
    data['feature_status'] = featureStatus;
    data['cnic_photo_front'] = cnicPhotoFront;
    data['cnic_photo_back'] = cnicPhotoBack;
    data['slug'] = slug;
    data['land_line_number'] = landLineNumber;
    data['g_import'] = gImport;
    data['cancel_before_appointment'] = cancelBeforeAppointment;
    data['auto_complete_appointment'] = autoCompleteAppointment;
    data['map_address'] = mapAddress;
    data['show_staff'] = showStaff;
    if (selectedShopType != null) {
      data['selected_shop_type'] =
          selectedShopType!.map((v) => v.toString()).toList();
    }
    data['alfa_payment'] = alfaPayment;
    data['complete_address'] = completeAddress;
    data['visit_payment'] = visitPayment;
    data['shop_discount_percentage'] = shopDiscountPercentage;
    data['parent'] = parent;
    data['child'] = child;
    if (amenitie != null) {
      data['amenitie'] = amenitie!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amenitie {
  int? id;
  String? name;
  String? description;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  String? pic;
  Pivot? pivot;

  Amenitie(
      {this.id,
      this.name,
      this.description,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.pic,
      this.pivot});

  Amenitie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pic = json['pic'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pic'] = pic;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class HealthSafetyRule {
  int? id;
  int? ownerId;
  String? name;
  var firstName;
  var lastName;
  var businessName;
  String? email;
  var emailVerifiedAt;
  String? phone;
  String? address;
  var about;
  String? logo;
  var portfolioId;
  int? mainCategoryId;
  String? businessDesc;
  String? salonName;
  String? city;
  String? area;
  int? userId;
  var zipCode;
  var shopCatId;
  var totalEarning;
  var services;
  int? status;
  String? ntn;
  var payPeriod;
  String? ecommerceLink;
  String? facebookLink;
  String? instagramLink;
  var websiteLink;
  var twitterLink;
  List<OpeningClosingHours>? openingClosingHours;
  var offDays;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var googleId;
  var clientType;
  var daymonth;
  var year;
  var internalNote;
  var allergens;
  var files;
  var photos;
  var discount;
  var clientOwnerId;
  int? showService;
  var favouriteShopId;
  int? shopDisable;
  var offDaysStart;
  var offDaysEnd;
  var verificationCode;
  var userVerified;
  var note;
  int? defaultConfirmAppointment;
  int? homeService;
  int? homeServiceCharges;
  String? healthNote;
  int? staffCommissionPrice;
  var staffCommissionPercentage;
  var exceedTime;
  String? amenitieNote;
  int? completedStep;
  String? latitude;
  String? longitude;
  var verifiedUser;
  String? cnic;
  var mapUrl;
  var tokenForInviteClient;
  String? shopLogo;
  var unverifyReason;
  var flagReason;
  var unfeatureReason;
  int? flagStatus;
  int? featureStatus;
  var cnicPhotoFront;
  var cnicPhotoBack;
  String? slug;
  var landLineNumber;
  int? gImport;
  var cancelBeforeAppointment;
  int? autoCompleteAppointment;
  var mapAddress;
  int? showStaff;
  List<String>? selectedShopType;
  String? alfaPayment;
  String? completeAddress;
  String? visitPayment;
  int? shopDiscountPercentage;
  var parent;
  var child;
  List<HealthSafetyRule>? healthSafetyRule;

  HealthSafetyRule(
      {this.id,
      this.ownerId,
      this.name,
      this.firstName,
      this.lastName,
      this.businessName,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.address,
      this.about,
      this.logo,
      this.portfolioId,
      this.mainCategoryId,
      this.businessDesc,
      this.salonName,
      this.city,
      this.area,
      this.userId,
      this.zipCode,
      this.shopCatId,
      this.totalEarning,
      this.services,
      this.status,
      this.ntn,
      this.payPeriod,
      this.ecommerceLink,
      this.facebookLink,
      this.instagramLink,
      this.websiteLink,
      this.twitterLink,
      this.openingClosingHours,
      this.offDays,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.googleId,
      this.clientType,
      this.daymonth,
      this.year,
      this.internalNote,
      this.allergens,
      this.files,
      this.photos,
      this.discount,
      this.clientOwnerId,
      this.showService,
      this.favouriteShopId,
      this.shopDisable,
      this.offDaysStart,
      this.offDaysEnd,
      this.verificationCode,
      this.userVerified,
      this.note,
      this.defaultConfirmAppointment,
      this.homeService,
      this.homeServiceCharges,
      this.healthNote,
      this.staffCommissionPrice,
      this.staffCommissionPercentage,
      this.exceedTime,
      this.amenitieNote,
      this.completedStep,
      this.latitude,
      this.longitude,
      this.verifiedUser,
      this.cnic,
      this.mapUrl,
      this.tokenForInviteClient,
      this.shopLogo,
      this.unverifyReason,
      this.flagReason,
      this.unfeatureReason,
      this.flagStatus,
      this.featureStatus,
      this.cnicPhotoFront,
      this.cnicPhotoBack,
      this.slug,
      this.landLineNumber,
      this.gImport,
      this.cancelBeforeAppointment,
      this.autoCompleteAppointment,
      this.mapAddress,
      this.showStaff,
      this.selectedShopType,
      this.alfaPayment,
      this.completeAddress,
      this.visitPayment,
      this.shopDiscountPercentage,
      this.parent,
      this.child,
      this.healthSafetyRule});

  HealthSafetyRule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    businessName = json['business_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    address = json['address'];
    about = json['about'];
    logo = json['logo'];
    portfolioId = json['portfolio_id'];
    mainCategoryId = json['main_category_id'];
    businessDesc = json['business_desc'];
    salonName = json['salon_name'];
    city = json['city'];
    area = json['area'];
    userId = json['user_id'];
    zipCode = json['zip_code'];
    shopCatId = json['shop_cat_id'];
    totalEarning = json['total_earning'];
    services = json['services'];
    status = json['status'];
    ntn = json['ntn'];
    payPeriod = json['pay_period'];
    ecommerceLink = json['ecommerce_link'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    websiteLink = json['website_link'];
    twitterLink = json['twitter_link'];
    if (json['opening_closing_hours'] != null) {
      openingClosingHours = <OpeningClosingHours>[];
      json['opening_closing_hours'].forEach((v) {
        openingClosingHours!.add(OpeningClosingHours.fromJson(v));
      });
    }
    offDays = json['off_days'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    googleId = json['google_id'];
    clientType = json['client_type'];
    daymonth = json['daymonth'];
    year = json['year'];
    internalNote = json['internal_note'];
    allergens = json['allergens'];
    files = json['files'];
    photos = json['photos'];
    discount = json['discount'];
    clientOwnerId = json['client_owner_id'];
    showService = json['show_service'];
    favouriteShopId = json['favourite_shop_id'];
    shopDisable = json['shop_disable'];
    offDaysStart = json['off_days_start'];
    offDaysEnd = json['off_days_end'];
    verificationCode = json['verification_code'];
    userVerified = json['user_verified'];
    note = json['note'];
    defaultConfirmAppointment = json['default_confirm_appointment'];
    homeService = json['home_service'];
    homeServiceCharges = json['home_service_charges'];
    healthNote = json['health_note'];
    staffCommissionPrice = json['staff_commission_price'];
    staffCommissionPercentage = json['staff_commission_percentage'];
    exceedTime = json['exceed_time'];
    amenitieNote = json['amenitie_note'];
    completedStep = json['completed_step'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    verifiedUser = json['verified_user'];
    cnic = json['cnic'];
    mapUrl = json['map_url'];
    tokenForInviteClient = json['token_for_invite_client'];
    shopLogo = json['shop_logo'];
    unverifyReason = json['unverify_reason'];
    flagReason = json['flag_reason'];
    unfeatureReason = json['unfeature_reason'];
    flagStatus = json['flag_status'];
    featureStatus = json['feature_status'];
    cnicPhotoFront = json['cnic_photo_front'];
    cnicPhotoBack = json['cnic_photo_back'];
    slug = json['slug'];
    landLineNumber = json['land_line_number'];
    gImport = json['g_import'];
    cancelBeforeAppointment = json['cancel_before_appointment'];
    autoCompleteAppointment = json['auto_complete_appointment'];
    mapAddress = json['map_address'];
    showStaff = json['show_staff'];
    debugPrint(json['selected_shop_type'].toString());
    if (json['selected_shop_type'] != null) {
      selectedShopType = <String>[];
      json['selected_shop_type'].forEach((v) {
        selectedShopType!.add(v.toString());
      });
    }
    alfaPayment = json['alfa_payment'];
    completeAddress = json['complete_address'];
    visitPayment = json['visit_payment'];
    shopDiscountPercentage = json['shop_discount_percentage'];
    parent = json['parent'];
    child = json['child'];
    if (json['health_safety_rule'] != null) {
      healthSafetyRule = <HealthSafetyRule>[];
      json['health_safety_rule'].forEach((v) {
        healthSafetyRule!.add(HealthSafetyRule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['name'] = name;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['business_name'] = businessName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone'] = phone;
    data['address'] = address;
    data['about'] = about;
    data['logo'] = logo;
    data['portfolio_id'] = portfolioId;
    data['main_category_id'] = mainCategoryId;
    data['business_desc'] = businessDesc;
    data['salon_name'] = salonName;
    data['city'] = city;
    data['area'] = area;
    data['user_id'] = userId;
    data['zip_code'] = zipCode;
    data['shop_cat_id'] = shopCatId;
    data['total_earning'] = totalEarning;
    data['services'] = services;
    data['status'] = status;
    data['ntn'] = ntn;
    data['pay_period'] = payPeriod;
    data['ecommerce_link'] = ecommerceLink;
    data['facebook_link'] = facebookLink;
    data['instagram_link'] = instagramLink;
    data['website_link'] = websiteLink;
    data['twitter_link'] = twitterLink;
    if (openingClosingHours != null) {
      data['opening_closing_hours'] =
          openingClosingHours!.map((v) => v.toJson()).toList();
    }
    data['off_days'] = offDays;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['google_id'] = googleId;
    data['client_type'] = clientType;
    data['daymonth'] = daymonth;
    data['year'] = year;
    data['internal_note'] = internalNote;
    data['allergens'] = allergens;
    data['files'] = files;
    data['photos'] = photos;
    data['discount'] = discount;
    data['client_owner_id'] = clientOwnerId;
    data['show_service'] = showService;
    data['favourite_shop_id'] = favouriteShopId;
    data['shop_disable'] = shopDisable;
    data['off_days_start'] = offDaysStart;
    data['off_days_end'] = offDaysEnd;
    data['verification_code'] = verificationCode;
    data['user_verified'] = userVerified;
    data['note'] = note;
    data['default_confirm_appointment'] = defaultConfirmAppointment;
    data['home_service'] = homeService;
    data['home_service_charges'] = homeServiceCharges;
    data['health_note'] = healthNote;
    data['staff_commission_price'] = staffCommissionPrice;
    data['staff_commission_percentage'] = staffCommissionPercentage;
    data['exceed_time'] = exceedTime;
    data['amenitie_note'] = amenitieNote;
    data['completed_step'] = completedStep;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['verified_user'] = verifiedUser;
    data['cnic'] = cnic;
    data['map_url'] = mapUrl;
    data['token_for_invite_client'] = tokenForInviteClient;
    data['shop_logo'] = shopLogo;
    data['unverify_reason'] = unverifyReason;
    data['flag_reason'] = flagReason;
    data['unfeature_reason'] = unfeatureReason;
    data['flag_status'] = flagStatus;
    data['feature_status'] = featureStatus;
    data['cnic_photo_front'] = cnicPhotoFront;
    data['cnic_photo_back'] = cnicPhotoBack;
    data['slug'] = slug;
    data['land_line_number'] = landLineNumber;
    data['g_import'] = gImport;
    data['cancel_before_appointment'] = cancelBeforeAppointment;
    data['auto_complete_appointment'] = autoCompleteAppointment;
    data['map_address'] = mapAddress;
    data['show_staff'] = showStaff;
    if (selectedShopType != null) {
      data['selected_shop_type'] =
          selectedShopType!.map((v) => v.toString()).toList();
    }
    data['alfa_payment'] = alfaPayment;
    data['complete_address'] = completeAddress;
    data['visit_payment'] = visitPayment;
    data['shop_discount_percentage'] = shopDiscountPercentage;
    data['parent'] = parent;
    data['child'] = child;
    if (healthSafetyRule != null) {
      data['health_safety_rule'] =
          healthSafetyRule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayAppointments {
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
  ServicePriceHistory? servicePriceHistory;
  String? startAppointment;
  String? appointmentId;
  var dealId;
  var dealName;
  List<Services>? services;
  List<Staffs>? staffs;

  TodayAppointments(
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

  TodayAppointments.fromJson(Map<String, dynamic> json) {
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
    servicePriceHistory = json['service_price_history'] != null
        ? ServicePriceHistory.fromJson(json['service_price_history'])
        : null;
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
      staffs = <Staffs>[];
      json['staffs'].forEach((v) {
        staffs!.add(Staffs.fromJson(v));
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
    if (servicePriceHistory != null) {
      data['service_price_history'] = servicePriceHistory!.toJson();
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

class ServicePriceHistory {
  List<String>? name;
  List<int>? price;

  ServicePriceHistory({this.name, this.price});

  ServicePriceHistory.fromJson(Map<String, dynamic> json) {
    name = [json['name'].toString()];
    price = [int.parse(json['price'].toString())];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class OffDays {
  int? id;
  int? userId;
  String? offDaysStart;
  String? offDaysEnd;
  String? createdAt;
  String? updatedAt;

  OffDays(
      {this.id,
      this.userId,
      this.offDaysStart,
      this.offDaysEnd,
      this.createdAt,
      this.updatedAt});

  OffDays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    offDaysStart = json['off_days_start'];
    offDaysEnd = json['off_days_end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['off_days_start'] = offDaysStart;
    data['off_days_end'] = offDaysEnd;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ShopOffdays {
  int? id;
  int? userId;
  String? offDaysStart;
  String? offDaysEnd;
  String? createdAt;
  String? updatedAt;

  ShopOffdays(
      {this.id,
      this.userId,
      this.offDaysStart,
      this.offDaysEnd,
      this.createdAt,
      this.updatedAt});

  ShopOffdays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    offDaysStart = json['off_days_start'];
    offDaysEnd = json['off_days_end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['off_days_start'] = offDaysStart;
    data['off_days_end'] = offDaysEnd;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class OwnerOffdays {
  int? id;
  int? userId;
  String? offDaysStart;
  String? offDaysEnd;
  String? createdAt;
  String? updatedAt;

  OwnerOffdays(
      {this.id,
      this.userId,
      this.offDaysStart,
      this.offDaysEnd,
      this.createdAt,
      this.updatedAt});

  OwnerOffdays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    offDaysStart = json['off_days_start'];
    offDaysEnd = json['off_days_end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['off_days_start'] = offDaysStart;
    data['off_days_end'] = offDaysEnd;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class GroupedServicesModel {
  String? categoryName;
  List<AllServices>? services;

  GroupedServicesModel({this.categoryName, this.services});

  // GroupedServicesModel.fromJson(Map<String, dynamic> json){
  //     this.id = json['id'];
  //     this.name = json['name'];
  // }

  // Map<String, dynamic> toJson() => {'id':id, 'name':name };

}
