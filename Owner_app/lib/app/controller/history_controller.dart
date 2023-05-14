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
import 'package:ultimate_salon_owner_flutter/app/backend/models/products_order_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/history_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/product_order_details_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';

class HistoryController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final HistoryParser parser;

  late TabController tabController;

  List<ProductSalonModel> _productSalonList = <ProductSalonModel>[];
  List<ProductSalonModel> get productSalonList => _productSalonList;

  List<ProductSalonModel> _productSalonListOld = <ProductSalonModel>[];
  List<ProductSalonModel> get productSalonListOld => _productSalonListOld;

  bool apiCalled = false;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<String> statusName = [
    'Created'.tr,
    'Accepted'.tr,
    'Rejected'.tr,
    'Ongoing'.tr,
    'Completed'.tr,
    'Cancelled'.tr,
    'Refunded'.tr,
    'Delayed'.tr,
    'Panding Payment'.tr,
  ];
  HistoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    tabController = TabController(length: 2, vsync: this);
    getList();
  }

  void getList() {
    if (parser.getType() == 'salon') {
      getSalonList();
    } else {
      getIndividualOrdersList();
    }
  }

  Future<void> getIndividualOrdersList() async {
    Response response = await parser.getIndividualOrdersList();

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
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getSalonList() async {
    Response response = await parser.getSalonList();

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
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onProductDetail(int id) {
    Get.delete<ProductOrderDetailsController>(force: true);
    Get.toNamed(AppRouter.getProductOrderDetailsRoutes(), arguments: [id]);
  }
}
