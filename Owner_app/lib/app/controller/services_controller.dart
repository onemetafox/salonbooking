/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/services_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/services_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_services_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class ServicesController extends GetxController implements GetxService {
  final ServicesParser parser;

  String title = 'Services';
  List<ServicesModel> _servicesList = <ServicesModel>[];
  List<ServicesModel> get servicesList => _servicesList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  bool apiCalled = false;

  ServicesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getServices();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  Future<void> getServices() async {
    var response = await parser
        .getServices({"id": parser.sharedPreferencesManager.getString('uid')});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _servicesList = [];
      body.forEach((element) {
        ServicesModel service = ServicesModel.fromJson(element);
        _servicesList.add(service);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateStatus(int id, int status) async {
    var body = {"status": status == 1 ? 0 : 1, "id": id};
    var response = await parser.onUpdateServices(body);
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Updated');
      getServices();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onAddNew() {
    Get.delete<AddServicesController>(force: true);
    Get.toNamed(AppRouter.getAddServicesRoute(), arguments: ['new']);
  }

  void onEdit(int id) {
    Get.delete<AddServicesController>(force: true);
    Get.toNamed(AppRouter.getAddServicesRoute(), arguments: ['edit', id]);
  }

  void onDestroy(int id) async {
    var param = {"id": id};
    debugPrint('id ---> $id');
    var response = await parser.servicesDestroy(param);
    if (response.statusCode == 200) {
      getServices();
      showToast('item remove successfully');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
