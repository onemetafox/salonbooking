/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class StylistModel {
  int? id;
  int? salonUid;
  String? cateId;
  String? firstName;
  String? lastName;
  String? cover;
  String? extraField;
  int? status;
  List<WebCatesData>? webCatesData;

  StylistModel(
      {this.id,
      this.salonUid,
      this.cateId,
      this.firstName,
      this.lastName,
      this.cover,
      this.extraField,
      this.status,
      this.webCatesData});

  StylistModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    salonUid = int.parse(json['salon_uid'].toString());
    cateId = json['cate_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    if (json['web_cates_data'] != null) {
      webCatesData = <WebCatesData>[];
      json['web_cates_data'].forEach((v) {
        webCatesData!.add(WebCatesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['salon_uid'] = salonUid;
    data['cate_id'] = cateId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['cover'] = cover;
    data['extra_field'] = extraField;
    data['status'] = status;
    if (webCatesData != null) {
      data['web_cates_data'] = webCatesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WebCatesData {
  int? id;
  String? name;
  String? cover;
  String? extraField;
  int? status;

  WebCatesData({this.id, this.name, this.cover, this.extraField, this.status});

  WebCatesData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
