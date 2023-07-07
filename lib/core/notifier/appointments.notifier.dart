import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/api/api_service.dart';
import 'package:reservim/core/model/appointment/book_appointment.model.dart';
import 'package:reservim/core/model/appointment/user_appointment_details.model.dart';
import 'package:reservim/core/model/appointment/user_latest_appointment.dart';
import 'package:reservim/core/model/notifications.model.dart';
import 'package:reservim/core/model/shops/appointment_booking_response.model.dart';
import 'package:reservim/core/model/shops/reviews.model.dart';
import 'package:reservim/core/model/timeslot.model.dart';
import 'package:reservim/core/model/user/payments.model.dart';
import 'package:reservim/core/model/user/appointments.model.dart';
import 'package:reservim/core/router/router_generator.dart';
import 'package:reservim/meta/utils/base_helper.dart';

class AppointmentsNotifier extends ChangeNotifier {
  // DATA MODELS
  AppointmentsModel appointmentsModel = AppointmentsModel();
  PaymentsModel paymentModel = PaymentsModel();
  ReviewsModel reviewsModel = ReviewsModel();
  NotificationsModel notificationsModel = NotificationsModel();
  UserLatestAppointment userLatestAppointment = UserLatestAppointment();
  UserAppointmentDetails userAppointmentDetails = UserAppointmentDetails();

  // BOOK APPOINTMENT MODEL
  BookAppointmentModel bookAppointmentModel = BookAppointmentModel();
  List<TimeSlotModel> timeSlots = <TimeSlotModel>[];

  Future<AppointmentsModel> getUserAppointments() async {
    var response = await ApiService.request(ApiPaths.userAppointments,
        method: RequestMethod.GET);
    appointmentsModel = AppointmentsModel.fromJson(response!);
    notifyListeners();

    return appointmentsModel;
  }

  Future<UserAppointmentDetails> getUserAppointmentDetails(
      {required String appId}) async {
    var response = await ApiService.request(
        ApiPaths.userAppointmentDetails + appId.toString(),
        method: RequestMethod.GET);
    userAppointmentDetails = UserAppointmentDetails.fromJson(response!);
    log("${userAppointmentDetails.toJson()}");
    notifyListeners();

    return userAppointmentDetails;
  }

  Future<PaymentsModel> getUserPayments() async {
    var response = await ApiService.request(ApiPaths.userPayments,
        method: RequestMethod.GET);

    paymentModel = PaymentsModel.fromJson(response!);
    notifyListeners();

    return paymentModel;
  }

  Future<NotificationsModel> getUserNotifications(String userId) async {
    var formData = {"role": "client"};
    var response = await ApiService.request(ApiPaths.userNotifications + userId,
        method: RequestMethod.POST, data: formData);

    notificationsModel = NotificationsModel.fromJson(response!);
    notifyListeners();

    return notificationsModel;
  }

  Future<void> removeUserNotification(
      String userId, String notificationId, int index) async {
    notificationsModel.notifications!.removeAt(index);
    notifyListeners();

    var formData = {"role": "client"};

    var response = await ApiService.request(
        ApiPaths.removeUserNotifications + "$userId/$notificationId",
        method: RequestMethod.POST,
        data: formData);
  }

  Future<ReviewsModel> getUserReviews() async {
    var response = await ApiService.request(ApiPaths.userReviews,
        method: RequestMethod.GET);
    print("REVIEWS MODEL: ${response}");
    reviewsModel = ReviewsModel.fromJson(response!);
    notifyListeners();

    return reviewsModel;
  }

  Future<UserLatestAppointment> getUserLatestAppointment() async {
    var response = await ApiService.request(ApiPaths.userLatestAppointments,
        method: RequestMethod.GET);

    userLatestAppointment = UserLatestAppointment.fromJson(response!);
    notifyListeners();

    return userLatestAppointment;
  }

  Future<void> reportShop({
    String? reportReason,
    required String shopId,
    String? clientId,
    String? reviewId,
  }) async {
    var formData = {
      "report_reason": reportReason,
      "shop_id": shopId,
      "client_id": clientId,
      "review_id": reviewId
    };

    var response = await ApiService.request(ApiPaths.reportShop,
        method: RequestMethod.POST, data: formData);

    if (response?['message'] == "Shop Reported") {
      navigationController.goBack();
      BaseHelper.showSnackBar(response?['message']);
    } else {
      BaseHelper.showSnackBar("Report reason is required");
    }
  }

