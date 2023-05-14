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
import 'package:ultimate_salon_owner_flutter/app/controller/add_slot_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class AddSlotScreen extends StatefulWidget {
  const AddSlotScreen({Key? key}) : super(key: key);

  @override
  State<AddSlotScreen> createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSlotController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text(
              'Add Slots'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(
                                color: ThemeProvider.appColor,
                                style: BorderStyle.solid),
                          ),
                          child: DropdownButton<String>(
                            value: value.dayName,
                            isExpanded: true,
                            icon: const Icon(Icons.expand_more),
                            elevation: 16,
                            style:
                                const TextStyle(color: ThemeProvider.appColor),
                            underline: const SizedBox(),
                            onChanged: (String? newValue) {
                              debugPrint(newValue);
                              value.onUpdateDayName(newValue.toString());
                            },
                            items: <String>[
                              'Sunday'.tr,
                              'Monday'.tr,
                              'Tuesday'.tr,
                              'Wednesday'.tr,
                              'Thursday'.tr,
                              'Friday'.tr,
                              'Saturday'.tr
                            ].map<DropdownMenuItem<String>>((String selected) {
                              return DropdownMenuItem<String>(
                                value: selected,
                                child: Text(selected),
                              );
                            }).toList(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.openTimePicker();
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                  color: ThemeProvider.appColor,
                                  style: BorderStyle.solid),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                value.openTime == ''
                                    ? Text('Open Time'.tr)
                                    : Text(value.openTime.toString()),
                                const Icon(Icons.expand_more),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            value.closeTimePicker();
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                  color: ThemeProvider.appColor,
                                  style: BorderStyle.solid),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                value.closeTime == ''
                                    ? Text('Close Time'.tr)
                                    : Text(value.closeTime.toString()),
                                const Icon(Icons.expand_more),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Wrap(
                              children: List.generate(
                            value.slotList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Chip(
                                    backgroundColor:
                                        ThemeProvider.backgroundColor,
                                    label: Text(
                                      '${value.slotList[index].startTime} to ${value.slotList[index].endTime}',
                                      style: const TextStyle(
                                          fontFamily: 'regular'),
                                    ),
                                  ),
                                  Positioned(
                                    right: -10,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/delete.png',
                                                      fit: BoxFit.cover,
                                                      height: 80,
                                                      width: 80,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Are you sure'.tr,
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontFamily:
                                                              'semi-bold'),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('to delete this slot ?'
                                                        .tr),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .backgroundColor,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .redColor,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Cancel'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              value.onDestroy(
                                                                  index);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .backgroundColor,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .greenColor,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Delete'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ThemeProvider.redColor,
                                          child: Icon(
                                            Icons.close,
                                            color: ThemeProvider.whiteColor,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ThemeProvider.greenColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        value.addSlots();
                      },
                      child: Center(
                        child: Text(
                          'Add'.tr,
                          style: const TextStyle(
                              fontFamily: 'bold',
                              color: ThemeProvider.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ThemeProvider.appColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (value.action == 'create') {
                          value.saveSlots();
                        } else {
                          value.updateSlots();
                        }
                      },
                      child: Center(
                        child: Text(
                          'Save & Submit'.tr,
                          style: const TextStyle(
                              fontFamily: 'bold',
                              color: ThemeProvider.whiteColor),
                        ),
                      ),
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
