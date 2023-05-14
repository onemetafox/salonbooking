/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/coupons_model.dart';
import 'package:salon_user/app/backend/parse/coupon_parse.dart';
import 'package:salon_user/app/controller/individual_payment_controller.dart';
import 'package:salon_user/app/controller/payment_controller.dart';
import 'package:salon_user/app/controller/product_payment_controller.dart';

class CouponController extends GetxController implements GetxService {
  final CouponParser parser;

  String selectedCouponCode = '';
  bool apiCalled = false;
  String action = 'service';

  List<CouponsModel> _couponList = <CouponsModel>[];
  List<CouponsModel> get couponList => _couponList;
  CouponController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] == 'product') {
      action = 'product';
    } else if (Get.arguments[0] == 'individual-service') {
      action = 'individual-service';
    } else {
      action = 'service';
    }
    getCoupons();
  }

  Future<void> getCoupons() async {
    Response response = await parser.getCouponCodes();
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _couponList = [];
      body.forEach((element) {
        CouponsModel data = CouponsModel.fromJson(element);
        _couponList.add(data);
      });
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveCoupon(int id) {
    selectedCouponCode = id.toString();
    update();
  }

  void onSaveCoupon() {
    if (action == 'service') {
      if (selectedCouponCode != '') {
        var savedCoupon = _couponList.firstWhere(
            (element) => element.id.toString() == selectedCouponCode);
        Get.find<PaymentController>().onSaveCoupon(savedCoupon);
      }
      onBack();
    } else if (action == 'product') {
      if (selectedCouponCode != '') {
        var savedCoupon = _couponList.firstWhere(
            (element) => element.id.toString() == selectedCouponCode);
        Get.find<ProductPaymentController>().onSaveCoupon(savedCoupon);
      }
      onProductBack();
    } else {
      if (selectedCouponCode != '') {
        var savedCoupon = _couponList.firstWhere(
            (element) => element.id.toString() == selectedCouponCode);
        Get.find<IndividualPaymentController>().onSaveCoupon(savedCoupon);
      }
      onIndividualBack();
    }
  }

  void onIndividualBack() {
    Get.find<IndividualPaymentController>().update();
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onBack() {
    Get.find<PaymentController>().update();
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onProductBack() {
    Get.find<ProductPaymentController>().update();
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
