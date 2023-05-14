/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';
import 'package:salon_user/app/backend/models/slot_time_model.dart';

class SlotModel {
  int? id;
  int? uid;
  int? weekId;
  List<SlotTimeModel>? slots;
  String? extraField;
  int? status;
  SlotModel(
      {this.id,
      this.uid,
      this.weekId,
      this.slots,
      this.extraField,
      this.status});
  SlotModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    weekId = int.parse(json['week_id'].toString());
    if (json['slots'] != null && json['slots'] != 'NA' && json['slots'] != '') {
      slots = <SlotTimeModel>[];
      var items = jsonDecode(json['slots']);
      items.forEach((element) {
        slots!.add(SlotTimeModel.fromJson(element));
      });
    }
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['week_id'] = weekId;
    data['slots'] = slots;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