  Future<bool> bookAppointmentCashOnDelivery() async {
    Iterable<dynamic>? services =
        bookAppointmentModel.service?.map((e) => jsonEncode(e.toJson()));
    Iterable<dynamic>? staffName =
        bookAppointmentModel.staffName?.map((e) => jsonEncode(e.toJson()));
    Iterable<dynamic>? startTime =
        bookAppointmentModel.startTime?.map((e) => jsonEncode(e));
    Iterable<dynamic>? endTime =
        bookAppointmentModel.endTime?.map((e) => jsonEncode(e));
    var jsonService = bookAppointmentModel.jsonService?.map((e) => e.toJson());

    Map<String, dynamic> formData = {
      "service": [...?services].toString(),
      "staff_name": [...?staffName].toString(),
      "start_time": [...?startTime].toString(),
      "end_time": [...?endTime].toString(),
      "jsonService": [...?jsonService].toString(),
      "client_name": bookAppointmentModel.clientName.toString(),
      "client_user_id": bookAppointmentModel.clientUserId.toString(),
      "date": bookAppointmentModel.date.toString(),
      "user_id": bookAppointmentModel.userId.toString(),
      "note": bookAppointmentModel.note.toString(),
      "total_amount": bookAppointmentModel.totalAmount.toString(),
      "used_service_before": "null",
      "home_service_check": bookAppointmentModel.homeServiceCheck.toString(),
      "home_address": bookAppointmentModel.homeAddress.toString(),
      "age": bookAppointmentModel.age.toString(),
      "gender": bookAppointmentModel.gender.toString(),
      "home_service_note": bookAppointmentModel.homeServiceNote.toString(),
      "shop_id": bookAppointmentModel.shopId.toString()
    };

    // Map<String, dynamic> formData = {
    //   "service": "[{\"service_id\": 1,\"price\": \"150\"}]",
    //   "staff_name": "[{\"id\": 1}]",
    //   "start_time": "[\"12:00 pm\"]",
    //   "end_time": "[\"01:20 pm\"]",
    //   "jsonService": "[{\"name\": [\"Braids\"],\"price\": [150]}]",
    //   "client_name": "Fahad",
    //   "client_user_id": "4166",
    //   "date": "2022-03-28",
    //   "user_id": "3210",
    //   "note": "null",
    //   "total_amount": "150",
    //   "used_service_before": "null",
    //   "home_service_check": "false",
    //   "home_address": "null",
    //   "age": "null",
    //   "gender": "null",
    //   "home_service_note": "null",
    //   "shop_id": "3210"
    // };

    var response = await ApiService.request(ApiPaths.bookUserAppointment,
        method: RequestMethod.POST, data: formData);
    if (response?['message'] == "Appointment Created Successfully") {
      bookAppointmentModel.service = [];
      bookAppointmentModel.jsonService = [];
      bookAppointmentModel.staffName = [];
      bookAppointmentModel.startTime = [];
      bookAppointmentModel.endTime = [];
      bookAppointmentModel.durationHour = [];
      bookAppointmentModel.durationMinute = [];
      return true;
    } else {
      return false;
    }
    return false;
  }

