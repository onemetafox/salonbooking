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
import 'package:salon_user/app/controller/payment_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/controller/slot_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
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
                'Payment'.tr,
                style: ThemeProvider.titleStyle,
              ),
            ),
            body: value.apiCalled == false
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.appColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          value.salonDetails.serviceAtHome == 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Service at'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 14),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          value.salonDetails.serviceAtHome == 1
                              ? Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ThemeProvider.whiteColor,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      value.updateServiceAt(1);
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(15),
                                            child: Image.asset(
                                                'assets/images/house.png',
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'At Home'.tr,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Icon(
                                                value.appointmentsTo == 1
                                                    ? Icons.check_circle
                                                    : Icons.circle_outlined,
                                                color: ThemeProvider.appColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          value.salonDetails.serviceAtHome == 1
                              ? Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ThemeProvider.whiteColor,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      value.updateServiceAt(0);
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(15),
                                            child: Image.asset(
                                                'assets/images/salon.png',
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'At Salon'.tr,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Icon(
                                                value.appointmentsTo == 0
                                                    ? Icons.check_circle
                                                    : Icons.circle_outlined,
                                                color: ThemeProvider.appColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Offers & Benefits'.tr,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                if (value.isWalletChecked == false) {
                                  value.onCoupon(
                                      value.offerId, value.offerName);
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: value.offerName.isEmpty
                                        ? Text('Apply Coupon Code'.tr,
                                            overflow: TextOverflow.ellipsis)
                                        : Text(
                                            'Coupon Applied :'.tr +
                                                value.offerName,
                                            overflow: TextOverflow.ellipsis),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: ThemeProvider.greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: ThemeProvider.appColor,
                                  value: value.isWalletChecked,
                                  onChanged: value.balance <= 0 ||
                                          value.offerName.isNotEmpty
                                      ? null
                                      : (bool? status) {
                                          value.updateWalletChecked(status!);
                                        },
                                ),
                                Expanded(
                                  child: value.currencySide == 'left'
                                      ? Text(
                                          '${'Available Balance'.tr + value.currencySymbol}${value.balance}')
                                      : Text(
                                          '${'Available Balance'.tr + value.balance.toString()}${value.currencySymbol}'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Notes For Service'.tr,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: double.infinity,
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
                              child: TextField(
                                controller: value.notesEditor,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeProvider.whiteColor,
                                  hintText: 'Appoinments notes'.tr,
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 8.0, top: 14.0, left: 10),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.appColor),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeProvider.transparent)),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Bill Details'.tr,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'item Total'.tr,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${Get.find<ServiceCartController>().totalPrice.toString()}'
                                            : '${Get.find<ServiceCartController>().totalPrice.toString()}${value.currencySymbol}',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'item Discount'.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: ThemeProvider.redColor),
                                        ),
                                      ),
                                      Text(
                                        value.currencySide == 'left'
                                            ? '-${value.currencySymbol}${value.discount.toString()}'
                                            : '-${value.discount.toString()}${value.currencySymbol}',
                                        style: const TextStyle(
                                            color: ThemeProvider.redColor),
                                      ),
                                    ],
                                  ),
                                ),
                                value.isWalletChecked == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Wallet Discount'.tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        ThemeProvider.redColor),
                                              ),
                                            ),
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '-${value.currencySymbol}${value.walletDiscount.toString()}'
                                                  : '-${value.walletDiscount.toString()}${value.currencySymbol}',
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.redColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                                value.appointmentsTo == 1
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Distance Charge'.tr,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol}${value.deliveryPrice.toString()}'
                                                  : '${value.deliveryPrice.toString()}${value.currencySymbol}',
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Taxes & Charges'.tr,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${Get.find<ServiceCartController>().orderTax.toString()}'
                                            : '${Get.find<ServiceCartController>().orderTax.toString()}${value.currencySymbol}',
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        value.currencySide == 'left'
                                            ? '${value.currencySymbol}${value.grandTotal.toString()}'
                                            : '${value.grandTotal.toString()}${value.currencySymbol}',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Method'.tr,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14),
                              ),
                            ],
                          ),
                          value.paymentAPICalled == false
                              ? SizedBox(
                                  height: 300,
                                  child: SkeletonListView(
                                    itemCount: 5,
                                  ),
                                )
                              : const SizedBox(),
                          Column(
                            children: List.generate(
                                value.paymentList.length,
                                (index) => InkWell(
                                      onTap: () {
                                        value.selectPaymentMethod(
                                            value.paymentList[index].id as int);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  ThemeProvider.transparent,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: SizedBox.fromSize(
                                                  size:
                                                      const Size.fromRadius(20),
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${value.paymentList[index].cover}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/images/notfound.png',
                                                          fit: BoxFit.cover);
                                                    },
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value.paymentList[index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    Icon(value
                                                                .paymentList[
                                                                    index]
                                                                .id ==
                                                            value.paymentId
                                                        ? Icons.check_circle
                                                        : Icons.circle_outlined)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          )
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: Container(
              color: Colors.white,
              height: 136,
              child: Column(
                children: [
                  value.appointmentsTo == 1
                      ? ListTile(
                          onTap: () {
                            value.onSelectAddress();
                          },
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          leading: const Icon(Icons.location_on, size: 14),
                          minLeadingWidth: 0,
                          title: value.haveAddress == true
                              ? Text(
                                  '${value.addressInfo.address} ${value.addressInfo.landmark}',
                                  style: const TextStyle(fontSize: 14),
                                )
                              : Text('Please Add Your Address'.tr),
                          trailing: const Icon(Icons.edit_outlined, size: 14),
                        )
                      : const SizedBox(),
                  value.apiCalled == true
                      ? ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          leading:
                              const Icon(Icons.access_time_sharp, size: 14),
                          minLeadingWidth: 0,
                          title: Text(
                            '${Get.find<SlotController>().savedDate} ${Get.find<SlotController>().selectedSlotIndex}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: const Icon(Icons.edit_outlined, size: 14),
                          onTap: () {
                            value.onBack();
                          },
                        )
                      : const SizedBox(),
                  value.haveFairDeliveryRadius == true
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: ElevatedButton(
                                onPressed: () {
                                  value.onPayment();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ThemeProvider.appColor,
                                    shadowColor: ThemeProvider.blackColor,
                                    foregroundColor: ThemeProvider.whiteColor,
                                    elevation: 3,
                                    shape: (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    )),
                                    padding: const EdgeInsets.all(0)),
                                child: Text(
                                  value.currencySide == 'left'
                                      ? '${'Pay'} ${value.currencySymbol}${value.grandTotal}'
                                      : '${'Pay'} ${value.grandTotal}${value.currencySymbol}',
                                  style: const TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      color: ThemeProvider.whiteColor,
                                      fontFamily: 'bold'),
                                )),
                          ))
                      : const SizedBox(),
                ],
              ),
            ));
      },
    );
  }
}
