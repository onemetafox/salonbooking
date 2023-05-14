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
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/categories_model.dart';
import 'package:salon_user/app/backend/parse/all_categories_parse.dart';
import 'package:salon_user/app/controller/categories_list_controller.dart';
import 'package:salon_user/app/helper/router.dart';

class AllCategoriesController extends GetxController implements GetxService {
  final AllCategoriesParser parser;

  List<CategoriesModel> _categoriesList = <CategoriesModel>[];
  List<CategoriesModel> get categoriesList => _categoriesList;

  bool apiCalled = false;

  AllCategoriesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    var response = await parser.getAllCategories();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _categoriesList = [];
      body.forEach((data) {
        CategoriesModel cateData = CategoriesModel.fromJson(data);
        _categoriesList.add(cateData);
      });
      debugPrint(categoriesList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onCategoriesList(int id, String name) {
    Get.delete<CategoriesListController>(force: true);
    Get.toNamed(AppRouter.getCategoriesListRoutes(), arguments: [id, name]);
  }
}
