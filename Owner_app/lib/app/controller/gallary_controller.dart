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
import 'package:ultimate_salon_owner_flutter/app/backend/models/individual_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/profile_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/gallary_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class GallaryController extends GetxController implements GetxService {
  final GallaryParser parser;

  ProfileModel _profileInfo = ProfileModel();
  ProfileModel get profileInfo => _profileInfo;

  IndividualInfoModel _individualInfo = IndividualInfoModel();
  IndividualInfoModel get individualInfo => _individualInfo;

  XFile? _selectedImage;
  List<String> gallery = [''];

  bool apiCalled = false;

  bool userType = true;

  GallaryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    userType = parser.getType();
    getCatebyId();
  }

  Future<void> getCatebyId() async {
    if (userType == true) {
      debugPrint('get id for salon');

      var response = await parser.getCateById();
      apiCalled = true;
      debugPrint(response.bodyString);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        var data = myMap['data'];
        ProfileModel profileData = ProfileModel.fromJson(data);
        _profileInfo = profileData;
        if (profileInfo.images != 'NA') {
          var images = jsonDecode(profileInfo.images.toString());
          images.forEach((element) {
            gallery.add(element);
          });
        }
        update();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      debugPrint('get id for individual');

      var response = await parser.getIndividualCateById();
      apiCalled = true;
      debugPrint(response.bodyString);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        var data = myMap['data'];
        IndividualInfoModel individualData = IndividualInfoModel.fromJson(data);
        _individualInfo = individualData;
        if (individualInfo.images != 'NA') {
          var images = jsonDecode(individualInfo.images.toString());
          images.forEach((element) {
            gallery.add(element);
          });
        }
        update();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void selectFromGalleryOthers(String kind) async {
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
            gallery.add(body['image_name']);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void deletePhoto(String name) {
    debugPrint(name);
    gallery.remove(name);
    update();
  }

  Future<void> onSave() async {
    if (userType == true) {
      debugPrint('for salon');

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
      gallery = gallery.where((element) => element != '').toList();

      var body = {
        "id": profileInfo.id,
        "images": gallery.isEmpty ? 'NA' : jsonEncode(gallery)
      };
      debugPrint(body.toString());
      Response response = await parser.updateSalon(body);
      Get.back();
      debugPrint(response.bodyString);
      if (response.statusCode == 200) {
        onBack();
        successToast('Gallery Updated');
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    } else {
      debugPrint('for individual');

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
      gallery = gallery.where((element) => element != '').toList();

      var body = {
        "id": individualInfo.id,
        "images": gallery.isEmpty ? 'NA' : jsonEncode(gallery)
      };
      debugPrint(body.toString());
      Response response = await parser.individualUpdate(body);
      Get.back();
      debugPrint(response.bodyString);
      if (response.statusCode == 200) {
        onBack();
        successToast('Gallery Updated');
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
