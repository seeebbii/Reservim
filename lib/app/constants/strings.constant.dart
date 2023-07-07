import 'package:intl/intl.dart';

import '../../meta/utils/app_theme.dart';

var emailValidate = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

String phoneNumber = '+923458817087';

Map<String, dynamic> checkStatus(String status) {
  Map<String, dynamic> calcStatus = {};
  switch (status) {
    case "0":
      calcStatus = {
        'status': "Pending",
        'color': AppTheme.cancelledAppointment
      };
      break;
    case "1":
      calcStatus = {
        'status': "Approved",
        'color': AppTheme.confirmedAppointment
      };
      break;
    case "2":
      calcStatus = {
        'status': "Declined",
        'color': AppTheme.cancelledAppointment
      };
      break;
    case "3":
      calcStatus = {
        'status': "Cancelled",
        'color': AppTheme.cancelledAppointment
      };
      break;
    case "4":
      calcStatus = {
        'status': "Completed",
        'color': AppTheme.confirmedAppointment
      };
      break;
    case "5":
      calcStatus = {
        'status': "No Show",
        'color': AppTheme.cancelledAppointment
      };
      break;
    default:
      calcStatus = {
        'status': "No Show",
        'color': AppTheme.cancelledAppointment
      };
      break;
  }
  return calcStatus;
}

String formatTime(DateTime dateTime){
  return DateFormat.jm().format(dateTime);
}

String formatDate(DateTime dateTime){
  return DateFormat.yMMMMd().format(dateTime);
}

String formatDatePayments(DateTime dateTime){
  return DateFormat.yMMMd().format(dateTime);
}

String formatMonth(DateTime dateTime){
  return DateFormat.LLL().format(dateTime);
}

String formatDay(DateTime dateTime){
  return DateFormat.d().format(dateTime);
}

String formatWeekDay(DateTime dateTime){
  return DateFormat.EEEE().format(dateTime);
}