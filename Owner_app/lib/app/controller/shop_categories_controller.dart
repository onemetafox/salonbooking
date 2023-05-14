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
import 'package:ultimate_salon_owner_flutter/app/backend/models/products_categories_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/shop_categories_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/create_products_controller.dart';

class ShopCategoriesController extends GetxController implements GetxService {
  final ShopCategoriesParser parser;

  String title = 'Products Categories'.tr;

  List<ProductsCategoriesModel> _productsList = <ProductsCategoriesModel>[];
  List<ProductsCategoriesModel> get productList => _productsList;

  String selectedProducts = '';
  String selectedProductsName = '';

  bool apiCalled = false;

  ShopCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectedProducts = Get.arguments[0].toString();
    getAllProductsCate();
  }

  Future<void> getAllProductsCate() async {
    var response = await parser.getAllProductsCate();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _productsList = [];
      body.forEach((data) {
        ProductsCategoriesModel product =
            ProductsCategoriesModel.fromJson(data);
        _productsList.add(product);
      });
      debugPrint(productList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveProductsCate(String id) {
    selectedProducts = id;
    var name =
        _productsList.firstWhere((element) => element.id.toString() == id).name;
    selectedProductsName = name as String;
    debugPrint(selectedProducts = id);
    update();
  }

  void saveAndClose() {
    debugPrint(selectedProducts.toString());
    debugPrint(selectedProductsName.toString());
    Get.find<CreateProductsController>()
        .onSaveproductCate(selectedProducts, selectedProductsName);
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
