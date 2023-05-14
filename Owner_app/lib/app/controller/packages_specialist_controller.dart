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
import 'package:ultimate_salon_owner_flutter/app/backend/models/salon_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/packages_specialist_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_packages_controller.dart';

class PackagesSpecialistController extends GetxController
    implements GetxService {
  final PackagesSpecialistParser parser;

  String title = 'Specialist'.tr;
  List<SalonModel> _salonList = <SalonModel>[];
  List<SalonModel> get salonList => _salonList;

  bool apiCalled = false;

  List<int> selectedSpecialist = [];
  List<String> selectedSpecialistName = [];

  PackagesSpecialistController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getBySalonId();
    if (Get.arguments[0] != null && Get.arguments[0] != '') {
      var ids = Get.arguments[0].toString(); // 1,2,3,4;
      ids.split(',').forEach((element) {
        selectedSpecialist.add(int.parse(element));
      });
    }
    if (Get.arguments[1] != null && Get.arguments[1] != '') {
      selectedSpecialistName = Get.arguments[1];
    }
  }

  Future<void> getBySalonId() async {
    var response = await parser
        .getBySalonId({"id": parser.sharedPreferencesManager.getString('uid')});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _salonList = [];
      body.forEach((element) {
        SalonModel salon = SalonModel.fromJson(element);
        var index = selectedSpecialist.indexOf(salon.id as int);
        if (index >= 0) {
          salon.isChecked = true;
        } else {
          salon.isChecked = false;
        }
        _salonList.add(salon);
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
    var itemIndex = _salonList.indexWhere((element) => element.id == id);
    _salonList[itemIndex].isChecked = status;
    if (status == false) {
      // remove
      selectedSpecialist.remove(id);
      selectedSpecialistName.remove(
          '${_salonList[itemIndex].firstName} ${_salonList[itemIndex].lastName}');
    } else {
      selectedSpecialist.add(id);
      selectedSpecialistName.add(
          '${_salonList[itemIndex].firstName} ${_salonList[itemIndex].lastName}');
      // add
    }
    debugPrint(selectedSpecialist.toString());
    update();
  }

  Future<void> onAdd() async {
    Get.find<AddPackagesController>().onSaveSpecialistCate(
        selectedSpecialist.join(','), selectedSpecialistName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
