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
import 'package:salon_user/app/controller/choose_location_controller.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/theme.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  Widget getLanguages() {
    return PopupMenuButton(
      onSelected: (value) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: IconButton(
          icon: const Icon(Icons.translate),
          color: ThemeProvider.appColor,
          tooltip: "Save Todo and Retrun to List".tr,
          onPressed: () {},
        ),
      ),
      itemBuilder: (context) => AppConstants.languages
          .map((e) => PopupMenuItem<String>(
                value: e.languageCode.toString(),
                onTap: () {
                  var locale = Locale(e.languageCode.toString());
                  Get.updateLocale(locale);
                  Get.find<ChooseLocationController>()
                      .saveLanguage(e.languageCode);
                },
                child: Text(e.languageName.toString()),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseLocationController>(builder: (value) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeProvider.whiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          actions: <Widget>[getLanguages()],
        ),
        backgroundColor: ThemeProvider.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Access Your'.tr),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Location'.tr,
                style: const TextStyle(
                    color: ThemeProvider.appColor,
                    fontSize: 20,
                    fontFamily: 'semi-bold'),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/1.png',
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  value.getLocation();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ThemeProvider.whiteColor,
                  backgroundColor: ThemeProvider.appColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'USE CURRENT LOCATION'.tr,
                  style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 14,
                      letterSpacing: 1.1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  value.onChooseLocation();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ThemeProvider.greyColor,
                  backgroundColor: ThemeProvider.whiteColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'CHOOSE LOCATION'.tr,
                  style: const TextStyle(
                      color: ThemeProvider.appColor, letterSpacing: 1.1),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
