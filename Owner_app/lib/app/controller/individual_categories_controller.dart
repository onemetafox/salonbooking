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
import 'package:ultimate_salon_owner_flutter/app/backend/models/add_profile_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/individual_categories_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/individual_profile_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class IndividualprofileCategoriesController extends GetxController
    implements GetxService {
  final IndividualProfileCategoriesParser parser;

  bool apiCalled = false;

  List<AddProfileModel> _categories = <AddProfileModel>[];
  List<AddProfileModel> get categories => _categories;

  List<int> selectedCategories = [];

  bool type = true;

  IndividualprofileCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectCategories();
    if (Get.arguments[0] != null) {
      selectedCategories = [];
      var ids = Get.arguments[0].toString().split(',');
      selectedCategories = ids.map((data) => int.parse(data)).toList();
      debugPrint(selectedCategories.toString());
    }
  }

  Future<void> selectCategories() async {
    var response = await parser.selectCategories();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var cates = myMap['data'];
      _categories = [];
      cates.forEach((data) {
        AddProfileModel datas = AddProfileModel.fromJson(data);
        var index = selectedCategories.indexOf(datas.id as int);
        if (index >= 0) {
          datas.isChecked = true;
        } else {
          datas.isChecked = false;
        }
        _categories.add(datas);
      });
      debugPrint(categories.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStatus(bool status, int id) {
    debugPrint(status.toString());
    debugPrint(id.toString());
    var itemIndex = _categories.indexWhere((element) => element.id == id);
    _categories[itemIndex].isChecked = status;
    if (status == false) {
      // remove
      selectedCategories.remove(id);
    } else {
      selectedCategories.add(id);
      // add
    }
    debugPrint(selectedCategories.toString());
    update();
  }

  Future<void> updateCate() async {
    if (selectedCategories.isEmpty) {
      showToast('Please select one of the categories');
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
          ),
        ],
      ),
      barrierDismissible: false,
    );
    var response = await parser.updateCate(selectedCategories.join(','));
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Get.find<IndividualProfileController>().getCateById();
      successToast('Categories Updated');
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
