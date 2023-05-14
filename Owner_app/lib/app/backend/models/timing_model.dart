/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class TimingModel {
  int? day;
  String? openTime;
  String? closeTime;

  TimingModel({this.day, this.openTime, this.closeTime});

  TimingModel.fromJson(Map<String, dynamic> json) {
    day = int.parse(json['day'].toString());
    openTime = json['open_time'];
    closeTime = json['close_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    return data;
  }
}
