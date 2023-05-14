/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class BannerModel {
  int? id;
  int? cityId;
  String? cover;
  int? type;
  String? value;
  String? title;
  String? from;
  String? to;
  String? extraField;
  int? status;

  BannerModel(
      {this.id,
      this.cityId,
      this.cover,
      this.type,
      this.value,
      this.title,
      this.from,
      this.to,
      this.extraField,
      this.status});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cityId = int.parse(json['city_id'].toString());
    cover = json['cover'];
    type = int.parse(json['type'].toString());
    value = json['value'];
    title = json['title'];
    from = json['from'];
    to = json['to'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['cover'] = cover;
    data['type'] = type;
    data['value'] = value;
    data['title'] = title;
    data['from'] = from;
    data['to'] = to;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
