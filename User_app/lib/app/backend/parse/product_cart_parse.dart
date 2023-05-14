/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:salon_user/app/backend/api/api.dart';
import 'package:salon_user/app/backend/models/products_list_model.dart';
import 'package:salon_user/app/helper/shared_pref.dart';
import 'package:salon_user/app/util/constant.dart';

class ProductCartParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProductCartParser(
      {required this.apiService, required this.sharedPreferencesManager});

  void saveProduct(List<ProductsListModel> product) {
    List<String> carts = [];
    for (var cartModel in product) {
      carts.add(jsonEncode(cartModel));
    }
    debugPrint('saved product cart $carts');
    sharedPreferencesManager.putStringList('savedProducts', carts);
  }

  int getShippingMethod() {
    return sharedPreferencesManager.getInt('shipping') ??
        AppConstants.defaultShippingMethod;
  }

  List<ProductsListModel> getProduct() {
    List<String>? carts = [];
    if (sharedPreferencesManager.isKeyExists('savedProducts') ?? false) {
      carts = sharedPreferencesManager.getStringList('savedProducts');
    }
    List<ProductsListModel> cartList = <ProductsListModel>[];
    carts?.forEach((element) {
      var data = jsonDecode(element);
      cartList.add(ProductsListModel.fromJson(data));
    });
    return cartList;
  }

  double getAllowedDeliveryRadius() {
    return sharedPreferencesManager.getDouble('allowDistance') ??
        AppConstants.defaultDeliverRadius;
  }

  bool isLoggedIn() {
    return sharedPreferencesManager.getString('uid') != null &&
            sharedPreferencesManager.getString('uid') != ''
        ? true
        : false;
  }

  double shippingPrice() {
    return sharedPreferencesManager.getDouble('shippingPrice') ?? 0.0;
  }

  double freeOrderPrice() {
    return sharedPreferencesManager.getDouble('free') ?? 0.0;
  }

  double taxOrderPrice() {
    return sharedPreferencesManager.getDouble('tax') ?? 0.0;
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  String getPhone() {
    return sharedPreferencesManager.getString('phone') ?? '';
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }

  String getFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getAppLogo() {
    return sharedPreferencesManager.getString('appLogo') ?? '';
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }
}
