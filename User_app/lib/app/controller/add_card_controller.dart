/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/parse/add_card_parse.dart';
import 'package:salon_user/app/controller/stripe_pay_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';

class AddCardController extends GetxController implements GetxService {
  final AddCardParse parser;
  bool apiCalled = false;
  final emailAddress = TextEditingController();
  final cardNumber = TextEditingController();
  final cardName = TextEditingController();
  final cvcNumber = TextEditingController();
  final expireNumber = TextEditingController();
  String stripeKey = '';
  AddCardController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    Response response = await parser.getProfile();
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null && body != '') {
        emailAddress.text = body['email'] ?? '';
        stripeKey = body['stripe_key'] ?? '';
        update();
      }
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> submitData() async {
    if (emailAddress.text == '' ||
        cardNumber.text == '' ||
        cardName.text == '' ||
        cvcNumber.text == '' ||
        expireNumber.text == '') {
      showToast('All fields are required'.tr);
      return;
    }
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);

    update();
    var param = {
      'number': cardNumber.text,
      'exp_month': expireNumber.text.split('/')[0],
      'exp_year': expireNumber.text.split('/')[1],
      'cvc': cvcNumber.text,
      'email': emailAddress.text
    };
    Response response = await parser.createCardToken(param);
    if (response.statusCode == 200) {
      if (stripeKey != '' && stripeKey.isNotEmpty) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["success"];
        addStripe(body['id']);
      } else {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["success"];
        createCustomer(body['id']);
      }
      update();
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> addStripe(String token) async {
    var param = {'token': token, 'id': stripeKey};
    Response response = await parser.addStripeCard(param);
    if (response.statusCode == 200) {
      Get.back();
      successToast('Card Information Saved'.tr);
      update();
      Get.find<StripePayController>().getProfile();
      onBack();
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  onBack() {
    var context = Get.context as BuildContext;
    Navigator.pop(context);
  }

  Future<void> createCustomer(String token) async {
    var param = {'email': emailAddress.text, 'source': token};
    Response response = await parser.createCustomer(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      updateUserStripeKey(body['id']);
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> updateUserStripeKey(String key) async {
    var param = {'id': parser.getUID(), 'stripe_key': key};
    Response response = await parser.updateProfile(param);
    if (response.statusCode == 200) {
      Get.back();
      successToast('Card Information Saved'.tr);
      update();
      Get.find<StripePayController>().getProfile();
      onBack();
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }
}
