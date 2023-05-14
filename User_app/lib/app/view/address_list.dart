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
import 'package:salon_user/app/controller/address_list_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          bottomNavigationBar: value.addressList.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            value.saveAndClose();
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeProvider.greenColor,
                            ),
                            child: Center(
                              child: Text(
                                'Save'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeProvider.redColor,
                            ),
                            child: Center(
                              child: Text(
                                'Cancle'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              'Select Address'.tr,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: ThemeProvider.greenColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    value.onNewAddress();
                  },
                  child: Center(
                    child: Text(
                      'Add Address'.tr,
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'bold',
                          color: ThemeProvider.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: value.addressList.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: value.addressList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) => Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    horizontalTitleGap: 0,
                                    minVerticalPadding: 20,
                                    title: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Text(value.titles[value
                                                .addressList[i].title as int]
                                            .toString())),
                                    subtitle:
                                        Text('${value.addressList[i].address} '
                                            ' ${value.addressList[i].house} '
                                            ' ${value.addressList[i].landmark} '
                                            ' ${value.addressList[i].pincode}'),
                                    trailing: Radio(
                                      activeColor: ThemeProvider.appColor,
                                      value: value.addressList[i].id.toString(),
                                      groupValue: value.selectedAddressId,
                                      onChanged: (data) {
                                        value.saveAdd(data.toString());
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/no-data.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Text(
                                  'No Data Found!'.tr,
                                  style: const TextStyle(fontFamily: 'bold'),
                                ),
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
