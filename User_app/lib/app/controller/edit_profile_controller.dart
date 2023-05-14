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
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/profile_model.dart';
import 'package:salon_user/app/backend/parse/edit_profile_parse.dart';
import 'package:salon_user/app/controller/account_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParser parser;

  XFile? _selectedImage;

  String cover = '';

  ProfileModel _profileInfo = ProfileModel();
  ProfileModel get profileInfo => _profileInfo;

  final firstNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();
  int selectedGender = 1;
  final emailTextEditor = TextEditingController();
  final mobileTextEditor = TextEditingController();
  String countryCodeMobile = '+91';

  bool apiCalled = false;

  EditProfileController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getUserByID();
  }

  Future<void> getUserByID() async {
    var response = await parser.getUserByID({"id": parser.getUID()});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _profileInfo = ProfileModel();
      var body = myMap['data'];
      ProfileModel data = ProfileModel.fromJson(body);
      _profileInfo = data;

      firstNameTextEditor.text = _profileInfo.firstName.toString();
      lastNameTextEditor.text = _profileInfo.lastName.toString();
      selectedGender = _profileInfo.gender as int;
      countryCodeMobile = _profileInfo.countryCode!.toString();
      emailTextEditor.text = _profileInfo.email.toString();
      mobileTextEditor.text = _profileInfo.mobile.toString();
      cover = _profileInfo.cover.toString();
      debugPrint('*****************');
      debugPrint(cover);
      debugPrint('*****************');
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onUpdateInfo() async {
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
                  ),
                ),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    var body = {
      "id": parser.getUID(),
      "first_name": firstNameTextEditor.text,
      "last_name": lastNameTextEditor.text,
      "gender": selectedGender,
      "cover": cover,
      "country_code": countryCodeMobile,
      "mobile": mobileTextEditor.text,
    };
    debugPrint(body.toString());
    var response = await parser.onUpdateInfo(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      successToast('update'.tr);
      Get.find<AccountController>().changeInfo();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
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
                    ),
                  ),
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

  void updateGender(int status) {
    selectedGender = status;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void saveCountryCode(String code) {
    countryCodeMobile = '+$code';
    update();
  }
}
