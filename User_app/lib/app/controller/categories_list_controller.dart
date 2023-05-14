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
import 'package:salon_user/app/backend/models/individual_categories_model.dart';
import 'package:salon_user/app/backend/models/salon_categories_model.dart';
import 'package:salon_user/app/backend/parse/categories_list_parse.dart';
import 'package:salon_user/app/controller/services_controller.dart';
import 'package:salon_user/app/controller/specialist_controller.dart';
import 'package:salon_user/app/helper/router.dart';

class CategoriesListController extends GetxController implements GetxService {
  final CategoriesListParser parser;

  List<IndividualCategoriesModel> _individualCateList =
      <IndividualCategoriesModel>[];
  List<IndividualCategoriesModel> get individualCateList => _individualCateList;

  List<SalonCategoriesModel> _salonCateList = <SalonCategoriesModel>[];
  List<SalonCategoriesModel> get salonCateList => _salonCateList;

  String selectedCateId = '';
  String selectedCateName = '';

  bool apiCalled = false;

  bool haveData = false;
  CategoriesListController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectedCateId = Get.arguments[0].toString();
    selectedCateName = Get.arguments[1].toString();
    update();
    debugPrint(selectedCateId);
    getDataFromCategories();
  }

  Future<void> getDataFromCategories() async {
    var param = {
      "lat": parser.getLat(),
      "lng": parser.getLng(),
      "id": selectedCateId
    };
    Response response = await parser.getDataFromCategories(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var individualData = myMap['individual'];
      var salonData = myMap['salon'];

      _individualCateList = [];
      _salonCateList = [];
      individualData.forEach((data) {
        IndividualCategoriesModel individual =
            IndividualCategoriesModel.fromJson(data);
        _individualCateList.add(individual);
      });
      debugPrint(individualCateList.length.toString());

      salonData.forEach((data) {
        SalonCategoriesModel salon = SalonCategoriesModel.fromJson(data);
        _salonCateList.add(salon);
      });
      debugPrint(salonCateList.length.toString());
      if (_salonCateList.isEmpty && _individualCateList.isEmpty) {
        haveData = false;
      } else {
        haveData = true;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onServices(int uid) {
    Get.delete<ServicesController>(force: true);
    Get.toNamed(AppRouter.getServicesRoutes(), arguments: [uid]);
  }

  void onSpecialist(int uid) {
    Get.delete<SpecialistController>(force: true);
    Get.toNamed(AppRouter.getSpecialistRoutes(), arguments: [uid]);
  }
}
