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
import 'package:image_picker/image_picker.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/profile_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/timing_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/profile_categories_parser.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_timing_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/cities_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/salon_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class ProfileCategoriesController extends GetxController
    implements GetxService {
  final ProfileCategoriesParse parser;

  final salonNameTextEditor = TextEditingController();
  final aboutTextEditor = TextEditingController();
  final addressTextEditor = TextEditingController();
  final zipCodeTextEditor = TextEditingController();
  final latTextEditor = TextEditingController();
  final lngTextEditor = TextEditingController();

  ProfileModel _profileInfo = ProfileModel();
  ProfileModel get profileInfo => _profileInfo;

  XFile? _selectedImage;
  String cover = '';

  bool apiCalled = false;

  bool haveStylist = false;
  bool haveShop = false;
  bool haveHome = false;
  List<TimingModel> _timesList = <TimingModel>[];
  List<TimingModel> get timesList => _timesList;
  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];
  ProfileCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getCateById();
  }

  Future<void> getCateById() async {
    var response = await parser.getCateById();
    apiCalled = true;
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap.toString());
      _timesList = [];
      var data = myMap['data'];
      ProfileModel profileData = ProfileModel.fromJson(data);
      _profileInfo = profileData;
      cover = _profileInfo.cover.toString();
      haveStylist = _profileInfo.haveStylist == 1 ? true : false;
      haveShop = _profileInfo.haveShop == 1 ? true : false;
      haveHome = _profileInfo.serviceAtHome == 1 ? true : false;
      salonNameTextEditor.text = profileInfo.name.toString();
      aboutTextEditor.text = profileInfo.about.toString();
      addressTextEditor.text = profileInfo.address.toString();
      zipCodeTextEditor.text = profileInfo.zipcode.toString();
      latTextEditor.text = profileInfo.lat.toString();
      lngTextEditor.text = profileInfo.lng.toString();
      if (profileInfo.timing != 'NA') {
        var times = jsonDecode(profileInfo.timing.toString());
        times.forEach((element) {
          TimingModel datas = TimingModel.fromJson(element);
          _timesList.add(datas);
        });
      }
      parser.saveId(profileInfo.id.toString());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStylist(bool status) {
    haveStylist = status;
    update();
  }

  void updateShop(bool status) {
    haveShop = status;
    update();
  }

  void updateHome(bool status) {
    haveHome = status;
    update();
  }

  void onSelectCategories() {
    Get.delete<SalonCategoriesController>(force: true);
    Get.toNamed(AppRouter.getSalonCategoriesRoute(),
        arguments: [profileInfo.categories]);
  }

  void onSelectCities() {
    Get.delete<CitiesCategoriesController>(force: true);
    Get.toNamed(AppRouter.getCitiesCategoriesRoute(),
        arguments: [profileInfo.cid]);
  }

  void onSaveCities(String cid, String name) {
    debugPrint('got from service list');
    update();
  }

  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
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
          barrierDismissible: false);
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            cover = body['image_name'];
            debugPrint(cover);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  Future<void> updateSalon() async {
    if (salonNameTextEditor.text == '' ||
        salonNameTextEditor.text.isEmpty ||
        addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        latTextEditor.text == '' ||
        latTextEditor.text.isEmpty ||
        lngTextEditor.text == '' ||
        lngTextEditor.text.isEmpty ||
        zipCodeTextEditor.text == '' ||
        zipCodeTextEditor.text.isEmpty ||
        aboutTextEditor.text == '' ||
        aboutTextEditor.text.isEmpty ||
        cover == '' ||
        cover.isEmpty) {
      showToast('All fields are required!');
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

    var body = {
      "id": profileInfo.id,
      "name": salonNameTextEditor.text,
      "address": addressTextEditor.text,
      "lat": latTextEditor.text,
      "lng": lngTextEditor.text,
      "zipcode": zipCodeTextEditor.text,
      "about": aboutTextEditor.text,
      "cover": cover,
      "have_stylist": haveStylist == true ? 1 : 0,
      "have_shop": haveShop == true ? 1 : 0,
      "service_at_home": haveHome == true ? 1 : 0,
      "timing": _timesList.isNotEmpty ? jsonEncode(timesList) : 'NA'
    };
    debugPrint(body.toString());
    Response response = await parser.updateSalon(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      onBack();
      successToast('Update Salon');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  String getDayName(int dayNumber) {
    return dayList[dayNumber];
  }

  void onAddNewTiming() {
    Get.delete<AddTimingController>(force: true);
    Get.toNamed(AppRouter.getAddTimingRoute(), arguments: ['new']);
  }

  void onSaveTime(int dayNumber, String openTime, String closeTime) {
    debugPrint('get Data');
    var param = {
      "day": dayNumber,
      "open_time": openTime,
      "close_time": closeTime
    };
    TimingModel data = TimingModel.fromJson(param);
    _timesList.add(data);
    debugPrint(jsonEncode(timesList).toString());
    update();
  }

  void onEditTime(String dayName, String openTime, String closeTime) {
    Get.delete<AddTimingController>(force: true);
    Get.toNamed(AppRouter.getAddTimingRoute(),
        arguments: ['edit', dayName, openTime, closeTime]);
  }

  void updateTime(int dayNumber, String openTime, String closeTime) {
    debugPrint(dayNumber.toString() + openTime.toString() + closeTime);
    var index = _timesList.indexWhere((element) => element.day == dayNumber);
    debugPrint(index.toString());
    _timesList[index].day = dayNumber;
    _timesList[index].openTime = openTime;
    _timesList[index].closeTime = closeTime;
    update();
  }
}
