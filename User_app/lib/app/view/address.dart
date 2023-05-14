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
import 'package:salon_user/app/controller/address_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
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
              'Address'.tr,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: ThemeProvider.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    value.onAddNew();
                  },
                  child: Center(
                    child: Text(
                      'Add New'.tr,
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'bold',
                          color: ThemeProvider.blackColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: List.generate(
                        value.addressList.length,
                        (index) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.titles[value
                                                    .addressList[index]
                                                    .title as int]
                                                .toString(),
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontSize: 14,
                                                fontFamily: 'semibold'),
                                          ),
                                          Text(
                                            '${value.addressList[index].address} ${value.addressList[index].house} ${value.addressList[index].landmark} ${value.addressList[index].pincode}',
                                            style: const TextStyle(
                                              color: ThemeProvider.greyColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onEdit(
                                          value.addressList[index].id as int);
                                    },
                                    child: const Icon(
                                      Icons.edit_note,
                                      color: ThemeProvider.appColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      value.onDestroy(
                                          value.addressList[index].id as int);
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
                  ),
                ),
        );
      },
    );
  }
}
