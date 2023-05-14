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
import 'package:skeletons/skeletons.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/slot_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class SlotScreen extends StatefulWidget {
  const SlotScreen({Key? key}) : super(key: key);

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SlotController>(
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
              'Slots'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ThemeProvider.blackColor,
                    backgroundColor: ThemeProvider.greenColor,
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  onPressed: () {
                    value.onAddNew();
                  },
                  child: Text(
                    'Add New'.tr,
                    style: const TextStyle(
                        color: ThemeProvider.whiteColor, fontFamily: 'bold'),
                  ),
                ),
              ),
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                    value.slotList.length,
                    (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: ThemeProvider.greyColor),
                                top: BorderSide(color: ThemeProvider.greyColor),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.dayList[
                                            value.slotList[index].weekId as int]
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 17, fontFamily: 'bold'),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            value.onEdit(value
                                                .slotList[index].id as int);
                                          },
                                          child: const Icon(
                                            Icons.edit_note,
                                            color: ThemeProvider.greenColor,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  content:
                                                      SingleChildScrollView(
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
                                                        Text('to delete Slots ?'
                                                            .tr),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ElevatedButton
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
                                                                            .circular(5),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  'Cancel'.tr,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ThemeProvider
                                                                        .whiteColor,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  value.onSlotDestroy(value
                                                                      .slotList[
                                                                          index]
                                                                      .id as int);
                                                                },
                                                                style: ElevatedButton
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
                                                                            .circular(5),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  'Delete'.tr,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ThemeProvider
                                                                        .whiteColor,
                                                                    fontSize:
                                                                        16,
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
                                          child: const Icon(
                                            Icons.delete,
                                            color: ThemeProvider.redColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Wrap(
                                children: List.generate(
                                    value.slotList[index].slots!.length,
                                    (subIndex) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Chip(
                                                backgroundColor: ThemeProvider
                                                    .backgroundColor,
                                                label: Text(
                                                  '${value.slotList[index].slots![subIndex].startTime} to ${value.slotList[index].slots![subIndex].endTime}',
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
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/delete.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 80,
                                                                  width: 80,
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  'Are you sure'
                                                                      .tr,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'semi-bold'),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                    'to delete Slots ?'
                                                                        .tr),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              ThemeProvider.backgroundColor,
                                                                          backgroundColor:
                                                                              ThemeProvider.redColor,
                                                                          minimumSize:
                                                                              const Size.fromHeight(35),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Cancel'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          value.onDistroy(
                                                                              index,
                                                                              subIndex);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              ThemeProvider.backgroundColor,
                                                                          backgroundColor:
                                                                              ThemeProvider.greenColor,
                                                                          minimumSize:
                                                                              const Size.fromHeight(35),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Delete'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontSize:
                                                                                16,
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
                                                          ThemeProvider
                                                              .redColor,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: ThemeProvider
                                                            .whiteColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ))),
                          ),
                        ]),
                  )),
                ),
        );
      },
    );
  }
}
