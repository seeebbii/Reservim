import 'package:reservim/core/model/user/userprofile.model.dart';

import '../opening_closing_hours.model.dart';
import '../payment.model.dart';
import '../shops/services.model.dart';

class UserLatestAppointment {
  Appointment? appointment;
  String? message;
  int? statusCode;
  String? status;

  UserLatestAppointment(
      {appointment, message, statusCode, status});

  UserLatestAppointment.fromJson(Map<String, dynamic> json) {
    appointment = json['appointment'] != null
        ?  Appointment.fromJson(json['appointment'])
        : null;
    message = json['message'];
    statusCode = json['statusCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (appointment != null) {
      data['appointment'] = appointment!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['status'] = status;
    return data;
  }
}

class Appointment {
  int? id;
  int? clientUserId;
  String? status;
  String? date;
  int? userId;
  int? homeService;
  var dealId;
  var dealName;
  UserModel? user;
  List<Services>? services;
  List<Payment>? payment;
  Client? client;

  Appointment(
      {id,
        clientUserId,
        status,
        date,
        userId,
        homeService,
        dealId,
        dealName,
        user,
        services,
        payment,
        client});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientUserId = json['client_user_id'];
    status = json['status'];
    date = json['date'];
    userId = json['user_id'];
    homeService = json['home_service'];
    dealId = json['deal_id'];
    dealName = json['deal_name'];
    user = json['user'] != null ?  UserModel.fromJson(json['user']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add( Services.fromJson(v));
      });
    }
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add( Payment.fromJson(v));
      });
    }
    client =
    json['client'] != null ?  Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['client_user_id'] = clientUserId;
    data['status'] = status;
    data['date'] = date;
    data['user_id'] = userId;
    data['home_service'] = homeService;
    data['deal_id'] = dealId;
    data['deal_name'] = dealName;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}

class Client {
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
  String? websiteLink;
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
  String? mapUrl;
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

  Client(
      {id,
        ownerId,
        name,
        firstName,
        lastName,
        businessName,
        email,
        emailVerifiedAt,
        phone,
        address,
        about,
        logo,
        portfolioId,
        mainCategoryId,
        businessDesc,
        salonName,
        city,
        area,
        userId,
        zipCode,
        shopCatId,
        totalEarning,
        services,
        status,
        ntn,
        payPeriod,
        ecommerceLink,
        facebookLink,
        instagramLink,
        websiteLink,
        twitterLink,
        openingClosingHours,
        offDays,
        deletedAt,
        createdAt,
        updatedAt,
        googleId,
        clientType,
        daymonth,
        year,
        internalNote,
        allergens,
        files,
        photos,
        discount,
        clientOwnerId,
        showService,
        favouriteShopId,
        shopDisable,
        offDaysStart,
        offDaysEnd,
        verificationCode,
        userVerified,
        note,
        defaultConfirmAppointment,
        homeService,
        homeServiceCharges,
        healthNote,
        staffCommissionPrice,
        staffCommissionPercentage,
        exceedTime,
        amenitieNote,
        completedStep,
        latitude,
        longitude,
        verifiedUser,
        cnic,
        mapUrl,
        tokenForInviteClient,
        shopLogo,
        unverifyReason,
        flagReason,
        unfeatureReason,
        flagStatus,
        featureStatus,
        cnicPhotoFront,
        cnicPhotoBack,
        slug,
        landLineNumber,
        gImport,
        cancelBeforeAppointment,
        autoCompleteAppointment,
        mapAddress,
        showStaff,
        selectedShopType,
        alfaPayment,
        completeAddress,
        visitPayment,
        shopDiscountPercentage,
        parent,
        child});

  Client.fromJson(Map<String, dynamic> json) {
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
        openingClosingHours!.add( OpeningClosingHours.fromJson(v));
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
    selectedShopType = json['selected_shop_type'].cast<String>();
    alfaPayment = json['alfa_payment'];
    completeAddress = json['complete_address'];
    visitPayment = json['visit_payment'];
    shopDiscountPercentage = json['shop_discount_percentage'];
    parent = json['parent'];
    child = json['child'];
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
