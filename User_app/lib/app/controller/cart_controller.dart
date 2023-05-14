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
import 'package:salon_user/app/backend/models/products_list_model.dart';
import 'package:salon_user/app/backend/parse/cart_parse.dart';
import 'package:salon_user/app/controller/categories_controller.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/login_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/product_payment_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';

class CartController extends GetxController implements GetxService {
  final CartParser parser;

  List<ProductsListModel> _savedInCart = <ProductsListModel>[];
  List<ProductsListModel> get savedInCart => _savedInCart;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  CartController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    _savedInCart = Get.find<ProductCartController>().savedInCart;
  }

  void deleteProductFromCart(int index) {
    Get.find<ProductCartController>().removeItem(_savedInCart[index]);
    _savedInCart = Get.find<ProductCartController>().savedInCart;
    Get.find<HomeController>().checkCartData();
    checkCartItems();
    update();
  }

  void updateProductQuantity(int index) {
    _savedInCart[index].quantity = _savedInCart[index].quantity + 1;
    Get.find<ProductCartController>().addQuantity(_savedInCart[index]);
    Get.find<HomeController>().checkCartData();
    checkCartItems();
    update();
  }

  void updateProductQuantityRemove(int index) {
    if (_savedInCart[index].quantity == 1) {
      _savedInCart[index].quantity = 0;
      Get.find<ProductCartController>().removeItem(_savedInCart[index]);
    } else {
      _savedInCart[index].quantity = _savedInCart[index].quantity - 1;
      Get.find<ProductCartController>().addQuantity(_savedInCart[index]);
    }
    Get.find<HomeController>().checkCartData();
    checkCartItems();
    update();
  }

  void checkCartItems() {
    if (Get.find<ProductCartController>().savedInCart.isEmpty) {
      Get.find<CategoriesController>().updateScreen();
      var context = Get.context as BuildContext;
      Navigator.of(context).pop(true);
    }
  }

  void onCheckout() {
    if (parser.isLogin() == true) {
      Get.delete<ProductPaymentController>(force: true);
      Get.toNamed(AppRouter.getProductPayment());
    } else {
      Get.delete<LoginController>(force: true);
      Get.toNamed(AppRouter.getLoginRoute());
    }
  }

  double getFinalTotal(int index) {
    return savedInCart[index].discount! > 0
        ? savedInCart[index].sellPrice! * savedInCart[index].quantity
        : savedInCart[index].originalPrice! * savedInCart[index].quantity;
  }
}
