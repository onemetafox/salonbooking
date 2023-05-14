/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:ultimate_salon_owner_flutter/app/backend/models/packages_details_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/services_model.dart';

class ServiceCartModel {
  List<ServicesModel>? services;
  List<PackagesDetailsModel>? packages;

  ServiceCartModel({this.services, this.packages});

  ServiceCartModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <ServicesModel>[];
      json['services'].forEach((v) {
        services!.add(ServicesModel.fromJson(v));
      });
    }

    if (json['packages'] != null) {
      packages = <PackagesDetailsModel>[];
      json['packages'].forEach((v) {
        packages!.add(PackagesDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
