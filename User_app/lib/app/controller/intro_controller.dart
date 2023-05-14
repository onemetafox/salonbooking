/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:salon_user/app/backend/parse/intro_parse.dart';
import 'package:salon_user/app/helper/router.dart';

class IntroController extends GetxController implements GetxService {
  final IntroParser parser;
  IntroController({required this.parser});

  void onSkip() {
    Get.toNamed(AppRouter.getWelcomeRoute(), arguments: ['']);
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
    update();
  }
}
