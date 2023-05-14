/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/city_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/cities_categories_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/profile_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class CitiesCategoriesController extends GetxController implements GetxService {
  final CitiesCategoriesParser parser;

  String title = 'Select Cities'.tr;

  List<CityModal> _cityList = <CityModal>[];
  List<CityModal> get cityList => _cityList;

  String selectedCities = '';
  String selectedCitiesName = '';

  bool apiCalled = false;

  CitiesCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getAllCities();
    selectedCities = Get.arguments[0].toString();
  }

  Future<void> getAllCities() async {
    var response = await parser.getAllCities();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _cityList = [];
      body.forEach((data) {
        CityModal cities = CityModal.fromJson(data);
        _cityList.add(cities);
      });
      debugPrint(cityList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveCities(String id) {
    selectedCities = id;
    var name =
        _cityList.firstWhere((element) => element.id.toString() == id).name;
    selectedCitiesName = name as String;
    debugPrint('city selected');
    update();
  }

  Future<void> updateCity() async {
    if (selectedCities == '' || selectedCities.isEmpty) {
      showToast('Select Your Cities !');
      return;
    }
    Response response = await parser.updateCities(selectedCities);
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      successToast('City Updated');
      Get.find<ProfileCategoriesController>().getCateById();
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
}
