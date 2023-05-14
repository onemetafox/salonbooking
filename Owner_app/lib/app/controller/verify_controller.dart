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
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/verify_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyController extends GetxController implements GetxService {
  final VerifyParser parser;
  RxBool isLogin = false.obs;
  final emailReset = TextEditingController();
  final passwordReset = TextEditingController();
  final confirmPasswordReset = TextEditingController();

  String otpCode = '';
  int smsId = 1;
  int divNumber = 1;
  String tempToken = '';
  RxBool passwordVisible = false.obs;
  VerifyController({required this.parser});
  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  void onEmailModal() {
    var context = Get.context as BuildContext;
    openOTPModal(context, emailReset.text);
  }

  Future<void> sendMail() async {
    if (emailReset.text == '') {
      showToast('All Fields Are Required'.tr);
      return;
    }
    if (!GetUtils.isEmail(emailReset.text)) {
      showToast('Email is not valid'.tr);
      return;
    }
    isLogin.value = !isLogin.value;
    update();
    var param = {'email': emailReset.text};
    Response response = await parser.resetWithOTPMail(param);
    debugPrint(response.bodyString.toString());
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['data'] == true) {
        smsId = myMap['otp_id'];
        FocusManager.instance.primaryFocus?.unfocus();
        onEmailModal();
      } else {
        if (myMap['data'] != '' &&
            myMap['data'] == false &&
            myMap['status'] == 500) {
          showToast(myMap['message'.tr]);
        } else {
          showToast('Something went wrong while signup'.tr);
        }
      }
      update();
    } else if (response.statusCode == 401) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  void openOTPModal(context, String text) {
    showDialog(
        context: context,
        barrierColor: ThemeProvider.appColor,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: Text(
              "Verification".tr,
              textAlign: TextAlign.center,
            ),
            content: AbsorbPointer(
              absorbing: isLogin.value == false ? false : true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      'We have sent verification code on'.tr,
                      style:
                          const TextStyle(fontSize: 12, fontFamily: 'medium'),
                    ),
                    Text(
                      text,
                      style:
                          const TextStyle(fontSize: 12, fontFamily: 'medium'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: ThemeProvider.greyColor,
                      keyboardType: TextInputType.number,
                      // cursorColor: ThemeProvider.appColor,
                      // enabledBorderColor: ThemeProvider.appColor,
                      focusedBorderColor: ThemeProvider.appColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) {
                        otpCode = verificationCode;
                        onOtpSubmit(context);
                      }, // end onSubmit
                    ),
                    // OTP
                  ],
                )),
              ),
            ),
            actions: [
              AbsorbPointer(
                absorbing: isLogin.value == false ? false : true,
                child: Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.white),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (otpCode != '' && otpCode.length >= 6) {
                            onOtpSubmit(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          elevation: 0,
                        ),
                        child: isLogin.value == true
                            ? const CircularProgressIndicator(
                                color: ThemeProvider.whiteColor,
                              )
                            : Text(
                                'Verify'.tr,
                                style: const TextStyle(
                                    fontFamily: 'regular', fontSize: 16),
                              ))),
              )
            ],
          );
        });
  }

  Future<void> onOtpSubmit(context) async {
    isLogin.value = !isLogin.value;
    update();
    var param = {
      'id': smsId,
      'otp': otpCode,
      'email': emailReset.text,
    };
    Response response = await parser.verifyOTP(param);
    debugPrint(response.bodyString.toString());
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        Navigator.of(context).pop(true);
        tempToken = myMap['temp'];
        debugPrint(tempToken);
        divNumber = 2;
        debugPrint(divNumber.toString());
        update();
      } else {
        showToast('Something went wrong while signup'.tr);
      }
      update();
    } else if (response.statusCode == 401) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error']);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> updatePassword() async {
    if (passwordReset.text == '' || confirmPasswordReset.text == '') {
      showToast('All Fields Are Required'.tr);
      return;
    }

    if (passwordReset.text != confirmPasswordReset.text) {
      showToast('Password mismatch'.tr);
      return;
    }

    isLogin.value = !isLogin.value;
    update();
    var param = {
      'id': smsId,
      'email': emailReset.text,
      'password': passwordReset.text
    };
    Response response = await parser.updatePassword(param, tempToken);
    debugPrint(response.bodyString.toString());
    if (response.statusCode == 200) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['data'] == true) {
        successToast('Password Updated'.tr);
        onBack();
      } else {
        if (myMap['data'] != '' &&
            myMap['data'] == false &&
            myMap['status'] == 500) {
          showToast(myMap['message'.tr]);
        } else {
          showToast('Something went wrong while signup'.tr);
        }
      }
      update();
    } else if (response.statusCode == 401) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      isLogin.value = !isLogin.value;
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      isLogin.value = !isLogin.value;
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }
}
