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
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/categories_model.dart';
import 'package:salon_user/app/backend/models/individual_info_model.dart';
import 'package:salon_user/app/backend/models/packages_model.dart';
import 'package:salon_user/app/backend/models/owner_reviews_model.dart';
import 'package:salon_user/app/backend/models/userinfo_model.dart';
import 'package:salon_user/app/backend/parse/specialist_parse.dart';
import 'package:salon_user/app/controller/chat_controller.dart';
import 'package:salon_user/app/controller/individual_checkout_controller.dart';
import 'package:salon_user/app/controller/individual_list_controller.dart';
import 'package:salon_user/app/controller/individual_packages_controller.dart';
import 'package:salon_user/app/controller/login_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialistController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final SpecialistParser parser;

  int tabID = 1;

  String title = 'Select Service'.tr;

  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];

  List<String> gallery = [];

  IndividualInfoModel _individualDetails = IndividualInfoModel();
  IndividualInfoModel get individualDetails => _individualDetails;

  UserInfoModel _userInfo = UserInfoModel();
  UserInfoModel get userInfo => _userInfo;

  List<CategoriesModel> _categoriesList = <CategoriesModel>[];
  List<CategoriesModel> get categoriesList => _categoriesList;

  List<PackagesModel> _packagesList = <PackagesModel>[];
  List<PackagesModel> get packagesList => _packagesList;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<OwnerReviewsModel> _ownerReviewsList = <OwnerReviewsModel>[];
  List<OwnerReviewsModel> get ownerReviewsList => _ownerReviewsList;

  String selectedService = '';
  String selectedServiceName = '';

  bool apiCalled = false;
  bool reviewsCalled = false;

  int individualId = 0;
  final Set<Marker> markers = {};
  String getDistance = '';
  SpecialistController({required this.parser});

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      debugPrint(tabController.index.toString());
      if (tabController.index == 2) {
        debugPrint('get reviews');
        reviewsCalled = false;
        update();
        getOwnerReviews();
      }
    });
    individualId = Get.arguments[0];
    getindividualDetails();
    debugPrint('individual id --> $individualId');
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  Future<void> getindividualDetails() async {
    var response = await parser.individualDetails({"id": individualId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      var salonCategories = myMap['categories'];
      var salonPackages = myMap['packages'];
      var user = myMap['userInfo'];

      _individualDetails = IndividualInfoModel();
      _userInfo = UserInfoModel();
      _categoriesList = [];
      _packagesList = [];

      IndividualInfoModel services = IndividualInfoModel.fromJson(body);
      _individualDetails = services;
      double storeDistance = 0.0;
      double totalMeters = 0.0;
      storeDistance = Geolocator.distanceBetween(
        double.tryParse(_individualDetails.lat.toString()) ?? 0.0,
        double.tryParse(_individualDetails.lng.toString()) ?? 0.0,
        double.tryParse(parser.getLat().toString()) ?? 0.0,
        double.tryParse(parser.getLng().toString()) ?? 0.0,
      );
      totalMeters = totalMeters + storeDistance;
      double distance = double.parse((storeDistance / 1000).toStringAsFixed(2));
      debugPrint(distance.toString());
      getDistance = distance.toString();
      if (individualDetails.images != 'NA' &&
          individualDetails.images != null &&
          individualDetails.images != '') {
        var imgs = jsonDecode(individualDetails.images!);
        gallery = [];
        if (imgs.length > 0) {
          imgs.forEach((element) {
            if (element != '') {
              gallery.add(element);
            }
          });
          update();
        }
      }

      UserInfoModel userDetails = UserInfoModel.fromJson(user);
      _userInfo = userDetails;

      salonCategories.forEach((data) {
        CategoriesModel categories = CategoriesModel.fromJson(data);
        _categoriesList.add(categories);
      });
      debugPrint(categoriesList.length.toString());

      salonPackages.forEach((data) {
        PackagesModel packages = PackagesModel.fromJson(data);
        _packagesList.add(packages);
      });
      debugPrint(packagesList.length.toString());

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getOwnerReviews() async {
    var response = await parser.getOwnerReviewsList({"id": individualId});
    reviewsCalled = true;
    _ownerReviewsList = [];
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      body.forEach((data) {
        OwnerReviewsModel reviews = OwnerReviewsModel.fromJson(data);
        _ownerReviewsList.add(reviews);
      });
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onServicesView(int id, String name) {
    Get.delete<IndividualListController>(force: true);
    Get.toNamed(AppRouter.getIndividualList(),
        arguments: [id, name, individualDetails.uid]);
  }

  void onPackagesDetails(int id, String name) {
    Get.delete<IndividualPackagesController>(force: true);
    Get.toNamed(AppRouter.getIndividualPackages(), arguments: [id, name]);
  }

  onMapCreated() {
    markers.add(
      Marker(
        markerId: const MarkerId('Id-1'),
        position: LatLng(
            individualDetails.lat as double, individualDetails.lng as double),
      ),
    );
  }

  Future<void> openMap() async {
    double latitude = individualDetails.lat as double;
    double longitude = individualDetails.lng as double;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    var url = Uri.parse(googleUrl);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> openWebsite() async {
    if (individualDetails.website.toString() != 'NA' ||
        individualDetails.website!.isEmpty ||
        individualDetails.website != null) {
      var url = Uri.parse(individualDetails.website.toString());
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    } else {
      showToast('No Website Found'.tr);
    }
  }

  Future<void> callIndividual() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: individualDetails.mobile.toString(),
    );
    await launchUrl(launchUri);
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: Environments.appName,
        linkUrl: individualDetails.website.toString(),
        chooserTitle: 'Share with'.tr);
  }

  void onChat() {
    debugPrint('on chat');
    if (parser.isLogin() == true) {
      Get.delete<ChatController>(force: true);
      Get.toNamed(AppRouter.getChatRoutes(), arguments: [
        individualDetails.uid.toString(),
        '${userInfo.firstName} ${userInfo.lastName}'
      ]);
    } else {
      Get.delete<LoginController>(force: true);
      Get.toNamed(AppRouter.getLoginRoute());
    }
  }

  void onCheckout() {
    Get.delete<IndividualCheckoutController>(force: true);
    Get.toNamed(AppRouter.getIndividualCheckout());
  }
}
