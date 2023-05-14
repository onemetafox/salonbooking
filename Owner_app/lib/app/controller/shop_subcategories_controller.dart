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
import 'package:ultimate_salon_owner_flutter/app/backend/models/sub_categories_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/shop_subcategories_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/create_products_controller.dart';

class ShopSubCategoriesController extends GetxController
    implements GetxService {
  final ShopSubCategoriesParser parser;

  List<SubCategoriesModel> _subCateList = <SubCategoriesModel>[];
  List<SubCategoriesModel> get subCateList => _subCateList;

  String id = '';
  String selectedSubCate = '';
  String selectedSubCateName = '';

  bool apiCalled = false;

  ShopSubCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments[0].toString();
    debugPrint(id);
    getProductsByCateId();
  }

  Future<void> getProductsByCateId() async {
    var param = {'id': id};
    var response = await parser.getProductsById(param);
    apiCalled = true;
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap.toString());
      var body = myMap['data'];
      _subCateList = [];
      body.forEach((data) {
        SubCategoriesModel subCate = SubCategoriesModel.fromJson(data);
        _subCateList.add(subCate);
      });
      debugPrint(_subCateList.length.toString());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveSubCate(String id) {
    selectedSubCate = id;
    var name =
        _subCateList.firstWhere((element) => element.id.toString() == id).name;
    selectedSubCateName = name as String;
    debugPrint('selected subcategories');
    update();
  }

  void saveAndClose() {
    debugPrint(selectedSubCate.toString());
    debugPrint(selectedSubCateName.toString());
    Get.find<CreateProductsController>()
        .onSaveSubCate(selectedSubCate, selectedSubCateName);
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
