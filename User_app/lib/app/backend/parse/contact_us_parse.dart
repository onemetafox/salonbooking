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
import 'package:get/get.dart';
import 'package:salon_user/app/util/constant.dart';

class ContactUsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ContactUsParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> saveContact(dynamic param) async {
    return await apiService.postPublic(AppConstants.saveaContacts, param);
  }

  Future<Response> sendToMail(dynamic param) async {
    return await apiService.postPublic(AppConstants.sendMailToAdmin, param);
  }

  String getSupportEmail() {
    return sharedPreferencesManager.getString('supportEmail') ?? '';
  }
}
