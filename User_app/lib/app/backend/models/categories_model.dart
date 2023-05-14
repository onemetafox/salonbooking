/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class CategoriesModel {
  int? id;
  String? name;
  String? cover;
  String? extraField;
  int? services;
  int? status;

  CategoriesModel(
      {this.id,
      this.name,
      this.cover,
      this.extraField,
      this.services,
      this.status});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    extraField = json['extra_field'];
    if (json.containsKey('services')) {
      services = int.parse(json['services'].toString());
    } else {
      services = 0;
    }
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['extra_field'] = extraField;
    data['services'] = services;
    data['status'] = status;
    return data;
  }
}
