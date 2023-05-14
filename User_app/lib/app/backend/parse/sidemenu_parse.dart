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

class SideMenuParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SideMenuParser(
      {required this.apiService, required this.sharedPreferencesManager});
}
