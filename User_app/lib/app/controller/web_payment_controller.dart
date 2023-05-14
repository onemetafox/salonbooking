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
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/parse/web_payment_parse.dart';
import 'package:salon_user/app/controller/individual_payment_controller.dart';
import 'package:salon_user/app/controller/individual_slot_controller.dart';
import 'package:salon_user/app/controller/payment_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/controller/slot_controller.dart';
import 'package:salon_user/app/controller/tabs_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';

class WebPaymentController extends GetxController implements GetxService {
  final WebPaymentParse parser;
  String payMethod = '';
  String paymentURL = '';
  String apiURL = '';
  String orderFrom = '';
  WebPaymentController({required this.parser});

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
    orderFrom = Get.arguments[2];
    update();
  }

  void createOrderRequest(String orderId) {
    if (orderFrom == 'salon') {
      createOrderSalon(orderId);
    } else {
      createOrderInvidual(orderId);
    }
  }

  Future<void> createOrderInvidual(String orderId) async {
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
      "freelancer_id": Get.find<ServiceCartController>().salonId,
      "salon_id": 0,
      "specialist_id": 0,
      "appointments_to": 1,
      "address":
          jsonEncode(Get.find<IndividualPaymentController>().addressInfo),
      "items": jsonEncode(Get.find<ServiceCartController>().savedInCart),
      "coupon_id":
          Get.find<IndividualPaymentController>().selectedCoupon.code != null
              ? Get.find<IndividualPaymentController>().selectedCoupon.id
              : 0,
      "coupon": Get.find<IndividualPaymentController>().selectedCoupon.code !=
              null
          ? jsonEncode(Get.find<IndividualPaymentController>().selectedCoupon)
          : 'NA',
      "discount": Get.find<IndividualPaymentController>().discount,
      "distance_cost": Get.find<IndividualPaymentController>().deliveryPrice,
      "total": Get.find<ServiceCartController>().totalPrice,
      "serviceTax": Get.find<ServiceCartController>().orderTax,
      "grand_total": Get.find<IndividualPaymentController>().grandTotal,
      "pay_method": Get.find<IndividualPaymentController>().paymentId,
      "paid": orderId,
      "save_date": Get.find<IndividualSlotController>().savedDate,
      "slot": Get.find<IndividualSlotController>().selectedSlotIndex,
      'wallet_used':
          Get.find<IndividualPaymentController>().isWalletChecked == true &&
                  Get.find<IndividualPaymentController>().walletDiscount > 0
              ? 1
              : 0,
      'wallet_price':
          Get.find<IndividualPaymentController>().isWalletChecked == true &&
                  Get.find<IndividualPaymentController>().walletDiscount > 0
              ? Get.find<IndividualPaymentController>().walletDiscount
              : 0,
      "notes":
          Get.find<IndividualPaymentController>().notesEditor.text.isNotEmpty
              ? Get.find<IndividualPaymentController>().notesEditor.text
              : 'NA',
      "status": 0
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

  Future<void> createOrderSalon(String orderId) async {
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
      "freelancer_id": 0,
      "salon_id": Get.find<ServiceCartController>().salonId.toString(),
      "specialist_id": Get.find<SlotController>().selectedSpecialist,
      "appointments_to": Get.find<PaymentController>().appointmentsTo,
      "address": Get.find<PaymentController>().appointmentsTo == 1
          ? jsonEncode(Get.find<PaymentController>().addressInfo)
          : 'NA',
      "items": jsonEncode(Get.find<ServiceCartController>().savedInCart),
      "coupon_id": Get.find<ServiceCartController>().selectedCoupon.code != null
          ? Get.find<ServiceCartController>().selectedCoupon.id
          : 0,
      "coupon": Get.find<ServiceCartController>().selectedCoupon.code != null
          ? jsonEncode(Get.find<ServiceCartController>().selectedCoupon)
          : 'NA',
      "discount": Get.find<PaymentController>().discount,
      "distance_cost": Get.find<PaymentController>().deliveryPrice,
      "total": Get.find<ServiceCartController>().totalPrice,
      "serviceTax": Get.find<ServiceCartController>().orderTax,
      "grand_total": Get.find<ServiceCartController>().grandTotal,
      "pay_method": Get.find<PaymentController>().paymentId,
      "paid": orderId,
      "save_date": Get.find<SlotController>().savedDate,
      "slot": Get.find<SlotController>().selectedSlotIndex,
      'wallet_used': Get.find<PaymentController>().isWalletChecked == true &&
              Get.find<PaymentController>().walletDiscount > 0
          ? 1
          : 0,
      'wallet_price': Get.find<PaymentController>().isWalletChecked == true &&
              Get.find<PaymentController>().walletDiscount > 0
          ? Get.find<PaymentController>().walletDiscount
          : 0,
      "notes": Get.find<PaymentController>().notesEditor.text.isNotEmpty
          ? Get.find<PaymentController>().notesEditor.text
          : 'NA',
      "status": 0
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
    Get.find<ServiceCartController>().clearCart();
    Get.find<TabsController>().updateTabId(0);
    Get.offAllNamed(AppRouter.getTabsBarRoute());
  }

  void backOrders() {
    Get.find<ServiceCartController>().clearCart();
    Get.find<TabsController>().updateTabId(3);
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
        createOrderRequest(jsonEncode(body));
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
    update();
  }
}
