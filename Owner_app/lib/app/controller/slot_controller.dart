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
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/slots_list_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/slot_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_slot_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class SlotController extends GetxController implements GetxService {
  final SlotParser parser;
  List<SlotListModel> _slotList = <SlotListModel>[];
  List<SlotListModel> get slotList => _slotList;
  bool apiCalled = false;

  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];
  SlotController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList() async {
    Response response = await parser.getSlots();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var data = myMap['data'];
      _slotList = [];
      data.forEach((element) {
        SlotListModel data = SlotListModel.fromJson(element);
        _slotList.add(data);
      });
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onAddNew() {
    Get.delete<AddSlotController>(force: true);
    Get.toNamed(AppRouter.getAddSlotRoute(), arguments: ['create']);
  }

  void onEdit(int id) {
    Get.delete<AddSlotController>(force: true);
    Get.toNamed(AppRouter.getAddSlotRoute(), arguments: ['update', id]);
  }

  Future<void> onDistroy(int index, int subIndex) async {
    debugPrint(index.toString());
    debugPrint(subIndex.toString());
    _slotList[index].slots!.removeAt(subIndex);
    Get.dialog(
      SimpleDialog(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const CircularProgressIndicator(
                color: ThemeProvider.appColor,
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                  child: Text(
                "Please wait".tr,
                style: const TextStyle(fontFamily: 'bold'),
              )),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );

    var param = {
      "id": _slotList[index].id,
      "week_id": _slotList[index].weekId,
      "slots": jsonEncode(_slotList[index].slots)
    };
    Response response = await parser.onUpdateSlots(param);
    Get.back();
    if (response.statusCode == 200) {
      getList();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onSlotDestroy(int id) async {
    var param = {"id": id};
    var response = await parser.destroyTimeSlot(param);
    if (response.statusCode == 200) {
      getList();
      showToast('Slot Remove Successfully');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
