/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class YearlyAnalyticsModel {
  int? count;
  int? dayName;
  int? day;
  double? total;

  YearlyAnalyticsModel({this.count, this.dayName, this.day, this.total});

  YearlyAnalyticsModel.fromJson(Map<String, dynamic> json) {
    count = int.parse(json['count'].toString());
    dayName = int.parse(json['day_name'].toString());
    day = int.parse(json['day'].toString());
    total = double.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['day_name'] = dayName;
    data['day'] = day;
    data['total'] = total;
    return data;
  }
}
