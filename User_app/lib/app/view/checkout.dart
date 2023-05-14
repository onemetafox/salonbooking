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
import 'package:salon_user/app/controller/checkout_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedList = '';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
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
              'Checkout'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  value.savedInCart.services!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total'.tr,
                              style: const TextStyle(
                                  fontFamily: 'bold', fontSize: 14),
                            ),
                            Text(
                                '${value.savedInCart.services!.length} ${'Services'.tr}',
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14))
                          ],
                        )
                      : const SizedBox(),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.savedInCart.services!.length,
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
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(40),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.savedInCart.services![i].cover}'),
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
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: -15,
                                      top: -15,
                                      child: IconButton(
                                          onPressed: () {
                                            value.deleteServiceFromCart(i);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: ThemeProvider.redColor,
                                          )),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.savedInCart.services![i].name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'bold', fontSize: 14),
                                        ),
                                        const SizedBox(height: 2),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: Get.find<CheckoutController>()
                                                            .currencySide ==
                                                        'right'
                                                    ? '${Get.find<CheckoutController>().currencySymbol} ${value.savedInCart.services![i].price}'
                                                    : ' ${value.savedInCart.services![i].price}${Get.find<CheckoutController>().currencySymbol}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        ThemeProvider.greyColor,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              TextSpan(
                                                text: Get.find<CheckoutController>()
                                                            .currencySide ==
                                                        'right'
                                                    ? '${Get.find<CheckoutController>().currencySymbol} ${value.savedInCart.services![i].off}'
                                                    : ' ${value.savedInCart.services![i].off}${Get.find<CheckoutController>().currencySymbol}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: ThemeProvider
                                                        .greenColor,
                                                    fontFamily: 'bold'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          value.savedInCart.services![i]
                                                  .duration
                                                  .toString() +
                                              'min'.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: ThemeProvider.greyColor,
                                              fontSize: 12),
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
                  value.savedInCart.packages!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total'.tr,
                              style: const TextStyle(
                                  fontFamily: 'bold', fontSize: 14),
                            ),
                            Text(
                                '${value.savedInCart.packages!.length} ${'Packages'.tr}',
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14))
                          ],
                        )
                      : const SizedBox(),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.savedInCart.packages!.length,
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
                                offset: Offset(0.7, 2.0),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(40),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.savedInCart.packages![i].cover}'),
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
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: -15,
                                      top: -15,
                                      child: IconButton(
                                          onPressed: () {
                                            value.deletePackageFromCart(i);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: ThemeProvider.redColor,
                                          )),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.savedInCart.packages![i].name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'bold', fontSize: 14),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                            value.savedInCart.packages![i]
                                                .services!.length,
                                            (serviceIndex) => Text(
                                              '* ${value.savedInCart.packages![i].services![serviceIndex].name}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: Get.find<CheckoutController>()
                                                            .currencySide ==
                                                        'right'
                                                    ? '${Get.find<CheckoutController>().currencySymbol} ${value.savedInCart.packages![i].price}'
                                                    : ' ${value.savedInCart.packages![i].price}${Get.find<CheckoutController>().currencySymbol}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        ThemeProvider.greyColor,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              TextSpan(
                                                text: Get.find<CheckoutController>()
                                                            .currencySide ==
                                                        'right'
                                                    ? '${Get.find<CheckoutController>().currencySymbol} ${value.savedInCart.packages![i].off}'
                                                    : ' ${value.savedInCart.packages![i].off}${Get.find<CheckoutController>().currencySymbol}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'bold',
                                                    color: ThemeProvider
                                                        .greenColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          value.savedInCart.packages![i]
                                                  .duration
                                                  .toString() +
                                              'min'.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: ThemeProvider.greyColor,
                                              fontSize: 12),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Specialist'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.blackColor,
                                                  fontSize: 12),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  children: List.generate(
                                                    value
                                                        .savedInCart
                                                        .packages![i]
                                                        .specialist!
                                                        .take(4)
                                                        .length,
                                                    (specialistIndex) =>
                                                        specialistIndex == 0
                                                            ? Positioned(
                                                                child: SizedBox(
                                                                  height: 25,
                                                                  width: 25,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      border: Border.all(
                                                                          color:
                                                                              ThemeProvider.whiteColor),
                                                                    ),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      child: SizedBox
                                                                          .fromSize(
                                                                        size: const Size.fromRadius(
                                                                            40),
                                                                        child:
                                                                            FadeInImage(
                                                                          image:
                                                                              NetworkImage('${Environments.apiBaseURL}storage/images/${value.savedInCart.packages![i].specialist![specialistIndex].cover}'),
                                                                          placeholder:
                                                                              const AssetImage("assets/images/placeholder.jpeg"),
                                                                          imageErrorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Image.asset('assets/images/notfound.png',
                                                                                fit: BoxFit.cover);
                                                                          },
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Positioned(
                                                                right: 10 *
                                                                    double.parse(
                                                                        specialistIndex
                                                                            .toString()),
                                                                child: SizedBox(
                                                                  height: 25,
                                                                  width: 25,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      border: Border.all(
                                                                          color:
                                                                              ThemeProvider.whiteColor),
                                                                    ),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      child: SizedBox
                                                                          .fromSize(
                                                                        size: const Size.fromRadius(
                                                                            40),
                                                                        child:
                                                                            FadeInImage(
                                                                          image:
                                                                              NetworkImage('${Environments.apiBaseURL}storage/images/${value.savedInCart.packages![i].specialist![specialistIndex].cover}'),
                                                                          placeholder:
                                                                              const AssetImage("assets/images/placeholder.jpeg"),
                                                                          imageErrorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Image.asset('assets/images/notfound.png',
                                                                                fit: BoxFit.cover);
                                                                          },
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
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
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Bill Details'.tr,
                        style:
                            const TextStyle(fontFamily: 'bold', fontSize: 14),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'item Total'.tr,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                value.currencySide == 'right'
                                    ? '${value.currencySymbol} ${Get.find<ServiceCartController>().totalPrice}'
                                    : ' ${Get.find<ServiceCartController>().totalPrice}${value.currencySymbol}',
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Taxes & Charges'.tr,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                value.currencySide == 'right'
                                    ? '${value.currencySymbol} ${Get.find<ServiceCartController>().orderTax}'
                                    : ' ${Get.find<ServiceCartController>().orderTax}${value.currencySymbol}',
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'To Pay'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                      fontFamily: 'bold'),
                                ),
                              ),
                              Text(
                                value.currencySide == 'right'
                                    ? '${value.currencySymbol} ${Get.find<ServiceCartController>().grandTotal}'
                                    : ' ${Get.find<ServiceCartController>().grandTotal}${value.currencySymbol}',
                                // Get.find<ServiceCartController>()
                                //     .grandTotal
                                //     .toString(),
                                style: const TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontFamily: 'bold'),
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
          bottomNavigationBar: SizedBox(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    value.onSlot();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    decoration: BoxDecoration(
                      color: ThemeProvider.appColor.withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Date & Time'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.whiteColor, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
