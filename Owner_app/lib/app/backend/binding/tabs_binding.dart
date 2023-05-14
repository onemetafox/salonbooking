/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/analytics_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/appointment_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/calendar_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/history_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/profile_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => TabsController(parser: Get.find()));
    Get.lazyPut(() => AppointmentController(parser: Get.find()));
    Get.lazyPut(() => HistoryController(parser: Get.find()));
    Get.lazyPut(() => AnalyticsController(parser: Get.find()));
    Get.lazyPut(() => CalendarsController(parser: Get.find()));
    Get.lazyPut(() => ProfileController(parser: Get.find()));
  }
}
