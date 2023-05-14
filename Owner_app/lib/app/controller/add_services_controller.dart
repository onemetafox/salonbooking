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
import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_services_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/services_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/services_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class AddServicesController extends GetxController implements GetxService {
  final AddServicesParser parser;

  String title = 'Add Service'.tr;
  XFile? _selectedImage;

  List<String> gallery = ['', '', '', '', '', ''];

  String selectedServicesName = '';
  String selectedServicesId = '';
  final nameTextEditor = TextEditingController();
  final durationTextEditor = TextEditingController();
  final priceTextEditor = TextEditingController();
  final discountTextEditor = TextEditingController();
  final offTextEditor = TextEditingController();
  final descriptionsTextEditor = TextEditingController();
  int selectedStatus = 1;

  bool apiCalled = false;

  String cover = '';

  int serviceId = 0;
  String action = 'new';

  AddServicesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] == 'edit') {
      action = 'edit';
      serviceId = Get.arguments[1] as int;
      debugPrint('service id --> $serviceId');
      getServiceById();
    } else {
      apiCalled = true;
    }
  }

  void onSaveCategory(String id, String name) {
    selectedServicesId = id;
    selectedServicesName = name;
    debugPrint('got from service list');
    update();
  }

  Future<void> onSubmit() async {
    if (nameTextEditor.text == '' ||
        nameTextEditor.text.isEmpty ||
        selectedServicesId == '' ||
        selectedServicesId.isEmpty ||
        durationTextEditor.text == '' ||
        durationTextEditor.text.isEmpty ||
        priceTextEditor.text == '' ||
        priceTextEditor.text.isEmpty ||
        discountTextEditor.text == '' ||
        discountTextEditor.text.isEmpty ||
        descriptionsTextEditor.text == '' ||
        descriptionsTextEditor.text.isEmpty ||
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
      "uid": parser.getUID(),
      "name": nameTextEditor.text,
      "cate_id": selectedServicesId,
      "duration": durationTextEditor.text,
      "price": priceTextEditor.text,
      "off": offTextEditor.text,
      "discount": discountTextEditor.text,
      "images": jsonEncode(gallery),
      "cover": cover,
      "extra_field": 'NA',
      "status": selectedStatus,
      "descriptions": descriptionsTextEditor.text,
    };

    var response = await parser.onSubmit(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Get.find<ServicesController>().getServices();
      successToast('Services Added !');
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStatus(int status) {
    selectedStatus = status;
    update();
  }

  Future<void> getServiceById() async {
    var response = await parser.getServiceByID({"id": serviceId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      debugPrint(body.toString());
      cover = body['cover'];
      selectedServicesId = body['cate_id'].toString();
      nameTextEditor.text = body['name'];
      selectedServicesName = body['web_cates_data']['name'].toString();
      durationTextEditor.text = body['duration'].toString();
      priceTextEditor.text = body['price'].toString();
      discountTextEditor.text = body['discount'].toString();
      offTextEditor.text = body['off'].toString();
      descriptionsTextEditor.text = body['descriptions'];
      selectedStatus = body['status'];
      var imgs = jsonDecode(body['images']);
      gallery = [];
      imgs.forEach((element) {
        gallery.add(element.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onUpdateService() async {
    var body = {
      "name": nameTextEditor.text,
      "cate_id": selectedServicesId,
      "duration": durationTextEditor.text,
      "price": priceTextEditor.text,
      "off": offTextEditor.text,
      "discount": discountTextEditor.text,
      "images": jsonEncode(gallery),
      "cover": cover,
      "extra_field": 'NA',
      "status": selectedStatus,
      "descriptions": descriptionsTextEditor.text,
      "id": serviceId
    };
    var response = await parser.onUpdateService(body);
    Get.back();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Get.find<ServicesController>().getServices();
      successToast('services update !');
      onBack();
    } else {
      ApiChecker.checkApi(response);
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
    offTextEditor.text = (realPrice - sum).toString();
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
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

  void onServiceCategories() {
    Get.delete<ServicesCategoriesController>(force: true);
    Get.toNamed(AppRouter.getServicesCategoriesRoute());
    update();
  }
}
