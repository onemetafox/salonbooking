/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:ultimate_salon_owner_flutter/app/backend/api/api.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';

class SignUpParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SignUpParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> verifyEmail(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.verifyEmail, body);
    return response;
  }

  Future<Response> verifyPhone(dynamic body) async {
    var response =
        await apiService.postPublic(AppConstants.verifyPhoneRegister, body);
    return response;
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTPEmail, param);
  }

  String getSMSName() {
    return sharedPreferencesManager.getString('smsName') ??
        AppConstants.defaultSMSGateway;
  }

  Future<Response> getHomeCities() async {
    var response = await apiService.getPublic(AppConstants.getHomeCities);
    return response;
  }

  Future<Response> checkPhoneExist(dynamic body) async {
    var response =
        await apiService.postPublic(AppConstants.checkPhoneExist, body);
    return response;
  }

  Future<Response> saveMyRequest(dynamic body) async {
    var response =
        await apiService.postPublic(AppConstants.saveMyRequest, body);
    return response;
  }
}
