/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class SettingsModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
  double? tax;
  double? deliveryCharge;
  String? currencySymbol;
  String? currencySide;
  String? currencyCode;
  String? appDirection;
  String? logo;
  String? smsName;
  String? smsCreds;
  int? haveShop;
  int? findType;
  int? resetPwd;
  int? userLogin;
  int? freelancerLogin;
  int? userVerifyWith;
  double? searchRadius;
  String? countryModal;
  String? defaultCountryCode;
  String? defaultCityId;
  String? defaultDeliveryZip;
  String? social;
  String? appColor;
  int? appStatus;
  String? fcmToken;
  int? status;
  double? allowDistance;
  int? searchResultKind;
  String? extraField;

  SettingsModel(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.tax,
      this.deliveryCharge,
      this.currencySymbol,
      this.currencySide,
      this.currencyCode,
      this.appDirection,
      this.logo,
      this.smsName,
      this.smsCreds,
      this.haveShop,
      this.findType,
      this.resetPwd,
      this.userLogin,
      this.freelancerLogin,
      this.userVerifyWith,
      this.searchRadius,
      this.countryModal,
      this.defaultCountryCode,
      this.defaultCityId,
      this.defaultDeliveryZip,
      this.social,
      this.appColor,
      this.appStatus,
      this.fcmToken,
      this.status,
      this.allowDistance,
      this.searchResultKind,
      this.extraField});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    tax = double.parse(json['tax'].toString());
    deliveryCharge = double.parse(json['delivery_charge'].toString());
    currencySymbol = json['currencySymbol'];
    currencySide = json['currencySide'];
    currencyCode = json['currencyCode'];
    appDirection = json['appDirection'];
    logo = json['logo'];
    smsName = json['sms_name'];
    smsCreds = json['sms_creds'];
    haveShop = int.parse(json['have_shop'].toString());
    findType = int.parse(json['findType'].toString());
    resetPwd = int.parse(json['reset_pwd'].toString());
    userLogin = int.parse(json['user_login'].toString());
    freelancerLogin = int.parse(json['freelancer_login'].toString());
    userVerifyWith = int.parse(json['user_verify_with'].toString());
    searchRadius = double.parse(json['search_radius'].toString());
    countryModal = json['country_modal'];
    defaultCountryCode = json['default_country_code'];
    defaultCityId = json['default_city_id'];
    defaultDeliveryZip = json['default_delivery_zip'];
    social = json['social'];
    appColor = json['app_color'];
    appStatus = json['app_status'];
    fcmToken = json['fcm_token'];
    status = int.parse(json['status'].toString());
    allowDistance = double.parse(json['allowDistance'].toString());
    searchResultKind = int.parse(json['searchResultKind'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['tax'] = tax;
    data['delivery_charge'] = deliveryCharge;
    data['currencySymbol'] = currencySymbol;
    data['currencySide'] = currencySide;
    data['currencyCode'] = currencyCode;
    data['appDirection'] = appDirection;
    data['logo'] = logo;
    data['sms_name'] = smsName;
    data['sms_creds'] = smsCreds;
    data['have_shop'] = haveShop;
    data['findType'] = findType;
    data['reset_pwd'] = resetPwd;
    data['user_login'] = userLogin;
    data['freelancer_login'] = freelancerLogin;
    data['user_verify_with'] = userVerifyWith;
    data['search_radius'] = searchRadius;
    data['country_modal'] = countryModal;
    data['default_country_code'] = defaultCountryCode;
    data['default_city_id'] = defaultCityId;
    data['default_delivery_zip'] = defaultDeliveryZip;
    data['social'] = social;
    data['app_color'] = appColor;
    data['app_status'] = appStatus;
    data['fcm_token'] = fcmToken;
    data['status'] = status;
    data['allowDistance'] = allowDistance;
    data['searchResultKind'] = searchResultKind;
    data['extra_field'] = extraField;
    return data;
  }
}
