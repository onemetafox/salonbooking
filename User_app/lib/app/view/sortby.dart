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
import 'package:salon_user/app/controller/sortby_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class SortByScreen extends StatefulWidget {
  const SortByScreen({Key? key}) : super(key: key);

  @override
  State<SortByScreen> createState() => _SortByScreenState();
}

class _SortByScreenState extends State<SortByScreen> {
  String radioItem = 'Customer Review';

  int id = 1;

  List<StylistList> fList = [
    StylistList(
      index: 1,
      name: "Customer Review".tr,
    ),
    StylistList(
      index: 2,
      name: "Low to High".tr,
    ),
    StylistList(
      index: 3,
      name: "High to Low".tr,
    ),
    StylistList(
      index: 4,
      name: "A to Z".tr,
    ),
    StylistList(
      index: 5,
      name: "Z to A".tr,
    ),
    StylistList(
      index: 6,
      name: "Discount".tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SortByController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: _buildAppBar(value),
          body: _buildBody(),
        );
      },
    );
  }

  AppBar _buildAppBar(value) {
    return AppBar(
      backgroundColor: ThemeProvider.appColor,
      iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 50,
      title: Text(
        'Sort By'.tr,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: ThemeProvider.titleStyle,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.check,
            color: ThemeProvider.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Column(
              children: fList
                  .map((data) => RadioListTile(
                        title: Text(data.name),
                        groupValue: id,
                        activeColor: ThemeProvider.appColor,
                        value: data.index,
                        onChanged: (val) {
                          setState(() {
                            radioItem = data.name;
                            id = data.index;
                          });
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class StylistList {
  String name;
  int index;
  StylistList({required this.name, required this.index});
}
