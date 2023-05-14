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
import 'package:salon_user/app/controller/booking_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          title: Text(
            'Appointments History'.tr,
            style: ThemeProvider.titleStyle,
          ),
          bottom: value.parser.haveLoggedIn() == true
              ? TabBar(
                  controller: value.tabController,
                  unselectedLabelColor: ThemeProvider.blackColor,
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
        body: value.parser.haveLoggedIn() == true
            ? value.apiCalled == false
                ? SkeletonListView()
                : TabBarView(
                    controller: value.tabController,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: value.appointmentList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                    value.appointmentList.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Banner(
                                          message: value
                                              .statusName[value
                                                  .appointmentList[index]
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
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  blurRadius: 5.0,
                                                ),
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                value.onAppointment(value
                                                    .appointmentList[index]
                                                    .id as int);
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      value.appointmentList[index]
                                                                  .salonId !=
                                                              0
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
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
                                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentList[index].salonInfo!.cover.toString()}'),
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
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            25,
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
                                                                      right:
                                                                          10),
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
                                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentList[index].individualInfo!.background.toString()}'),
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
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            25,
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
                                                            value.appointmentList[index]
                                                                        .salonId !=
                                                                    0
                                                                ? Text(
                                                                    value
                                                                        .appointmentList[
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
                                                                    '${value.appointmentList[index].individualInfo!.firstName} ${value.appointmentList[index].individualInfo!.lastName}',
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
                                                            Row(
                                                              children: [
                                                                value.appointmentList[index]
                                                                            .salonId !=
                                                                        0
                                                                    ? Expanded(
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .appointmentList[index]
                                                                              .salonInfo!
                                                                              .address
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style: const TextStyle(
                                                                              fontSize: 11,
                                                                              color: ThemeProvider.blackColor),
                                                                        ),
                                                                      )
                                                                    : Expanded(
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .appointmentList[index]
                                                                              .individualInfo!
                                                                              .address
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style: const TextStyle(
                                                                              fontSize: 11,
                                                                              color: ThemeProvider.blackColor),
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: ThemeProvider
                                                              .backgroundColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      value
                                                              .appointmentList[
                                                                  index]
                                                              .items!
                                                              .services!
                                                              .isNotEmpty
                                                          ? Text(
                                                              'Services'.tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  fontSize: 12,
                                                                  color: ThemeProvider
                                                                      .blackColor),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                            value
                                                                .appointmentList[
                                                                    index]
                                                                .items!
                                                                .services!
                                                                .length,
                                                            (serviceIndex) =>
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
                                                                          .appointmentList[
                                                                              index]
                                                                          .items!
                                                                          .services![
                                                                              serviceIndex]
                                                                          .name
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'regular',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              ThemeProvider.blackColor),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: value.currencySide == 'left'
                                                                                ? value.currencySymbol + value.appointmentList[index].items!.services![serviceIndex].price.toString()
                                                                                : value.appointmentList[index].items!.services![serviceIndex].price.toString() + value.currencySymbol,
                                                                            style: const TextStyle(
                                                                                fontSize: 10,
                                                                                color: ThemeProvider.blackColor,
                                                                                decoration: TextDecoration.lineThrough),
                                                                          ),
                                                                          const TextSpan(
                                                                              text: ' '),
                                                                          TextSpan(
                                                                            text: value.currencySide == 'left'
                                                                                ? value.currencySymbol + value.appointmentList[index].items!.services![serviceIndex].off.toString()
                                                                                : value.appointmentList[index].items!.services![serviceIndex].off.toString() + value.currencySymbol,
                                                                            style: const TextStyle(
                                                                                fontSize: 10,
                                                                                color: ThemeProvider.blackColor,
                                                                                fontFamily: 'bold'),
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
                                                      value
                                                              .appointmentList[
                                                                  index]
                                                              .items!
                                                              .packages!
                                                              .isNotEmpty
                                                          ? Text(
                                                              'Packages'.tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  fontSize: 12,
                                                                  color: ThemeProvider
                                                                      .blackColor),
                                                            )
                                                          : const SizedBox(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                            value
                                                                .appointmentList[
                                                                    index]
                                                                .items!
                                                                .packages!
                                                                .length,
                                                            (packageIndex) =>
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
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
                                                                              .appointmentList[index]
                                                                              .items!
                                                                              .packages![packageIndex]
                                                                              .name
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'regular',
                                                                              fontSize: 10,
                                                                              color: ThemeProvider.blackColor),
                                                                        ),
                                                                        RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: value.currencySide == 'left' ? value.currencySymbol + value.appointmentList[index].items!.packages![packageIndex].price.toString() : value.appointmentList[index].items!.packages![packageIndex].price.toString() + value.currencySymbol,
                                                                                style: const TextStyle(fontSize: 10, color: ThemeProvider.blackColor, decoration: TextDecoration.lineThrough),
                                                                              ),
                                                                              const TextSpan(text: ' '),
                                                                              TextSpan(
                                                                                text: value.currencySide == 'left' ? value.currencySymbol + value.appointmentList[index].items!.packages![packageIndex].off.toString() : value.appointmentList[index].items!.packages![packageIndex].off.toString() + value.currencySymbol,
                                                                                style: const TextStyle(fontSize: 10, color: ThemeProvider.blackColor, fontFamily: 'bold'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: List.generate(
                                                                          value.appointmentList[index].items!.packages![packageIndex].services!.length,
                                                                          (packageServiceIndex) => Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  const Text('-', style: TextStyle(fontSize: 8, fontFamily: 'regular', color: ThemeProvider.blackColor)),
                                                                                  Text(
                                                                                    value.appointmentList[index].items!.packages![packageIndex].services![packageServiceIndex].name.toString(),
                                                                                    style: const TextStyle(fontSize: 8, fontFamily: 'regular', color: ThemeProvider.blackColor),
                                                                                  )
                                                                                ],
                                                                              )),
                                                                    )
                                                                  ],
                                                                )),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Grand Total :'.tr,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: 'bold',
                                                            color: ThemeProvider
                                                                .blackColor),
                                                      ),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? value.currencySymbol +
                                                                value
                                                                    .appointmentList[
                                                                        index]
                                                                    .grandTotal
                                                                    .toString()
                                                            : value
                                                                    .appointmentList[
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
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Appointment at :'.tr,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .appColor),
                                                      ),
                                                      Text(
                                                        '${value.appointmentList[index].saveDate} ${value.appointmentList[index].slot}',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      )
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/no-data.png',
                                          width: 60, height: 60),
                                      const SizedBox(height: 30),
                                      Text(
                                        'No New Appointment Found!'.tr,
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
                          child: value.appointmentListOld.isNotEmpty
                              ? Column(
                                  children: List.generate(
                                    value.appointmentListOld.length,
                                    (index) => Column(
                                      children: [
                                        Banner(
                                          message: value
                                              .statusName[value
                                                  .appointmentListOld[index]
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
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  blurRadius: 5.0,
                                                ),
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                value.onAppointment(value
                                                    .appointmentListOld[index]
                                                    .id as int);
                                              },
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      value.appointmentListOld[index]
                                                                  .salonId !=
                                                              0
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
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
                                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentListOld[index].salonInfo!.cover.toString()}'),
                                                                    placeholder:
                                                                        const AssetImage(
                                                                            "assets/images/placeholder.jpeg"),
                                                                    imageErrorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Image.asset(
                                                                          'assets/images/notfound.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              25);
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
                                                                      right:
                                                                          10),
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
                                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentListOld[index].individualInfo!.background.toString()}'),
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
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            25,
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
                                                            value.appointmentListOld[index]
                                                                        .salonId !=
                                                                    0
                                                                ? Text(
                                                                    value
                                                                        .appointmentListOld[
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
                                                                    '${value.appointmentListOld[index].individualInfo!.firstName} ${value.appointmentListOld[index].individualInfo!.lastName}',
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
                                                            Row(
                                                              children: [
                                                                value.appointmentListOld[index]
                                                                            .salonId !=
                                                                        0
                                                                    ? Expanded(
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .appointmentListOld[index]
                                                                              .salonInfo!
                                                                              .address
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style: const TextStyle(
                                                                              fontSize: 11,
                                                                              color: ThemeProvider.blackColor),
                                                                        ),
                                                                      )
                                                                    : Expanded(
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .appointmentListOld[index]
                                                                              .individualInfo!
                                                                              .address
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style: const TextStyle(
                                                                              fontSize: 11,
                                                                              color: ThemeProvider.blackColor),
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: ThemeProvider
                                                              .backgroundColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      value
                                                              .appointmentListOld[
                                                                  index]
                                                              .items!
                                                              .services!
                                                              .isNotEmpty
                                                          ? Text(
                                                              'Services'.tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  fontSize: 12,
                                                                  color: ThemeProvider
                                                                      .blackColor),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                            value
                                                                .appointmentListOld[
                                                                    index]
                                                                .items!
                                                                .services!
                                                                .length,
                                                            (serviceIndex) =>
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
                                                                          .appointmentListOld[
                                                                              index]
                                                                          .items!
                                                                          .services![
                                                                              serviceIndex]
                                                                          .name
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'regular',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              ThemeProvider.blackColor),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: value.currencySide == 'left'
                                                                                ? value.currencySymbol + value.appointmentListOld[index].items!.services![serviceIndex].price.toString()
                                                                                : value.appointmentListOld[index].items!.services![serviceIndex].price.toString() + value.currencySymbol,
                                                                            style: const TextStyle(
                                                                                fontSize: 10,
                                                                                color: ThemeProvider.blackColor,
                                                                                decoration: TextDecoration.lineThrough),
                                                                          ),
                                                                          const TextSpan(
                                                                              text: ' '),
                                                                          TextSpan(
                                                                            text: value.currencySide == 'left'
                                                                                ? value.currencySymbol + value.appointmentListOld[index].items!.services![serviceIndex].off.toString()
                                                                                : value.appointmentListOld[index].items!.services![serviceIndex].off.toString() + value.currencySymbol,
                                                                            style: const TextStyle(
                                                                                fontSize: 10,
                                                                                color: ThemeProvider.blackColor,
                                                                                fontFamily: 'bold'),
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
                                                      value
                                                              .appointmentListOld[
                                                                  index]
                                                              .items!
                                                              .packages!
                                                              .isNotEmpty
                                                          ? Text(
                                                              'Packages'.tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  fontSize: 12,
                                                                  color: ThemeProvider
                                                                      .blackColor),
                                                            )
                                                          : const SizedBox(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                            value
                                                                .appointmentListOld[
                                                                    index]
                                                                .items!
                                                                .packages!
                                                                .length,
                                                            (packageIndex) =>
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
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
                                                                              .appointmentListOld[index]
                                                                              .items!
                                                                              .packages![packageIndex]
                                                                              .name
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'regular',
                                                                              fontSize: 10,
                                                                              color: ThemeProvider.blackColor),
                                                                        ),
                                                                        RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: value.currencySide == 'left' ? value.currencySymbol + value.appointmentListOld[index].items!.packages![packageIndex].price.toString() : value.appointmentListOld[index].items!.packages![packageIndex].price.toString() + value.currencySymbol,
                                                                                style: const TextStyle(fontSize: 10, color: ThemeProvider.blackColor, decoration: TextDecoration.lineThrough),
                                                                              ),
                                                                              const TextSpan(text: ' '),
                                                                              TextSpan(
                                                                                text: value.currencySide == 'left' ? value.currencySymbol + value.appointmentListOld[index].items!.packages![packageIndex].off.toString() : value.appointmentListOld[index].items!.packages![packageIndex].off.toString() + value.currencySymbol,
                                                                                style: const TextStyle(fontSize: 10, color: ThemeProvider.blackColor, fontFamily: 'bold'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: List.generate(
                                                                          value.appointmentListOld[index].items!.packages![packageIndex].services!.length,
                                                                          (packageServiceIndex) => Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  const Text('-', style: TextStyle(fontSize: 8, fontFamily: 'regular', color: ThemeProvider.blackColor)),
                                                                                  Text(
                                                                                    value.appointmentListOld[index].items!.packages![packageIndex].services![packageServiceIndex].name.toString(),
                                                                                    style: const TextStyle(fontSize: 8, fontFamily: 'regular', color: ThemeProvider.blackColor),
                                                                                  )
                                                                                ],
                                                                              )),
                                                                    )
                                                                  ],
                                                                )),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Grand Total :'.tr,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: 'bold',
                                                            color: ThemeProvider
                                                                .blackColor),
                                                      ),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? value.currencySymbol +
                                                                value
                                                                    .appointmentListOld[
                                                                        index]
                                                                    .grandTotal
                                                                    .toString()
                                                            : value
                                                                    .appointmentListOld[
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
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Appointment at :'.tr,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .appColor),
                                                      ),
                                                      Text(
                                                        '${value.appointmentListOld[index].saveDate} ${value.appointmentListOld[index].slot}',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      )
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/no-data.png',
                                          width: 60, height: 60),
                                      const SizedBox(height: 30),
                                      Text(
                                        'No Past Appointment Found!'.tr,
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
                  )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/no-data.png',
                        width: 60, height: 60),
                    const SizedBox(height: 30),
                    TextButton(
                        onPressed: () {
                          value.onLoginRoutes();
                        },
                        child: Text(
                          'Opps, Please Login or Register first!'.tr,
                          style: const TextStyle(
                              fontFamily: 'bold',
                              color: ThemeProvider.appColor),
                        )),
                  ],
                ),
              ),
      );
    });
  }
}
