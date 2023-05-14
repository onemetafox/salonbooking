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
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  "assets/images/error.png",
                  fit: BoxFit.contain,
                ),
              ),
              Center(
                child: Text('Connection Failed'.tr),
              ),
              Center(
                child: Text('Could not connect to network'.tr),
              ),
              Center(
                child: Text('Please check and try again'.tr),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.offNamed(AppRouter.getInitialRoute());
                  },
                  child: Text(
                    "retry".tr.toUpperCase(),
                    style: const TextStyle(color: ThemeProvider.whiteColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
