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
import 'package:salon_user/app/backend/models/product_salon_model.dart';
import 'package:salon_user/app/backend/parse/product_order_parse.dart';
import 'package:salon_user/app/controller/product_order_detail_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';

class ProductOrderController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final ProductOrderParser parser;

  late TabController tabController;

  List<ProductSalonModel> _productSalonList = <ProductSalonModel>[];
  List<ProductSalonModel> get productSalonList => _productSalonList;

  List<ProductSalonModel> _productSalonListOld = <ProductSalonModel>[];
  List<ProductSalonModel> get productSalonListOld => _productSalonListOld;

  bool apiCalled = false;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<String> statusName = [
    'Created',
    'Accepted',
    'Rejected',
    'Ongoing',
    'Completed',
    'Cancelled',
    'Refunded',
    'Delayed',
    'Panding Payment',
  ];
  ProductOrderController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    tabController = TabController(length: 2, vsync: this);
    getProductById();
  }

  Future<void> getProductById() async {
    Response response = await parser.getProductById();

    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _productSalonList = [];
      _productSalonListOld = [];
      body.forEach((data) {
        ProductSalonModel productSalon = ProductSalonModel.fromJson(data);
        if (productSalon.status == 0) {
          _productSalonList.add(productSalon);
        } else {
          _productSalonListOld.add(productSalon);
        }
      });
      debugPrint(jsonEncode(productSalonList));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onProductDetail(int id) {
    Get.delete<ProductOrderDetailController>(force: true);
    Get.toNamed(AppRouter.getProductOrderDetail(), arguments: [id]);
  }
}
