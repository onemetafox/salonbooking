/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salon_user/app/backend/api/handler.dart';
import 'package:salon_user/app/backend/models/individual_model.dart';
import 'package:salon_user/app/backend/models/salon_model.dart';
import 'package:salon_user/app/backend/parse/near_parse.dart';
import 'package:salon_user/app/controller/services_controller.dart';
import 'package:salon_user/app/controller/specialist_controller.dart';
import 'package:salon_user/app/helper/router.dart';

const double cameraZoom = 16;
const double cameraTilt = 80;
const double cameraBearing = 30;

class NearController extends GetxController implements GetxService {
  final NearParser parser;
  bool apiCalled = false;

  List<SalonModel> _salonList = <SalonModel>[];
  List<SalonModel> get salonList => _salonList;

  List<IndividualModel> _individualList = <IndividualModel>[];
  List<IndividualModel> get individualList => _individualList;

  final Set<Marker> markers = {};
  late CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> googleMapsController = Completer();

  bool haveData = false;

  NearController({required this.parser});

  @override
  void onInit() {
    super.onInit();

    getHomeData();
  }

  Future<void> getHomeData() async {
    var param = {"lat": parser.getLat(), "lng": parser.getLng()};
    Response response = await parser.getHomeData(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var salonData = myMap['salon'];
      var individualData = myMap['individual'];
      _salonList = [];
      _individualList = [];
      salonData.forEach((data) {
        SalonModel salon = SalonModel.fromJson(data);
        _salonList.add(salon);
      });
      debugPrint(salonList.length.toString());

      individualData.forEach((data) {
        IndividualModel individual = IndividualModel.fromJson(data);
        _individualList.add(individual);
      });
      var destPosition = LatLng(parser.getLat(), parser.getLng());
      initialCameraPosition = CameraPosition(
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing,
          target: destPosition);
      debugPrint(individualList.length.toString());

      for (var element in _salonList) {
        markers.add(Marker(
          markerId: MarkerId('${element.id}salon'),
          position: LatLng(element.salonLat as double,
              element.salonLng as double), //position of marker
          infoWindow: InfoWindow(
            title: element.name,
            snippet: element.address,
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
      }

      for (var element in _individualList) {
        markers.add(Marker(
          markerId: MarkerId('${element.uid}freelancer'),
          position: LatLng(element.lat as double,
              element.lng as double), //position of marker
          infoWindow: InfoWindow(
            title:
                '${element.userInfo!.firstName} ${element.userInfo!.lastName}',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
      }

      if (salonList.isEmpty && individualList.isEmpty) {
        haveData = false;
      } else {
        haveData = true;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onFilter() {
    Get.toNamed(AppRouter.getFilterRoutes(), arguments: ['']);
  }

  void onServices(int uid) {
    Get.delete<ServicesController>(force: true);
    Get.toNamed(AppRouter.getServicesRoutes(), arguments: [uid]);
  }

  void onSpecialist(int uid) {
    Get.delete<SpecialistController>(force: true);
    Get.toNamed(AppRouter.getSpecialistRoutes(), arguments: [uid]);
  }
}
