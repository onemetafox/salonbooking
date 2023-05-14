/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
// import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/address_model.dart';
import 'package:salon_user/app/backend/models/google_address_model.dart';
import 'package:salon_user/app/backend/parse/new_address_parse.dart';
import 'package:salon_user/app/controller/address_controller.dart';
import 'package:salon_user/app/controller/address_list_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';

class NewAddressController extends GetxController implements GetxService {
  final NewAddressParser parser;

  int title = 0;

  final addressTextEditor = TextEditingController();
  final houseTextEditor = TextEditingController();
  final landmarkTextEditor = TextEditingController();
  final pincodeTextEditor = TextEditingController();

  int addressId = 0;
  double lat = 0.0;
  double lng = 0.0;
  String action = 'new';

  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;
  bool apiCalled = false;

  NewAddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments[0] == 'update') {
      action = 'update';
      addressId = Get.arguments[1] as int;
      debugPrint('address id --> $addressId');
      getAddressById();
    } else {
      apiCalled = true;
    }
  }

  void onFilter(int choice) {
    title = choice;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void getLatLngFromAddress() async {
    if (addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        houseTextEditor.text == '' ||
        houseTextEditor.text.isEmpty ||
        landmarkTextEditor.text == '' ||
        landmarkTextEditor.text.isEmpty ||
        pincodeTextEditor.text == '' ||
        pincodeTextEditor.text.isEmpty) {
      showToast('All fields are required'.tr);
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

    var response = await parser.getLatLngFromAddress(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${addressTextEditor.text} ${houseTextEditor.text} ${landmarkTextEditor.text}${pincodeTextEditor.text}&key=${Environments.googleMapsKey}');
    debugPrint(response.bodyString);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      GoogleAddresModel address = GoogleAddresModel.fromJson(myMap);
      debugPrint(address.toString());
      if (address.results!.isNotEmpty) {
        debugPrint('ok');
        if (action == 'new') {
          debugPrint('create');
          lat = address.results![0].geometry!.location!.lat!;
          lng = address.results![0].geometry!.location!.lng!;
          saveAddress();
        } else {
          debugPrint('update');
          lat = address.results![0].geometry!.location!.lat!;
          lng = address.results![0].geometry!.location!.lng!;
          updateAddress();
        }
      } else {
        showToast("could not determine your location");
        update();
      }
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> saveAddress() async {
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
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": pincodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "status": 1
    };
    var response = await parser.saveAddress(body);
    Get.back();

    if (response.statusCode == 200) {
      Get.find<AddressController>().getSavedAddress();
      Get.find<AddressListController>().getSavedAddress();
      successToast('Successfully Added'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getAddressById() async {
    var param = {"id": addressId};

    Response response = await parser.getAddressByID(param);
    apiCalled = true;
    if (response.statusCode == 200) {
      _addressInfo = AddressModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      AddressModel datas = AddressModel.fromJson(body);
      _addressInfo = datas;
      addressTextEditor.text = _addressInfo.address.toString();
      houseTextEditor.text = _addressInfo.house.toString();
      landmarkTextEditor.text = _addressInfo.landmark.toString();
      pincodeTextEditor.text = _addressInfo.pincode.toString();
      title = _addressInfo.title as int;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> updateAddress() async {
    var body = {
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": pincodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "id": addressId
    };

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

    var response = await parser.updateAddress(body);
    Get.back();
    if (response.statusCode == 200) {
      Get.find<AddressController>().getSavedAddress();
      Get.find<AddressListController>().getSavedAddress();
      successToast('Successfully Updated'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
