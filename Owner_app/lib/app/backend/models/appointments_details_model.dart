/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:jiffy/jiffy.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/address_model.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/models/service_cart_model.dart';

class AppointmentDetailsModel {
  int? id;
  int? uid;
  int? freelancerId;
  int? salonId;
  int? specialistId;
  int? appointmentsTo;
  AddressModel? address;
  ServiceCartModel? items;
  int? couponId;
  String? coupon;
  double? discount;
  double? distanceCost;
  double? total;
  double? serviceTax;
  double? grandTotal;
  int? payMethod;
  String? paid;
  String? saveDate;
  String? slot;
  int? walletUsed;
  double? walletPrice;
  String? notes;
  String? createdAt;
  String? extraField;
  int? status;
  SalonInfo? salonInfo;
  IndividualInfo? individualInfo;
  UserModel? userInfo;
  AppointmentDetailsModel(
      {this.id,
      this.uid,
      this.freelancerId,
      this.salonId,
      this.specialistId,
      this.appointmentsTo,
      this.address,
      this.items,
      this.couponId,
      this.coupon,
      this.discount,
      this.distanceCost,
      this.total,
      this.serviceTax,
      this.grandTotal,
      this.payMethod,
      this.paid,
      this.saveDate,
      this.slot,
      this.walletUsed,
      this.walletPrice,
      this.notes,
      this.extraField,
      this.status,
      this.createdAt,
      this.salonInfo,
      this.individualInfo,
      this.userInfo});

  AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    freelancerId = int.parse(json['freelancer_id'].toString());
    salonId = int.parse(json['salon_id'].toString());
    specialistId = int.parse(json['specialist_id'].toString());
    appointmentsTo = int.parse(json['appointments_to'].toString());
    if (int.parse(json['appointments_to'].toString()) == 1) {
      AddressModel addressInfo =
          AddressModel.fromJson(jsonDecode(json['address']));
      address = addressInfo;
    } else {
      address = AddressModel();
    }
    if (json.containsKey('items') &&
        json['items'] != null &&
        json['items'] != '') {
      var listItems = jsonDecode(json['items']);
      ServiceCartModel datas = ServiceCartModel.fromJson(listItems);
      items = datas;
    } else {
      items = ServiceCartModel();
    }
    couponId = int.parse(json['coupon_id'].toString());
    coupon = json['coupon'];
    discount = double.parse(json['discount'].toString());
    distanceCost = double.parse(json['distance_cost'].toString());
    total = double.parse(json['total'].toString());
    serviceTax = double.parse(json['serviceTax'].toString());
    grandTotal = double.parse(json['grand_total'].toString());
    payMethod = int.parse(json['pay_method'].toString());
    paid = json['paid'];
    saveDate = Jiffy(json['save_date']).yMMMMd;
    slot = json['slot'];
    walletUsed = int.parse(json['wallet_used'].toString());
    walletPrice = double.parse(json['wallet_price'].toString());
    notes = json['notes'];
    extraField = json['extra_field'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json.containsKey('salonInfo')) {
      salonInfo = json['salonInfo'] != null
          ? SalonInfo.fromJson(json['salonInfo'])
          : null;
    }

    if (json.containsKey('individualInfo')) {
      individualInfo = json['individualInfo'] != null
          ? IndividualInfo.fromJson(json['individualInfo'])
          : null;
    }

