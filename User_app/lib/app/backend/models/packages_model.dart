/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class PackagesModel {
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

  PackagesModel(
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
      this.status});

  PackagesModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
