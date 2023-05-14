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
import 'package:salon_user/app/controller/coupon_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              'Select Coupon'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: List.generate(
                          value.couponList.length,
                          (index) => Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ThemeProvider.whiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: ThemeProvider.greyColor,
                                      blurRadius: 5.0,
                                      offset: Offset(0.7, 2.0),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    value.saveCoupon(
                                        value.couponList[index].id as int);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Use coupon code '.tr +
                                                    value.couponList[index].name
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                  value.couponList[index]
                                                          .shortDescriptions
                                                          .toString() +
                                                      ' - Valid until '.tr +
                                                      value.couponList[index]
                                                          .expire
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),
                                        value.selectedCouponCode ==
                                                value.couponList[index].id
                                                    .toString()
                                            ? const Icon(
                                                Icons.check_circle_outline)
                                            : const Icon(Icons.circle_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
          bottomNavigationBar: InkWell(
            onTap: () {
              value.onSaveCoupon();
            },
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13.0),
              decoration: const BoxDecoration(
                color: ThemeProvider.greenColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save'.tr,
                    style: const TextStyle(
                        color: ThemeProvider.whiteColor, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