    if (json.containsKey('userInfo')) {
      userInfo = json['userInfo'] != null
          ? UserModel.fromJson(json['userInfo'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['freelancer_id'] = freelancerId;
    data['salon_id'] = salonId;
    data['specialist_id'] = specialistId;
    data['appointments_to'] = appointmentsTo;
    data['address'] = address;
    data['items'] = items;
    data['coupon_id'] = couponId;
    data['coupon'] = coupon;
    data['discount'] = discount;
    data['distance_cost'] = distanceCost;
    data['total'] = total;
    data['serviceTax'] = serviceTax;
    data['grand_total'] = grandTotal;
    data['pay_method'] = payMethod;
    data['paid'] = paid;
    data['save_date'] = saveDate;
    data['slot'] = slot;
    data['wallet_used'] = walletUsed;
    data['wallet_price'] = walletPrice;
    data['notes'] = notes;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (salonInfo != null) {
      data['salonInfo'] = salonInfo!.toJson();
    }
    return data;
  }
}

class SalonInfo {
  int? id;
  int? uid;
  String? name;
  String? cover;
  String? categories;
  String? address;
  String? lat;
  String? lng;
  int? cid;
  String? about;
  double? rating;
  int? totalRating;
  String? website;
  String? timing;
  String? images;
  String? zipcode;
  int? serviceAtHome;
  int? verified;
  int? inHome;
  int? popular;
  int? haveShop;
  int? haveStylist;
  String? extraField;
  int? status;

  SalonInfo(
      {this.id,
      this.uid,
      this.name,
      this.cover,
      this.categories,
      this.address,
      this.lat,
      this.lng,
      this.cid,
      this.about,
      this.rating,
      this.totalRating,
      this.website,
      this.timing,
      this.images,
      this.zipcode,
      this.serviceAtHome,
      this.verified,
      this.inHome,
      this.popular,
      this.haveShop,
      this.haveStylist,
      this.extraField,
      this.status});

  SalonInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    name = json['name'];
    cover = json['cover'];
    categories = json['categories'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    cid = int.parse(json['cid'].toString());
    about = json['about'];
    rating = double.parse(json['rating'].toString());
    totalRating = int.parse(json['total_rating'].toString());
    website = json['website'];
    timing = json['timing'];
    images = json['images'];
    zipcode = json['zipcode'];
    serviceAtHome = int.parse(json['service_at_home'].toString());
    verified = int.parse(json['verified'].toString());
    inHome = int.parse(json['in_home'].toString());
    popular = int.parse(json['popular'].toString());
    haveShop = int.parse(json['have_shop'].toString());
    haveStylist = int.parse(json['have_stylist'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['cover'] = cover;
    data['categories'] = categories;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['cid'] = cid;
    data['about'] = about;
    data['rating'] = rating;
    data['total_rating'] = totalRating;
    data['website'] = website;
    data['timing'] = timing;
    data['images'] = images;
    data['zipcode'] = zipcode;
    data['service_at_home'] = serviceAtHome;
    data['verified'] = verified;
    data['in_home'] = inHome;
    data['popular'] = popular;
    data['have_shop'] = haveShop;
    data['have_stylist'] = haveStylist;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}

class IndividualInfo {
  int? id;
  int? uid;
  String? background;
  String? categories;
  String? address;
  String? lat;
  String? lng;
  String? cid;
  String? about;
  double? rating;
  double? feeStart;
  int? totalRating;
  String? website;
  String? timing;
  String? images;
  String? zipcode;
  int? verified;
  int? inHome;
  int? popular;
  int? haveShop;
  String? extraField;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;

  IndividualInfo(
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
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName});

  IndividualInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    background = json['background'];
    categories = json['categories'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    cid = json['cid'];
    about = json['about'];
    rating = double.parse(json['rating'].toString());
    feeStart = double.parse(json['fee_start'].toString());
    totalRating = int.parse(json['total_rating'].toString());
    website = json['website'];
    timing = json['timing'];
    images = json['images'];
    zipcode = json['zipcode'];
    verified = int.parse(json['verified'].toString());
    inHome = int.parse(json['in_home'].toString());
    popular = int.parse(json['popular'].toString());
    haveShop = int.parse(json['have_shop'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? mobile;
  String? cover;
  int? gender;
  String? type;
  String? fcmToken;
  String? stripeKey;
  String? extraField;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.mobile,
      this.cover,
      this.gender,
      this.type,
      this.fcmToken,
      this.stripeKey,
      this.extraField,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    cover = json['cover'];
    gender = int.parse(json['gender'].toString());
    type = json['type'];
    fcmToken = json['fcm_token'];
    stripeKey = json['stripe_key'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['cover'] = cover;
    data['gender'] = gender;
    data['type'] = type;
    data['fcm_token'] = fcmToken;
    data['stripe_key'] = stripeKey;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
