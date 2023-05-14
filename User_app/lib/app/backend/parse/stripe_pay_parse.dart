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

class StripePayParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  StripePayParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getProfile() async {
    return await apiService.postPrivate(
        AppConstants.getUserProfile,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getStripeCards(var id) async {
    return await apiService.postPrivate(AppConstants.getStripeCards, {'id': id},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  Future<Response> createAppoinment(var param) async {
    return await apiService.postPrivate(AppConstants.createAppointments, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> checkout(param) async {
    return await apiService.postPrivate(AppConstants.stripeCheckout, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
