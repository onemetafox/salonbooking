/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/appointment_model.dart';
import 'package:salon_user/app/backend/parse/appointment_detail_parse.dart';
import 'package:salon_user/app/controller/add_review_controller.dart';
import 'package:salon_user/app/controller/booking_controller.dart';
import 'package:salon_user/app/controller/chat_controller.dart';
import 'package:salon_user/app/controller/complaints_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/constant.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetailController extends GetxController
    implements GetxService {
  final AppointmentDetailParser parser;

  bool apiCalled = false;

  int appointmentId = 0;

  String name = '';
  String address = '';
  String slot = '';
  String savedDate = '';
  String discount = '';
  String walletDiscount = '';
  String distanceCost = '';
  String serviceTax = '';
  String total = '';
  String grandTotal = '';

  String firstName = '';
  String lastName = '';
  String individualAddress = '';

  AppointmentModel _appointmentInfo = AppointmentModel();
  AppointmentModel get appointmentInfo => _appointmentInfo;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String invoiceURL = '';
  String orderStatus = '';

  List<String> paymentName = [
    'NA',
    'COD'.tr,
    'Stripe'.tr,
    'PayPal'.tr,
    'Paytm'.tr,
    'Razorpay'.tr,
    'Instamojo'.tr,
    'Paystack'.tr,
    'Flutterwave'.tr
  ];
  AppointmentDetailController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    appointmentId = Get.arguments[0] as int;
    debugPrint('appointment id --> $appointmentId');
    invoiceURL =
        '${parser.apiService.appBaseUrl}${AppConstants.getAppointmentsInvoice}$appointmentId&token=${parser.getToken()}';
    getAppointmentDetails();
  }

  Future<void> getAppointmentDetails() async {
    var response = await parser.getAppointmentDetails({"id": appointmentId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _appointmentInfo = AppointmentModel();
      AppointmentModel info = AppointmentModel.fromJson(body);
      _appointmentInfo = info;
      if (appointmentInfo.status == 1) {
        orderStatus = 'Accepted'.tr;
      } else if (appointmentInfo.status == 2) {
        orderStatus = 'Rejected by Freelancer'.tr;
      } else if (appointmentInfo.status == 3) {
        orderStatus = 'Ongoing'.tr;
      } else if (appointmentInfo.status == 4) {
        orderStatus = 'Completed'.tr;
      } else if (appointmentInfo.status == 5) {
        orderStatus = 'Cancelled'.tr;
      } else if (appointmentInfo.status == 6) {
        orderStatus = 'Refunded'.tr;
      } else if (appointmentInfo.status == 7) {
        orderStatus = 'Delayed'.tr;
      } else if (appointmentInfo.status == 8) {
        orderStatus = 'Panding Payment'.tr;
      }
      debugPrint(orderStatus);
      if (appointmentInfo.salonId != 0) {
        name = _appointmentInfo.salonInfo!.name as String;
        address = _appointmentInfo.salonInfo!.address as String;
      } else {
        firstName = _appointmentInfo.individualInfo!.firstName as String;
        lastName = _appointmentInfo.individualInfo!.lastName as String;
        individualAddress = _appointmentInfo.individualInfo!.address as String;
      }
      debugPrint(appointmentInfo.ownerInfo!.email);
      slot = _appointmentInfo.slot as String;
      savedDate = _appointmentInfo.saveDate as String;
      walletDiscount = _appointmentInfo.walletPrice.toString();
      discount = _appointmentInfo.discount.toString();
      distanceCost = _appointmentInfo.distanceCost.toString();
      serviceTax = _appointmentInfo.serviceTax.toString();
      total = _appointmentInfo.total.toString();
      grandTotal = _appointmentInfo.grandTotal.toString();
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> onUpdateAppointmentStatus(int status) async {
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
    var body = {"id": appointmentId, "status": status};
    Response response = await parser.onUpdateAppointmentStatus(body);
    Get.back();
    if (response.statusCode == 200) {
      // back//
      successToast('Status Updated'.tr);
      Get.find<BookingController>().getAppointmentById();
      onBack(); // list refresh
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onAddReview(int id) {
    debugPrint(id.toString());
    var context = Get.context as BuildContext;
    showDialog(
        context: context,
        barrierColor: ThemeProvider.appColor,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rate Your Appointment'.tr,
                  style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 14,
                    ))
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Owner'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ThemeProvider.appColor,
                          fontFamily: 'bold',
                          fontSize: 15),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              appointmentInfo.salonId != 0
                                  ? appointmentInfo.salonInfo!.name.toString()
                                  : '${appointmentInfo.ownerInfo!.firstName!} ${appointmentInfo.ownerInfo!.lastName!}',
                              style: const TextStyle(
                                  fontSize: 14, fontFamily: 'bold')),
                          InkWell(
                              onTap: () {
                                Get.back();
                                Get.delete<AddReviewController>(force: true);
                                Get.toNamed(AppRouter.getAddReviewsRoutes(),
                                    arguments: [
                                      'owner',
                                      appointmentInfo.salonId != 0
                                          ? appointmentInfo.salonInfo!.cover
                                              .toString()
                                              .toString()
                                          : appointmentInfo.ownerInfo!.cover
                                              .toString(),
                                      appointmentInfo.salonId != 0
                                          ? appointmentInfo.salonInfo!.name
                                              .toString()
                                          : '${appointmentInfo.ownerInfo!.firstName} ${appointmentInfo.ownerInfo!.lastName}',
                                      appointmentInfo.salonId != 0
                                          ? appointmentInfo.salonId.toString()
                                          : appointmentInfo.freelancerId
                                              .toString()
                                    ]);
                              },
                              child: const Icon(Icons.star_outline,
                                  color: ThemeProvider.orangeColor))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        appointmentInfo.items!.services!.isNotEmpty
                            ? const Text(
                                'Services',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontFamily: 'bold',
                                    fontSize: 15),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              appointmentInfo.items!.services!.length,
                              (serviceIndex) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          appointmentInfo.items!
                                              .services![serviceIndex].name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'regular',
                                              fontSize: 10,
                                              color: ThemeProvider.blackColor),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.delete<AddReviewController>(
                                                  force: true);
                                              Get.toNamed(
                                                  AppRouter
                                                      .getAddReviewsRoutes(),
                                                  arguments: [
                                                    'service',
                                                    appointmentInfo
                                                        .items!
                                                        .services![serviceIndex]
                                                        .cover
                                                        .toString(),
                                                    appointmentInfo
                                                        .items!
                                                        .services![serviceIndex]
                                                        .name
                                                        .toString(),
                                                    appointmentInfo
                                                        .items!
                                                        .services![serviceIndex]
                                                        .id
                                                        .toString(),
                                                    appointmentInfo.salonId != 0
                                                        ? appointmentInfo
                                                            .salonId
                                                            .toString()
                                                        : appointmentInfo
                                                            .freelancerId
                                                            .toString()
                                                  ]);
                                            },
                                            child: const Icon(
                                                Icons.star_outline,
                                                color:
                                                    ThemeProvider.orangeColor))
                                      ],
                                    ),
                                  )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        appointmentInfo.items!.packages!.isNotEmpty
                            ? const Text(
                                'Packages',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ThemeProvider.appColor,
                                    fontFamily: 'bold',
                                    fontSize: 15),
                              )
                            : const SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              appointmentInfo.items!.packages!.length,
                              (packageIndex) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              appointmentInfo.items!
                                                  .packages![packageIndex].name
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: 'regular',
                                                  fontSize: 10,
                                                  color:
                                                      ThemeProvider.blackColor),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Get.back();
                                                  Get.delete<
                                                          AddReviewController>(
                                                      force: true);
                                                  Get.toNamed(
                                                      AppRouter
                                                          .getAddReviewsRoutes(),
                                                      arguments: [
                                                        'package',
                                                        appointmentInfo
                                                            .items!
                                                            .packages![
                                                                packageIndex]
                                                            .cover
                                                            .toString(),
                                                        appointmentInfo
                                                            .items!
                                                            .packages![
                                                                packageIndex]
                                                            .name
                                                            .toString(),
                                                        appointmentInfo
                                                            .items!
                                                            .packages![
                                                                packageIndex]
                                                            .id
                                                            .toString(),
                                                        appointmentInfo
                                                                    .salonId !=
                                                                0
                                                            ? appointmentInfo
                                                                .salonId
                                                                .toString()
                                                            : appointmentInfo
                                                                .freelancerId
                                                                .toString()
                                                      ]);
                                                },
                                                child: const Icon(
                                                    Icons.star_outline,
                                                    color: ThemeProvider
                                                        .orangeColor))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bottomBorder() {
    return BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 1, color: ThemeProvider.greyColor.shade300)));
  }

  Future<void> launchInBrowser() async {
    var url = Uri.parse(invoiceURL);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw '${'Could not launch'.tr} $url';
    }
  }

  Future<void> makePhoneCall(String phone) async {
    debugPrint(phone);
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchUrl(launchUri);
  }

  Future<void> onMail(String email) async {
    debugPrint(email);
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  void openHelpModal() {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose'.tr),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Chat'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ChatController>(force: true);
              Get.toNamed(AppRouter.getChatRoutes(), arguments: [
                parser.getAdminId().toString(),
                parser.getAdminName()
              ]);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Complaints'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ComplaintsController>(force: true);
              Get.toNamed(AppRouter.getComplaintsRoutes(),
                  arguments: [appointmentId, 'appointments']);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(fontFamily: 'bold', color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void onContactInfo(String name, String phone, String email, String uid) {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose'.tr),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Chat'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ChatController>(force: true);
              Get.toNamed(AppRouter.getChatRoutes(), arguments: [uid, name]);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Call'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              makePhoneCall(phone);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Email'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              onMail(email);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(fontFamily: 'bold', color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
