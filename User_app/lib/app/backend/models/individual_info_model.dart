/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:salon_user/app/backend/models/timing_model.dart';

class IndividualInfoModel {
  int? id;
  int? uid;
  String? background;
  String? categories;
  String? address;
  double? lat;
  double? lng;
  int? cid;
  String? about;
  double? rating;
  double? feeStart;
  int? totalRating;
  String? website;
  List<TimingModel>? timing;
  String? images;
  String? zipcode;
  int? verified;
  int? inHome;
  int? popular;
  int? haveShop;
  String? extraField;
  int? status;
  String? email;
  String? mobile;

  IndividualInfoModel(
      {this.id,
      this.uid,
      this.background,
      this.categories,
      this.address,
      this.lat,
      this.lng,
      this.cid,
      this.about,
      this.rating,
      this.feeStart,
      this.totalRating,
      this.website,
      this.timing,
      this.images,
      this.zipcode,
      this.verified,
      this.inHome,
      this.popular,
      this.haveShop,
      this.extraField,
      this.status,
      this.email,
      this.mobile});

  IndividualInfoModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    background = json['background'];
    categories = json['categories'];
    address = json['address'];
    lat = double.parse(json['lat'].toString());
    lng = double.parse(json['lng'].toString());
    cid = int.parse(json['cid'].toString());
    about = json['about'];
    rating = double.parse(json['rating'].toString());
    feeStart = double.parse(json['fee_start'].toString());
    totalRating = int.parse(json['total_rating'].toString());
    website = json['website'];
    if (json['timing'] != null &&
        json['timing'] != 'NA' &&
        json['timing'] != '') {
      timing = <TimingModel>[];
      var items = jsonDecode(json['timing']);
      items.forEach((v) {
        timing!.add(TimingModel.fromJson(v));
      });
    } else {
      timing = [];
    }
    images = json['images'];
    zipcode = json['zipcode'];
    verified = int.parse(json['verified'].toString());
    inHome = int.parse(json['in_home'].toString());
    popular = int.parse(json['popular'].toString());
    haveShop = int.parse(json['have_shop'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['background'] = background;
    data['categories'] = categories;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['cid'] = cid;
    data['about'] = about;
    data['rating'] = rating;
    data['fee_start'] = feeStart;
    data['total_rating'] = totalRating;
    data['website'] = website;
    data['timing'] = timing;
    data['images'] = images;
    data['zipcode'] = zipcode;
    data['verified'] = verified;
    data['in_home'] = inHome;
    data['popular'] = popular;
    data['have_shop'] = haveShop;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}
