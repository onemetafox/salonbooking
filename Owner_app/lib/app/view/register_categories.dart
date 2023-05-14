/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/register_categories_controller.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class RegisterCategoryScreen extends StatefulWidget {
  const RegisterCategoryScreen({super.key});

  @override
  State<RegisterCategoryScreen> createState() => _RegisterCategoryScreenState();
}

class _RegisterCategoryScreenState extends State<RegisterCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterCategoriesController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Served Category'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                  child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      value.saveAndClose();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeProvider.whiteColor,
                        backgroundColor: ThemeProvider.appColor,
                        shadowColor: ThemeProvider.blackColor,
                        elevation: 3,
                        shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                        padding: const EdgeInsets.all(0)),
                    child: Text('Save'.tr)),
              )),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          shadowColor: ThemeProvider.blackColor,
                          elevation: 3,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                          padding: const EdgeInsets.all(0)),
                      child: Text('Cancle'.tr)),
                ),
              )
            ],
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: ThemeProvider.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: ThemeProvider.blackColor.withOpacity(0.2),
                          offset: const Offset(0, 1),
                          blurRadius: 3),
                    ],
                  ),
                  child: Column(
                    children: [
                      for (var item in value.servedCategoriesList)
                        CheckboxListTile(
                          title: Text(item.name.toString()),
                          checkColor: Colors.white,
                          activeColor: ThemeProvider.appColor,
                          value: item.isChecked,
                          onChanged: (status) {
                            // isChecked = value!;
                            value.updateStatus(status!, item.id as int);
                          },
                        ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
