/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/add_card_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCardController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Add New Card'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          color: ThemeProvider.greyColor.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: value.emailAddress,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email Address'.tr),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          color: ThemeProvider.greyColor.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: value.cardName,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Card Holder Name'.tr),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          color: ThemeProvider.greyColor.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: value.cardNumber,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CreditCardNumberInputFormatter()],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Card Number'.tr),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          color: ThemeProvider.greyColor.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: value.cvcNumber,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CreditCardCvcInputFormatter()],
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'CVV'.tr),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                          color: ThemeProvider.greyColor.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: value.expireNumber,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CreditCardExpirationDateFormatter()],
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'MM/YY'.tr),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        value.submitData();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeProvider.whiteColor,
                        backgroundColor: ThemeProvider.appColor,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'ADD CARD'.tr,
                        style: const TextStyle(
                          color: ThemeProvider.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: ,
        // ),
      );
    });
  }
}
