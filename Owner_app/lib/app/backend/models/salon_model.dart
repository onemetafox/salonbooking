/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class SalonModel {
  int? id;
  int? salonUid;
  String? cateId;
  String? firstName;
  String? lastName;
  String? cover;
  String? extraField;
  int? status;
  bool? isChecked;
  List<Categories>? categories;

  SalonModel({
    this.id,
    this.salonUid,
    this.cateId,
    this.firstName,
    this.lastName,
    this.cover,
    this.extraField,
    this.status,
    this.categories,
    this.isChecked,
  });

  SalonModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    salonUid = int.parse(json['salon_uid'].toString());
    cateId = json['cate_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
    extraField = json['extra_field'];
    isChecked = json['isChecked'];
    status = int.parse(json['status'].toString());
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
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
    data['isChecked'] = isChecked;
    data['status'] = status;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? cover;

  Categories({this.id, this.name, this.cover});

  Categories.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    return data;
  }
}
