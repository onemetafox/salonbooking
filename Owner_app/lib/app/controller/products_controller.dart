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
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/products_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/products_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/create_products_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class ProductsController extends GetxController implements GetxService {
  final ProductsParser parser;

  bool apiCalled = false;

  List<ProductsModel> _productsInfo = <ProductsModel>[];
  List<ProductsModel> get productsInfo => _productsInfo;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  ProductsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getProductWFreelancer();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  Future<void> getProductWFreelancer() async {
    var param = {"id": parser.getFreelancerId()};
    apiCalled = true;
    Response response = await parser.getProductWFreelancer(param);
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var product = myMap['data'];
      debugPrint(response.bodyString);
      _productsInfo = [];
      product.forEach((data) {
        ProductsModel datas = ProductsModel.fromJson(data);
        _productsInfo.add(datas);
      });
      debugPrint(productsInfo.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> destroyProduct(int id) async {
    var param = {"id": id};
    var response = await parser.destroyProduct(param);
    if (response.statusCode == 200) {
      getProductWFreelancer();
      showToast('item remove successfully');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateStatus(int id, int status) async {
    var body = {"status": status == 1 ? 0 : 1, "id": id};
    var response = await parser.onUpdateProducts(body);
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Updated');
      getProductWFreelancer();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onCreateProducts() {
    Get.delete<CreateProductsController>(force: true);
    Get.toNamed(AppRouter.getCreateProductsRoute(), arguments: ['create']);
  }

  void onUpdateProducts(int id) {
    Get.delete<CreateProductsController>(force: true);
    Get.toNamed(AppRouter.getCreateProductsRoute(), arguments: ['update', id]);
  }
}
