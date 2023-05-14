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
import 'package:image_picker/image_picker.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/stylist_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_stylist_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/stylist_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/stylist_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class AddStylistController extends GetxController implements GetxService {
  final AddStylistParser parser;

  XFile? _selectedImage;
  String salonUid = '';
  String cover = '';

  String selectedCategories = '';
  List<String> savedCategories = [];

  int salonId = 0;

  bool apiCalled = false;

  String action = 'new';

  StylistModel _stylistInfo = StylistModel();
  StylistModel get stylistInfo => _stylistInfo;

  final firstNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();

  AddStylistController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] == 'edit') {
      action = 'edit';
      salonId = Get.arguments[1] as int;
      debugPrint('salon id --> $salonId');
      getById();
    } else {
      apiCalled = true;
    }
  }

  Future<void> saveSpecilaist() async {
    if (firstNameTextEditor.text == '' ||
        firstNameTextEditor.text.isEmpty ||
        lastNameTextEditor.text == '' ||
        lastNameTextEditor.text.isEmpty ||
        cover == '' ||
        cover.isEmpty ||
        selectedCategories == '' ||
        selectedCategories.isEmpty) {
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
      "salon_uid": parser.getUid(),
      "cate_id": selectedCategories,
      "cover": cover,
      "first_name": firstNameTextEditor.text,
      "last_name": lastNameTextEditor.text,
      "status": 1,
    };
    debugPrint(body.toString());
    var response = await parser.onCreateSpecialist(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      successToast('Save Specialist');
      Get.find<StylistController>().getBySalonId();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getById() async {
    var response = await parser.getByID({"id": salonId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _stylistInfo = StylistModel();
      var body = myMap['data'];
      StylistModel info = StylistModel.fromJson(body);
      _stylistInfo = info;
      selectedCategories = _stylistInfo.cateId as String;
      firstNameTextEditor.text = _stylistInfo.firstName.toString();
      lastNameTextEditor.text = _stylistInfo.lastName.toString();
      for (var element in _stylistInfo.webCatesData!) {
        savedCategories.add(element.name.toString());
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
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

  Future<void> onUpdateSpecialist() async {
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
      "cate_id": selectedCategories,
      "cover": cover,
      "first_name": firstNameTextEditor.text,
      "last_name": lastNameTextEditor.text,
      "id": salonId
    };
    var response = await parser.onUpdateService(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      onBack();
      successToast('services update !');
      Get.find<StylistController>().getBySalonId();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onSaveCategory(String categoriesId, List<String> names) {
    selectedCategories = categoriesId;
    savedCategories = names;
    debugPrint('add specialist categories $categoriesId');
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onSelectStylist() {
    Get.delete<StylistCategoriesController>(force: true);
    Get.toNamed(AppRouter.getStylistCategoriesRoute(),
        arguments: [selectedCategories]);
  }
}
