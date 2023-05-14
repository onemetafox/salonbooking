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
import 'package:salon_user/app/controller/product_order_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class ProductOrderScreen extends StatefulWidget {
  const ProductOrderScreen({Key? key}) : super(key: key);

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductOrderController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          titleSpacing: 0,
          title: Text(
            'Order History'.tr,
            style: ThemeProvider.titleStyle,
          ),
          bottom: value.parser.haveLoggedIn() == true
              ? TabBar(
                  controller: value.tabController,
                  unselectedLabelColor: ThemeProvider.whiteColor,
                  labelColor: ThemeProvider.whiteColor,
                  indicatorColor: ThemeProvider.whiteColor,
                  labelStyle: const TextStyle(
                      fontFamily: 'medium',
                      fontSize: 16,
                      color: ThemeProvider.whiteColor),
                  unselectedLabelStyle: const TextStyle(
                      fontFamily: 'medium',
                      fontSize: 16,
                      color: ThemeProvider.whiteColor),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.all(8),
                  tabs: [
                    Text(
                      'New'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor),
                    ),
                    Text(
                      'Old'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor),
                    ),
                  ],
                )
              : null,
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : TabBarView(
                controller: value.tabController,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: value.productSalonList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                value.productSalonList.length,
                                (index) => Column(
                                  children: [
                                    Banner(
                                      message: value
                                          .statusName[value
                                              .productSalonList[index]
                                              .status as int]
                                          .tr,
                                      color: ThemeProvider.appColor,
                                      location: BannerLocation.topStart,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ThemeProvider.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: ThemeProvider.greyColor,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            value.onProductDetail(value
                                                .productSalonList[index]
                                                .id as int);
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  value.productSalonList[index]
                                                              .type ==
                                                          'salon'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: const Size
                                                                  .fromRadius(25),
                                                              child:
                                                                  FadeInImage(
                                                                image: NetworkImage(
                                                                    '${Environments.apiBaseURL}storage/images/${value.productSalonList[index].salonInfo!.cover.toString()}'),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        "assets/images/placeholder.jpeg"),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image
                                                                      .asset(
                                                                    'assets/images/notfound.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 25,
                                                                    width: 25,
                                                                  );
                                                                },
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: const Size
                                                                  .fromRadius(25),
                                                              child:
                                                                  FadeInImage(
                                                                image: NetworkImage(
                                                                    '${Environments.apiBaseURL}storage/images/${value.productSalonList[index].freelancerInfo!.cover.toString()}'),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        "assets/images/placeholder.jpeg"),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image
                                                                      .asset(
                                                                    'assets/images/notfound.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 25,
                                                                    width: 25,
                                                                  );
                                                                },
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        value.productSalonList[index]
                                                                    .type ==
                                                                'salon'
                                                            ? Text(
                                                                value
                                                                    .productSalonList[
                                                                        index]
                                                                    .salonInfo!
                                                                    .name
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        12,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              )
                                                            : Text(
                                                                '${value.productSalonList[index].freelancerInfo!.firstName}  ${value.productSalonList[index].freelancerInfo!.lastName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        12,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${value.productSalonList[index].address!.address} ${value.productSalonList[index].address!.landmark} ${value.productSalonList[index].address!.pincode}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                  color: ThemeProvider
                                                                      .greyColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '${'Order Id #'.tr} ${value.productSalonList[index].id}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            color: ThemeProvider
                                                                .greyColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                        value
                                                            .productSalonList[
                                                                index]
                                                            .orders!
                                                            .length,
                                                        (subIndex) => Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: value
                                                                          .productSalonList[
                                                                              index]
                                                                          .orders![
                                                                              subIndex]
                                                                          .name
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            ' '),
                                                                    TextSpan(
                                                                      text: 'X'
                                                                          .tr,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            ' '),
                                                                    TextSpan(
                                                                      text: value
                                                                          .productSalonList[
                                                                              index]
                                                                          .orders![
                                                                              subIndex]
                                                                          .quantity
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: value.currencySide ==
                                                                            'left'
                                                                        ? value.currencySymbol +
                                                                            value.productSalonList[index].orders![subIndex].originalPrice
                                                                                .toString()
                                                                        : value.productSalonList[index].orders![subIndex].originalPrice.toString() +
                                                                            value.currencySymbol,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                        decoration:
                                                                            TextDecoration.lineThrough),
                                                                  ),
                                                                  const TextSpan(
                                                                      text:
                                                                          ' '),
                                                                  TextSpan(
                                                                    text: value.currencySide ==
                                                                            'left'
                                                                        ? value.currencySymbol +
                                                                            value.productSalonList[index].orders![subIndex].sellPrice
                                                                                .toString()
                                                                        : value.productSalonList[index].orders![subIndex].sellPrice.toString() +
                                                                            value.currencySymbol,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Grand Total : '.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'bold'),
                                                  ),
                                                  Text(
                                                    value.currencySide == 'left'
                                                        ? value.currencySymbol +
                                                            value
                                                                .productSalonList[
                                                                    index]
                                                                .grandTotal
                                                                .toString()
                                                        : value
                                                                .productSalonList[
                                                                    index]
                                                                .grandTotal
                                                                .toString() +
                                                            value
                                                                .currencySymbol,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Order At : '.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'bold'),
                                                  ),
                                                  Text(
                                                    value
                                                        .productSalonList[index]
                                                        .createdAt
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'bold'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/no-data.png',
                                      width: 60, height: 60),
                                  const SizedBox(height: 30),
                                  Text(
                                    'No New Orders Found!'.tr,
                                    style: const TextStyle(
                                        fontFamily: 'bold',
                                        color: ThemeProvider.appColor),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: value.productSalonListOld.isNotEmpty
                          ? Column(
                              children: List.generate(
                                value.productSalonListOld.length,
                                (index) => Column(
                                  children: [
                                    Banner(
                                      message: value
                                          .statusName[value
                                              .productSalonListOld[index]
                                              .status as int]
                                          .tr,
                                      color: ThemeProvider.appColor,
                                      location: BannerLocation.topStart,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ThemeProvider.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: ThemeProvider.greyColor,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            value.onProductDetail(value
                                                .productSalonListOld[index]
                                                .id as int);
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  value.productSalonListOld[index]
                                                              .type ==
                                                          'salon'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: const Size
                                                                  .fromRadius(25),
                                                              child:
                                                                  FadeInImage(
                                                                image: NetworkImage(
                                                                    '${Environments.apiBaseURL}storage/images/${value.productSalonListOld[index].salonInfo!.cover.toString()}'),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        "assets/images/placeholder.jpeg"),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image
                                                                      .asset(
                                                                    'assets/images/notfound.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 25,
                                                                    width: 25,
                                                                  );
                                                                },
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: const Size
                                                                  .fromRadius(25),
                                                              child:
                                                                  FadeInImage(
                                                                image: NetworkImage(
                                                                    '${Environments.apiBaseURL}storage/images/${value.productSalonListOld[index].freelancerInfo!.cover.toString()}'),
                                                                placeholder:
                                                                    const AssetImage(
                                                                        "assets/images/placeholder.jpeg"),
                                                                imageErrorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Image
                                                                      .asset(
                                                                    'assets/images/notfound.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 25,
                                                                    width: 25,
                                                                  );
                                                                },
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        value.productSalonListOld[index]
                                                                    .type ==
                                                                'salon'
                                                            ? Text(
                                                                value
                                                                    .productSalonListOld[
                                                                        index]
                                                                    .salonInfo!
                                                                    .name
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        12,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              )
                                                            : Text(
                                                                '${value.productSalonListOld[index].freelancerInfo!.firstName}  ${value.productSalonListOld[index].freelancerInfo!.lastName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    fontSize:
                                                                        12,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${value.productSalonListOld[index].address!.address} ${value.productSalonListOld[index].address!.landmark} ${value.productSalonListOld[index].address!.pincode}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                  color: ThemeProvider
                                                                      .greyColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '${'Order Id #'.tr} ${value.productSalonListOld[index].id}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            color: ThemeProvider
                                                                .greyColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                        value
                                                            .productSalonListOld[
                                                                index]
                                                            .orders!
                                                            .length,
                                                        (subIndex) => Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: value
                                                                          .productSalonListOld[
                                                                              index]
                                                                          .orders![
                                                                              subIndex]
                                                                          .name
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            ' '),
                                                                    TextSpan(
                                                                      text: 'X'
                                                                          .tr,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            ' '),
                                                                    TextSpan(
                                                                      text: value
                                                                          .productSalonListOld[
                                                                              index]
                                                                          .orders![
                                                                              subIndex]
                                                                          .quantity
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: value.currencySide ==
                                                                            'left'
                                                                        ? value.currencySymbol +
                                                                            value.productSalonListOld[index].orders![subIndex].originalPrice
                                                                                .toString()
                                                                        : value.productSalonListOld[index].orders![subIndex].originalPrice.toString() +
                                                                            value.currencySymbol,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular',
                                                                        decoration:
                                                                            TextDecoration.lineThrough),
                                                                  ),
                                                                  const TextSpan(
                                                                      text:
                                                                          ' '),
                                                                  TextSpan(
                                                                    text: value.currencySide ==
                                                                            'left'
                                                                        ? value.currencySymbol +
                                                                            value.productSalonListOld[index].orders![subIndex].sellPrice
                                                                                .toString()
                                                                        : value.productSalonListOld[index].orders![subIndex].sellPrice.toString() +
                                                                            value.currencySymbol,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: ThemeProvider
                                                                            .blackColor,
                                                                        fontFamily:
                                                                            'regular'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Grand Total : '.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'bold'),
                                                  ),
                                                  Text(
                                                    value.currencySide == 'left'
                                                        ? value.currencySymbol +
                                                            value
                                                                .productSalonListOld[
                                                                    index]
                                                                .grandTotal
                                                                .toString()
                                                        : value
                                                                .productSalonListOld[
                                                                    index]
                                                                .grandTotal
                                                                .toString() +
                                                            value
                                                                .currencySymbol,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Order At : '.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'bold'),
                                                  ),
                                                  Text(
                                                    value
                                                        .productSalonListOld[
                                                            index]
                                                        .createdAt
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'bold'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/no-data.png',
                                      width: 60, height: 60),
                                  const SizedBox(height: 30),
                                  Text(
                                    'No Past Orders Found!'.tr,
                                    style: const TextStyle(
                                        fontFamily: 'bold',
                                        color: ThemeProvider.appColor),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
