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

class CalendarsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CalendarsParser(
      {required this.sharedPreferencesManager, required this.apiService});

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getType() {
    return sharedPreferencesManager.getString('type') ?? '';
  }

  Future<Response> getCalendarView() async {
    return await apiService.postPrivate(
        AppConstants.calendarView,
        {'id': getUID(), "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getByDate(var body) async {
    return await apiService.postPrivate(AppConstants.getByDate, body,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }
}
