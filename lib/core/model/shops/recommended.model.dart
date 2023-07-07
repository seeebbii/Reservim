import 'package:reservim/core/model/cities.model.dart';

import 'area.model.dart';
import 'city.model.dart';
import '../opening_closing_hours.model.dart';

class RecommendedModel {
  List<ShopModel>? shop;
  String? logoPath;
  int? statusCode;
  String? status;
  String? message;

  RecommendedModel(
      {this.shop, this.logoPath, this.statusCode, this.status, this.message});

  RecommendedModel.fromJson(Map<String, dynamic> json) {
    if (json['shop'] != null) {
      shop = <ShopModel>[];
      json['shop'].forEach((v) {
        shop!.add(ShopModel.fromJson(v));
      });
    }
    logoPath = json['logo_path'];
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (shop != null) {
      data['shop'] = shop!.map((v) => v.toJson()).toList();
    }
    data['logo_path'] = logoPath;
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class ShopModel {
  bool? isLiked = false;
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
  Area? area;
  int? userId;
  int? zipCode;
  var shopCatId;
  var totalEarning;
  var services;
  int? status;
  String? ntn;
  var payPeriod;
  String? ecommerceLink;
  String? facebookLink;
  String? instagramLink;
  String? websiteLink;
  var twitterLink;
  List<OpeningClosingHours>? openingClosingHours;
  var offDays;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var googleId;
  int? clientType;
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
  String? mapUrl;
  var tokenForInviteClient;
  String? shopLogo;
  var unverifyReason;
  var flagReason;
  var unfeatureReason;
  int? flagStatus;
  int? featureStatus;
  String? cnicPhotoFront;
  String? cnicPhotoBack;
  String? slug;
  var landLineNumber;
  int? gImport;
  int? cancelBeforeAppointment;
  int? autoCompleteAppointment;
  String? mapAddress;
  int? showStaff;
  List<String>? selectedShopType;
  String? alfaPayment;
  String? completeAddress;
  String? visitPayment;
  int? shopDiscountPercentage;
  var parent;
  var child;
  int? reviewCount;
  String? reviewAvgRating;
  CitiesModel? cities;
  MainCategory? mainCategory;
  List<ShopServiceForValid>? shopServiceForValid;

  ShopModel(
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
      this.reviewCount,
      this.reviewAvgRating,
      this.cities,
      this.mainCategory,
      this.shopServiceForValid});

  ShopModel.fromJson(Map<String, dynamic> json) {
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
    logo = json['logo'] ?? json['shop_logo'];
    portfolioId = json['portfolio_id'];
    mainCategoryId = json['main_category_id'];
    businessDesc = json['business_desc'];
    salonName = json['salon_name'];
    city = json['city'];
    area = json['area'] != null ? Area.fromJson(json['area']) : Area();
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
    selectedShopType = [json['selected_shop_type'].toString()];
    alfaPayment = json['alfa_payment'];
    completeAddress = json['complete_address'];
    visitPayment = json['visit_payment'];
    shopDiscountPercentage = json['shop_discount_percentage'];
    parent = json['parent'];
    child = json['child'];
    reviewCount = json['review_count'];
    reviewAvgRating = json['review_avg_rating'];
    cities =
        json['cities'] != null ? CitiesModel.fromJson(json['cities']) : null;
    mainCategory = json['main_category'] != null
        ? MainCategory.fromJson(json['main_category'])
        : null;
    if (json['shop_service_for_valid'] != null) {
      shopServiceForValid = <ShopServiceForValid>[];
      json['shop_service_for_valid'].forEach((v) {
        shopServiceForValid!.add(ShopServiceForValid.fromJson(v));
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
    if (area != null) {
      data['area'] = area!.toJson();
    }
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
    data['selected_shop_type'] = selectedShopType;
    data['alfa_payment'] = alfaPayment;
    data['complete_address'] = completeAddress;
    data['visit_payment'] = visitPayment;
    data['shop_discount_percentage'] = shopDiscountPercentage;
    data['parent'] = parent;
    data['child'] = child;
    data['review_count'] = reviewCount;
    data['review_avg_rating'] = reviewAvgRating;
    if (cities != null) {
      data['cities'] = cities!.toJson();
    }
    if (mainCategory != null) {
      data['main_category'] = mainCategory!.toJson();
    }
    if (shopServiceForValid != null) {
      data['shop_service_for_valid'] =
          shopServiceForValid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainCategory {
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

  MainCategory(
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

  MainCategory.fromJson(Map<String, dynamic> json) {
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

class ShopServiceForValid {
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
  SubServices? subServices;
  String? description;
  String? noteDescription;
  DefaultService? defaultService;
  Category? category;

  ShopServiceForValid(
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

  ShopServiceForValid.fromJson(Map<String, dynamic> json) {
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
    subServices = json['sub_services'] != null
        ? SubServices.fromJson(json['sub_services'])
        : null;
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
    if (subServices != null) {
      data['sub_services'] = subServices!.toJson();
    }
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

class SubServices {
  List<String>? name;
  List<String>? price;
  List<String>? durationHour;
  List<String>? durationMinute;

  SubServices({this.name, this.price, this.durationHour, this.durationMinute});

  SubServices.fromJson(Map<String, dynamic> json) {
    name = [json['name'].toString()];
    price = [json['price'].toString()];
    durationHour = [json['duration_hour'].toString()];
    durationMinute = [json['duration_minute'].toString()];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    data['duration_hour'] = durationHour;
    data['duration_minute'] = durationMinute;
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
  String? shopId;
  String? status;
  int? position;
  String? selected;
  String? slug;
  String? image;
  String? vertexImage;
  int? type;
  String? categoryType;

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
