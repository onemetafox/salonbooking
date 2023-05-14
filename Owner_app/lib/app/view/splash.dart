/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/splash_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Get.find<SplashController>().initSharedData();
    _routing();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  void _routing() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        if (Get.find<SplashController>().getLanguageCode() != '') {
          var locale = Get.find<SplashController>().getLanguageCode();
          Get.updateLocale(Locale(locale));
        } else {
          var locale =
              Get.find<SplashController>().defaultLanguage.languageCode != '' &&
                      Get.find<SplashController>()
                              .defaultLanguage
                              .languageCode !=
                          ''
                  ? Locale(Get.find<SplashController>()
                      .defaultLanguage
                      .languageCode
                      .toString())
                  : Locale('en'.tr);
          Get.updateLocale(locale);
        }

        if (Get.find<SplashController>().parser.haveLoggedIn() == true) {
          Get.offNamed(AppRouter.getTabRoute());
        } else {
          Get.offNamed(AppRouter.getInitialRoute());
        }
        // if (Get.find<SplashController>().parser.isNewUser() == false) {
        //   Get.find<SplashController>().parser.saveWelcome(true);
        //   Get.offNamed(AppRouter.getInitialRoute());
        // } else {
        //   Get.find<SplashController>().parser.saveWelcome(true);
        //   Get.offNamed(AppRouter.getInitialRoute());
        // }
      } else {
        Get.toNamed(AppRouter.getErrorRoutes());
      }
    });
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      e;
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    bool isNotConnected = result != ConnectivityResult.wifi &&
        result != ConnectivityResult.mobile;
    if (isNotConnected) {
      showToast('No Internet Connection'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (value) {
      return Scaffold(
        body: Stack(alignment: AlignmentDirectional.center, children: [
          const Image(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          const Positioned(
            top: 100,
            child: Image(
              image: AssetImage('assets/images/logo_white.png'),
              fit: BoxFit.cover,
              height: 50,
              width: 50,
              alignment: Alignment.center,
            ), //CircularAvatar
          ),
          const Positioned(
            top: 180,
            child: Center(
              child: Text(
                Environments.appName,
                style: TextStyle(
                    color: ThemeProvider.whiteColor, fontFamily: 'bold'),
              ),
            ), //CircularAvatar
          ),
          const Positioned(
            bottom: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: ThemeProvider.whiteColor,
              ),
            ), //CircularAvatar
          ),
          Positioned(
            bottom: 20,
            child: Center(
              child: Text(
                'Developed By '.tr + Environments.companyName,
                style: const TextStyle(
                    color: ThemeProvider.whiteColor, fontFamily: 'bold'),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
