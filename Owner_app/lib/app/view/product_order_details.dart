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
import 'package:ultimate_salon_owner_flutter/app/controller/product_order_details_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';

class ProductOrderDetailScreen extends StatefulWidget {
  const ProductOrderDetailScreen({super.key});

  @override
  State<ProductOrderDetailScreen> createState() =>
      _ProductOrderDetailScreenState();
}

class _ProductOrderDetailScreenState extends State<ProductOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductOrderDetailsController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            title: Text(
              "Order No #".tr + value.id.toString(),
              style: ThemeProvider.titleStyle,
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    value.launchInBrowser();
                  },
                  icon: const Icon(Icons.print_outlined)),
              IconButton(
                  onPressed: () {
                    value.openHelpModal();
                  },
                  icon: const Icon(Icons.question_mark_outlined))
            ],
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.productOrderDetails.userInfo!.cover.toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/notfound.png',
                                      fit: BoxFit.cover,
                                      height: 30,
                                      width: 30,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${value.productOrderDetails.userInfo!.firstName} ${value.productOrderDetails.userInfo!.lastName}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'bold', fontSize: 14),
                                  ),
                                  Text(
                                    value.productOrderDetails.userInfo!.email
                                        .toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    value.productOrderDetails.userInfo!.mobile
                                        .toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                value.onContactInfo(
                                    '${value.productOrderDetails.userInfo!.firstName!} ${value.productOrderDetails.userInfo!.lastName!}',
                                    value.productOrderDetails.userInfo!.mobile!,
                                    value.productOrderDetails.userInfo!.email!,
                                    value.productOrderDetails.userInfo!.id
                                        .toString());
                              },
                              icon: const Icon(Icons.info),
                              color: ThemeProvider.appColor,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Delivery Address'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                      fontFamily: 'bold',
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '${value.productOrderDetails.address!.house} ${value.productOrderDetails.address!.address} ${value.productOrderDetails.address!.landmark} ${value.productOrderDetails.address!.pincode}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: ThemeProvider.greyColor,
                                      fontFamily: 'bold',
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Order Date'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.productOrderDetails.createdAt
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Orders'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontFamily: 'bold',
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            value.productOrderDetails.orders!.length,
                            (subIndex) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: value.productOrderDetails
                                          .orders![subIndex].name
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: ThemeProvider.blackColor,
                                        fontFamily: 'regular',
                                      ),
                                    ),
                                    const TextSpan(text: ' '),
                                    const TextSpan(
                                      text: 'X',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: ThemeProvider.blackColor,
                                        fontFamily: 'regular',
                                      ),
                                    ),
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                      text: value.productOrderDetails
                                          .orders![subIndex].quantity
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: ThemeProvider.blackColor,
                                        fontFamily: 'regular',
                                      ),
                                    ),
                                  ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: value.currencySide == 'left'
                                            ? value.currencySymbol +
                                                value
                                                    .productOrderDetails
                                                    .orders![subIndex]
                                                    .originalPrice
                                                    .toString()
                                            : value
                                                    .productOrderDetails
                                                    .orders![subIndex]
                                                    .originalPrice
                                                    .toString() +
                                                value.currencySymbol,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: ThemeProvider.blackColor,
                                            fontFamily: 'regular',
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: value.currencySide == 'left'
                                            ? value.currencySymbol +
                                                value.productOrderDetails
                                                    .orders![subIndex].sellPrice
                                                    .toString()
                                            : value.productOrderDetails
                                                    .orders![subIndex].sellPrice
                                                    .toString() +
                                                value.currencySymbol,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: ThemeProvider.blackColor,
                                            fontFamily: 'regular'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pricing'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontFamily: 'bold',
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Discount'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.currencySide == 'left'
                                        ? value.currencySymbol +
                                            value.productOrderDetails.discount
                                                .toString()
                                        : value.productOrderDetails.discount
                                                .toString() +
                                            value.currencySymbol,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Wallet Discount'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.currencySide == 'left'
                                        ? value.currencySymbol +
                                            value
                                                .productOrderDetails.walletPrice
                                                .toString()
                                        : value.productOrderDetails.walletPrice
                                                .toString() +
                                            value.currencySymbol,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Distance Cost'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.currencySide == 'left'
                                        ? value.currencySymbol +
                                            value.productOrderDetails
                                                .deliveryCharge
                                                .toString()
                                        : value.productOrderDetails
                                                .deliveryCharge
                                                .toString() +
                                            value.currencySymbol,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Service Tax'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.currencySide == 'left'
                                        ? value.currencySymbol +
                                            value.productOrderDetails.tax
                                                .toString()
                                        : value.productOrderDetails.tax
                                                .toString() +
                                            value.currencySymbol,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Total'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.currencySide == 'left'
                                        ? value.currencySymbol +
                                            value.productOrderDetails.total
                                                .toString()
                                        : value.productOrderDetails.total
                                                .toString() +
                                            value.currencySymbol,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Payment'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    value.paymentName[value
                                        .productOrderDetails.paidMethod as int],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Total Amount'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: ThemeProvider.blackColor,
                                      fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  value.currencySide == 'left'
                                      ? value.currencySymbol +
                                          value.productOrderDetails.grandTotal
                                              .toString()
                                      : value.productOrderDetails.grandTotal
                                              .toString() +
                                          value.currencySymbol,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                      fontFamily: 'bold',
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: value.apiCalled == false
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: value.productOrderDetails.status == 2 ||
                          value.productOrderDetails.status == 4 ||
                          value.productOrderDetails.status == 5 ||
                          value.productOrderDetails.status == 6
                      ? Text(
                          '${'Your Order Status'.tr} : ${value.orderStatus}',
                          textAlign: TextAlign.center,
                        )
                      : value.productOrderDetails.status == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        value.onUpdateAppointmentStatus(1);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor:
                                              ThemeProvider.whiteColor,
                                          backgroundColor:
                                              ThemeProvider.appColor,
                                          shadowColor: ThemeProvider.blackColor,
                                          elevation: 3,
                                          shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )),
                                          padding: const EdgeInsets.all(0)),
                                      child: Text(
                                        'Accept'.tr,
                                        style: const TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 16,
                                            color: ThemeProvider.whiteColor,
                                            fontFamily: 'bold'),
                                      )),
                                )),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        value.onUpdateAppointmentStatus(2);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor:
                                              ThemeProvider.whiteColor,
                                          backgroundColor:
                                              ThemeProvider.greyColor,
                                          shadowColor: ThemeProvider.blackColor,
                                          elevation: 3,
                                          shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )),
                                          padding: const EdgeInsets.all(0)),
                                      child: Text(
                                        'Decline'.tr,
                                        style: const TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 16,
                                            color: ThemeProvider.whiteColor,
                                            fontFamily: 'bold'),
                                      )),
                                )),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: ThemeProvider.whiteColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: ThemeProvider.blackColor
                                                  .withOpacity(0.2),
                                              offset: const Offset(0, 1),
                                              blurRadius: 3),
                                        ],
                                      ),
                                      child: DropdownButton<String>(
                                        value: value.savedStatus,
                                        underline: const SizedBox(),
                                        iconSize: 24,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        iconEnabledColor:
                                            ThemeProvider.blackColor,
                                        onChanged: (String? newValue) {
                                          value.onSelectStatus(
                                              newValue.toString());
                                        },
                                        items: value.selectStatus
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        value.updateStatus();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor:
                                              ThemeProvider.whiteColor,
                                          backgroundColor:
                                              ThemeProvider.appColor,
                                          shadowColor: ThemeProvider.blackColor,
                                          elevation: 3,
                                          shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )),
                                          padding: const EdgeInsets.all(0)),
                                      child: Text(
                                        'Update Status'.tr,
                                        style: const TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 16,
                                            color: ThemeProvider.whiteColor,
                                            fontFamily: 'bold'),
                                      )),
                                )),
                              ],
                            ),
                ),
        );
      },
    );
  }
}
