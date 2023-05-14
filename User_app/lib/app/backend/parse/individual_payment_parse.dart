/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:salon_user/app/backend/api/api.dart';
import 'package:salon_user/app/helper/shared_pref.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:get/get.dart';

class IndividualPaymentParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  IndividualPaymentParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> individualDetails(var body) async {
    return await apiService.postPublic(
      AppConstants.individualDetails,
      body,
    );
  }

  Future<Response> getPayments() async {
    var response = await apiService.getPrivate(AppConstants.getPayments,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> createAppoinments(var body) async {
    return await apiService.postPrivate(AppConstants.createAppointments, body,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getInstaMojoPayLink(var param) async {
    return await apiService.postPrivate(AppConstants.payWithInstaMojo, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  String getPhone() {
    return sharedPreferencesManager.getString('phone') ?? '';
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }

  String getFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getAppLogo() {
    return sharedPreferencesManager.getString('appLogo') ?? '';
  }

  Future<Response> getSavedAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.getSavedAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getMyWalletBalance() async {
    return await apiService.postPrivate(
        AppConstants.getMyWalletBalance,
        {'id': sharedPreferencesManager.getString('uid')},
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
