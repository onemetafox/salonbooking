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
import 'package:ultimate_salon_owner_flutter/app/backend/api/handler.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/appointments_details_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/parse/order_details_parse.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/appointment_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/chat_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/helper/router.dart';
import 'package:ultimate_salon_owner_flutter/app/util/constance.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsController extends GetxController implements GetxService {
  final OrderDetailsParser parser;
  int id = 0;
  AppointmentDetailsModel _appointmentInfo = AppointmentDetailsModel();
  AppointmentDetailsModel get appointmentInfo => _appointmentInfo;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  bool apiCalled = false;

  List<String> paymentName = [
    'NA'.tr,
    'COD'.tr,
    'Stripe'.tr,
    'PayPal'.tr,
    'Paytm'.tr,
    'Razorpay'.tr,
    'Instamojo'.tr,
    'Paystack'.tr,
    'Flutterwave'.tr
  ];

  List<String> selectStatus = ['Ongoing'.tr, 'Completed'.tr, 'Delayed'.tr];
  String orderStatus = '';
  String savedStatus = 'Ongoing'.tr;
  String invoiceURL = '';
  OrderDetailsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments[0];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    debugPrint('appointment id --> $id');
    invoiceURL =
        '${parser.apiService.appBaseUrl}${AppConstants.getAppointmentInvoice}$id&token=${parser.getToken()}';
    getAppointmentDetails();
    debugPrint(id.toString());
  }

  Future<void> getAppointmentDetails() async {
    var response = await parser.getAppointmentDetails({"id": id});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _appointmentInfo = AppointmentDetailsModel();
      AppointmentDetailsModel info = AppointmentDetailsModel.fromJson(body);
      _appointmentInfo = info;
      if (_appointmentInfo.status == 2) {
        orderStatus = 'Rejected'.tr;
      } else if (_appointmentInfo.status == 4) {
        orderStatus = 'Completed'.tr;
      } else if (_appointmentInfo.status == 5) {
        orderStatus = 'Cancelled by user'.tr;
      } else if (_appointmentInfo.status == 6) {
        orderStatus = 'Refunded'.tr;
      } else if (_appointmentInfo.status == 8) {
        orderStatus = 'Panding Payment'.tr;
      }
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
    var body = {"id": id, "status": status};
    Response response = await parser.updateAppointments(body);
    Get.back();
    if (response.statusCode == 200) {
      // back//
      successToast('Status Updated'.tr);
      var notificationParam = {
        "id": appointmentInfo.uid,
        "title": "New Notificaiton".tr,
        "message": "Your Appointment status is Changed"
      };
      await parser.sendNotification(notificationParam);
      Get.find<AppointmentController>().getList();
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

  void onSelectStatus(String choice) {
    savedStatus = choice;
    update();
  }

  void updateStatus() {
    debugPrint('*************');
    debugPrint(savedStatus);
    debugPrint('*************');
    int index = 0;
    if (savedStatus == 'Ongoing'.tr) {
      index = 3;
    } else if (savedStatus == 'Completed'.tr) {
      index = 4;
    } else {
      index = 7;
    }
    debugPrint('----------');
    debugPrint(index.toString());
    debugPrint('----------');
    onUpdateAppointmentStatus(index);
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
              Get.toNamed(AppRouter.getChatRoute(), arguments: [
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
              // Get.delete<ComplaintsController>(force: true);
              // Get.toNamed(AppRouter.getComplaintsRoutes(),
              //     arguments: [appointmentId, 'appointments']);
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
              Get.toNamed(AppRouter.getChatRoute(), arguments: [uid, name]);
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
