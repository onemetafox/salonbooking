/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/appointment_model.dart';
import 'package:salon_user/app/backend/parse/booking_parse.dart';
import 'package:salon_user/app/controller/appointment_detail_controller.dart';
import 'package:salon_user/app/controller/login_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';

class BookingController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final BookingParser parser;

  List<AppointmentModel> _appointmentList = <AppointmentModel>[];
  List<AppointmentModel> get appointmentList => _appointmentList;

  List<AppointmentModel> _appointmentListOld = <AppointmentModel>[];
  List<AppointmentModel> get appointmentListOld => _appointmentListOld;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<String> statusName = [
    'Created',
    'Accepted',
    'Rejected',
    'Ongoing',
    'Completed',
    'Cancelled',
    'Refunded',
    'Delayed',
    'Panding Payment',
  ];
  BookingController({required this.parser});

  bool apiCalled = false;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    tabController = TabController(length: 2, vsync: this);
    if (parser.haveLoggedIn() == true) {
      getAppointmentById();
    }
  }

  Future<void> getAppointmentById() async {
    Response response = await parser.getAppointmentById();

    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _appointmentList = [];
      _appointmentListOld = [];
      body.forEach((data) {
        AppointmentModel appointment = AppointmentModel.fromJson(data);
        if (appointment.status == 0) {
          _appointmentList.add(appointment);
        } else {
          _appointmentListOld.add(appointment);
        }
      });
      debugPrint(jsonEncode(_appointmentList));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onAppointment(int id) {
    Get.delete<AppointmentDetailController>(force: true);
    Get.toNamed(AppRouter.getAppointmentDetailRoutes(), arguments: [id]);
  }

  void onLoginRoutes() {
    Get.delete<LoginController>(force: true);
    Get.toNamed(AppRouter.getLoginRoute());
  }
}
