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
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';

class ProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});

  bool getType() {
    return sharedPreferencesManager.getString('type') == 'salon' ? true : false;
  }

  Future<Response> logout() async {
    return await apiService.logout(
        AppConstants.logout, sharedPreferencesManager.getString('token') ?? '');
  }

  void clearAccount() {
    sharedPreferencesManager.clearKey('first_name');
    sharedPreferencesManager.clearKey('last_name');
    sharedPreferencesManager.clearKey('token');
    sharedPreferencesManager.clearKey('uid');
    sharedPreferencesManager.clearKey('email');
    sharedPreferencesManager.clearKey('cover');
    sharedPreferencesManager.clearKey('name');
    sharedPreferencesManager.clearKey('background');
    sharedPreferencesManager.clearKey('rating');
    sharedPreferencesManager.clearKey('totalRating');
  }

  String getName() {
    return sharedPreferencesManager.getString('name') ?? '';
  }

  String getCover() {
    return sharedPreferencesManager.getString('cover') ?? '';
  }

  String getBackground() {
    return sharedPreferencesManager.getString('background') ?? '';
  }

  double getRating() {
    return sharedPreferencesManager.getDouble('rating') ?? 0;
  }

  String getTotalRating() {
    return sharedPreferencesManager.getString('totalRating') ?? '';
  }
}
