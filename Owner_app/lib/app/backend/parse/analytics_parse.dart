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

class AnalyticsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AnalyticsParser(
      {required this.apiService, required this.sharedPreferencesManager});

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getType() {
    return sharedPreferencesManager.getString('type') ?? '';
  }

  Future<Response> getStats(var month, var year) async {
    return await apiService.postPrivate(
        AppConstants.getStats,
        {'id': getUID(), "month": month, "year": year, "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getMonthsStatus(var year) async {
    return await apiService.postPrivate(
        AppConstants.getMonthsStats,
        {'id': getUID(), "year": year, "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getAllStats() async {
    return await apiService.postPrivate(
        AppConstants.getAllStats,
        {'id': getUID(), "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getStatsProducts(var month, var year) async {
    return await apiService.postPrivate(
        AppConstants.getStatsProducts,
        {'id': getUID(), "month": month, "year": year, "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getMonthsStatusProducts(var year) async {
    return await apiService.postPrivate(
        AppConstants.getMonthsStatsProducts,
        {'id': getUID(), "year": year, "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getAllStatsProducts() async {
    return await apiService.postPrivate(
        AppConstants.getAllStatsProducts,
        {'id': getUID(), "type": getType()},
        sharedPreferencesManager.getString('token') ?? '');
  }
}
