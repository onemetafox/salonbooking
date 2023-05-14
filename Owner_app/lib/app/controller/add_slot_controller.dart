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
import 'package:jiffy/jiffy.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/slots_list_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/slots_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_slot_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/slot_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class AddSlotController extends GetxController implements GetxService {
  final AddSlotParser parser;

  String dayName = 'Sunday'.tr;

  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];
  String openTime = '';
  String closeTime = '';

  List<SlotsModel> _slotList = <SlotsModel>[];
  List<SlotsModel> get slotList => _slotList;

  SlotListModel _slotData = SlotListModel();
  SlotListModel get slotData => _slotData;

  String action = '';

  int slotId = 0;
  bool apiCalled = false;

  AddSlotController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    action = Get.arguments[0];
    if (action == 'update') {
      slotId = Get.arguments[1];
      getSlotData();
    } else {
      apiCalled = true;
    }
    _slotList = [];
  }

  Future<void> getSlotData() async {
    Response response = await parser.getSlotbyId(slotId);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var data = myMap['data'];
      _slotList = [];
      SlotListModel slotInfo = SlotListModel.fromJson(data);
      _slotData = slotInfo;
      dayName = dayList[_slotData.weekId as int];
      _slotList = _slotData.slots as List<SlotsModel>;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> openTimePicker() async {
    var context = Get.context as BuildContext;
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    openTime = Jiffy({
      "year": 2020,
      "month": 10,
      "day": 19,
      "hour": pickedTime!.hour,
      "minute": pickedTime.minute
    }).format("hh:mm a").toString();
    update();
  }

  Future<void> closeTimePicker() async {
    var context = Get.context as BuildContext;
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    closeTime = Jiffy({
      "year": 2020,
      "month": 10,
      "day": 19,
      "hour": pickedTime!.hour,
      "minute": pickedTime.minute
    }).format("hh:mm a").toString();
    update();
  }

  void addSlots() {
    if (openTime == '' || closeTime == '') {
      showToast('Please select time');
      return;
    }
    var isExist = _slotList.where((element) =>
        element.startTime == openTime && element.endTime == closeTime);
    if (isExist.isNotEmpty) {
      showToast('Already exist');
      return;
    }
    var param = {
      "start_time": openTime,
      "end_time": closeTime,
    };
    SlotsModel datas = SlotsModel.fromJson(param);
    _slotList.add(datas);
    update();
  }

  void onUpdateDayName(String name) {
    dayName = name;
    update();
  }

  Future<void> saveSlots() async {
    if (_slotList.isEmpty) {
      showToast('Slots are empty');
      return;
    }
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
      "uid": parser.getUID(),
      "week_id": dayList.indexOf(dayName),
      "slots": jsonEncode(slotList)
    };
    Response response = await parser.onCreateTimeSlot(param);
    Get.back();
    if (response.statusCode == 200) {
      Get.find<SlotController>().getList();
      onBack();
    } else if (response.statusCode == 500) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      showToast(myMap['message']);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateSlots() async {
    if (_slotList.isEmpty) {
      showToast('Slots are empty');
      return;
    }
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
      "id": slotId,
      "week_id": dayList.indexOf(dayName),
      "slots": jsonEncode(slotList)
    };
    Response response = await parser.onUpdateSlots(param);
    Get.back();
    if (response.statusCode == 200) {
      Get.find<SlotController>().getList();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onDestroy(int index) {
    debugPrint(index.toString());
    _slotList.removeAt(index);
    update();
  }
}
