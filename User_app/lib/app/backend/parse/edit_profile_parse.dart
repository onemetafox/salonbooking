/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:salon_user/app/backend/api/api.dart';
import 'package:salon_user/app/helper/shared_pref.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  EditProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getUserByID(var body) async {
    var response = await apiService.postPrivate(AppConstants.getUserByID, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> onUpdateInfo(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateInfo, body,
        sharedPreferencesManager.getString('token') ?? '');
    sharedPreferencesManager.putString('cover', body['cover']);
    sharedPreferencesManager.putString('first_name', body['first_name']);
    sharedPreferencesManager.putString('last_name', body['last_name']);
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '0';
  }
}
