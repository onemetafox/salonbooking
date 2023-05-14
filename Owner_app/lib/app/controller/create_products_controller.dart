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
import 'package:jiffy/jiffy.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/categories_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/products_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/sub_categories_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/create_products_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/products_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/shop_categories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/shop_subcategories_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';

class CreateProductsController extends GetxController implements GetxService {
  final CreateProductsParser parser;

  DateTime expDate = DateTime(2022, 12, 24);
  bool inGrams = false;
  bool inKG = false;
  bool inLiter = false;
  bool inPCs = false;
  bool inML = false;
  bool inHome = false;
  bool inSingle = false;
  bool inOffers = false;
  bool inStock = false;

  String selectedProductId = '';

  ProductsModel _productsInfo = ProductsModel();
  ProductsModel get productInfo => _productsInfo;

  String selectedCateId = '';
  String selectedCateName = '';

  String selectedSubId = '';
  String selectedSubName = '';

  int selectedOfferStatus = 1;
  int selectedStackStatus = 1;

  XFile? _selectedImage;
  String cover = '';

  bool apiCalled = false;

  List<String> gallery = ['', '', '', '', '', ''];

  final productNameTextEditor = TextEditingController();
  final productsPriceTextEditor = TextEditingController();
  final discountTextEditor = TextEditingController();
  final sellPriceTextEditor = TextEditingController();
  final descriptionTextEditor = TextEditingController();
  final gramTextEditor = TextEditingController();
  final kgTextEditor = TextEditingController();
  final pcsTextEditor = TextEditingController();
  final literTextEditor = TextEditingController();
  final mlTextEditor = TextEditingController();

