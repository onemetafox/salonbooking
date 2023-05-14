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

class SalonCategoriesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SalonCategoriesParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> selectCategories() async {
    var response = await apiService.getPrivate(AppConstants.categories,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateCate(String cateIds) async {
    var response = await apiService.postPrivate(
        AppConstants.salonUpdate,
        {"id": sharedPreferencesManager.getString('id'), "categories": cateIds},
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
