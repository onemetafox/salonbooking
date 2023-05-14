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
import 'package:salon_user/app/controller/appointment_detail_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentDetailController>(
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
                'Appointment Detail'.tr,
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
            body: value.apiCalled != true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.appColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
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
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  value.appointmentInfo.salonId != 0
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: SizedBox.fromSize(
                                                size: const Size.fromRadius(30),
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.appointmentInfo.salonInfo!.cover.toString()}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${value.appointmentInfo.salonInfo!.name}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontFamily: 'bold',
                                                        fontSize: 14),
                                                  ),
                                                  Row(
                                                    children: [
                                                      value.appointmentInfo
                                                                  .salonId !=
                                                              0
                                                          ? Expanded(
                                                              child: Text(
                                                                value
                                                                    .appointmentInfo
                                                                    .salonInfo!
                                                                    .address
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              child: Text(
                                                                value
                                                                    .appointmentInfo
                                                                    .individualInfo!
                                                                    .address
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                value.onContactInfo(
                                                    value.appointmentInfo
                                                        .salonInfo!.name!,
                                                    value.appointmentInfo
                                                        .ownerInfo!.mobile!,
                                                    value.appointmentInfo
                                                        .ownerInfo!.email!,
                                                    value
                                                        .appointmentInfo.salonId
                                                        .toString());
                                              },
                                              icon: const Icon(Icons.info),
                                              color: ThemeProvider.appColor,
                                            )
                                          ],
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: SizedBox.fromSize(
                                                size: const Size.fromRadius(30),
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.appointmentInfo.ownerInfo!.cover.toString()}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${value.appointmentInfo.ownerInfo!.firstName} ${value.appointmentInfo.ownerInfo!.lastName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontFamily: 'bold',
                                                        fontSize: 14),
                                                  ),
                                                  Row(
                                                    children: [
                                                      value.appointmentInfo
                                                                  .salonId !=
                                                              0
                                                          ? Expanded(
                                                              child: Text(
                                                                value
                                                                    .appointmentInfo
                                                                    .salonInfo!
                                                                    .address
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                            )
                                                          : Expanded(
                                                              child: Text(
                                                                value
                                                                    .appointmentInfo
                                                                    .individualInfo!
                                                                    .address
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                            ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                value.onContactInfo(
                                                    '${value.appointmentInfo.ownerInfo!.firstName!} ${value.appointmentInfo.ownerInfo!.lastName!}',
                                                    value.appointmentInfo
                                                        .ownerInfo!.mobile!,
                                                    value.appointmentInfo
                                                        .ownerInfo!.email!,
                                                    value.appointmentInfo
                                                        .freelancerId
                                                        .toString());
                                              },
                                              icon: const Icon(Icons.info),
                                              color: ThemeProvider.appColor,
                                            )
                                          ],
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Booking Date & Time'.tr,
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
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Booking Date'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.blackColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.savedDate,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: ThemeProvider.appColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Booking Time'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.blackColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.slot,
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      value.appointmentInfo.items!.services!
                                              .isNotEmpty
                                          ? Text(
                                              'Services'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold',
                                                  fontSize: 15),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                            value.appointmentInfo.items!
                                                .services!.length,
                                            (serviceIndex) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      value
                                                          .appointmentInfo
                                                          .items!
                                                          .services![
                                                              serviceIndex]
                                                          .name
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'regular',
                                                          fontSize: 10,
                                                          color: ThemeProvider
                                                              .blackColor),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: value.currencySide ==
                                                                    'left'
                                                                ? value.currencySymbol +
                                                                    value
                                                                        .appointmentInfo
                                                                        .items!
                                                                        .services![
                                                                            serviceIndex]
                                                                        .price
                                                                        .toString()
                                                                : value
                                                                        .appointmentInfo
                                                                        .items!
                                                                        .services![
                                                                            serviceIndex]
                                                                        .price
                                                                        .toString() +
                                                                    value
                                                                        .currencySymbol,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: ThemeProvider
                                                                    .blackColor,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                          const TextSpan(
                                                              text: ' '),
                                                          TextSpan(
                                                            text: value.currencySide ==
                                                                    'left'
                                                                ? value.currencySymbol +
                                                                    value
                                                                        .appointmentInfo
                                                                        .items!
                                                                        .services![
                                                                            serviceIndex]
                                                                        .off
                                                                        .toString()
                                                                : value
                                                                        .appointmentInfo
                                                                        .items!
                                                                        .services![
                                                                            serviceIndex]
                                                                        .off
                                                                        .toString() +
                                                                    value
                                                                        .currencySymbol,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: ThemeProvider
                                                                    .blackColor,
                                                                fontFamily:
                                                                    'bold'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      value.appointmentInfo.items!.packages!
                                              .isNotEmpty
                                          ? Text(
                                              'Packages'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold',
                                                  fontSize: 15),
                                            )
                                          : const SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                            value.appointmentInfo.items!
                                                .packages!.length,
                                            (packageIndex) => Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          value
                                                              .appointmentInfo
                                                              .items!
                                                              .packages![
                                                                  packageIndex]
                                                              .name
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'regular',
                                                              fontSize: 10,
                                                              color: ThemeProvider
                                                                  .blackColor),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: value.currencySide ==
                                                                        'left'
                                                                    ? value.currencySymbol +
                                                                        value
                                                                            .appointmentInfo
                                                                            .items!
                                                                            .packages![
                                                                                packageIndex]
                                                                            .price
                                                                            .toString()
                                                                    : value
                                                                            .appointmentInfo
                                                                            .items!
                                                                            .packages![
                                                                                packageIndex]
                                                                            .price
                                                                            .toString() +
                                                                        value
                                                                            .currencySymbol,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: ThemeProvider
                                                                        .blackColor,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                              ),
                                                              const TextSpan(
                                                                  text: ' '),
                                                              TextSpan(
                                                                text: value.currencySide ==
                                                                        'left'
                                                                    ? value.currencySymbol +
                                                                        value
                                                                            .appointmentInfo
                                                                            .items!
                                                                            .packages![
                                                                                packageIndex]
                                                                            .off
                                                                            .toString()
                                                                    : value
                                                                            .appointmentInfo
                                                                            .items!
                                                                            .packages![
                                                                                packageIndex]
                                                                            .off
                                                                            .toString() +
                                                                        value
                                                                            .currencySymbol,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: ThemeProvider
                                                                        .blackColor,
                                                                    fontFamily:
                                                                        'bold'),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                          value
                                                              .appointmentInfo
                                                              .items!
                                                              .packages![
                                                                  packageIndex]
                                                              .services!
                                                              .length,
                                                          (packageServiceIndex) =>
                                                              Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  const Text(
                                                                      '-',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              8,
                                                                          fontFamily:
                                                                              'regular',
                                                                          color:
                                                                              ThemeProvider.blackColor)),
                                                                  Text(
                                                                    value
                                                                        .appointmentInfo
                                                                        .items!
                                                                        .packages![
                                                                            packageIndex]
                                                                        .services![
                                                                            packageServiceIndex]
                                                                        .name
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            8,
                                                                        fontFamily:
                                                                            'regular',
                                                                        color: ThemeProvider
                                                                            .blackColor),
                                                                  )
                                                                ],
                                                              )),
                                                    )
                                                  ],
                                                )),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Discount'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.discount.toString()
                                                  : value.discount.toString() +
                                                      value.currencySymbol,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Wallet Discount'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.walletDiscount
                                                          .toString()
                                                  : value.walletDiscount
                                                          .toString() +
                                                      value.currencySymbol,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Distance Cost'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.distanceCost
                                                          .toString()
                                                  : value.distanceCost
                                                          .toString() +
                                                      value.currencySymbol,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Service Tax'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.serviceTax
                                                          .toString()
                                                  : value.serviceTax
                                                          .toString() +
                                                      value.currencySymbol,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Total'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.currencySide == 'left'
                                                  ? value.currencySymbol +
                                                      value.total.toString()
                                                  : value.total.toString() +
                                                      value.currencySymbol,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Payment Method'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              value.paymentName[value
                                                  .appointmentInfo
                                                  .payMethod as int],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                    value.grandTotal.toString()
                                                : value.grandTotal.toString() +
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
                          ],
                        )),
                  ),
            bottomNavigationBar: value.apiCalled == false
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: value.appointmentInfo.status == 1 ||
                            value.appointmentInfo.status == 2 ||
                            value.appointmentInfo.status == 3 ||
                            value.appointmentInfo.status == 7 ||
                            value.appointmentInfo.status == 8 ||
                            value.appointmentInfo.status == 5 ||
                            value.appointmentInfo.status == 6
                        ? Text(
                            '${'Your Appoinments Status'.tr} : ${value.orderStatus}',
                            textAlign: TextAlign.center,
                          )
                        : value.appointmentInfo.status == 0
                            ? SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: () {
                                      value.onUpdateAppointmentStatus(5);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: ThemeProvider.appColor,
                                        shadowColor: ThemeProvider.blackColor,
                                        foregroundColor:
                                            ThemeProvider.whiteColor,
                                        elevation: 3,
                                        shape: (RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        )),
                                        padding: const EdgeInsets.all(0)),
                                    child: Text(
                                      'Cancel'.tr,
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'bold'),
                                    )),
                              )
                            : value.appointmentInfo.status == 4
                                ? SizedBox(
                                    height: 65,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                value.onAddReview(value
                                                    .appointmentInfo
                                                    .freelancerId as int);
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
                                                'Add Review'.tr,
                                                style: const TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 16,
                                                    color: ThemeProvider
                                                        .whiteColor,
                                                    fontFamily: 'bold'),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                  ));
      },
    );
  }
}
