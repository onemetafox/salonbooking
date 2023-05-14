/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class PaymentModel {
  int? id;
  String? name;
  String? cover;
  int? env;
  int? status;
  String? currencyCode;
  String? extraField;

  PaymentModel(
      {this.id,
      this.name,
      this.cover,
      this.env,
      this.status,
      this.currencyCode,
      this.extraField});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    env = int.parse(json['env'].toString());
    status = int.parse(json['status'].toString());
    currencyCode = json['currency_code'];
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['env'] = env;
    data['status'] = status;
    data['currency_code'] = currencyCode;
    data['extra_field'] = extraField;
    return data;
  }
}
