/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:jiffy/jiffy.dart';

class OwnerReviewsModel {
  int? id;
  int? uid;
  String? freelancerId;
  String? notes;
  double? rating;
  int? status;
  String? extraField;
  String? createdAt;
  User? user;

  OwnerReviewsModel(
      {this.id,
      this.uid,
      this.freelancerId,
      this.notes,
      this.rating,
      this.status,
      this.extraField,
      this.createdAt,
      this.user});

  OwnerReviewsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    freelancerId = json['freelancer_id'];
    notes = json['notes'];
    rating = double.parse(json['rating'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    createdAt = Jiffy(json['created_at']).yMMMMd;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['freelancer_id'] = freelancerId;
    data['notes'] = notes;
    data['rating'] = rating;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? cover;
  String? firstName;
  String? lastName;

  User({this.id, this.cover, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cover = json['cover'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover'] = cover;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
