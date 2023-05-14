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
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/top_products_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class TopProductScreen extends StatefulWidget {
  const TopProductScreen({Key? key}) : super(key: key);

  @override
  State<TopProductScreen> createState() => _TopProductScreenState();
}

class _TopProductScreenState extends State<TopProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopProductsControllrer>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Top Products'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        bottomNavigationBar: Get.find<ProductCartController>()
                .savedInCart
                .isNotEmpty
            ? SizedBox(
                height: 50,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          value.onCart();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: ThemeProvider.appColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${'Total'.tr} ${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${Get.find<ProductCartController>().totalPrice}',
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor),
                              ),
                              Text(
                                'Payments'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        body: value.apiCalled == false
            ? SkeletonListView()
            : GridView.count(
                primary: false,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                childAspectRatio: 60 / 100,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  value.productsList.length,
                  (i) {
                    return GestureDetector(
                      onTap: () {
                        value.onProduct(
                          value.productsList[i].id as int,
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ThemeProvider.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    ThemeProvider.blackColor.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.productsList[i].cover.toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/notfound.png',
                                          width: double.infinity,
                                          height: 120,
                                          fit: BoxFit.cover);
                                    },
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    value.productsList[i].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontFamily: 'medium',
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          color:
                                              value.productsList[i].rating! >= 1
                                                  ? ThemeProvider.orangeColor
                                                  : ThemeProvider.greyColor,
                                          size: 12),
                                      Icon(Icons.star,
                                          color:
                                              value.productsList[i].rating! >= 2
                                                  ? ThemeProvider.orangeColor
                                                  : ThemeProvider.greyColor,
                                          size: 12),
                                      Icon(Icons.star,
                                          color:
                                              value.productsList[i].rating! >= 3
                                                  ? ThemeProvider.orangeColor
                                                  : ThemeProvider.greyColor,
                                          size: 12),
                                      Icon(Icons.star,
                                          color:
                                              value.productsList[i].rating! >= 4
                                                  ? ThemeProvider.orangeColor
                                                  : ThemeProvider.greyColor,
                                          size: 12),
                                      Icon(Icons.star,
                                          color:
                                              value.productsList[i].rating! >= 5
                                                  ? ThemeProvider.orangeColor
                                                  : ThemeProvider.greyColor,
                                          size: 12),
                                      const SizedBox(width: 6),
                                      Text(
                                        value.productsList[i].totalRating
                                            .toString(),
                                        style: const TextStyle(
                                            color: ThemeProvider.blackColor,
                                            fontFamily: 'medium',
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${value.productsList[i].originalPrice}/hr'
                                            : '${value.productsList[i].originalPrice}${value.currencySymbol}/hr',
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: ThemeProvider.greyColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${value.productsList[i].sellPrice}/hr'
                                            : '${value.productsList[i].sellPrice}${value.currencySymbol}/hr',
                                        style: const TextStyle(
                                            color: ThemeProvider.appColor,
                                            fontFamily: 'bold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  value.productsList[i].quantity == 0
                                      ? SizedBox(
                                          height: 26,
                                          width: 100,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                value.addToCart(i);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ThemeProvider.appColor,
                                                  shadowColor:
                                                      ThemeProvider.blackColor,
                                                  foregroundColor:
                                                      ThemeProvider.whiteColor,
                                                  elevation: 3,
                                                  shape:
                                                      (RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  )),
                                                  padding:
                                                      const EdgeInsets.all(0)),
                                              child: Text(
                                                'ADD'.tr,
                                                style: const TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 12,
                                                    color: ThemeProvider
                                                        .whiteColor,
                                                    fontFamily: 'bold'),
                                              )),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        value
                                                            .updateProductQuantityRemove(
                                                                i);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .secondaryAppColor,
                                                              shadowColor:
                                                                  ThemeProvider
                                                                      .blackColor,
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .whiteColor,
                                                              elevation: 3,
                                                              shape:
                                                                  (RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              )),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                      child: const Icon(
                                                          Icons.remove)),
                                                ),
                                                Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      value.productsList[i]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'medium',
                                                          color: ThemeProvider
                                                              .blackColor),
                                                    )),
                                                SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        value
                                                            .updateProductQuantity(
                                                                i);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .secondaryAppColor,
                                                              shadowColor:
                                                                  ThemeProvider
                                                                      .blackColor,
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .whiteColor,
                                                              elevation: 3,
                                                              shape:
                                                                  (RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              )),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                      child: const Icon(
                                                          Icons.add)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      );
    });
  }
}
