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
import 'package:salon_user/app/controller/products_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
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
              'Products'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    value.onSortBy();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    decoration: BoxDecoration(
                      color: ThemeProvider.blackColor.withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sort,
                          color: ThemeProvider.whiteColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Sort By'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.whiteColor, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            value.currencySide == 'left'
                                ? '${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${value.currencySymbol} ${Get.find<ProductCartController>().totalPrice}'
                                : ' ${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${Get.find<ProductCartController>().totalPrice}${value.currencySymbol}',
                            style: const TextStyle(
                                color: ThemeProvider.whiteColor),
                          ),
                          // Text(
                          //   'Total'.tr +
                          //       ' ' +
                          //       Get.find<ProductCartController>()
                          //           .savedInCart
                          //           .length
                          //           .toString() +
                          //       ' ' +
                          //       'Items'.tr +
                          //       ' ' +
                          //       Get.find<ProductCartController>()
                          //           .totalPrice
                          //           .toString(),
                          //   style: const TextStyle(
                          //       color: ThemeProvider.whiteColor),
                          // ),
                          Text(
                            'Book Services'.tr,
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
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : value.productsList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Column(
                              children: List.generate(
                                value.productsList.length,
                                (index) => Container(
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ThemeProvider.whiteColor,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: ThemeProvider.greyColor,
                                          blurRadius: 5.0,
                                          offset: Offset(0.7, 2.0)),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      value.onProductsDetails(
                                          value.productsList[index].id as int);
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(40),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.productsList[index].cover.toString()}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/placeholder.jpeg"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/notfound.png',
                                                    fit: BoxFit.cover);
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.productsList[index].name
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                value.productsList[index]
                                                    .descriptions
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        ThemeProvider.greyColor,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(height: 3),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: Get.find<ProductsController>()
                                                                  .currencySide ==
                                                              'left'
                                                          ? '${Get.find<ProductsController>().currencySymbol}  ${value.productsList[index].sellPrice}'
                                                          : '  ${value.productsList[index].sellPrice}${Get.find<ProductsController>().currencySymbol}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: ThemeProvider
                                                              .appColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                    TextSpan(
                                                      text: Get.find<ProductsController>()
                                                                  .currencySide ==
                                                              'left'
                                                          ? '${Get.find<ProductsController>().currencySymbol}  ${value.productsList[index].originalPrice}'
                                                          : '  ${value.productsList[index].originalPrice}${Get.find<ProductsController>().currencySymbol}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: ThemeProvider
                                                              .blackColor,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '    ${value.productsList[index].discount} %',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: ThemeProvider
                                                              .greenColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: const TextSpan(
                                                      children: [
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: ThemeProvider
                                                                .orangeColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: ThemeProvider
                                                                .orangeColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: ThemeProvider
                                                                .orangeColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: ThemeProvider
                                                                .orangeColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: ThemeProvider
                                                                .orangeColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  value.productsList[index]
                                                              .quantity ==
                                                          0
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  value.addToCart(
                                                                      index);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        ThemeProvider
                                                                            .appColor,
                                                                    shape:
                                                                        const StadiumBorder()),
                                                                child: Text(
                                                                    'Add'.tr),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    ThemeProvider
                                                                        .redColor,
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      value.updateProductQuantityRemove(
                                                                          index);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: ThemeProvider
                                                                          .whiteColor,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              value
                                                                  .productsList[
                                                                      index]
                                                                  .quantity
                                                                  .toString(),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    ThemeProvider
                                                                        .greenColor,
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      value.updateProductQuantity(
                                                                          index);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: ThemeProvider
                                                                          .whiteColor,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            "assets/images/no-data.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            'No Data Found!'.tr,
                            style: const TextStyle(fontFamily: 'bold'),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
