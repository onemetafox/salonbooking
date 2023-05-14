/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/address_model.dart';
import 'package:salon_user/app/backend/models/coupons_model.dart';
import 'package:salon_user/app/backend/models/individual_model.dart';
import 'package:salon_user/app/backend/models/owner_info_model.dart';
import 'package:salon_user/app/backend/models/owner_user_model.dart';
import 'package:salon_user/app/backend/models/payment_models.dart';
import 'package:salon_user/app/backend/models/products_model.dart';
import 'package:salon_user/app/backend/models/salon_details_model.dart';
import 'package:salon_user/app/backend/parse/product_payment_parse.dart';
import 'package:salon_user/app/controller/address_list_controller.dart';
import 'package:salon_user/app/controller/coupon_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/stripe_pay_product_controller.dart';
import 'package:salon_user/app/controller/tabs_controller.dart';
import 'package:salon_user/app/controller/web_product_payment_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';

class ProductPaymentController extends GetxController implements GetxService {
  final ProductPaymentParser parser;
  String title = 'Payment'.tr;

  bool isChecked = false;
  bool apiCalled = false;
  bool paymentAPICalled = false;

  ProductsModel _productInfo = ProductsModel();
  ProductsModel get productInfo => _productInfo;

  List<PaymentModel> _paymentList = <PaymentModel>[];
  List<PaymentModel> get paymentList => _paymentList;

  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;

  late CouponsModel _selectedCoupon = CouponsModel();
  CouponsModel get selectedCoupon => _selectedCoupon;

  SalonDetailsModel _salonInfo = SalonDetailsModel();
  SalonDetailsModel get salonInfo => _salonInfo;

  IndividualModel _individualInfo = IndividualModel();
  IndividualModel get individualInfo => _individualInfo;

  OwnerInfoModel _ownerInfo = OwnerInfoModel();
  OwnerInfoModel get ownerInfo => _ownerInfo;

  OwnerUserModel _ownerUser = OwnerUserModel();
  OwnerUserModel get ownerUser => _ownerUser;

  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  double _discount = 0.0;
  double get discount => _discount;

  int paymentId = 0;
  String payMethodName = '';

  String selectedAddressId = '';
  bool haveAddress = false;

  String offerId = '';
  String offerName = '';

  String salonId = '';
  int ownerId = 0;
  String ownerType = '';

  double _ownerLat = 0.0;
  double get ownerLat => _ownerLat;

  double _ownerLng = 0.0;
  double get ownerLng => _ownerLng;

  final notesEditor = TextEditingController();

  bool haveFairDeliveryRadius = false;

  double _deliveryPrice = 0.0;
  double get deliveryPrice => _deliveryPrice;

  double _grandTotal = 0.0;
  double get grandTotal => _grandTotal;

