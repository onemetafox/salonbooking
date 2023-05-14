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

class AddCardParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddCardParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> updateProfile(dynamic param) async {
    return await apiService.postPrivate(AppConstants.updateProfile, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> createCardToken(dynamic param) async {
    return await apiService.postPrivate(AppConstants.createStripeToken, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> createCustomer(dynamic param) async {
    return await apiService.postPrivate(AppConstants.createStripeCustomer,
        param, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> addStripeCard(dynamic param) async {
    return await apiService.postPrivate(AppConstants.addStripeCard, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getProfile() async {
    return await apiService.postPrivate(
        AppConstants.getUserProfile,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
