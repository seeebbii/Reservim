import 'package:reservim/core/model/opening_closing_hours.model.dart';

class UserProfileModel {
  UserModel? data;
  String? logoPath;
  String? message;
  int? statusCode;
  String? status;

  UserProfileModel({this.data, this.message, this.statusCode, this.status});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    logoPath = json['logo_path'];
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['logo_path'] = logoPath;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['status'] = status;
    return data;
  }
}

class UserModel {
  int? id;
  var ownerId;
  String? name;
  var firstName;
  var lastName;
  var businessName;
  var email;
  var emailVerifiedAt;
  String? phone;
  var address;
  var about;
  var logo;
  var portfolioId;
  var mainCategoryId;
  var businessDesc;
  var salonName;
  var city;
  var area;
  var userId;
  var zipCode;
  var shopCatId;
  var totalEarning;
  var services;
  int? status;
  var ntn;
  var payPeriod;
  var ecommerceLink;
  var facebookLink;
  var instagramLink;
  var websiteLink;
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
  var showService;
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
  var healthNote;
  var staffCommissionPrice;
  var staffCommissionPercentage;
  var exceedTime;
  var amenitieNote;
  int? completedStep;
  var latitude;
  var longitude;
  var verifiedUser;
  var cnic;
  var mapUrl;
  var tokenForInviteClient;
  var shopLogo;
  var unverifyReason;
  var flagReason;
  var unfeatureReason;
  int? flagStatus;
  int? featureStatus;
  var cnicPhotoFront;
  var cnicPhotoBack;
  var slug;
  var landLineNumber;
  int? gImport;
  int? cancelBeforeAppointment;
  int? autoCompleteAppointment;
  var mapAddress;
  int? showStaff;
  var selectedShopType;
  String? alfaPayment;
  var completeAddress;
  String? visitPayment;
  int? shopDiscountPercentage;
  var parent;
  var child;

  UserModel(
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
        this.child});

  UserModel.fromJson(Map<String, dynamic> json) {
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
    selectedShopType = json['selected_shop_type'];
    alfaPayment = json['alfa_payment'];
    completeAddress = json['complete_address'];
    visitPayment = json['visit_payment'];
    shopDiscountPercentage = json['shop_discount_percentage'];
    parent = json['parent'];
    child = json['child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['selected_shop_type'] = selectedShopType;
    data['alfa_payment'] = alfaPayment;
    data['complete_address'] = completeAddress;
    data['visit_payment'] = visitPayment;
    data['shop_discount_percentage'] = shopDiscountPercentage;
    data['parent'] = parent;
    data['child'] = child;
    return data;
  }
}
