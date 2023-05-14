/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/bookedslot_model.dart';
import 'package:salon_user/app/backend/models/slots_model.dart';
import 'package:salon_user/app/backend/parse/individual_slot_parse.dart';
import 'package:salon_user/app/controller/individual_checkout_controller.dart';
import 'package:salon_user/app/controller/individual_payment_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';

class IndividualSlotController extends GetxController implements GetxService {
  final IndividualSlotParser parser;

  bool selected = false;
  String savedDate = '';
  List<String> bookedSlots = [];
  bool haveData = false;
  String selectedSlotIndex = '';
  DatePickerController controller = DatePickerController();
  DateTime selectedValue = DateTime.now();
  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];

  bool isChecked = false;

  bool apiCalled = false;
  String uid = '';

  SlotModel _slotList = SlotModel();
  SlotModel get slotList => _slotList;

  IndividualSlotController({required this.parser});

  @override
  void onInit() {
    super.onInit();

    if (Get.find<IndividualCheckoutController>()
            .savedInCart
            .services!
            .isNotEmpty ||
        Get.find<IndividualCheckoutController>()
            .savedInCart
            .packages!
            .isNotEmpty) {
      if (Get.find<IndividualCheckoutController>()
          .savedInCart
          .services!
          .isNotEmpty) {
        uid = Get.find<IndividualCheckoutController>()
            .savedInCart
            .services![0]
            .uid
            .toString();
      } else if (Get.find<IndividualCheckoutController>()
          .savedInCart
          .packages!
          .isNotEmpty) {
        uid = Get.find<IndividualCheckoutController>()
            .savedInCart
            .packages![0]
            .uid
            .toString();
      }

      var dayName = Jiffy().format("EEEE"); // Tuesday
      debugPrint(dayName);
      int index = dayList.indexOf(dayName);
      var date = Jiffy().format('yyyy-MM-dd');
      savedDate = date;
      update();
      getSlotsForBookings(index, date);
    } else {
      onBack();
    }
  }

  Future<void> getSlotsForBookings(int index, String date) async {
    var response = await parser.getSlots(
      {"week_id": index, "date": date, "uid": uid, "from": "individual"},
    );
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      var booked = myMap['bookedSlots'];
      _slotList = SlotModel();
      if (body != null) {
        haveData = true;
        SlotModel datas = SlotModel.fromJson(body);
        _slotList = datas;
        update();
      }

      if (booked != null) {
        bookedSlots = [];
        booked.forEach((element) {
          BookedSlotModel slot = BookedSlotModel.fromJson(element);
          bookedSlots.add(slot.slot.toString());
        });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Color getColor(Set<MaterialState> states) {
    return ThemeProvider.appColor;
  }

  bool isBooked(String slot) {
    return bookedSlots.contains(slot) ? true : false;
  }

  void onSelectSlot(String slot) {
    if (!bookedSlots.contains(slot)) {
      selectedSlotIndex = slot;
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onDateChange(DateTime date) {
    selectedSlotIndex = '';
    haveData = false;
    debugPrint(date.toString());
    var dayName = Jiffy(date).format("EEEE");
    var selectedDate = Jiffy(date).format('yyyy-MM-dd');
    savedDate = selectedDate;
    update();
    debugPrint(dayName);
    int index = dayList.indexOf(dayName);
    debugPrint(index.toString());
    getSlotsForBookings(index, selectedDate);
  }

  void onPayment() {
    if (selectedSlotIndex == '') {
      showToast('Please select Slots'.tr);
      return;
    }

    Get.delete<IndividualPaymentController>(force: true);
    Get.toNamed(AppRouter.getIndividualPayment());
  }
}
