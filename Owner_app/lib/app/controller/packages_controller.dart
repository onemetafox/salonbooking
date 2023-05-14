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
import 'package:ultimate_salon_owner_flutter/app/backend/models/packages_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/packages_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_packages_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class PackagesController extends GetxController implements GetxService {
  final PackagesParser parser;

  String title = 'Packages'.tr;
  List<PackagesModel> _packagesList = <PackagesModel>[];
  List<PackagesModel> get packagesList => _packagesList;

  bool apiCalled = false;

  bool onEye = false;

  bool userType = true;

  PackagesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    userType = parser.getType();
    getByPackagesId();
  }

  Future<void> getByPackagesId() async {
    var response = await parser.getPackagesById(
        {"id": parser.sharedPreferencesManager.getString('uid')});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _packagesList = [];
      body.forEach((element) {
        PackagesModel packages = PackagesModel.fromJson(element);
        _packagesList.add(packages);
        debugPrint(response.bodyString.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onDestroy(int id) async {
    var param = {"id": id};
    debugPrint('id ---> $id');
    var response = await parser.packagesDestroy(param);
    if (response.statusCode == 200) {
      getByPackagesId();
      showToast('item remove successfully');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateStatus(int id, int status) async {
    var body = {"status": status == 1 ? 0 : 1, "id": id};
    var response = await parser.onUpdatePackages(body);
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Updated');
      getByPackagesId();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onAddPackages() {
    Get.delete<AddPackagesController>(force: true);
    Get.toNamed(AppRouter.getAddPackagesRoute(), arguments: ['new']);
  }

  void onEdit(int id) {
    Get.delete<AddPackagesController>(force: true);
    Get.toNamed(AppRouter.getAddPackagesRoute(), arguments: ['edit', id]);
  }
}
