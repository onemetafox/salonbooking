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
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/profile_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/app_pages_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/contact_us_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/gallary_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/history_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/inbox_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/individual_profile_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/packages_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/products_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/profile_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/review_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/services_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/slot_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/stylist_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class ProfileController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final ProfileParser parser;

  bool type = true;

  ProfileController({required this.parser});

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    type = parser.getType();
    debugPrint('profile type is --> $type');
    tabController = TabController(length: 3, vsync: this);
  }

  void onHistory() {
    Get.delete<HistoryController>(force: true);
    Get.toNamed(AppRouter.getHistoryRoute());
  }

  void onSlot() {
    Get.delete<SlotController>(force: true);
    Get.toNamed(AppRouter.getSlotRoute());
  }

  void onServices() {
    Get.delete<ServicesController>(force: true);
    Get.toNamed(AppRouter.getServicesRoute());
  }

  void onStylist() {
    Get.delete<StylistController>(force: true);
    Get.toNamed(AppRouter.getStylistRoute());
  }

  void onProducts() {
    Get.delete<ProductsController>(force: true);
    Get.toNamed(AppRouter.getProductsRoute());
  }

  void onPackages() {
    Get.delete<PackagesController>(force: true);
    Get.toNamed(AppRouter.getPackagesRoute());
  }

  void onEditProfile() {
    if (type == true) {
      Get.delete<ProfileCategoriesController>(force: true);
      Get.toNamed(AppRouter.getProfileCategoriesRoute());
    } else {
      Get.delete<IndividualProfileController>(force: true);
      Get.toNamed(AppRouter.getIndividualProfileRoute());
    }
  }

  void onGallary() {
    Get.delete<GallaryController>(force: true);
    Get.toNamed(AppRouter.getGallaryRoute());
  }

  void onReview() {
    Get.delete<ReviewController>(force: true);
    Get.toNamed(AppRouter.getReviewRoute());
  }

  void onInbox() {
    Get.delete<InboxController>(force: true);
    Get.toNamed(AppRouter.getInboxRoute());
  }

  void onLanguages() {
    Get.toNamed(AppRouter.getLanguagesRoute());
  }

  void onContactUs() {
    Get.delete<ContactUsController>(force: true);
    Get.toNamed(AppRouter.getContactUsRoute());
  }

  void onAppPages(String name, String id) {
    debugPrint('$name = $id');
    Get.delete<AppPagesController>(force: true);
    Get.toNamed(AppRouter.getAppPagesRoute(),
        arguments: [name, id], preventDuplicates: false);
  }

  Future<void> onLogout() async {
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
    Response response = await parser.logout();
    Get.back();
    if (response.statusCode == 200) {
      parser.clearAccount();
      Get.toNamed(AppRouter.getInitialRoute());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
