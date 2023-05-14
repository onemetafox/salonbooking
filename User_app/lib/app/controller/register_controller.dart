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
import 'package:salon_user/app/backend/parse/register_parse.dart';
import 'package:salon_user/app/controller/account_controller.dart';
import 'package:salon_user/app/controller/app_pages_controller.dart';
import 'package:salon_user/app/controller/booking_controller.dart';
import 'package:salon_user/app/controller/categories_controller.dart';
import 'package:salon_user/app/controller/firebase_controller.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/near_controller.dart';
import 'package:salon_user/app/controller/tabs_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:salon_user/app/env.dart';

class RegisterController extends GetxController implements GetxService {
  final RegisterParser parser;

  final firstNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();
  final mobileTextEditor = TextEditingController();
  final emailTextEditor = TextEditingController();
  final passwordTextEditor = TextEditingController();
  final referralCodeTextEditor = TextEditingController();

  String countryCode = '+91';

  int verificationMethod = AppConstants.defaultVerificationForSignup;
  String smsName = AppConstants.defaultSMSGateway;
  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  int smsId = 1;
  String otpCode = '';
  RegisterController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    smsName = parser.getSMSName();
    verificationMethod = parser.getVerificationMethod();
    debugPrint('smsname$smsName');
    debugPrint('verification method$verificationMethod');
  }

  Future<void> onRegister() async {
    if (firstNameTextEditor.text == '' ||
        firstNameTextEditor.text.isEmpty ||
        lastNameTextEditor.text == '' ||
        lastNameTextEditor.text.isEmpty ||
        mobileTextEditor.text == '' ||
        mobileTextEditor.text.isEmpty ||
        emailTextEditor.text == '' ||
        emailTextEditor.text.isEmpty ||
        passwordTextEditor.text == '' ||
        passwordTextEditor.text.isEmpty) {
      showToast('All fields are requires'.tr);
      return;
    }
    if (!GetUtils.isEmail(emailTextEditor.text)) {
      showToast('Email is not valid'.tr);
      return;
    }
    if (verificationMethod == 0) {
      debugPrint('email verification'.tr);
      var param = {
        'email': emailTextEditor.text,
        'subject': 'Verification'.tr,
        'header_text': 'Use this code for verification'.tr,
        'thank_you_text': "Don't share this otp to anybody else".tr,
        'mediaURL': '${Environments.apiBaseURL}storage/images/',
        'country_code': countryCode,
        'mobile': mobileTextEditor.text
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
      Response response = await parser.sendVerificationMail(param);
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != '' && myMap['data'] == true) {
          smsId = myMap['otp_id'];
          FocusManager.instance.primaryFocus?.unfocus();
          openOTPModal(emailTextEditor.text);
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
      } else if (response.statusCode == 500) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['success'] == false) {
          showToast(myMap['message']);
        } else {
          showToast('Something went wrong'.tr);
        }
        update();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
    } else {
      debugPrint('phone verification'.tr);
      if (smsName == '2') {
        var param = {
          'email': emailTextEditor.text,
          'country_code': countryCode,
          'mobile': mobileTextEditor.text
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
        Response response = await parser.verifyMobileForeFirebase(param);
        Get.back();
        if (response.statusCode == 200) {
          Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
          if (myMap['data'] != '' && myMap['data'] == true) {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.delete<FirebaseController>(force: true);
            Get.toNamed(AppRouter.getFirebaseAuthRoutes(),
                arguments: [countryCode, mobileTextEditor.text, 'register']);
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
        } else if (response.statusCode == 500) {
          Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
          if (myMap['success'] == false) {
            showToast(myMap['message']);
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
        var param = {
          'country_code': countryCode,
          'mobile': mobileTextEditor.text,
          'email': emailTextEditor.text
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
        Response response = await parser.sendRegisterOTP(param);
        Get.back();
        if (response.statusCode == 200) {
          Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
          if (myMap['data'] != '' && myMap['data'] == true) {
            smsId = myMap['otp_id'];
            FocusManager.instance.primaryFocus?.unfocus();
            openOTPModal(
                countryCode.toString() + mobileTextEditor.text.toString());
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
  }

  void openOTPModal(String text) {
    var context = Get.context as BuildContext;
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
      barrierDismissible: false,
    );
    var param = {'id': smsId, 'otp': otpCode};
    Response response = await parser.verifyOTP(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != '' && myMap['success'] == true) {
        Navigator.of(context).pop(true);
        createAccount();
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

  Future<void> createAccount() async {
    var body = {
      "email": emailTextEditor.text,
      "password": passwordTextEditor.text,
      "first_name": firstNameTextEditor.text,
      "last_name": lastNameTextEditor.text,
      "mobile": mobileTextEditor.text,
      "country_code": countryCode,
      "referal": referralCodeTextEditor.text,
      'fcm_token': parser.getFcmToken(),
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
        barrierDismissible: false);
    var response = await parser.onRegister(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap['user']['id'].toString());
      parser.saveToken(myMap['token']);
      parser.saveInfo(
        myMap['user']['id'].toString(),
        myMap['user']['first_name'].toString(),
        myMap['user']['last_name'].toString(),
        myMap['user']['cover'].toString(),
        myMap['user']['email'].toString(),
        myMap['user']['mobile'].toString(),
      );
      if (referralCodeTextEditor.text.isNotEmpty &&
          referralCodeTextEditor.text != '') {
        getRewards(myMap['user']['id'].toString());
      } else {
        Get.delete<TabsController>(force: true);
        Get.delete<HomeController>(force: true);
        Get.delete<NearController>(force: true);
        Get.delete<CategoriesController>(force: true);
        Get.delete<BookingController>(force: true);
        Get.delete<AccountController>(force: true);
        Get.offNamed(AppRouter.getTabsBarRoute());
      }
    } else if (response.statusCode == 401) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['message'] != '') {
        showToast(myMap['message'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['message'] != '') {
        showToast(myMap['message'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void updateCountryCode(String code) {
    countryCode = code;
    update();
  }

  void onAppPages(String name, String id) {
    debugPrint('$name = $id');
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPagesRoutes(),
        arguments: [name, id], preventDuplicates: false);
  }

  Future<void> getRewards(String id) async {
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
                "Getting Rewards".tr,
                style: const TextStyle(fontFamily: 'bold'),
              )),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
    var body = {"id": id, "code": referralCodeTextEditor.text};
    var response = await parser.saveReferral(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap['data'].toString());
      String modalText = '';
      if (myMap['data'] != null &&
          myMap['data']['who_received'] != null &&
          myMap['data']['who_received'] == 1) {
        modalText =
            '${'Congratulations your friend have received the'.tr}$currencySide${myMap['data']['amount']} on wallet';
      } else if (myMap['data'] != null &&
          myMap['data']['who_received'] != null &&
          myMap['data']['who_received'] == 2) {
        modalText =
            '${'Congratulations you have received the '.tr}$currencySide${myMap['data']['amount']} on wallet';
      } else if (myMap['data'] != null &&
          myMap['data']['who_received'] != null &&
          myMap['data']['who_received'] == 3) {
        modalText =
            '${'Congratulations you & your friend have received the '.tr}$currencySide${myMap['data']['amount']} on wallet';
        showRedeemModal(modalText);
      } else {
        Get.delete<TabsController>(force: true);
        Get.delete<HomeController>(force: true);
        Get.delete<NearController>(force: true);
        Get.delete<CategoriesController>(force: true);
        Get.delete<BookingController>(force: true);
        Get.delete<AccountController>(force: true);
        Get.offNamed(AppRouter.getTabsBarRoute());
      }
      debugPrint(modalText);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void showRedeemModal(String msg) {
    var context = Get.context as BuildContext;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/redeem.png',
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Congratulation'.tr,
                  style: const TextStyle(fontSize: 16, fontFamily: 'semi-bold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Get.delete<TabsController>(force: true);
                          Get.delete<HomeController>(force: true);
                          Get.delete<NearController>(force: true);
                          Get.delete<CategoriesController>(force: true);
                          Get.delete<BookingController>(force: true);
                          Get.delete<AccountController>(force: true);
                          Get.offNamed(AppRouter.getTabsBarRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          minimumSize: const Size.fromHeight(35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Close'.tr,
                          style: const TextStyle(
                            color: ThemeProvider.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Get.delete<TabsController>(force: true);
                          Get.delete<HomeController>(force: true);
                          Get.delete<NearController>(force: true);
                          Get.delete<CategoriesController>(force: true);
                          Get.delete<BookingController>(force: true);
                          Get.delete<AccountController>(force: true);
                          Get.offNamed(AppRouter.getTabsBarRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          minimumSize: const Size.fromHeight(35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Ok'.tr,
                          style: const TextStyle(
                            color: ThemeProvider.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
