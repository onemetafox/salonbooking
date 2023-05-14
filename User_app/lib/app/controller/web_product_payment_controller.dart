/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/parse/web_product_payment_parse.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/product_payment_controller.dart';
import 'package:salon_user/app/controller/tabs_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';

class WebProductPaymentController extends GetxController
    implements GetxService {
  final WebProductPaymentParse parser;
  String payMethod = '';
  String paymentURL = '';
  String apiURL = '';
  WebProductPaymentController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    apiURL = parser.apiService.appBaseUrl;
    payMethod = Get.arguments[0];
    if (payMethod != 'instamojo') {
      paymentURL = apiURL + Get.arguments[1];
    } else {
      paymentURL = Get.arguments[1];
    }
    update();
  }

  Future<void> createOrder(String orderId) async {
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
      "uid": parser.getUID(),
      "freelancer_id":
          Get.find<ProductPaymentController>().ownerType == 'individual'
              ? Get.find<ProductCartController>().savedInCart[0].freelacerId
              : 0,
      "salon_id": Get.find<ProductPaymentController>().ownerType == 'salon'
          ? Get.find<ProductCartController>().savedInCart[0].freelacerId
          : 0,
      "date_time": Jiffy().format('yyyy-MM-dd'),
      "paid_method": Get.find<ProductPaymentController>().paymentId,
      "order_to": "home",
      "orders": jsonEncode(Get.find<ProductCartController>().savedInCart),
      "notes": Get.find<ProductPaymentController>().notesEditor.text.isNotEmpty
          ? Get.find<ProductPaymentController>().notesEditor.text
          : 'NA',
      "address": jsonEncode(Get.find<ProductPaymentController>().addressInfo),
      "total": Get.find<ProductCartController>().totalPrice,
      "tax": Get.find<ProductCartController>().orderTax,
      "grand_total": Get.find<ProductCartController>().grandTotal,
      "discount": Get.find<ProductPaymentController>().discount,
      "driver_id": 0,
      "delivery_charge": Get.find<ProductPaymentController>().deliveryPrice,
      'wallet_used':
          Get.find<ProductPaymentController>().isWalletChecked == true &&
                  Get.find<ProductPaymentController>().walletDiscount > 0
              ? 1
              : 0,
      'wallet_price':
          Get.find<ProductPaymentController>().isWalletChecked == true &&
                  Get.find<ProductPaymentController>().walletDiscount > 0
              ? Get.find<ProductPaymentController>().walletDiscount
              : 0,
      "coupon_id":
          Get.find<ProductPaymentController>().selectedCoupon.code != null
              ? Get.find<ProductPaymentController>().selectedCoupon.id
              : 0,
      "coupon_code":
          Get.find<ProductPaymentController>().selectedCoupon.code != null
              ? jsonEncode(Get.find<ProductPaymentController>().selectedCoupon)
              : 'NA',
      "extra": 'NA',
      "pay_key": orderId,
      "status": 0,
      "payStatus": 1,
    };
    var response = await parser.createAppoinments(param);
    Get.back();

    if (response.statusCode == 200) {
      Get.defaultDialog(
        title: '',
        contentPadding: const EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/sure.gif',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Thank You!'.tr,
                style: const TextStyle(fontFamily: 'bold', fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'For Your Appoinment'.tr,
                style: const TextStyle(fontFamily: 'semi-bold', fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                    .tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  backOrders();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ThemeProvider.whiteColor,
                  backgroundColor: ThemeProvider.appColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'TRACK MY APPOINTMENT'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  backHome();
                },
                child: Text(
                  'BACK TO HOME'.tr,
                  style: const TextStyle(color: ThemeProvider.appColor),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void backHome() {
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(0);
    Get.offAllNamed(AppRouter.getTabsBarRoute());
  }

  void backOrders() {
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(4);
    Get.offAllNamed(AppRouter.getTabsBarRoute());
  }

  Future<void> verifyRazorpayPurchase(String payKey) async {
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
                  "Creating Order".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    Response response = await parser.verifyPurchase(payKey);

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['status'] == 'captured') {
        Get.back();
        createOrder(jsonEncode(body));
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
    update();
  }
}
