/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/individual_slot_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class IndividualSlotScreen extends StatefulWidget {
  const IndividualSlotScreen({Key? key}) : super(key: key);

  @override
  State<IndividualSlotScreen> createState() => _IndividualSlotScreenState();
}

class _IndividualSlotScreenState extends State<IndividualSlotScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndividualSlotController>(
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
              'Slots'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Select Date'.tr,
                              style: const TextStyle(
                                  fontFamily: 'bold', fontSize: 14),
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
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
                          child: DatePicker(
                            DateTime.now(),
                            width: 60,
                            height: 80,
                            controller: value.controller,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: ThemeProvider.appColor,
                            selectedTextColor: Colors.white,
                            activeDates: List.generate(
                                7,
                                (index) =>
                                    DateTime.now().add(Duration(days: index))),
                            onDateChange: (date) {
                              value.onDateChange(date);
                            },
                          ),
                        ),
                        value.haveData == false
                            ? Center(
                                child: Text('No Slots Found'.tr),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Slots'.tr,
                                    style: const TextStyle(
                                        fontFamily: 'bold', fontSize: 14),
                                  ),
                                ],
                              ),
                        value.haveData == false
                            ? const SizedBox()
                            : Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                child: Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                    value.slotList.slots!.length,
                                    (i) => GestureDetector(
                                      onTap: () {
                                        value.onSelectSlot(
                                            '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: value.isBooked(
                                                  '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}')
                                              ? Colors.grey
                                              : value.selectedSlotIndex ==
                                                      '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}'
                                                  ? ThemeProvider.appColor
                                                  : Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.16),
                                            )
                                          ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        child: Text(
                                          '${value.slotList.slots![i].startTime} to ${value.slotList.slots![i].endTime}',
                                          style: TextStyle(
                                              color: value.isBooked(
                                                          '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}') ||
                                                      value.selectedSlotIndex ==
                                                          '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}'
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: InkWell(
            onTap: () {
              value.onPayment();
            },
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13.0),
              decoration: const BoxDecoration(
                color: ThemeProvider.appColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Make Payment'.tr,
                    style: const TextStyle(
                        color: ThemeProvider.whiteColor, fontSize: 17),
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