  Future<bool> bookAppointmentPayByCard() async {
    Iterable<dynamic>? services =
        bookAppointmentModel.service?.map((e) => jsonEncode(e.toJson()));
    Iterable<dynamic>? staffName =
        bookAppointmentModel.staffName?.map((e) => jsonEncode(e.toJson()));
    Iterable<dynamic>? startTime =
        bookAppointmentModel.startTime?.map((e) => jsonEncode(e));
    Iterable<dynamic>? endTime =
        bookAppointmentModel.endTime?.map((e) => jsonEncode(e));
    var jsonService = bookAppointmentModel.jsonService?.map((e) => e.toJson());

    Map<String, dynamic> formData = {
      "alfa_status ": "1",
      "service": [...?services].toString(),
      "staff_name": [...?staffName].toString(),
      "start_time": [...?startTime].toString(),
      "end_time": [...?endTime].toString(),
      "jsonService": [...?jsonService].toString(),
      "client_name": bookAppointmentModel.clientName.toString(),
      "client_user_id": bookAppointmentModel.clientUserId.toString(),
      "date": bookAppointmentModel.date.toString(),
      "user_id": bookAppointmentModel.userId.toString(),
      "note": bookAppointmentModel.note.toString(),
      "total_amount": bookAppointmentModel.totalAmount.toString(),
      "used_service_before": "null",
      "home_service_check": bookAppointmentModel.homeServiceCheck.toString(),
      "home_address": bookAppointmentModel.homeAddress.toString(),
      "age": bookAppointmentModel.age.toString(),
      "gender": bookAppointmentModel.gender.toString(),
      "home_service_note": bookAppointmentModel.homeServiceNote.toString(),
      "shop_id": bookAppointmentModel.shopId.toString()
    };

    var response = await ApiService.request(ApiPaths.bookUserAppointment,
        method: RequestMethod.POST, data: formData);
    if (response?['message'] == "Appointment Created Successfully") {
      print(response);

      AppointmentBookingResponseModel responseModel =
          AppointmentBookingResponseModel.fromJson(response!);
      navigationController.navigateToNamedWithArg(RouteGenerator.paymentScree, {
        "appointmentId":
            "RES-${responseModel.recipent?.id}-${responseModel.recipent!.date!.replaceAll('-', '')}",
        "totalAmount": bookAppointmentModel.totalAmount,
      });

      bookAppointmentModel.service = [];
      bookAppointmentModel.jsonService = [];
      bookAppointmentModel.staffName = [];
      bookAppointmentModel.startTime = [];
      bookAppointmentModel.endTime = [];
      bookAppointmentModel.durationMinute = [];
      bookAppointmentModel.durationHour = [];

      return true;
    } else {
      return false;
    }
    return false;
  }

  Future<List<TimeSlotModel>> shopSlots(
      String startTime, String endTime, String clickDate,
      {String length = "56"}) async {
    var formData = {
      "shop_start_time": startTime,
      "shop_end_time": endTime,
      "click_date": clickDate,
      "length": length
    };

    var response = await ApiService.request(ApiPaths.slotsOfShop,
        method: RequestMethod.POST, data: formData);
    Iterable slots = response?['slot_list'];

    timeSlots = slots
        .map((e) => TimeSlotModel(timeSlot: e, isSelected: false))
        .toList();

    return timeSlots;
  }

  void updateSlotsUi(int index) {
    for (var element in timeSlots) {
      element.isSelected = false;
    }
    timeSlots.elementAt(index).isSelected = true;
    notifyListeners();
  }

  void addServices(Service service, JsonService jsonService) {
    bookAppointmentModel.service!.add(service);
    bookAppointmentModel.jsonService!.add(jsonService);
    notifyListeners();
  }

  void removeService(int index) {
    bookAppointmentModel.startTime!.removeLast();
    bookAppointmentModel.endTime!.removeLast();

    bookAppointmentModel.service!.removeAt(index);
    bookAppointmentModel.jsonService!.removeAt(index);
    bookAppointmentModel.staffName!.removeAt(index);

    notifyListeners();
  }

  void addStaffName(List<StaffName> staffName) {
    bookAppointmentModel.staffName = staffName;
    // notifyListeners();
  }

  void updateStaffName(int index, StaffName staffName) {
    bookAppointmentModel.staffName![index] = staffName;
    notifyListeners();
  }

  void addTimeSlot(
    String startTimeSlot,
    String endTimeSlot,
  ) {
    bookAppointmentModel.startTime!.add(startTimeSlot);
    bookAppointmentModel.endTime!.add(endTimeSlot);
    notifyListeners();
  }

  String calculateTotalPrice(bool homeCheck) {
    int totalAmount = 0;
    for (JsonService val in bookAppointmentModel.jsonService ?? []) {
      totalAmount += val.price?.first ?? 0;
    }
    if (homeCheck) {
      totalAmount += 500;
    }
    bookAppointmentModel.totalAmount = totalAmount.toString();
    return totalAmount.toString();
  }

  bool bookAppointEmpty() {
    return bookAppointmentModel.service!.isEmpty;
  }
}
