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
import 'package:salon_user/app/controller/wallet_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Wallet'.tr,
              style: ThemeProvider.titleStyle,
            ),
            bottom: value.apiCalled == true
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Container(
                      width: double.infinity,
                      color: ThemeProvider.whiteColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: value.currencySide == 'left'
                                ? Text(
                                    '${value.currencySymbol}${value.amount}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'bold',
                                        color: ThemeProvider.appColor),
                                  )
                                : Text(
                                    '${value.amount}${value.currencySymbol}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'bold',
                                        color: ThemeProvider.appColor),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'All Transactions'.tr,
                              style: const TextStyle(
                                  fontFamily: 'regular',
                                  fontSize: 14,
                                  color: ThemeProvider.appColor),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: ThemeProvider.appColor))),
                          )
                        ],
                      ),
                    ))
                : null,
          ),
          body: value.apiCalled == false
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      value.walletList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.walletList[index].type
                                      .toString()
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontFamily: 'bold', fontSize: 12),
                                ),
                                Text(
                                  value.walletList[index].uuid.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontFamily: 'regular', fontSize: 10),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                value.currencySide == 'left'
                                    ? Text(
                                        '${value.currencySymbol}${value.walletList[index].amount}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'bold',
                                        ),
                                      )
                                    : Text(
                                        '${value.walletList[index].amount}${value.currencySymbol}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'bold',
                                        ),
                                      ),
                                Text(
                                  value.walletList[index].createdAt.toString(),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      fontFamily: 'regular', fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
