/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class SoldByModel {
  int? id;
  String? lastName;
  String? firstName;
  int? status;

  SoldByModel({this.id, this.lastName, this.firstName, this.status});

  SoldByModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    lastName = json['last_name'];
    firstName = json['first_name'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['status'] = status;
    return data;
  }
}
