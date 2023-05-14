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
import 'package:salon_user/app/controller/stripe_pay_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class StripePay extends StatefulWidget {
  const StripePay({Key? key}) : super(key: key);

  @override
  State<StripePay> createState() => _StripePayState();
}

class _StripePayState extends State<StripePay> {
  Color getColor(Set<MaterialState> states) {
    return ThemeProvider.appColor;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StripePayController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Pay With Stripe'.tr,
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
                    InkWell(
                      onTap: () {
                        value.onAddCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Add New Card'.tr),
                        ],
                      ),
                    ),
                    value.cardsListCalled == false
                        ? Column(
                            children: [
                              SizedBox(
                                height: 400, // fixed height
                                child: SkeletonListView(),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 30,
                    ),
                    for (var item in value.cards)
                      ListTile(
                        textColor: ThemeProvider.blackColor,
                        iconColor: ThemeProvider.blackColor,
                        title: Text(
                          'XXXX XXXX XXXX ${item.last4.toString().toUpperCase()}',
                          style: const TextStyle(
                              color: ThemeProvider.blackColor, fontSize: 14),
                        ),
                        subtitle: Text(
                          '${'Expiry '.tr}${item.expMonth} / ${item.expYear}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        trailing: Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: item.id.toString(),
                            groupValue: value.selectedCard,
                            onChanged: (e) {
                              value.saveCardToPay(e.toString());
                            }),
                        // trailing: ,
                      ),
                  ],
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              value.createPayment();
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
              'Payment'.tr,
              style: const TextStyle(
                color: ThemeProvider.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    });
  }
}
