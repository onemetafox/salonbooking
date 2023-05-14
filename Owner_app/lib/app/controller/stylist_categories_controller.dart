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
import 'package:ultimate_salon_owner_flutter/app/backend/models/add_profile_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/stylist_categories_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/add_stylist_controller.dart';

class StylistCategoriesController extends GetxController
    implements GetxService {
  final StylistCategoriesParser parser;

  bool apiCalled = false;

  List<AddProfileModel> _selectEditProfileList = <AddProfileModel>[];
  List<AddProfileModel> get selectEditProfileList => _selectEditProfileList;

  List<int> selectedCategories = [];
  List<String> selectedCateName = [];

  StylistCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectCategories();
    if (Get.arguments[0] != null && Get.arguments[0] != '') {
      var ids = Get.arguments[0].toString(); // 1,2,3,4;
      ids.split(',').forEach((element) {
        selectedCategories.add(int.parse(element));
      });
    }
  }

  Future<void> selectCategories() async {
    var response = await parser.selectCategories();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var cates = myMap['data'];
      _selectEditProfileList = [];
      cates.forEach((data) {
        AddProfileModel datas = AddProfileModel.fromJson(data);
        if (selectedCategories.contains(datas.id)) {
          datas.isChecked = true;
          selectedCateName.add(datas.name.toString());
        } else {
          datas.isChecked = false;
        }
        _selectEditProfileList.add(datas);
      });
      debugPrint(selectEditProfileList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStatus(bool status, int id, String name) {
    debugPrint(status.toString());
    debugPrint(id.toString());
    var itemIndex =
        _selectEditProfileList.indexWhere((element) => element.id == id);
    _selectEditProfileList[itemIndex].isChecked = status;
    if (status == false) {
      // remove
      selectedCategories.remove(id);
      selectedCateName.remove(name);
    } else {
      selectedCategories.add(id);
      selectedCateName.add(name);
      // add
    }
    debugPrint(selectedCategories.join(','));
    update();
  }

  Future<void> onAdd() async {
    Get.find<AddStylistController>()
        .onSaveCategory(selectedCategories.join(','), selectedCateName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
