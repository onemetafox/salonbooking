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
import 'package:salon_user/app/backend/models/stripe_model.dart';
import 'package:salon_user/app/backend/parse/stripe_pay_product_parse.dart';
import 'package:salon_user/app/controller/add_card_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/product_payment_controller.dart';
import 'package:salon_user/app/controller/tabs_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';

class StripePayProductController extends GetxController implements GetxService {
  final StripePayProductParse parser;
  bool apiCalled = false;
  bool cardsListCalled = false;
  List<StripeCardsModel> _cards = <StripeCardsModel>[];
  List<StripeCardsModel> get cards => _cards;
  String stripeKey = '';
  String selectedCard = '';

  double grandTotal = 0.0;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencyCode = '';
  StripePayProductController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    grandTotal = Get.arguments[0];
    currencyCode = Get.arguments[1];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getProfile();
  }

  Future<void> getProfile() async {
    Response response = await parser.getProfile();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null && body != '') {
        stripeKey = body['stripe_key'] ?? '';
        getStringCards();
        update();
      }
    } else {
      cardsListCalled = true;
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> getStringCards() async {
    if (stripeKey != '' && stripeKey.isNotEmpty) {
      Response response = await parser.getStripeCards(stripeKey);
      cardsListCalled = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["success"];
        _cards = [];
        body['data'].forEach((data) {
          StripeCardsModel datas = StripeCardsModel.fromJson(data);
          _cards.add(datas);
        });
      } else {
        cardsListCalled = true;
        ApiChecker.checkApi(response);
        update();
      }
      update();
    } else {
      cardsListCalled = true;
      update();
    }
  }

  void onAddCard() {
    Get.delete<AddCardController>(force: true);
    Get.toNamed(AppRouter.getAddCard());
  }

  void saveCardToPay(String id) {
    selectedCard = id;
    update();
  }

  void createPayment() {
    if (selectedCard != '' && selectedCard.isNotEmpty) {
      Get.generalDialog(
          pageBuilder: (context, __, ___) => AlertDialog(
                title: Text('Are you sure?'.tr),
                content: Text(
                    "Orders once placed cannot be cancelled and are non-refundable"
                        .tr),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.blackColor,
                          fontFamily: 'medium'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      makePayment();
                    },
                    child: Text(
                      'Yes, Place Order'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.appColor, fontFamily: 'bold'),
                    ),
                  )
                ],
              ));
    } else {
      showToast('Please select card'.tr);
    }
  }

  Future<void> makePayment() async {
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
    var param = {
      'amount': grandTotal.toInt() * 100,
      'currency': currencyCode,
      'customer': stripeKey,
      'card': selectedCard
    };
    Response response = await parser.checkout(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic successResponse = myMap["success"];
      createOrder(successResponse);
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> createOrder(dynamic paymentInfo) async {
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
      "grand_total": grandTotal,
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
      "pay_key": jsonEncode(paymentInfo),
      "status": 0,
      "payStatus": 1,
    };
    var response = await parser.createAppoinment(param);
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
}
