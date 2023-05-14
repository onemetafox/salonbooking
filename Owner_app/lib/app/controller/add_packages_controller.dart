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
import 'package:ultimate_salon_owner_flutter/app/backend/models/packages_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_packages_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/packages_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/packages_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/packages_specialist_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class AddPackagesController extends GetxController implements GetxService {
  final AddPackagesParser parser;

  XFile? _selectedImage;
  String cover = '';

  bool userType = true;

  bool apiCalled = false;

  int salonId = 0;
  int individualId = 1;

  PackagesModel _packagesInfo = PackagesModel();
  PackagesModel get packagesInfo => _packagesInfo;

  List<String> gallery = ['', '', '', '', '', ''];

  String selectedServicesName = '';
  String selectedServicesId = '';

  String selectedSpecialistId = '';
  String selectedSpecialistName = '';

  String selectedCategories = '';
  List<String> savedCategories = [];

  String selectedSpecialist = '';
  List<String> savedSpecialist = [];

  String action = 'new';

  final packagesNameTextEditor = TextEditingController();
  final priceTextEditor = TextEditingController();
  final discountTextEditor = TextEditingController();
  final sellPriceTextEditor = TextEditingController();
  final descriptionTextEditor = TextEditingController();
  final durationTextEditor = TextEditingController();

  AddPackagesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    userType = parser.getType();
    if (Get.arguments[0] == 'edit') {
      action = 'edit';
      salonId = Get.arguments[1] as int;
      debugPrint('packages id --> $salonId');
      getById();
    } else {
      apiCalled = true;
    }
  }

  Future<void> onSave() async {
    if (packagesNameTextEditor.text == '' ||
        packagesNameTextEditor.text.isEmpty ||
        selectedCategories == '' ||
        selectedCategories.isEmpty ||
        durationTextEditor.text == '' ||
        durationTextEditor.text.isEmpty ||
        priceTextEditor.text == '' ||
        priceTextEditor.text.isEmpty ||
        discountTextEditor.text == '' ||
        discountTextEditor.text.isEmpty ||
        descriptionTextEditor.text == '' ||
        descriptionTextEditor.text.isEmpty ||
        cover == '' ||
        cover.isEmpty) {
      showToast('All fields are required!');
      return;
    }

    if (userType == true) {
      if (selectedSpecialist == '' || selectedSpecialist.isEmpty) {
        showToast('Please select specialist');
        return;
      }
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
      "uid": parser.getUId(),
      "package_from": userType == true ? 0 : 1,
      "service_id": selectedCategories,
      "specialist_ids": selectedSpecialist,
      "name": packagesNameTextEditor.text,
      "price": priceTextEditor.text,
      "off": sellPriceTextEditor.text,
      "discount": discountTextEditor.text,
      "duration": durationTextEditor.text,
      "descriptions": descriptionTextEditor.text,
      "cover": cover,
      "images": jsonEncode(gallery),
      "extra_field": 'NA',
    };
    debugPrint(body.toString());
    gallery = gallery.where((element) => element != '').toList();
    var response = await parser.onCreateProducts(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      successToast('Save Packages');
      Get.find<PackagesController>().getByPackagesId();
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
      _packagesInfo = PackagesModel();
      var body = myMap['data'];
      PackagesModel info = PackagesModel.fromJson(body);
      _packagesInfo = info;
      cover = _packagesInfo.cover.toString();
      selectedCategories = _packagesInfo.serviceId.toString();
      selectedSpecialist = _packagesInfo.specialistIds.toString();
      packagesNameTextEditor.text = _packagesInfo.name.toString();
      priceTextEditor.text = _packagesInfo.price.toString();
      sellPriceTextEditor.text = _packagesInfo.off.toString();
      discountTextEditor.text = _packagesInfo.discount.toString();
      durationTextEditor.text = _packagesInfo.duration.toString();
      descriptionTextEditor.text = _packagesInfo.descriptions.toString();

      for (var element in _packagesInfo.services!) {
        savedCategories.add(element.name.toString());
      }

      for (var element in _packagesInfo.specialist!) {
        savedSpecialist.add('${element.firstName} ${element.lastName}');
      }

      var images = jsonDecode(_packagesInfo.images.toString());
      if (images.length > 0) {
        int index = 0;
        images.forEach((element) {
          gallery[index] = element;
          index++;
        });
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onUpdate() async {
    if (packagesNameTextEditor.text == '' ||
        packagesNameTextEditor.text.isEmpty ||
        selectedCategories == '' ||
        selectedCategories.isEmpty ||
        durationTextEditor.text == '' ||
        durationTextEditor.text.isEmpty ||
        priceTextEditor.text == '' ||
        priceTextEditor.text.isEmpty ||
        discountTextEditor.text == '' ||
        discountTextEditor.text.isEmpty ||
        descriptionTextEditor.text == '' ||
        descriptionTextEditor.text.isEmpty ||
        cover == '' ||
        cover.isEmpty) {
      showToast('All fields are required!');
      return;
    }

    if (userType == true) {
      if (selectedSpecialist == '' || selectedSpecialist.isEmpty) {
        showToast('Please select specialist');
        return;
      }
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
      "id": salonId,
      "service_id": selectedCategories,
      "specialist_ids": selectedSpecialist,
      "name": packagesNameTextEditor.text,
      "price": priceTextEditor.text,
      "off": sellPriceTextEditor.text,
      "discount": discountTextEditor.text,
      "duration": durationTextEditor.text,
      "descriptions": descriptionTextEditor.text,
      "cover": cover,
      "images": jsonEncode(gallery),
      "extra_field": 'NA',
    };
    var response = await parser.updatePackages(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('packages update !');
      Get.find<PackagesController>().getByPackagesId();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onSaveCategory(String categoriesId, List<String> names) {
    selectedCategories = categoriesId;
    savedCategories = names;
    debugPrint('add categories $categoriesId');
    update();
  }

  void onSaveSpecialistCate(String specialistId, List<String> names) {
    selectedSpecialist = specialistId;
    savedSpecialist = names;
    debugPrint('add specialist $specialistId');
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

  void selectFromGalleryOthers(String kind, int index) async {
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
            gallery[index] = body['image_name'];
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void onRealPrice(var input) {
    if (input != '' && discountTextEditor.text != '') {
      double value = num.tryParse(input)!.toDouble();
      debugPrint(value.toString());
      double sellPriceFinal = num.tryParse(discountTextEditor.text)!.toDouble();
      if (sellPriceFinal > 0 && value > 1) {
        double discountPriceFinal =
            num.tryParse(discountTextEditor.text)!.toDouble();
        double realPrice = num.tryParse(priceTextEditor.text)!.toDouble();
        percentage(discountPriceFinal, realPrice);
      }
    }
  }

  void onDiscountPrice(var input) {
    if (input != '' && priceTextEditor.text != '') {
      double value = num.tryParse(input)!.toDouble();
      double realPrice = num.tryParse(priceTextEditor.text)!.toDouble();
      if (realPrice > 0 && value <= 99) {
        double discountPriceFinal =
            num.tryParse(discountTextEditor.text)!.toDouble();
        percentage(discountPriceFinal, realPrice);
      }
      if (value >= 99) {
        discountTextEditor.text = '';
        discountTextEditor.text = '99';
        showToast('Discount must be less than 100');
        update();
      }
    }
  }

  void percentage(double percent, double total) {
    double sum = (total * percent) / 100;
    sum = double.parse((sum).toStringAsFixed(2));
    debugPrint(sum.toString());
    double realPrice = num.tryParse(priceTextEditor.text)!.toDouble();
    sellPriceTextEditor.text = (realPrice - sum).toString();
    update();
  }

  void onSelectPackages() {
    Get.delete<PackagesCategoriesController>(force: true);
    Get.toNamed(AppRouter.getPackagesCategoriesRoute(),
        arguments: [selectedCategories, savedCategories]);
  }

  void onSelectSpecialist() {
    Get.delete<PackagesSpecialistController>(force: true);
    Get.toNamed(AppRouter.getPackagesSpecialistRoute(),
        arguments: [selectedSpecialist, savedSpecialist]);
  }
}
