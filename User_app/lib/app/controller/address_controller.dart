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
import 'package:salon_user/app/backend/models/address_model.dart';
import 'package:salon_user/app/backend/parse/address_parse.dart';
import 'package:salon_user/app/controller/new_address_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/toast.dart';

class AddressController extends GetxController implements GetxService {
  final AddressParser parser;

  String title = 'Select Address'.tr;

  String selectedAddressId = '';
  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;
  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  bool apiCalled = false;

  AddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getSavedAddress();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getSavedAddress(param);

    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var address = myMap['data'];
      _addressList = [];
      address.forEach((add) {
        AddressModel adds = AddressModel.fromJson(add);
        _addressList.add(adds);
      });
      debugPrint(addressList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveAdd(String id) {
    selectedAddressId = id;
    update();
  }

  void onAddNew() {
    Get.delete<NewAddressController>(force: true);
    Get.toNamed(AppRouter.getNewAddressRoutes(), arguments: ['new']);
  }

  void onEdit(int id) {
    Get.delete<NewAddressController>(force: true);
    Get.toNamed(AppRouter.getNewAddressRoutes(), arguments: ['update', id]);
  }

  void onDestroy(int id) async {
    var param = {"id": id};
    debugPrint('id ---> $id');
    var response = await parser.addressDestroy(param);
    if (response.statusCode == 200) {
      getSavedAddress();
      showToast('item remove successfully'.tr);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