  String type = 'create';
  CreateProductsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments[0];
    if (type == 'update') {
      selectedProductId = Get.arguments[1].toString();
      getProductById();
    } else {
      apiCalled = true;
    }
  }

  Future<void> getProductById() async {
    var response = await parser.getProductById(selectedProductId);
    apiCalled = true;
    update();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      debugPrint(myMap.toString());
      var data = myMap['data'];
      ProductsModel productData = ProductsModel.fromJson(data);
      _productsInfo = productData;
      cover = _productsInfo.cover.toString();
      productNameTextEditor.text = _productsInfo.name.toString();
      productsPriceTextEditor.text = _productsInfo.originalPrice.toString();
      sellPriceTextEditor.text = _productsInfo.sellPrice.toString();
      discountTextEditor.text = _productsInfo.discount.toString();
      inHome = productInfo.inHome == 1 ? true : false;
      inSingle = productInfo.isSingle == 1 ? true : false;
      inGrams = productInfo.haveGram == 1 ? true : false;
      inKG = productInfo.haveKg == 1 ? true : false;
      inPCs = productInfo.havePcs == 1 ? true : false;
      inLiter = productInfo.haveLiter == 1 ? true : false;
      inML = productInfo.haveMl == 1 ? true : false;
      selectedCateId = _productsInfo.cateId.toString();
      selectedSubId = _productsInfo.subCateId.toString();
      gramTextEditor.text = _productsInfo.gram.toString();
      kgTextEditor.text = _productsInfo.kg.toString();
      pcsTextEditor.text = productInfo.pcs.toString();
      literTextEditor.text = _productsInfo.liter.toString();
      mlTextEditor.text = _productsInfo.ml.toString();
      inOffers = _productsInfo.inOffer == 1 ? true : false;
      inStock = _productsInfo.inStock == 1 ? true : false;

      CategoryModel cateData = CategoryModel.fromJson(myMap['cateInfo']);
      selectedCateName = cateData.name.toString();

      SubCategoriesModel subCateData =
          SubCategoriesModel.fromJson(myMap['subCateInfo']);
      selectedSubName = subCateData.name.toString();

      var images = jsonDecode(_productsInfo.images.toString());
      expDate = DateTime.parse(_productsInfo.expDate.toString());
      if (images.length > 0) {
        int index = 0;
        images.forEach((element) {
          gallery[index] = element;
          index++;
        });
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateProduct() async {
    if (productNameTextEditor.text == '' ||
        productNameTextEditor.text.isEmpty ||
        productsPriceTextEditor.text == '' ||
        productsPriceTextEditor.text.isEmpty) {
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
      "id": selectedProductId,
      "cover": cover,
      "name": productNameTextEditor.text,
      "original_price": productsPriceTextEditor.text,
      "sell_price": sellPriceTextEditor.text,
      "discount": discountTextEditor.text,
      "in_home": inHome == true ? 1 : 0,
      "is_single": inSingle == true ? 1 : 0,
      "have_gram": inGrams == true ? 1 : 0,
      "have_kg": inKG == true ? 1 : 0,
      "have_pcs": inPCs == true ? 1 : 0,
      "have_liter": inLiter == true ? 1 : 0,
      "have_ml": inML == true ? 1 : 0,
      "cate_id": selectedCateId,
      "sub_cate_id": selectedSubId,
      "images": jsonEncode(gallery),
      "gram": inGrams == true ? gramTextEditor.text : 0,
      "kg": inKG == true ? kgTextEditor.text : 0,
      "pcs": inPCs == true ? pcsTextEditor.text : 0,
      "liter": inLiter == true ? literTextEditor.text : 0,
      "ml": inML == true ? mlTextEditor.text : 0,
      "in_offer": inOffers == true ? 1 : 0,
      "in_stock": inStock == true ? 1 : 0,
      "exp_date": Jiffy(expDate).format('yyyy-MM-dd').toString(),
      "rating": 0,
      "total_rating": 0,
    };

    debugPrint(body.toString());
    Response response = await parser.updateProducts(body);
    Get.back();
    debugPrint(response.toString());
    if (response.statusCode == 200) {
      onBack();
      Get.find<ProductsController>().getProductWFreelancer();
      successToast('Update Products');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onShopCategories() {
    Get.delete<ShopCategoriesController>(force: true);
    Get.toNamed(AppRouter.getShopCategoriesRoute(),
        arguments: [selectedCateId]);
  }

  void onShopSubCategories() {
    if (selectedCateId == '' || selectedCateId.isEmpty) {
      showToast('Please select category');
      return;
    }
    Get.delete<ShopSubCategoriesController>(force: true);
    Get.toNamed(AppRouter.getShopSubCategoriesRoute(),
        arguments: [selectedCateId]);
  }

  void updateinGrams(bool status) {
    inGrams = status;
    update();
  }

  void updateinKG(bool status) {
    inKG = status;
    update();
  }

  void updateinLiter(bool status) {
    inLiter = status;
    update();
  }

  void updateinPCs(bool status) {
    inPCs = status;
    update();
  }

  void updateinML(bool status) {
    inML = status;
    update();
  }

  void updateinHome(bool status) {
    inHome = status;
    update();
  }

  void updateinSingle(bool status) {
    inSingle = status;
    update();
  }

  void updateOfferStatus(int status) {
    selectedOfferStatus = status;
    update();
  }

  void updateStackStatus(int status) {
    selectedStackStatus = status;
    update();
  }

  void onSaveproductCate(String id, String name) {
    debugPrint(id);
    selectedCateId = id;
    selectedCateName = name;
    selectedSubId = '';
    selectedSubName = '';
    update();
  }

  void onSaveSubCate(String id, String name) {
    debugPrint(id);
    selectedSubId = id;
    selectedSubName = name;
    update();
  }

  Future<void> saveProducts() async {
    if (productNameTextEditor.text == '' ||
        productNameTextEditor.text.isEmpty ||
        productsPriceTextEditor.text == '' ||
        productsPriceTextEditor.text.isEmpty) {
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
      "freelacer_id": parser.getFreelancerId(),
      "cover": cover,
      "name": productNameTextEditor.text,
      "original_price": productsPriceTextEditor.text,
      "sell_price": sellPriceTextEditor.text,
      "discount": discountTextEditor.text,
      "in_home": inHome == true ? 1 : 0,
      "is_single": inSingle == true ? 1 : 0,
      "have_gram": inGrams == true ? 1 : 0,
      "have_kg": inKG == true ? 1 : 0,
      "have_pcs": inPCs == true ? 1 : 0,
      "have_liter": inLiter == true ? 1 : 0,
      "have_ml": inML == true ? 1 : 0,
      "cate_id": selectedCateId,
      "sub_cate_id": selectedSubId,
      "images": jsonEncode(gallery),
      "gram": inGrams == true ? gramTextEditor.text : 0,
      "kg": inKG == true ? kgTextEditor.text : 0,
      "pcs": inPCs == true ? pcsTextEditor.text : 0,
      "liter": inLiter == true ? literTextEditor.text : 0,
      "ml": inML == true ? mlTextEditor.text : 0,
      "in_offer": inOffers == true ? 1 : 0,
      "in_stock": inStock == true ? 1 : 0,
      "exp_date": Jiffy(expDate).format('yyyy-MM-dd').toString(),
      "rating": 0,
      "total_rating": 0,
    };
    debugPrint(body.toString());
    gallery = gallery.where((element) => element != '').toList();
    var response = await parser.onCreateProducts(body);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Get.find<ProductsController>().getProductWFreelancer();
      successToast('Save Products');
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onRealPrice(var input) {
    if (input != '' && discountTextEditor.text != '') {
      double value = num.tryParse(input)!.toDouble();
      debugPrint(value.toString());
      double sellPriceFinal = num.tryParse(discountTextEditor.text)!.toDouble();
      if (sellPriceFinal > 0 && value > 1) {
        double discountPriceFinal =
            num.tryParse(discountTextEditor.text)!.toDouble();
        double realPrice =
            num.tryParse(productsPriceTextEditor.text)!.toDouble();
        percentage(discountPriceFinal, realPrice);
      }
    }
  }

  void onDiscountPrice(var input) {
    if (input != '' && productsPriceTextEditor.text != '') {
      double value = num.tryParse(input)!.toDouble();
      double realPrice = num.tryParse(productsPriceTextEditor.text)!.toDouble();
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
    // sellPrice.text = sum.toString();
    double realPrice = num.tryParse(productsPriceTextEditor.text)!.toDouble();
    sellPriceTextEditor.text = (realPrice - sum).toString();
    update();
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

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> openTimePicker() async {
    var context = Get.context as BuildContext;
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: expDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ThemeProvider.appColor
                  .withOpacity(0.7), // header background color
              onPrimary: ThemeProvider.whiteColor, // header text color
              onSurface: ThemeProvider.blackColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ThemeProvider.appColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    newDate != null ? expDate = newDate : expDate;
    debugPrint(Jiffy(expDate).format('yyyy-MM-dd'));
    update();
  }
}
