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
import 'package:ultimate_salon_owner_flutter/app/backend/parse/stylist_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_stylist_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class StylistController extends GetxController implements GetxService {
  final StylistParser parser;

  String title = 'Services'.tr;
  List<SalonModel> _salonList = <SalonModel>[];
  List<SalonModel> get salonList => _salonList;

  bool apiCalled = false;

  bool onEye = false;

  StylistController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getBySalonId();
  }

  void clickOnEye(bool status) {
    onEye = status;
    update();
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
        _salonList.add(salon);
        debugPrint(response.bodyString.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onAddStylist() {
    Get.delete<AddStylistController>(force: true);
    Get.toNamed(AppRouter.getAddStylistRoute(), arguments: ['new']);
  }

  void onEdit(int id) {
    Get.delete<AddStylistController>(force: true);
    Get.toNamed(AppRouter.getAddStylistRoute(), arguments: ['edit', id]);
  }

  void onDestroy(int id) async {
    var param = {"id": id};
    debugPrint('id ---> $id');
    var response = await parser.salonDestroy(param);
    if (response.statusCode == 200) {
      getBySalonId();
      showToast('item remove successfully');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateStatus(int id, int status) async {
    var body = {"status": status == 1 ? 0 : 1, "id": id};
    var response = await parser.onUpdateService(body);
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Updated');
      getBySalonId();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
