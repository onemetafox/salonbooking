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
import 'package:ultimate_salon_owner_flutter/app/backend/parse/login_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/analytics_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/appointment_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/calendar_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/history_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/profile_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/signup_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/tabs_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class LoginController extends GetxController implements GetxService {
  final LoginParser parser;

  String title = 'signin';
  final emailTextEditor = TextEditingController();
  final passwordTextEditor = TextEditingController();
  final mobileNo = TextEditingController();
  RxBool passwordVisible = false.obs;

  int loginVersion = AppConstants.userLogin;
  String smsName = AppConstants.defaultSMSGateway;

  int smsId = 1;
  String otpCode = '';
  String countryCode = '+91';
  LoginController({required this.parser});

  @override
  void onInit() {
    debugPrint('login api call');
    super.onInit();
    smsName = parser.smsName();
    loginVersion = parser.userLogin();
    emailTextEditor.text = '';
    passwordTextEditor.text = '';
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
  }

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  void onForgot() {
    Get.toNamed(AppRouter.getVerifyRoute());
  }

  void onSignUp() {
    Get.delete<SignUpController>(force: true);
    Get.toNamed(AppRouter.getSignUpRoute());
  }

  Future<void> onLogin() async {
    if (emailTextEditor.text == '' ||
        emailTextEditor.text.isEmpty ||
        passwordTextEditor.text == '' ||
        passwordTextEditor.text.isEmpty) {
      showToast('All fields are required!');
      return;
    }
    if (!GetUtils.isEmail(emailTextEditor.text)) {
      showToast('Email is not valid');
      return;
    }
    var body = {
      "email": emailTextEditor.text,
      "password": passwordTextEditor.text,
    };

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
      barrierDismissible: false,
    );

    var response = await parser.onLogin(body);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap['user']['id'].toString());

      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] != 'user') {
        debugPrint(myMap['user']['id'].toString());
        debugPrint(myMap['user']['id'].toString());

        parser.saveToken(myMap['token']);
        parser.saveInfo(
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['mobile'].toString(),
            myMap['user']['type'].toString());
        if (myMap['user']['type'].toString() == 'individual') {
          parser.saveOtherInfo(
              '${myMap['user']['first_name']} ${myMap['user']['last_name']}',
              myMap['user']['cover'].toString(),
              myMap['individual']['background'].toString(),
              double.parse(myMap['individual']['rating'].toString()),
              myMap['individual']['total_rating'].toString());
        } else {
          parser.saveOtherInfo(
              myMap['salon']['name'].toString(),
              myMap['salon']['cover'].toString(),
              'NA',
              double.parse(myMap['salon']['rating'].toString()),
              myMap['salon']['total_rating'].toString());
        }
        var updateParam = {
          "id": myMap['user']['id'].toString(),
          'fcm_token': parser.getFcmToken(),
        };
        await parser.updateProfile(updateParam, myMap['token']);
        onNavigate();
      } else {
        showToast('Access denied'.tr);
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> loginWithPhonePassword() async {
    if (mobileNo.text == '' || passwordTextEditor.text == '') {
      showToast('All fields are required'.tr);
      return;
    }
    update();
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

    var param = {
      'country_code': countryCode,
      'mobile': mobileNo.text,
      'password': passwordTextEditor.text
    };
    Response response = await parser.loginWithPhonePasswordPost(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] != 'user') {
        debugPrint(myMap['user']['id'].toString());
        parser.saveToken(myMap['token']);
        parser.saveInfo(
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['mobile'].toString(),
            myMap['user']['type'].toString());
        if (myMap['user']['type'].toString() == 'individual') {
          parser.saveOtherInfo(
              '${myMap['user']['first_name']} ${myMap['user']['last_name']}',
              myMap['user']['cover'].toString(),
              myMap['individual']['background'].toString(),
              double.parse(myMap['individual']['rating'].toString()),
              myMap['individual']['total_rating'].toString());
        } else {
          parser.saveOtherInfo(
              myMap['salon']['name'].toString(),
              myMap['salon']['cover'].toString(),
              'NA',
              double.parse(myMap['salon']['rating'].toString()),
              myMap['salon']['total_rating'].toString());
        }
        var updateParam = {
          "id": myMap['user']['id'].toString(),
          'fcm_token': parser.getFcmToken(),
        };
        await parser.updateProfile(updateParam, myMap['token']);
        onNavigate();
      } else {
        showToast('Access denied'.tr);
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  void updateCountryCode(String code) {
    countryCode = code;
    update();
  }

  Future<void> loginWithPhoneOTP() async {
    if (mobileNo.text == '') {
      showToast('Phone Number is required'.tr);
      return;
    }

    if (smsName == '2') {
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

      var param = {'country_code': countryCode, 'mobile': mobileNo.text};

      Response response = await parser.verifyPhoneWithFirebase(param);
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          FocusManager.instance.primaryFocus?.unfocus();
          Get.toNamed(AppRouter.getFirebaseAuthRoutes(),
              arguments: [countryCode, mobileNo.text, 'login']);
        } else {
          showToast('Something went wrong while signup'.tr);
        }
        update();
      } else if (response.statusCode == 401) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Something went wrong'.tr);
        }
        update();
      } else if (response.statusCode == 500) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Something went wrong'.tr);
        }
        update();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
      update();
    } else {
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

      var param = {'country_code': countryCode, 'mobile': mobileNo.text};
      Response response = await parser.verifyPhone(param);
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          smsId = myMap['otp_id'];
          FocusManager.instance.primaryFocus?.unfocus();
          var context = Get.context as BuildContext;
          // ignore: use_build_context_synchronously
          openOTPModal(
              context, countryCode.toString() + mobileNo.text.toString());
        } else {
          showToast('Something went wrong while signup'.tr);
        }
        update();
      } else if (response.statusCode == 401) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error'.tr]);
        } else {
          showToast('Something went wrong'.tr);
        }
        update();
      } else if (response.statusCode == 500) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['error'] != '') {
          showToast(myMap['error'.tr]);
        } else {
          showToast('Something went wrong'.tr);
        }
        update();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
      update();
    }
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
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Column(
                children: [
                  Text(
                    'We have sent verification code on'.tr,
                    style: const TextStyle(fontSize: 12, fontFamily: 'medium'),
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 12, fontFamily: 'medium'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: ThemeProvider.greyColor,
                    keyboardType: TextInputType.number,
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
            actions: [
              Container(
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
                      child: Text(
                        'Verify'.tr,
                        style: const TextStyle(
                            fontFamily: 'regular', fontSize: 16),
                      )))
            ],
          );
        });
  }

  Future<void> onOtpSubmit(context) async {
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
    var param = {'id': smsId, 'otp': otpCode};
    Response response = await parser.verifyOTP(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        Navigator.of(context).pop(true);
        loginWithPhoneToken();
      } else {
        showToast('Something went wrong while signup'.tr);
      }
      update();
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> loginWithPhoneToken() async {
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
    var param = {'country_code': countryCode, 'mobile': mobileNo.text};
    Response response = await parser.loginWithPhoneToken(param);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['user'] != '' &&
          myMap['token'] != '' &&
          myMap['user']['type'] != 'user') {
        debugPrint(myMap['user']['id'].toString());
        parser.saveToken(myMap['token']);
        parser.saveInfo(
            myMap['user']['id'].toString(),
            myMap['user']['first_name'].toString(),
            myMap['user']['last_name'].toString(),
            myMap['user']['cover'].toString(),
            myMap['user']['email'].toString(),
            myMap['user']['mobile'].toString(),
            myMap['user']['type'].toString());

        if (myMap['user']['type'].toString() == 'individual') {
          parser.saveOtherInfo(
              '${myMap['user']['first_name']} ${myMap['user']['last_name']}',
              myMap['user']['cover'].toString(),
              myMap['individual']['background'].toString(),
              double.parse(myMap['individual']['rating'].toString()),
              myMap['individual']['total_rating'].toString());
        } else {
          parser.saveOtherInfo(
              myMap['salon']['name'].toString(),
              myMap['salon']['cover'].toString(),
              'NA',
              double.parse(myMap['salon']['rating'].toString()),
              myMap['salon']['total_rating'].toString());
        }
        var updateParam = {
          "id": myMap['user']['id'].toString(),
          'fcm_token': parser.getFcmToken(),
        };
        await parser.updateProfile(updateParam, myMap['token']);
        onNavigate();
      } else {
        showToast('Access denied'.tr);
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['error'] != '') {
        showToast(myMap['error'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onNavigate() {
    Get.delete<TabsController>(force: true);
    Get.delete<AppointmentController>(force: true);
    Get.delete<HistoryController>(force: true);
    Get.delete<AnalyticsController>(force: true);
    Get.delete<CalendarsController>(force: true);
    Get.delete<ProfileController>(force: true);
    Get.offNamed(AppRouter.getTabRoute());
  }
}