  bool isWalletChecked = false;
  double balance = 0.0;
  double walletDiscount = 0.0;
  ProductPaymentController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    _productInfo = ProductsModel();
    _selectedCoupon = CouponsModel();
    _salonInfo = SalonDetailsModel();
    _individualInfo = IndividualModel();
    _discount = 0;
    _ownerLat = 0;
    _ownerLng = 0;
    _grandTotal = 0;
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getMyWalletAmount();
    getFreelancerByID();
    getSavedAddress();
    getPaymentMethods();
  }

  Future<void> getMyWalletAmount() async {
    Response response = await parser.getMyWalletBalance();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null &&
          body != '' &&
          body['balance'] != null &&
          body['balance'] != '') {
        balance = double.tryParse(body['balance'].toString()) ?? 0.0;
        walletDiscount = double.tryParse(body['balance'].toString()) ?? 0.0;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onSelectAddress() {
    Get.delete<AddressListController>(force: true);
    Get.toNamed(AppRouter.getAddressList(),
        arguments: ['product', selectedAddressId]);
  }

  void onSaveAddress(String id) {
    selectedAddressId = id;
    var address =
        _addressList.firstWhere((element) => element.id.toString() == id);
    _addressInfo = address;
    debugPrint('********');
    debugPrint(jsonEncode(_addressInfo));
    debugPrint('********');
    calculateDistance();
    update();
  }

  Future<void> getFreelancerByID() async {
    var response = await parser.getFreelancerByID(
        {"id": Get.find<ProductCartController>().savedInCart[0].freelacerId});
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _ownerInfo = OwnerInfoModel();
      _ownerUser = OwnerUserModel();

      var body = myMap['info'];
      var userInfo = myMap['data'];

      OwnerUserModel userData = OwnerUserModel.fromJson(userInfo);
      _ownerUser = userData;
      if (_ownerUser.type == 'salon') {
        SalonDetailsModel data = SalonDetailsModel.fromJson(body);
        _salonInfo = data;
        ownerId = data.uid as int;
      } else {
        OwnerInfoModel data = OwnerInfoModel.fromJson(body);
        _ownerInfo = data;
        ownerId = data.uid as int;
      }

      ownerType = userData.type as String;

      debugPrint('id --------------------------> $ownerId');
      debugPrint('type ------------------------> $ownerType');

      calculateDistance();
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void calculateDistance() {
    if (ownerType == 'individual') {
      debugPrint('-------');
      debugPrint(addressInfo.lat.toString());
      debugPrint(addressInfo.lng.toString());
      debugPrint(ownerInfo.lat.toString());
      debugPrint(ownerInfo.lng.toString());
      debugPrint('-------');
      if (addressInfo.lat != null &&
          addressInfo.lng != null &&
          ownerInfo.lat != null &&
          ownerInfo.lng != null) {
        debugPrint('have address');
        double storeDistance = 0.0;
        double totalMeters = 0.0;
        storeDistance = Geolocator.distanceBetween(
          double.tryParse(addressInfo.lat.toString()) ?? 0.0,
          double.tryParse(addressInfo.lng.toString()) ?? 0.0,
          double.tryParse(ownerInfo.lat.toString()) ?? 0.0,
          double.tryParse(ownerInfo.lng.toString()) ?? 0.0,
        );
        totalMeters = totalMeters + storeDistance;
        double distance =
            double.parse((storeDistance / 1000).toStringAsFixed(2));
        debugPrint(distance.toString());
        if (distance > parser.getAllowedDeliveryRadius()) {
          haveFairDeliveryRadius = false;
          showToast(
              '${'Sorry we deliver the order near to'.tr} ${parser.getAllowedDeliveryRadius()}KM');
        } else {
          if (Get.find<ProductCartController>().shippingMethod == 0) {
            double distancePricer =
                distance * Get.find<ProductCartController>().shippingPrice;
            _deliveryPrice = double.parse((distancePricer).toStringAsFixed(2));
          } else {
            _deliveryPrice = Get.find<ProductCartController>().shippingPrice;
          }
          haveFairDeliveryRadius = true;
        }
        update();
      }
    } else {
      debugPrint('-------');
      debugPrint(addressInfo.lat.toString());
      debugPrint(addressInfo.lng.toString());
      debugPrint(salonInfo.lat.toString());
      debugPrint(salonInfo.lng.toString());
      debugPrint('-------');
      if (addressInfo.lat != null &&
          addressInfo.lng != null &&
          salonInfo.lat != null &&
          salonInfo.lng != null) {
        debugPrint('have address');
        double storeDistance = 0.0;
        double totalMeters = 0.0;
        storeDistance = Geolocator.distanceBetween(
          double.tryParse(addressInfo.lat.toString()) ?? 0.0,
          double.tryParse(addressInfo.lng.toString()) ?? 0.0,
          double.tryParse(salonInfo.lat.toString()) ?? 0.0,
          double.tryParse(salonInfo.lng.toString()) ?? 0.0,
        );
        totalMeters = totalMeters + storeDistance;
        double distance =
            double.parse((storeDistance / 1000).toStringAsFixed(2));
        debugPrint(distance.toString());
        if (distance > parser.getAllowedDeliveryRadius()) {
          haveFairDeliveryRadius = false;
          showToast(
              '${'Sorry we deliver the order near to'.tr} ${parser.getAllowedDeliveryRadius()}KM');
        } else {
          if (Get.find<ProductCartController>().shippingMethod == 0) {
            double distancePricer =
                distance * Get.find<ProductCartController>().shippingPrice;
            _deliveryPrice = double.parse((distancePricer).toStringAsFixed(2));
          } else {
            _deliveryPrice = Get.find<ProductCartController>().shippingPrice;
          }
          haveFairDeliveryRadius = true;
        }
        update();
      }
    }
    calculateAllCharge();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};
    Response response = await parser.getSavedAddress(param);

    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != null && myMap['data'] != '') {
        var address = myMap['data'];
        _addressList = [];
        _addressInfo = AddressModel();
        address.forEach((add) {
          AddressModel adds = AddressModel.fromJson(add);
          _addressList.add(adds);
        });
        if (_addressList.isNotEmpty) {
          haveAddress = true;
          _addressInfo = _addressList[0];
          selectedAddressId = _addressInfo.id.toString();
          calculateDistance();
        } else {
          haveAddress = false;
        }
        debugPrint(addressList.length.toString());
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getPaymentMethods() async {
    Response response = await parser.getPayments();
    paymentAPICalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var payment = myMap['data'];
      _paymentList = [];
      payment.forEach((pay) {
        PaymentModel pays = PaymentModel.fromJson(pay);
        _paymentList.add(pays);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onCoupon(String offerId, String offerName) {
    Get.delete<CouponController>(force: true);
    Get.toNamed(AppRouter.getCouponRoutes(),
        arguments: ['product', offerId, offerName]);
  }

  void updateWalletChecked(bool status) {
    isWalletChecked = status;
    calculateAllCharge();
    update();
  }

  void onSaveCoupon(CouponsModel offer) {
    _selectedCoupon = offer;
    offerId = offer.id.toString();
    offerName = offer.name.toString();
    update();
    calculateAllCharge();
  }

  void calculateAllCharge() {
    double totalPrice = Get.find<ProductCartController>().totalPrice +
        Get.find<ProductCartController>().orderTax +
        deliveryPrice;
    if (_selectedCoupon.discount != null && _selectedCoupon.discount != 0) {
      double percentage(numFirst, per) {
        return (numFirst / 100) * per;
      }

      _discount = percentage(Get.find<ProductCartController>().totalPrice,
          _selectedCoupon.discount); // null
    }
    walletDiscount = balance;
    if (isWalletChecked == true) {
      if (totalPrice <= walletDiscount) {
        walletDiscount = totalPrice;
        totalPrice = totalPrice - walletDiscount;
      } else {
        totalPrice = totalPrice - walletDiscount;
      }
    } else {
      if (totalPrice <= discount) {
        _discount = totalPrice;
        totalPrice = totalPrice - discount;
      } else {
        totalPrice = totalPrice - discount;
      }
    }
    debugPrint('grand total $totalPrice');
    _grandTotal = double.parse((totalPrice).toStringAsFixed(2));
    update();
  }

  void updateStatus() {
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void selectPaymentMethod(int id) {
    paymentId = id;
    if (paymentId == 1) {
      payMethodName = 'cod';
    } else if (paymentId == 2) {
      payMethodName = 'stripe';
    } else if (paymentId == 3) {
      payMethodName = 'paypal';
    } else if (paymentId == 4) {
      payMethodName = 'paytm';
    } else if (paymentId == 5) {
      payMethodName = 'razorpay';
    } else if (paymentId == 6) {
      payMethodName = 'instamojo';
    } else if (paymentId == 7) {
      payMethodName = 'paystack';
    } else if (paymentId == 8) {
      payMethodName = 'flutterwave';
    }
    update();
  }

  void onPayment() {
    if (paymentId == 0) {
      showToast('Please select payment method'.tr);
      return;
    }

    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/question-mark.png',
            fit: BoxFit.cover,
            height: 80,
            width: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Are you sure'.tr,
            style: const TextStyle(fontSize: 24, fontFamily: 'semi-bold'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Orders once placed cannot be cancelled and non-refundable'.tr),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    var context = Get.context as BuildContext;
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ThemeProvider.whiteColor,
                    backgroundColor: ThemeProvider.greyColor,
                    minimumSize: const Size.fromHeight(35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Cancel'.tr,
                    style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    var context = Get.context as BuildContext;
                    Navigator.pop(context);
                    onCheckout();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ThemeProvider.whiteColor,
                    backgroundColor: ThemeProvider.appColor,
                    minimumSize: const Size.fromHeight(35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Book'.tr,
                    style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onCheckout() {
    if (paymentId == 1) {
      createOrder();
      // cod
      //  Order API call
    } else if (paymentId == 2) {
      Get.delete<StripePayProductController>(force: true);
      var gateway = paymentList.firstWhereOrNull(
          (element) => element.id.toString() == paymentId.toString());
      // stripe payment
      Get.toNamed(AppRouter.getProductStripePay(),
          arguments: [grandTotal, gateway!.currencyCode.toString()]);
    } else if (paymentId == 3) {
      Get.delete<WebProductPaymentController>(force: true);
      var paymentURL = AppConstants.payPalPayLink + grandTotal.toString();
      Get.toNamed(AppRouter.getWebProductPayment(),
          arguments: [payMethodName, paymentURL]);
      // paypal
    } else if (paymentId == 4) {
      // paytm
      Get.delete<WebProductPaymentController>(force: true);
      var paymentURL = AppConstants.payTmPayLink + grandTotal.toString();
      Get.toNamed(AppRouter.getWebProductPayment(),
          arguments: [payMethodName, paymentURL]);
    } else if (paymentId == 5) {
      // razorpay
      Get.delete<WebProductPaymentController>(force: true);
      var paymentPayLoad = {
        'amount':
            double.parse((grandTotal * 100).toStringAsFixed(2)).toString(),
        'email': parser.getEmail(),
        'logo':
            '${parser.apiService.appBaseUrl}storage/images/${parser.getAppLogo()}',
        'name': parser.getName(),
        'app_color': '#f47878'
      };

      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.razorPayLink + queryString;

      Get.toNamed(AppRouter.getWebProductPayment(),
          arguments: [payMethodName, paymentURL]);
    } else if (paymentId == 6) {
      payWithInstaMojo();
      // instamojo
    } else if (paymentId == 7) {
      var rng = Random();
      var paykey = List.generate(12, (_) => rng.nextInt(100));
      Get.delete<WebProductPaymentController>(force: true);
      var paymentPayLoad = {
        'email': parser.getEmail(),
        'amount':
            double.parse((grandTotal * 100).toStringAsFixed(2)).toString(),
        'first_name': parser.getFirstName(),
        'last_name': parser.getLastName(),
        'ref': paykey.join()
      };
      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.paystackCheckout + queryString;

      Get.toNamed(AppRouter.getWebProductPayment(),
          arguments: [payMethodName, paymentURL]);
      // paystock
    } else if (paymentId == 8) {
      //flutterwave
      Get.delete<WebProductPaymentController>(force: true);
      var gateway = paymentList.firstWhereOrNull(
          (element) => element.id.toString() == paymentId.toString());
      var paymentPayLoad = {
        'amount': grandTotal.toString(),
        'email': parser.getEmail(),
        'phone': parser.getPhone(),
        'name': parser.getName(),
        'code': gateway!.currencyCode.toString(),
        'logo':
            '${parser.apiService.appBaseUrl}storage/images/${parser.getAppLogo()}',
        'app_name': Environments.appName
      };

      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.flutterwaveCheckout + queryString;

      Get.toNamed(AppRouter.getWebProductPayment(),
          arguments: [payMethodName, paymentURL]);
    }
  }

  Future<void> createOrder() async {
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

    var param = {
      "uid": parser.getUID(),
      "freelancer_id": ownerType == 'individual'
          ? Get.find<ProductCartController>().savedInCart[0].freelacerId
          : 0,
      "salon_id": ownerType == 'salon'
          ? Get.find<ProductCartController>().savedInCart[0].freelacerId
          : 0,
      "date_time": Jiffy().format('yyyy-MM-dd'),
      "paid_method": paymentId,
      "order_to": "home",
      "orders": jsonEncode(Get.find<ProductCartController>().savedInCart),
      "notes": notesEditor.text.isNotEmpty ? notesEditor.text : 'NA',
      "address": jsonEncode(addressInfo),
      "total": Get.find<ProductCartController>().totalPrice,
      "tax": Get.find<ProductCartController>().orderTax,
      "grand_total": grandTotal,
      "discount": discount,
      "driver_id": 0,
      "delivery_charge": deliveryPrice,
      'wallet_used': isWalletChecked == true && walletDiscount > 0 ? 1 : 0,
      'wallet_price':
          isWalletChecked == true && walletDiscount > 0 ? walletDiscount : 0,
      "coupon_id": selectedCoupon.code != null ? selectedCoupon.id : 0,
      "coupon_code":
          selectedCoupon.code != null ? jsonEncode(selectedCoupon) : 'NA',
      "extra": 'NA',
      "pay_key": 'COD',
      "status": 0,
      "payStatus": 1,
    };

    var response = await parser.createAppoinments(param);
    Get.back();

    if (response.statusCode == 200) {
      Get.defaultDialog(
        title: '',
        contentPadding: const EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/sure.gif',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Thank You!'.tr,
                style: const TextStyle(fontFamily: 'bold', fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'For Your Orders'.tr,
                style: const TextStyle(fontFamily: 'semi-bold', fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                    .tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  backOrders();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ThemeProvider.whiteColor,
                  backgroundColor: ThemeProvider.appColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'TRACK MY APPOINTMENT'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  backHome();
                },
                child: Text(
                  'BACK TO HOME'.tr,
                  style: const TextStyle(color: ThemeProvider.appColor),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> payWithInstaMojo() async {
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
    var param = {
      'allow_repeated_payments': 'False',
      'amount': grandTotal,
      'buyer_name': parser.getName(),
      'purpose': 'Orders',
      'redirect_url': '${parser.apiService.appBaseUrl}/api/v1/success_payments',
      'phone': parser.getPhone() != '' ? parser.getPhone() : '8888888888888888',
      'send_email': 'True',
      'webhook': parser.apiService.appBaseUrl,
      'send_sms': 'True',
      'email': parser.getEmail()
    };
    Response response = await parser.getInstaMojoPayLink(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['payment_request'] != '' &&
          body['payment_request']['longurl'] != '') {
        Get.delete<WebProductPaymentController>(force: true);
        var paymentURL = body['payment_request']['longurl'];
        Get.toNamed(AppRouter.getWebPayment(),
            arguments: [payMethodName, paymentURL]);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void backHome() {
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(0);
    Get.offAllNamed(AppRouter.getTabsBarRoute());
  }

  void backOrders() {
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(4);
    Get.offAllNamed(AppRouter.getTabsBarRoute());
  }
}
