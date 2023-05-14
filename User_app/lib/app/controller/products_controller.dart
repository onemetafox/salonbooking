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
import 'package:salon_user/app/backend/models/products_list_model.dart';
import 'package:salon_user/app/backend/parse/products_parse.dart';
import 'package:salon_user/app/controller/cart_controller.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/products_details_controller.dart';
import 'package:salon_user/app/controller/sortby_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/toast.dart';

class ProductsController extends GetxController implements GetxService {
  final ProductsParser parser;

  List<ProductsListModel> _productsList = <ProductsListModel>[];
  List<ProductsListModel> get productsList => _productsList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String selectedCateId = '';
  String selectedSubCateId = '';

  bool apiCalled = false;

  ProductsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectedCateId = Get.arguments[0].toString();
    selectedSubCateId = Get.arguments[1].toString();
    update();
    debugPrint('cate id == $selectedCateId');
    debugPrint('sub cate id == $selectedSubCateId');
    getDataFromCategories();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  Future<void> getDataFromCategories() async {
    var param = {
      "cate_id": selectedCateId,
      "sub_cate_id": selectedSubCateId,
    };
    Response response = await parser.getproductsByIdAndCateId(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _productsList = [];
      body.forEach((data) {
        ProductsListModel products = ProductsListModel.fromJson(data);
        _productsList.add(products);
      });
      checkCartData();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void checkCartData() {
    for (var element in _productsList) {
      debugPrint(element.id.toString());
      debugPrint(Get.find<ProductCartController>()
          .checkProductInCart(element.id as int)
          .toString());
      if (Get.find<ProductCartController>()
              .checkProductInCart(element.id as int) ==
          true) {
        debugPrint('Chhe HOo');
        element.quantity =
            Get.find<ProductCartController>().getQuantity(element.id as int);
        debugPrint(element.quantity.toString());
      } else {
        element.quantity = 0;
      }
    }
    update();
  }

  void addToCart(int index) {
    if (Get.find<ProductCartController>().savedInCart.isEmpty) {
      _productsList[index].quantity = 1;
      Get.find<ProductCartController>().addItem(_productsList[index]);
      checkCartData();
      update();
    } else {
      int freelancerId = Get.find<ProductCartController>()
          .getFreelancerId(_productsList[index]);
      if (freelancerId == _productsList[index].freelacerId) {
        _productsList[index].quantity = 1;
        Get.find<ProductCartController>().addItem(_productsList[index]);
        checkCartData();
        update();
      } else {
        showToast('We have already select product with other freelancer'.tr);
        update();
      }
    }
    Get.find<HomeController>().checkCartData();
  }

  void updateProductQuantity(int index) {
    _productsList[index].quantity = _productsList[index].quantity + 1;
    Get.find<ProductCartController>().addQuantity(_productsList[index]);
    checkCartData();
    Get.find<HomeController>().checkCartData();
    update();
  }

  void updateProductQuantityRemove(int index) {
    if (_productsList[index].quantity == 1) {
      _productsList[index].quantity = 0;
      Get.find<ProductCartController>().removeItem(_productsList[index]);
      // Get.find<TabsController>().updateCartValue();
    } else {
      _productsList[index].quantity = _productsList[index].quantity - 1;
      Get.find<ProductCartController>().addQuantity(_productsList[index]);
    }
    checkCartData();
    Get.find<HomeController>().checkCartData();
    update();
  }

  void onProductsDetails(int id) {
    Get.delete<ProductsDetailsController>(force: true);
    Get.toNamed(AppRouter.getProductsDetailsRoutes(), arguments: [id]);
  }

  void onSortBy() {
    Get.delete<SortByController>(force: true);
    Get.toNamed(AppRouter.getSortByRoutes());
  }

  void onCart() {
    Get.delete<CartController>(force: true);
    Get.toNamed(AppRouter.getCartRoutes());
  }
}
