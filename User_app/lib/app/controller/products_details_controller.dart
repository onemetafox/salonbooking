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
import 'package:salon_user/app/backend/models/cate_info_model.dart';
import 'package:salon_user/app/backend/models/products_list_model.dart';
import 'package:salon_user/app/backend/models/sold_by_model.dart';
import 'package:salon_user/app/backend/models/sub_cate_info_model.dart';
import 'package:salon_user/app/backend/parse/products_details_parse.dart';
import 'package:salon_user/app/controller/cart_controller.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/top_products_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/toast.dart';

class ProductsDetailsController extends GetxController implements GetxService {
  final ProductsDetailsParser parser;

  ProductsListModel _productsList = ProductsListModel();
  ProductsListModel get productsList => _productsList;

  CateInfoModel _cateInfo = CateInfoModel();
  CateInfoModel get cateInfo => _cateInfo;

  List<ProductsListModel> _relatedList = <ProductsListModel>[];
  List<ProductsListModel> get relatedList => _relatedList;

  SubCateInfoModel _subCateInfo = SubCateInfoModel();
  SubCateInfoModel get subCateInfo => _subCateInfo;

  SoldByModel _soldByInfo = SoldByModel();
  SoldByModel get soldByInfo => _soldByInfo;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  String selectedproductsId = '';

  bool apiCalled = false;

  bool isOpen = false;

  ProductsDetailsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectedproductsId = Get.arguments[0].toString();
    update();
    debugPrint('products id ==> $selectedproductsId');
    getProducts();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
  }

  void onRateExpand() {
    isOpen = !isOpen;
    update();
  }

  Future<void> getProducts() async {
    var param = {
      "id": selectedproductsId,
    };
    Response response = await parser.getProductsInfo(param);
    apiCalled = true;
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      var cateInfo = myMap['cateInfo'];
      var subCateInfo = myMap['subCateInfo'];
      var soldBy = myMap['soldby'];
      var related = myMap['related'];

      _relatedList = [];
      related.forEach((data) {
        ProductsListModel relatedinfo = ProductsListModel.fromJson(data);
        _relatedList.add(relatedinfo);
      });
      debugPrint(relatedList.length.toString());

      _productsList = ProductsListModel();
      ProductsListModel products = ProductsListModel.fromJson(body);
      _productsList = products;

      if (Get.find<ProductCartController>()
              .checkProductInCart(_productsList.id as int) ==
          true) {
        debugPrint('Chhe HOo');
        _productsList.quantity = Get.find<ProductCartController>()
            .getQuantity(_productsList.id as int);
        debugPrint(_productsList.quantity.toString());
      } else {
        _productsList.quantity = 0;
      }

      _cateInfo = CateInfoModel();
      CateInfoModel categories = CateInfoModel.fromJson(cateInfo);
      _cateInfo = categories;

      _subCateInfo = SubCateInfoModel();
      SubCateInfoModel subCategories = SubCateInfoModel.fromJson(subCateInfo);
      _subCateInfo = subCategories;

      _soldByInfo = SoldByModel();
      SoldByModel soldinfo = SoldByModel.fromJson(soldBy);
      _soldByInfo = soldinfo;

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  onCheckout() {
    Get.delete<CartController>(force: true);
    Get.toNamed(AppRouter.getCartRoutes());
  }

  void updateProductQuantity() {
    _productsList.quantity = _productsList.quantity + 1;
    Get.find<ProductCartController>().addQuantity(_productsList);
    Get.find<HomeController>().checkCartData();
    Get.find<TopProductsControllrer>().checkCartData();
    update();
  }

  void updateProductQuantityRemove() {
    if (_productsList.quantity == 1) {
      _productsList.quantity = 0;
      Get.find<ProductCartController>().removeItem(_productsList);
    } else {
      _productsList.quantity = _productsList.quantity - 1;
      Get.find<ProductCartController>().addQuantity(_productsList);
    }
    Get.find<HomeController>().checkCartData();
    Get.find<TopProductsControllrer>().checkCartData();
    update();
  }

  double getTotal() {
    return productsList.discount! > 0
        ? productsList.sellPrice! * productsList.quantity
        : productsList.originalPrice! * productsList.quantity;
  }

  void addToCart() {
    if (Get.find<ProductCartController>().savedInCart.isEmpty) {
      _productsList.quantity = 1;
      Get.find<ProductCartController>().addItem(_productsList);
      Get.find<HomeController>().checkCartData();
      Get.find<TopProductsControllrer>().checkCartData();
      update();
    } else {
      int freelancerId =
          Get.find<ProductCartController>().getFreelancerId(_productsList);
      if (freelancerId == _productsList.freelacerId) {
        _productsList.quantity = 1;
        Get.find<ProductCartController>().addItem(_productsList);
        Get.find<HomeController>().checkCartData();
        Get.find<TopProductsControllrer>().checkCartData();
        update();
      } else {
        showToast('We already have product with other freelancer'.tr);
        update();
      }
    }
  }
}
