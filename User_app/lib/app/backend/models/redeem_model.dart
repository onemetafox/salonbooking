/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class RedeemModel {
  int? id;
  double? amount;
  String? title;
  String? message;
  int? limit;
  int? whoReceived;
  int? status;
  String? extraField;

  RedeemModel(
      {this.id,
      this.amount,
      this.title,
      this.message,
      this.limit,
      this.whoReceived,
      this.status,
      this.extraField});

  RedeemModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    amount = double.parse(json['amount'].toString());
    title = json['title'];
    message = json['message'];
    limit = int.parse(json['limit'].toString());
    whoReceived = int.parse(json['who_received'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['title'] = title;
    data['message'] = message;
    data['limit'] = limit;
    data['who_received'] = whoReceived;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
