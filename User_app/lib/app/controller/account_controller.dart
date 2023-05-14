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
import 'package:salon_user/app/backend/parse/account_parse.dart';
import 'package:salon_user/app/controller/address_controller.dart';
import 'package:salon_user/app/controller/app_pages_controller.dart';
import 'package:salon_user/app/controller/edit_profile_controller.dart';
import 'package:salon_user/app/controller/login_controller.dart';
import 'package:salon_user/app/controller/product_order_controller.dart';
import 'package:salon_user/app/controller/refer_and_earn_controller.dart';
import 'package:salon_user/app/controller/reset_password_controller.dart';
import 'package:salon_user/app/controller/wallet_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';

class AccountController extends GetxController implements GetxService {
  final AccountParser parser;

  String cover = '';
  String firstName = '';
  String lastName = '';
  String email = '';

  AccountController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    changeInfo();
  }

  void changeInfo() {
    firstName = parser.getFirstName();
    lastName = parser.getLastName();
    email = parser.getEmail();
    cover = parser.getCover();
    debugPrint('Update');
    update();
  }

  Future<void> logout() async {
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
    Response response = await parser.logout();
    Get.back();
    if (response.statusCode == 200) {
      // Navigator.of(context).pop(true);
      parser.clearAccount();
      // Get.find<OrderController>().getOrder();
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void cleanData() {
    parser.clearAccount();
  }

  void onProductOrder() {
    Get.delete<ProductOrderController>(force: true);
    Get.toNamed(AppRouter.getProductOrder());
  }

  void onAddress() {
    Get.delete<AddressController>(force: true);
    Get.toNamed(AppRouter.getAddressRoutes());
  }

  void onWallet() {
    Get.delete<WalletController>(force: true);
    Get.toNamed(AppRouter.getWalletRoutes());
  }

  void onReferAndEarn() {
    Get.delete<ReferAndEarnController>(force: true);
    Get.toNamed(AppRouter.getReferAndEarnRoutes());
  }

  void onChangePassword() {
    Get.delete<ResetPasswordController>(force: true);
    Get.toNamed(AppRouter.getResetPasswordRoute());
  }

  void onLanguages() {
    Get.toNamed(AppRouter.getLanguagesRoutes());
  }

  void onAccountChat() {
    Get.toNamed(AppRouter.getAccountChatRoutes());
  }

  void onContactUs() {
    Get.toNamed(AppRouter.getContactUsRoutes());
  }

  void onAppPages(String name, String id) {
    debugPrint('$name = $id');
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPagesRoutes(),
        arguments: [name, id], preventDuplicates: false);
  }

  void onLogin() {
    Get.delete<LoginController>(force: true);
    Get.toNamed(AppRouter.getLoginRoute());
  }

  void onEdit() {
    Get.delete<EditProfileController>(force: true);
    Get.toNamed(AppRouter.getEditProfileRoutes());
  }
}
