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
import 'package:salon_user/app/controller/cart_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
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
              'Cart'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () {
              value.onCheckout();
            },
            child: Container(
              height: 50,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),
              decoration: BoxDecoration(
                color: ThemeProvider.appColor.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue'.tr,
                    style: const TextStyle(
                        color: ThemeProvider.whiteColor, fontFamily: 'bold'),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.savedInCart.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) => Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    value.deleteProductFromCart(i);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: ThemeProvider.redColor,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(40),
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                '${Environments.apiBaseURL}storage/images/${value.savedInCart[i].cover}'),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    value.savedInCart[i].name
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontFamily: 'bold',
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    value.savedInCart[i]
                                                        .descriptions
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: value.currencySide ==
                                                                'left'
                                                            ? value.currencySymbol +
                                                                value
                                                                    .savedInCart[
                                                                        i]
                                                                    .sellPrice
                                                                    .toString()
                                                            : value
                                                                    .savedInCart[
                                                                        i]
                                                                    .sellPrice
                                                                    .toString() +
                                                                value
                                                                    .currencySymbol,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .appColor,
                                                            fontFamily: 'bold'),
                                                      ),
                                                      TextSpan(
                                                        text: value.currencySide ==
                                                                'left'
                                                            ? '  ${value.currencySymbol}${value.savedInCart[i].originalPrice}  '
                                                            : value
                                                                    .savedInCart[
                                                                        i]
                                                                    .originalPrice
                                                                    .toString() +
                                                                value
                                                                    .currencySymbol,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .blackColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 25,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ThemeProvider
                                                        .greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      value
                                                          .updateProductQuantityRemove(
                                                              i);
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          ThemeProvider
                                                              .transparent,
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      value.savedInCart[i]
                                                          .quantity
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      value
                                                          .updateProductQuantity(
                                                              i);
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          ThemeProvider
                                                              .transparent,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: ThemeProvider.greyColor),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Special Discount : '.tr,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text: value
                                                        .savedInCart[i].discount
                                                        .toString() +
                                                    ' %OFF'.tr,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: ThemeProvider.redColor,
                                                  fontFamily: 'bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Total Price : '.tr,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text: value.currencySide ==
                                                        'left'
                                                    ? value.currencySymbol +
                                                        value
                                                            .getFinalTotal(i)
                                                            .toString()
                                                    : value
                                                            .getFinalTotal(i)
                                                            .toString() +
                                                        value.currencySymbol,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greenColor,
                                                  fontFamily: 'bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
