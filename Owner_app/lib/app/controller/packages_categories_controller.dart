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
import 'package:ultimate_salon_owner_flutter/app/backend/parse/packages_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_packages_controller.dart';

class PackagesCategoriesController extends GetxController
    implements GetxService {
  final PackagesCategoriesParser parser;

  String title = 'Packages'.tr;
  List<ServicesModel> _servicesList = <ServicesModel>[];
  List<ServicesModel> get servicesList => _servicesList;

  List<int> selectedServices = [];
  List<String> selectedServicesName = [];

  bool apiCalled = false;
  PackagesCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getServices();
    if (Get.arguments[0] != null && Get.arguments[0] != '') {
      var ids = Get.arguments[0].toString(); // 1,2,3,4;
      ids.split(',').forEach((element) {
        selectedServices.add(int.parse(element));
      });
    }

    if (Get.arguments[1] != null && Get.arguments[1] != '') {
      selectedServicesName = Get.arguments[1];
    }
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
        var index = selectedServices.indexOf(service.id as int);
        if (index >= 0) {
          service.isChecked = true;
        } else {
          service.isChecked = false;
        }
        _servicesList.add(service);
        debugPrint(response.bodyString.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStatus(bool status, int id) {
    debugPrint(status.toString());
    debugPrint(id.toString());
    var itemIndex = _servicesList.indexWhere((element) => element.id == id);
    _servicesList[itemIndex].isChecked = status;
    if (status == false) {
      // remove
      selectedServices.remove(id);
      selectedServicesName.remove('${_servicesList[itemIndex].name}');
    } else {
      selectedServices.add(id);
      selectedServicesName.add('${_servicesList[itemIndex].name}');
      // add
    }
    debugPrint(selectedServices.toString());
    update();
  }

  Future<void> onAdd() async {
    Get.find<AddPackagesController>()
        .onSaveCategory(selectedServices.join(','), selectedServicesName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
