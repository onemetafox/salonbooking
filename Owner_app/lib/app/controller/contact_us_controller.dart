/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/contact_us_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class ContactUsController extends GetxController implements GetxService {
  final ContactUsParser parser;

  final nameContact = TextEditingController();
  final emailContanct = TextEditingController();
  final messageContanct = TextEditingController();

  RxBool isLogin = false.obs;
  ContactUsController({required this.parser});

  Future<void> saveContacts() async {
    if (emailContanct.text == '' ||
        nameContact.text == '' ||
        messageContanct.text == '') {
      showToast('All fields are required');
      return;
    }
    if (!GetUtils.isEmail(emailContanct.text)) {
      showToast('Email is not valid');
      return;
    }
    isLogin.value = !isLogin.value;
    update();
    DateTime now = DateTime.now();
    String ymd = now.toIso8601String().split('T').first;
    var param = {
      'name': nameContact.text,
      'email': emailContanct.text,
      'message': messageContanct.text,
      'status': '0',
      'date': ymd.toString()
    };

    Response response = await parser.saveContact(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body['id'] != '' && body['id'] != '') {
        sendToAdmin(body['id']);
      }
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> sendToAdmin(var id) async {
    var param = {
      'id': id,
      'mediaURL': '${Environments.apiBaseURL}/storage/images/',
      'subject': 'New Mail Request Received'.tr,
      'thank_you_text': 'You have received new mail'.tr,
      'header_text': 'New Contact Details'.tr,
      'email': parser.getSupportEmail(),
      'from_mail': emailContanct.text,
      'from_username': nameContact.text,
      'from_message': messageContanct.text,
      'to_respond':
          'We have received your request, we will respond on your issue soon'.tr
    };
    Response response = await parser.sendToMail(param);
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      update();
      nameContact.text = '';
      emailContanct.text = '';
      messageContanct.text = '';
      HapticFeedback.lightImpact();

      Get.generalDialog(
          pageBuilder: (context, __, ___) => AlertDialog(
                title: Text('Alert!'.tr),
                content: Text('Contact Information Sent'.tr),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Okay'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.appColor, fontFamily: 'bold'),
                    ),
                  )
                ],
              ));
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }
}
