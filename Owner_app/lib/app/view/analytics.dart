/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/analytics_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  TooltipBehavior? _tooltipBehavior;
  final ScrollController _scrollControllerAppointments = ScrollController();
  final ScrollController _scrollControllerProducts = ScrollController();
  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyticsController>(builder: (value) {
      Map<int, Widget> myTabs = <int, Widget>{
        0: Text(
          "Daily".tr,
          style: TextStyle(
              color:
                  Get.find<AnalyticsController>().segmentedControlGroupValue ==
                          0
                      ? ThemeProvider.whiteColor
                      : ThemeProvider.blackColor),
        ),
        1: Text("Monthly".tr,
            style: TextStyle(
                color: Get.find<AnalyticsController>()
                            .segmentedControlGroupValue ==
                        1
                    ? ThemeProvider.whiteColor
                    : ThemeProvider.blackColor)),
        2: Text("Yearly".tr,
            style: TextStyle(
                color: Get.find<AnalyticsController>()
                            .segmentedControlGroupValue ==
                        2
                    ? ThemeProvider.whiteColor
                    : ThemeProvider.blackColor)),
      };
      Map<int, Widget> myTabsProducts = <int, Widget>{
        0: Text(
          "Daily".tr,
          style: TextStyle(
              color: Get.find<AnalyticsController>()
                          .segmentedControlGroupValueProducts ==
                      0
                  ? ThemeProvider.whiteColor
                  : ThemeProvider.blackColor),
        ),
        1: Text("Monthly".tr,
            style: TextStyle(
                color: Get.find<AnalyticsController>()
                            .segmentedControlGroupValueProducts ==
                        1
                    ? ThemeProvider.whiteColor
                    : ThemeProvider.blackColor)),
        2: Text("Yearly".tr,
            style: TextStyle(
                color: Get.find<AnalyticsController>()
                            .segmentedControlGroupValueProducts ==
                        2
                    ? ThemeProvider.whiteColor
                    : ThemeProvider.blackColor)),
      };
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
              backgroundColor: ThemeProvider.appColor,
              iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Analyze'.tr,
                style: ThemeProvider.titleStyle,
              ),
              bottom: TabBar(
                unselectedLabelColor: ThemeProvider.blackColor,
                labelColor: ThemeProvider.appColor,
                indicatorColor: ThemeProvider.appColor,
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
                  Text('Appointment'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor)),
                  Text('Products Order'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor)),
                ],
              )),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                controller: _scrollControllerAppointments,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Earnings'.tr,
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'medium',
                            color: ThemeProvider.blackColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl(
                          groupValue: value.segmentedControlGroupValue,
                          children: myTabs,
                          thumbColor: ThemeProvider.appColor,
                          onValueChanged: (i) {
                            value.updateSegments(i as int);
                          }),
                    ),
                    const SizedBox(height: 20),
                    value.segmentedControlGroupValue == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        value.backMonth();
                                      },
                                      icon: const Icon(Icons.chevron_left)),
                                  Text(value.getName()),
                                  IconButton(
                                      onPressed: () {
                                        value.nextMonth();
                                      },
                                      icon: const Icon(Icons.chevron_right))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              value.dailyApiCalled == true
                                  ? _buildChart()
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: ThemeProvider.appColor,
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              value.list.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol} ${value.totalPrice}'
                                                  : '${value.totalPrice} ${value.currencySymbol}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold'),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Total'.toUpperCase().tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold'),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol} ${value.averagePrice}'
                                                  : '${value.averagePrice} ${value.currencySymbol}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontFamily: 'bold'),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Average'.toUpperCase().tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontFamily: 'bold'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              value.list.isNotEmpty
                                  ? Container(
                                      color: ThemeProvider.whiteColor,
                                      width: double.infinity,
                                      child: DataTable(
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'Day'.tr,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 10),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Bookings'.tr,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 10),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Earnings'.tr,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                        rows: <DataRow>[
                                          for (var item in value.list)
                                            DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text(
                                                    item.dayName.toString())),
                                                DataCell(Text(
                                                    item.count.toString())),
                                                DataCell(Text(value
                                                            .currencySide ==
                                                        'left'
                                                    ? '${value.currencySymbol} ${item.total}'
                                                    : '${item.total} ${value.currencySymbol}')),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          )
                        : value.segmentedControlGroupValue == 1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            value.backYear();
                                          },
                                          icon: const Icon(Icons.chevron_left)),
                                      Text(value.currenyYear.toString()),
                                      IconButton(
                                          onPressed: () {
                                            value.nextYear();
                                          },
                                          icon: const Icon(Icons.chevron_right))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.monthlyApiCalled == true
                                      ? _buildChartForMonths()
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                  value.monthList.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.totalPriceMonth}'
                                                      : '${value.totalPriceMonth} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Total'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.averagePriceMonth}'
                                                      : '${value.averagePriceMonth} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Average'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.monthList.isNotEmpty
                                      ? Container(
                                          color: ThemeProvider.whiteColor,
                                          width: double.infinity,
                                          child: DataTable(
                                            columns: <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Months'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Bookings'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Earnings'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                            rows: <DataRow>[
                                              for (var item in value.monthList)
                                                DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(Text(value
                                                            .monthsListNames[
                                                        item.dayName as int])),
                                                    DataCell(Text(
                                                        item.count.toString())),
                                                    DataCell(Text(value
                                                                .currencySide ==
                                                            'left'
                                                        ? '${value.currencySymbol} ${item.total}'
                                                        : '${item.total} ${value.currencySymbol}')),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.yearlyApiCalled == true
                                      ? _buildChartForYearly()
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                  value.yearlyList.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.totalPriceYearly}'
                                                      : '${value.totalPriceYearly} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Total'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.averagePriceYearly}'
                                                      : '${value.averagePriceYearly} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Average'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.yearlyList.isNotEmpty
                                      ? Container(
                                          color: ThemeProvider.whiteColor,
                                          width: double.infinity,
                                          child: DataTable(
                                            columns: <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Months'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Bookings'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Earnings'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                            rows: <DataRow>[
                                              for (var item in value.yearlyList)
                                                DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(Text(item.dayName
                                                        .toString())),
                                                    DataCell(Text(
                                                        item.count.toString())),
                                                    DataCell(Text(value
                                                                .currencySide ==
                                                            'left'
                                                        ? '${value.currencySymbol} ${item.total}'
                                                        : '${item.total} ${value.currencySymbol}')),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: _scrollControllerProducts,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Earnings'.tr,
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'medium',
                            color: ThemeProvider.blackColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl(
                          groupValue: value.segmentedControlGroupValueProducts,
                          children: myTabsProducts,
                          thumbColor: ThemeProvider.appColor,
                          onValueChanged: (i) {
                            value.updateSegmentsProducts(i as int);
                          }),
                    ),
                    const SizedBox(height: 20),
                    value.segmentedControlGroupValueProducts == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        value.backMonthProducts();
                                      },
                                      icon: const Icon(Icons.chevron_left)),
                                  Text(value.getNameProducts()),
                                  IconButton(
                                      onPressed: () {
                                        value.nextMonthProducts();
                                      },
                                      icon: const Icon(Icons.chevron_right))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              value.dailyApiCalledProducts == true
                                  ? _buildChartProducts()
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: ThemeProvider.appColor,
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              value.listProducts.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol} ${value.totalPriceProducts}'
                                                  : '${value.totalPriceProducts} ${value.currencySymbol}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold'),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Total'.toUpperCase().tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold'),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol} ${value.averagePriceProducts}'
                                                  : '${value.averagePriceProducts} ${value.currencySymbol}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontFamily: 'bold'),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Average'.toUpperCase().tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontFamily: 'bold'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              value.listProducts.isNotEmpty
                                  ? Container(
                                      color: ThemeProvider.whiteColor,
                                      width: double.infinity,
                                      child: DataTable(
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'Day'.tr,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 10),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Orders'.tr,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 10),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Earnings'.tr,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                        rows: <DataRow>[
                                          for (var item in value.listProducts)
                                            DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text(
                                                    item.dayName.toString())),
                                                DataCell(Text(
                                                    item.count.toString())),
                                                DataCell(Text(value
                                                            .currencySide ==
                                                        'left'
                                                    ? '${value.currencySymbol} ${item.total}'
                                                    : '${item.total} ${value.currencySymbol}')),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          )
                        : value.segmentedControlGroupValueProducts == 1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            value.backYearProducts();
                                          },
                                          icon: const Icon(Icons.chevron_left)),
                                      Text(
                                          value.currenyYearProducts.toString()),
                                      IconButton(
                                          onPressed: () {
                                            value.nextYearProducts();
                                          },
                                          icon: const Icon(Icons.chevron_right))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.monthlyApiCalledProducts == true
                                      ? _buildChartForMonthsProducts()
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                  value.monthListProducts.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.totalPriceMonthProducts}'
                                                      : '${value.totalPriceMonthProducts} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Total'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.averagePriceMonthProducts}'
                                                      : '${value.averagePriceMonthProducts} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Average'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.monthListProducts.isNotEmpty
                                      ? Container(
                                          color: ThemeProvider.whiteColor,
                                          width: double.infinity,
                                          child: DataTable(
                                            columns: <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Months'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Orders'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Earnings'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                            rows: <DataRow>[
                                              for (var item
                                                  in value.monthListProducts)
                                                DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(Text(value
                                                            .monthsListNames[
                                                        item.dayName as int])),
                                                    DataCell(Text(
                                                        item.count.toString())),
                                                    DataCell(Text(value
                                                                .currencySide ==
                                                            'left'
                                                        ? '${value.currencySymbol} ${item.total}'
                                                        : '${item.total} ${value.currencySymbol}')),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.yearlyApiCalledProducts == true
                                      ? _buildChartForYearlyProducts()
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                  value.yearlyListProducts.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.totalPriceYearlyProducts}'
                                                      : '${value.totalPriceYearlyProducts} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Total'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .appColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol} ${value.averagePriceYearlyProducts}'
                                                      : '${value.averagePriceYearlyProducts} ${value.currencySymbol}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Average'.toUpperCase().tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .greyColor,
                                                      fontFamily: 'bold'),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  value.yearlyListProducts.isNotEmpty
                                      ? Container(
                                          color: ThemeProvider.whiteColor,
                                          width: double.infinity,
                                          child: DataTable(
                                            columns: <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Months'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Orders'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Earnings'.tr,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                            rows: <DataRow>[
                                              for (var item
                                                  in value.yearlyListProducts)
                                                DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(Text(item.dayName
                                                        .toString())),
                                                    DataCell(Text(
                                                        item.count.toString())),
                                                    DataCell(Text(value
                                                                .currencySide ==
                                                            'left'
                                                        ? '${value.currencySymbol} ${item.total}'
                                                        : '${item.total} ${value.currencySymbol}')),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  SfCartesianChart _buildChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text:
              '${'Total number of bookings'.tr} ${Get.find<AnalyticsController>().getName()}',
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<AnalyticsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getWeekData(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildChartProducts() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text:
              '${'Total number of orders'.tr} ${Get.find<AnalyticsController>().getName()}',
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<AnalyticsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getWeekDataProducts(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildChartForMonths() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text:
              '${'Total number of bookings'.tr} ${Get.find<AnalyticsController>().currenyYear}',
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<AnalyticsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getMonthsData(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildChartForMonthsProducts() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text:
              '${'Total number of orders'.tr} ${Get.find<AnalyticsController>().currenyYear}',
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<AnalyticsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getMonthsDataProducts(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildChartForYearly() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Total number of bookings'.tr,
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<AnalyticsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getYearlyData(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildChartForYearlyProducts() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Total number of orders'.tr,
          textStyle: const TextStyle(fontSize: 10)),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat:
              '{value}${Get.find<AnalyticsController>().currencySymbol}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getYearlyDataProducts(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getWeekData() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<AnalyticsController>().list)
            ChartSampleData(
                x: item.dayName,
                y: item.total,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getWeekDataProducts() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<AnalyticsController>().listProducts)
            ChartSampleData(
                x: item.dayName,
                y: item.total,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getMonthsData() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<AnalyticsController>().monthList)
            ChartSampleData(
                x: Get.find<AnalyticsController>()
                    .monthsListNames[item.dayName as int],
                y: item.total,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getMonthsDataProducts() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<AnalyticsController>().monthListProducts)
            ChartSampleData(
                x: Get.find<AnalyticsController>()
                    .monthsListNames[item.dayName as int],
                y: item.total,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getYearlyData() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<AnalyticsController>().yearlyList)
            ChartSampleData(
                x: item.dayName.toString(),
                y: item.total,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getYearlyDataProducts() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          for (var item in Get.find<AnalyticsController>().yearlyListProducts)
            ChartSampleData(
                x: item.dayName.toString(),
                y: item.total,
                pointColor: ThemeProvider.appColor),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
