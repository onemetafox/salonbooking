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
import 'package:salon_user/app/controller/products_details_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  var top = 0.0;

  final ScrollController _scrollController = ScrollController();

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsDetailsController>(builder: (value) {
      return value.apiCalled == false
          ? Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                    ],
                  ),
                ],
              ),
            )
          : NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: ThemeProvider.backgroundColor,
                    pinned: true,
                    snap: false,
                    floating: true,
                    elevation: 0,
                    expandedHeight: 230.0,
                    iconTheme: const IconThemeData(color: Colors.black),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isShrink
                            ? ThemeProvider.blackColor
                            : ThemeProvider.whiteColor,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    title: Text(
                      'Products Details'.tr,
                      style: TextStyle(
                          color: isShrink
                              ? ThemeProvider.blackColor
                              : ThemeProvider.whiteColor,
                          fontFamily: 'bold',
                          fontSize: 14),
                    ),
                    flexibleSpace: LayoutBuilder(
                      builder: (ctx, cons) {
                        top = cons.biggest.height;
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: top <= 80 ? 1.0 : 0.0,
                            duration: const Duration(microseconds: 200),
                          ),
                          background: SizedBox(
                            height: 180,
                            width: double.infinity,
                            child: FadeInImage(
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${value.productsList.cover.toString()}'),
                              placeholder: const AssetImage(
                                  "assets/images/placeholder.jpeg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/notfound.png',
                                    fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ];
              },
              body: Scaffold(
                backgroundColor: ThemeProvider.whiteColor,
                bottomNavigationBar: value.apiCalled == false
                    ? const SizedBox()
                    : SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value.productsList.quantity == 0
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 17, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Price'.tr,
                                          style: const TextStyle(
                                            fontFamily: 'bold',
                                            decoration: TextDecoration.none,
                                            color: ThemeProvider.blackColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          value.getTotal().toString(),
                                          style: const TextStyle(
                                            fontFamily: 'bold',
                                            decoration: TextDecoration.none,
                                            color: ThemeProvider.blackColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            value.productsList.quantity == 0
                                ? InkWell(
                                    onTap: () {
                                      value.addToCart();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13.0),
                                      decoration: BoxDecoration(
                                        color: ThemeProvider.appColor
                                            .withOpacity(0.8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Add To Cart'.tr,
                                            style: const TextStyle(
                                                color: ThemeProvider.whiteColor,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 50,
                                          color: ThemeProvider.blackColor
                                              .withOpacity(0.8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      ThemeProvider.redColor,
                                                  child: Center(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        value
                                                            .updateProductQuantityRemove();
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color: ThemeProvider
                                                            .whiteColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                value.productsList.quantity
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .whiteColor),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      ThemeProvider.greenColor,
                                                  child: Center(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        value
                                                            .updateProductQuantity();
                                                      },
                                                      icon: const Icon(
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
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              value.onCheckout();
                                            },
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13.0),
                                              decoration: BoxDecoration(
                                                color: ThemeProvider.appColor
                                                    .withOpacity(0.8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Checkout'.tr,
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .whiteColor,
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    value.productsList.name.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'bold',
                                      decoration: TextDecoration.none,
                                      color: ThemeProvider.blackColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Sold By :   '.tr,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: ThemeProvider.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${value.soldByInfo.firstName}  ${value.soldByInfo.lastName}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ThemeProvider.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Categories Info :   '.tr,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: ThemeProvider.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: value.cateInfo.name.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ThemeProvider.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Sub Categories Info :   '.tr,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: ThemeProvider.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: value.subCateInfo.name.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ThemeProvider.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Descriptions'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.blackColor,
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                value.productsList.descriptions.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Special Price'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.greenColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: Get.find<ProductsDetailsController>()
                                                .currencySide ==
                                            'left'
                                        ? '${Get.find<ProductsDetailsController>().currencySymbol}  ${value.productsList.sellPrice}'
                                        : '  ${value.productsList.sellPrice}${Get.find<ProductsDetailsController>().currencySymbol}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.appColor,
                                        fontFamily: 'bold'),
                                  ),
                                  TextSpan(
                                    text: Get.find<ProductsDetailsController>()
                                                .currencySide ==
                                            'left'
                                        ? '${Get.find<ProductsDetailsController>().currencySymbol}  ${value.productsList.originalPrice}'
                                        : '  ${value.productsList.originalPrice}${Get.find<ProductsDetailsController>().currencySymbol}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ThemeProvider.blackColor,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  TextSpan(
                                    text:
                                        '  ${value.productsList.discount}${'  %Off '.tr}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ThemeProvider.greenColor,
                                        fontFamily: 'bold'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Only 5 Days Left'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.redColor,
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Disclaimer'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.blackColor,
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                value.productsList.disclaimer.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Related Products'.tr,
                                    style: const TextStyle(
                                      color: ThemeProvider.blackColor,
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  value.relatedList.length,
                                  (index) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(35),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.relatedList[index].cover.toString()}'),
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
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            value.relatedList[index].name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: ThemeProvider.blackColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
