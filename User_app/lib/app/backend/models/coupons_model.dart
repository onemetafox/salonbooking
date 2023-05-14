/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class CouponsModel {
  int? id;
  String? name;
  String? shortDescriptions;
  String? code;
  int? type;
  int? forWhome;
  double? discount;
  double? upto;
  String? expire;
  String? freelancerIds;
  int? maxUsage;
  double? minCartValue;
  int? validations;
  int? userLimitValidation;
  String? extraField;
  int? status;

  CouponsModel(
      {this.id,
      this.name,
      this.shortDescriptions,
      this.code,
      this.type,
      this.forWhome,
      this.discount,
      this.upto,
      this.expire,
      this.freelancerIds,
      this.maxUsage,
      this.minCartValue,
      this.validations,
      this.userLimitValidation,
      this.extraField,
      this.status});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    shortDescriptions = json['short_descriptions'];
    code = json['code'];
    type = int.parse(json['type'].toString());
    forWhome = int.parse(json['for'].toString());
    discount = double.parse(json['discount'].toString());
    upto = double.parse(json['upto'].toString());
    expire = json['expire'];
    freelancerIds = json['freelancer_ids'];
    maxUsage = int.parse(json['max_usage'].toString());
    minCartValue = double.parse(json['min_cart_value'].toString());
    validations = int.parse(json['validations'].toString());
    userLimitValidation = int.parse(json['user_limit_validation'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_descriptions'] = shortDescriptions;
    data['code'] = code;
    data['type'] = type;
    data['for'] = forWhome;
    data['discount'] = discount;
    data['upto'] = upto;
    data['expire'] = expire;
    data['freelancer_ids'] = freelancerIds;
    data['max_usage'] = maxUsage;
    data['min_cart_value'] = minCartValue;
    data['validations'] = validations;
    data['user_limit_validation'] = userLimitValidation;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
