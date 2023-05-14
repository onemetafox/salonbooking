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
import 'package:jiffy/jiffy.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/wallet_model.dart';
import 'package:salon_user/app/backend/parse/wallet_parse.dart';
import 'package:salon_user/app/util/constant.dart';

class WalletController extends GetxController implements GetxService {
  final WalletParser parser;
  bool apiCalled = false;

  List<WalletModel> _walletList = <WalletModel>[];
  List<WalletModel> get walletList => _walletList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  double amount = 0.0;
  WalletController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getWallet();
  }

  Future<void> getWallet() async {
    Response response = await parser.getWallet();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var transactions = myMap['transactions'];
      dynamic user = myMap['data'];
      amount = double.tryParse(user['balance'].toString()) ?? 0.0;
      _walletList = [];
      transactions.forEach((element) {
        WalletModel ele = WalletModel.fromJson(element);
        ele.createdAt = Jiffy(ele.createdAt).format('yMMMMd');
        _walletList.add(ele);
        debugPrint(walletList.length.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
