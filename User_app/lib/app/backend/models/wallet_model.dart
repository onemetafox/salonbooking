/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class WalletModel {
  String? amount;
  String? uuid;
  String? type;
  String? createdAt;
  String? updatedAt;

  WalletModel(
      {this.amount, this.uuid, this.type, this.createdAt, this.updatedAt});

  WalletModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    uuid = json['uuid'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['uuid'] = uuid;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
