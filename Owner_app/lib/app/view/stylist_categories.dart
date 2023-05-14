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
import 'package:ultimate_salon_owner_flutter/app/controller/stylist_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class StylistCategoriesScreen extends StatefulWidget {
  const StylistCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<StylistCategoriesScreen> createState() => _StylistCategoriesScreen();
}

class _StylistCategoriesScreen extends State<StylistCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StylistCategoriesController>(
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
              'Select Stylist'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: List.generate(
                      20,
                      (index) => SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                          lines: 1,
                          spacing: 2,
                          lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 20,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width),
                        ),
                      ),
                    )),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        for (var item in value.selectEditProfileList)
                          CheckboxListTile(
                            title: Text(item.name.toString()),
                            checkColor: Colors.white,
                            activeColor: ThemeProvider.appColor,
                            value: item.isChecked,
                            onChanged: (status) {
                              // isChecked = value!;
                              value.updateStatus(status!, item.id as int,
                                  item.name.toString());
                            },
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
                  child: InkWell(
                    onTap: () {
                      value.onAdd();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ThemeProvider.greenColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
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
                  child: InkWell(
                    onTap: () {
                      value.onBack();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ThemeProvider.redColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel'.tr,
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
