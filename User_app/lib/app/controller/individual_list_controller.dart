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
import 'package:salon_user/app/backend/models/services_model.dart';
import 'package:salon_user/app/backend/parse/individual_list_parse.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/individual_checkout_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/toast.dart';

class IndividualListController extends GetxController implements GetxService {
  final IndividualListParser parser;

  String selectedServiceId = '';
  String selectedServiceName = '';
  String selectedUID = '';

  bool apiCalled = false;

  List<int> services = [];

  List<ServicesModel> _servicesList = <ServicesModel>[];
  List<ServicesModel> get servicesList => _servicesList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  IndividualListController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectedServiceId = Get.arguments[0].toString();
    debugPrint('selected services --> $selectedServiceId');
    selectedServiceName = Get.arguments[1].toString();
    debugPrint('selected servicesName --> $selectedServiceName');
    selectedUID = Get.arguments[2].toString();
    debugPrint('uid --> $selectedUID');
    getSalonDetails();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  Future<void> getSalonDetails() async {
    var response = await parser
        .getServicesById({"id": selectedServiceId, "uid": selectedUID});

    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _servicesList = [];

      body.forEach((data) {
        ServicesModel services = ServicesModel.fromJson(data);
        // services.isChecked = false;
        if (Get.find<ServiceCartController>()
            .checkServiceInCart(services.id as int)) {
          services.isChecked = true;
        } else {
          services.isChecked = false;
        }
        _servicesList.add(services);
      });
      debugPrint(servicesList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateServiceStatusInCart(int index, bool status) {
    debugPrint('service id $index');
    debugPrint('service status $status');
    if (Get.find<ServiceCartController>().savedInCart.services!.isEmpty &&
        Get.find<ServiceCartController>().savedInCart.packages!.isEmpty) {
      _servicesList[index].isChecked = status;
      if (status == true) {
        Get.find<ServiceCartController>()
            .addServiceToCart(_servicesList[index], 'individual');
      } else {
        Get.find<ServiceCartController>()
            .removeServiceFromCart(_servicesList[index].id as int);
      }
    } else if (Get.find<ServiceCartController>()
        .savedInCart
        .packages!
        .isNotEmpty) {
      int freelancerPackagesId =
          Get.find<ServiceCartController>().getPackageFreelancerId();
      if (freelancerPackagesId == _servicesList[index].uid) {
        _servicesList[index].isChecked = status;
        if (status == true) {
          Get.find<ServiceCartController>()
              .addServiceToCart(_servicesList[index], 'individual');
        } else {
          Get.find<ServiceCartController>()
              .removeServiceFromCart(_servicesList[index].id as int);
        }
      } else {
        showToast(
            'We already have service or package with other salon or with freelancer'
                .tr);
      }
    } else {
      int freelancerIdServices =
          Get.find<ServiceCartController>().getServiceFreelancerId();

      if (freelancerIdServices == _servicesList[index].uid) {
        _servicesList[index].isChecked = status;
        if (status == true) {
          Get.find<ServiceCartController>()
              .addServiceToCart(_servicesList[index], 'individual');
        } else {
          Get.find<ServiceCartController>()
              .removeServiceFromCart(_servicesList[index].id as int);
        }
      } else {
        showToast(
            'We already have service or package with other salon or with freelancer'
                .tr);
        update();
      }
    }
    Get.find<HomeController>().updateScreen();
    update();
  }

  void onCheckout() {
    Get.delete<IndividualCheckoutController>(force: true);
    Get.toNamed(AppRouter.getIndividualCheckout());
  }
}
