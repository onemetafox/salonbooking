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
import 'package:salon_user/app/backend/parse/add_review_parse.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';

class AddReviewController extends GetxController implements GetxService {
  final AddReviewParser parser;
  String type = '';
  String cover = '';
  String name = '';
  int id = 0;
  int ownerId = 0;

  bool apiCalled = false;
  double rate = 4.5;
  final notesEditor = TextEditingController();
  List<double?> rating = [];
  AddReviewController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    type = Get.arguments[0];
    cover = Get.arguments[1];
    name = Get.arguments[2];
    id = int.parse(Get.arguments[3].toString());

    if (type == 'owner') {
      getOwnerReviews();
    } else if (type == 'service') {
      ownerId = int.parse(Get.arguments[4].toString());
      apiCalled = true;
    } else if (type == 'package') {
      ownerId = int.parse(Get.arguments[4].toString());
      apiCalled = true;
    } else if (type == 'products') {
      getProductsReviews();
    }

    debugPrint(type);
    debugPrint(cover);
    debugPrint(name);
    debugPrint(id.toString());
    debugPrint(ownerId.toString());
    update();
  }

  Future<void> getOwnerReviews() async {
    Response response = await parser.getOwnerReviews({"id": id});
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic reviews = myMap["data"];
      rating = [];
      reviews.forEach((element) {
        rating.add(double.parse(element['rating'].toString()));
      });
      debugPrint(rating.length.toString());
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> getProductsReviews() async {
    Response response = await parser.getProductsReviews({"id": id});
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic reviews = myMap["data"];
      rating = [];
      reviews.forEach((element) {
        rating.add(double.parse(element['rating'].toString()));
      });
      debugPrint(rating.length.toString());
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void saveRating(double ratte) {
    rate = ratte;
    update();
  }

  Future<void> saveReview() async {
    if (notesEditor.text == '' || notesEditor.text.isEmpty) {
      showToast('Please add comments'.tr);
      return;
    }
    if (type == 'owner') {
      saveOwnerReview();
    } else if (type == 'service') {
      saveServiceReview();
    } else if (type == 'package') {
      savePackageReviews();
    } else if (type == 'products') {
      saveProductsReviews();
    }
  }

  Future<void> saveProductsReviews() async {
    rating.add(double.parse(rate.toString()));
    List<double> ratings = rating.map((e) => e!).cast<double>().toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / ratings.length;
      debugPrint(rate.toString());

      debugPrint(notesEditor.text);
      var param = {
        "uid": parser.getUID(),
        "product_id": id,
        "notes": notesEditor.text,
        "rating": rate,
        "status": 1
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
          barrierDismissible: false);
      Response response = await parser.saveProductReviews(param);
      Get.back();
      apiCalled = true;
      update();
      if (response.statusCode == 200) {
        var updateParam = {
          "id": id,
          'total_rating': rating.length,
          'rating': average.toStringAsFixed(2)
        };
        await parser.updateProductReviews(updateParam);
        successToast('Review Saved'.tr);
        onBack();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
    }
  }

  Future<void> savePackageReviews() async {
    debugPrint(rate.toString());

    debugPrint(notesEditor.text);
    var param = {
      "uid": parser.getUID(),
      "package_id": id,
      "freelancer_id": ownerId,
      "notes": notesEditor.text,
      "rating": rate,
      "status": 1
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
        barrierDismissible: false);
    Response response = await parser.savePackageReviews(param);
    Get.back();
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      successToast('Review Saved'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> saveOwnerReview() async {
    rating.add(double.parse(rate.toString()));
    List<double> ratings = rating.map((e) => e!).cast<double>().toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / ratings.length;
      debugPrint(rate.toString());

      debugPrint(notesEditor.text);
      var param = {
        "uid": parser.getUID(),
        "freelancer_id": id,
        "notes": notesEditor.text,
        "rating": rate,
        "status": 1
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
          barrierDismissible: false);
      Response response = await parser.saveOwnerReview(param);
      Get.back();
      apiCalled = true;
      update();
      if (response.statusCode == 200) {
        var updateParam = {
          "id": id,
          'total_rating': rating.length,
          'rating': average.toStringAsFixed(2)
        };
        await parser.updateOwnerReview(updateParam);
        successToast('Review Saved'.tr);

        onBack();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
    }
  }

  Future<void> saveServiceReview() async {
    debugPrint(rate.toString());

    debugPrint(notesEditor.text);
    var param = {
      "uid": parser.getUID(),
      "service_id": id,
      "freelancer_id": ownerId,
      "notes": notesEditor.text,
      "rating": rate,
      "status": 1
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
        barrierDismissible: false);
    Response response = await parser.saveServiceReviews(param);
    Get.back();
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      successToast('Review Saved'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
