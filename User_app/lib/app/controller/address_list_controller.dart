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
import 'package:salon_user/app/backend/parse/address_list_parse.dart';
import 'package:salon_user/app/controller/individual_payment_controller.dart';
import 'package:salon_user/app/controller/new_address_controller.dart';
import 'package:salon_user/app/controller/payment_controller.dart';
import 'package:salon_user/app/controller/product_payment_controller.dart';
import 'package:salon_user/app/helper/router.dart';

class AddressListController extends GetxController implements GetxService {
  final AddressListParser parser;
  String title = 'Select Address'.tr;
  String actionFrom = '';

  String selectedAddressId = '';
  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;
  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];
  bool apiCalled = false;

  AddressListController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    actionFrom = Get.arguments[0];
    selectedAddressId = Get.arguments[1];
    update();
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
      if (actionFrom == 'product') {
        Get.find<ProductPaymentController>().getSavedAddress();
      } else if (actionFrom == 'salon') {
        Get.find<PaymentController>().getSavedAddress();
      } else if (actionFrom == 'individual') {
        Get.find<IndividualPaymentController>().getSavedAddress();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveAdd(String id) {
    selectedAddressId = id;
    update();
  }

  void saveAndClose() {
    if (actionFrom == 'product') {
      Get.find<ProductPaymentController>().getSavedAddress();
      Get.find<ProductPaymentController>().onSaveAddress(selectedAddressId);
    } else if (actionFrom == 'salon') {
      Get.find<PaymentController>().getSavedAddress();
      Get.find<PaymentController>().onSaveAddress(selectedAddressId);
    } else if (actionFrom == 'individual') {
      Get.find<IndividualPaymentController>().getSavedAddress();
      Get.find<IndividualPaymentController>().onSaveAddress(selectedAddressId);
    }
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onNewAddress() {
    Get.delete<NewAddressController>(force: true);
    Get.toNamed(AppRouter.getNewAddressRoutes(), arguments: ['new']);
  }
}
