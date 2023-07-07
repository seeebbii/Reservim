import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:reservim/app/constants/controller.constant.dart';
import 'package:reservim/core/api/api_paths.dart';
import 'package:reservim/core/model/user/userprofile.model.dart';
import 'package:reservim/core/notifier/appointments.notifier.dart';
import 'package:reservim/meta/utils/base_helper.dart';
import 'package:reservim/meta/utils/hive_database.dart';

import '../api/api_service.dart';
import '../router/router_generator.dart';

class AuthenticationNotifier extends ChangeNotifier {
  UserProfileModel currentUser = UserProfileModel();

  Future<bool> login(String email, String password) async {
    // GENERATING [FCM TOKEN]
    String? token = await firebaseToken();

    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "fcm_token": "$token",
    };

    var response = await ApiService.request(ApiPaths.login,
        method: RequestMethod.POST, data: data);

    print("$response");

    if (response?['status'] == 'success') {

      if(response?['phone_verified'] == 0){
        navigationController.navigateToNamedWithArg(RouteGenerator.enterPhoneNumberScreen, {'clientId': response?['role_data']['client_id'][0]});
        BaseHelper.showSnackBar("Phone Number not verified");
        return false;
      }

      HiveDatabase.storeValue(
          HiveDatabase.authToken, "Bearer " + response!['access_token']);
      HiveDatabase.storeValue(HiveDatabase.loginCheck, true);

      log("Logged in successful");

      // LOAD USER PROFILE FROM BEARER TOKEN
      loadUserProfile();

      return true;
    } else {
      // TODO :: INVALID CREDENTIALS

      BaseHelper.showSnackBar(response?['msg']);

      return false;
    }
  }

  Future<bool> signup(String name, String phone, String password) async {
    String? fcmToken = await firebaseToken();
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "password": password,
      "role": "client",
      "fcm_token": fcmToken
    };

    var response = await ApiService.request(ApiPaths.signup,
        method: RequestMethod.POST, data: data);

    if (response?['status'] == 'success') {
      if(response?['phone_verified'] == 0){
        navigationController.navigateToNamedWithArg(RouteGenerator.enterPhoneNumberScreen, {'clientId': response?['role_data']['client_id'][0]});
        BaseHelper.showSnackBar("Please Verify Your Phone Number");
        return false;
      }
      HiveDatabase.storeValue(
          HiveDatabase.authToken, "Bearer " + response!['access_token']);
      HiveDatabase.storeValue(HiveDatabase.loginCheck, true);

      log("Signup successful");

      // LOAD USER PROFILE FROM BEARER TOKEN
      loadUserProfile();

      return true;
    } else if (response?['phone'][0] == "The phone has already been taken.") {
      // TODO :: NUMBER ALREADY IN USE

      BaseHelper.showSnackBar(response?['phone'][0]);

      return false;
    } else {
      return false;
    }
  }

  Future<void> loadUserProfile() async {
    var response = await ApiService.request(
      ApiPaths.userProfile,
      method: RequestMethod.GET,
    );
    currentUser = UserProfileModel.fromJson(response!);
    HiveDatabase.storeValue(HiveDatabase.userId, currentUser.data!.id);
    HiveDatabase.storeValue(HiveDatabase.userCityId, currentUser.data!.city);
    notifyListeners();
    // AppointmentsNotifier().getUserNotifications(currentUser.data!.id.toString());
  }

  Future<bool> resetPassword(
    String previousPassword,
    String newPassword,
  ) async {
    Map<String, dynamic> data = {
      "prev_password": previousPassword,
      "new_password": newPassword,
      "role": "client",
    };

    var response = await ApiService.request(
      ApiPaths.resetPassword + currentUser.data!.id.toString(),
      method: RequestMethod.POST,
      data: data,
    );

    if (response?['statusCode'] == 200) {
      // PASSWORD CHANGED SUCCESSFULLY
      navigationController.goBack();
      BaseHelper.showSnackBar(response?['message']);
      return true;
    } else {
      // ERROR CHANGING PASSWORD
      BaseHelper.showSnackBar(response?['message']);
      return false;
    }
  }

  Future<bool> forgotPassword(
    String phoneNumber,
    String newPassword,
  ) async {
    Map<String, dynamic> data = {
      "phone": phoneNumber,
      "password": newPassword,
    };

    var response = await ApiService.request(
      ApiPaths.resetPassword + currentUser.data!.id.toString(),
      method: RequestMethod.POST,
      data: data,
    );

    if (response?['statusCode'] == 200) {
      // PASSWORD CHANGED SUCCESSFULLY
      navigationController.goBack();
      BaseHelper.showSnackBar(response?['message']);
      return true;
    } else {
      // ERROR CHANGING PASSWORD
      BaseHelper.showSnackBar(response?['message']);
      return false;
    }
  }

  Future<void> updateUserProfileLogo(File file, int userId) async {
    print(userId);
    Map<String, dynamic> data = {
      "logo": await dio.MultipartFile.fromFile(file.path),
      "role": "client",
    };

    var response = await ApiService.request(
      ApiPaths.updateUserLogo + userId.toString(),
      method: RequestMethod.POST,
      data: data,
    );
    if (response != null) {
      debugPrint(response.toString());
      currentUser.data?.logo = response['logo'];
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile(Map<String, dynamic> formData) async {
    var response = await ApiService.request(
      ApiPaths.updateUserProfile,
      method: RequestMethod.POST,
      data: formData,
    );
    loadUserProfile();

    if (response?['phone'] is Object) {
      if (response?['phone'][0] == 'The phone has already been taken.') {
        BaseHelper.showSnackBar("This number is already in use");
      } else {
        BaseHelper.showSnackBar("The number must be at least 11 characters");
      }
    }
    if (response?['email'] is Object) {
      if (response?['email'][0] == 'The email has already been taken.') {
        BaseHelper.showSnackBar("The email has already been taken");
      } else {
        BaseHelper.showSnackBar("The email format is invalid");
      }
    }

    if (response?['statusCode'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> firebaseToken() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    String? token = await fcm.getToken();
    return token;
  }

  Future<void> logout() async {
    // var response = await ApiService.request(
    //   ApiPaths.logout,
    //   method: RequestMethod.GET,
    // );
    // if (response?['statusCode'] == 200) {
    HiveDatabase.storeValue(HiveDatabase.loginCheck, false);
    HiveDatabase.storeValue(HiveDatabase.authToken, null);
    currentUser = UserProfileModel();
    // HiveDatabase.storeValue(HiveDatabase.userModel, null);
    navigationController.getOffAll(RouteGenerator.welcomeScreen);
    // }
  }

  /*
     FIREBASE PHONE AUTHENTICATIONS
  */

  Future verifyPhoneNo(context, String phoneNumber,
      {isFromOtpPage = false}) async {
    debugPrint("Phone Number: $phoneNumber");
    await FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (AuthCredential authCredential) async {
          _phoneLogin(context, authCredential, phoneNumber);
        },
        verificationFailed: (FirebaseAuthException e) async {
          // if (e.code == 'invalid-phone-number') {
          //   print('The provided phone number is not valid.');
          // }
        },
        codeSent: (String? verificationId, [int? forceCodeResent]) {
          print(verificationId);
          print(forceCodeResent);
          if (!isFromOtpPage)
            navigationController.navigateToNamedWithArg(
                RouteGenerator.forgotPasswordScreen,
                {"phoneNumber": phoneNumber, "verificationId": verificationId});
        },
        codeAutoRetrievalTimeout: (String verId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future verifyOtp(context, otp, verId, phone) async {
    final AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);
    print(authCredential);
    _phoneLogin(context, authCredential, phone);
  }

  Future<void> _phoneLogin(context, credential, phone) async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (user.user != null) {}
    print(user);
  }
}
