/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:ultimate_salon_owner_flutter/app/backend/models/specialist_model.dart';

class PackagesDetailsModel {
  int? id;
  int? uid;
  int? packageFrom;
  String? name;
  String? cover;
  String? serviceId;
  String? descriptions;
  String? images;
  double? duration;
  double? price;
  double? off;
  double? discount;
  String? specialistIds;
  String? extraField;
  int? status;
  List<Services>? services;
  List<Specialist>? specialist;
  late bool? isBooked;

  PackagesDetailsModel(
      {this.id,
      this.uid,
      this.packageFrom,
      this.name,
      this.cover,
      this.serviceId,
      this.descriptions,
      this.images,
      this.duration,
      this.price,
      this.off,
      this.discount,
      this.specialistIds,
      this.extraField,
      this.status,
      this.services,
      this.isBooked = false,
      this.specialist});

  PackagesDetailsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    packageFrom = int.parse(json['package_from'].toString());
    name = json['name'];
    cover = json['cover'];
    serviceId = json['service_id'];
    descriptions = json['descriptions'];
    images = json['images'];
    duration = double.parse(json['duration'].toString());
    price = double.parse(json['price'].toString());
    off = double.parse(json['off'].toString());
    discount = double.parse(json['discount'].toString());
    specialistIds = json['specialist_ids'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    isBooked = json['isBooked'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['specialist'] != null) {
      specialist = <Specialist>[];
      json['specialist'].forEach((v) {
        specialist!.add(Specialist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['package_from'] = packageFrom;
    data['name'] = name;
    data['cover'] = cover;
    data['service_id'] = serviceId;
    data['descriptions'] = descriptions;
    data['images'] = images;
    data['duration'] = duration;
    data['price'] = price;
    data['off'] = off;
    data['discount'] = discount;
    data['specialist_ids'] = specialistIds;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['isBooked'] = isBooked;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (specialist != null) {
      data['specialist'] = specialist!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void add(SpecialistModel services) {}
}

class Services {
  int? id;
  String? name;
  String? cover;
  double? price;

  Services({this.id, this.name, this.cover, this.price});

  Services.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    if (json['price'] != null) {
      price = double.parse(json['price'].toString());
    } else {
      price = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    return data;
  }
}

class Specialist {
  int? id;
  String? firstName;
  String? lastName;
  String? cover;

  Specialist({this.id, this.firstName, this.lastName, this.cover});

  Specialist.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['cover'] = cover;
    return data;
  }
}
