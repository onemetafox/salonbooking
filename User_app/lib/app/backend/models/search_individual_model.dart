/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class SearchIndividualModel {
  int? id;
  int? uid;
  String? lat;
  String? lng;
  String? firstName;
  String? lastName;
  String? cover;
  double? distance;

  SearchIndividualModel(
      {this.id,
      this.uid,
      this.lat,
      this.lng,
      this.firstName,
      this.lastName,
      this.cover,
      this.distance});

  SearchIndividualModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    lat = json['lat'];
    lng = json['lng'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['lat'] = lat;
    data['lng'] = lng;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['cover'] = cover;
    data['distance'] = distance;
    return data;
  }
}
