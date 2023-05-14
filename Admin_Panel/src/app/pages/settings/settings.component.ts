/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import { ModalDirective } from 'ngx-bootstrap/modal';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.scss']
})
export class SettingsComponent implements OnInit {
  @ViewChild('largeModal') public largeModal: ModalDirective;

  isNew: boolean = true;
  id: any = '';
  address: any = '';
  allowDistance: any = 0;
  appDirection: any = '';
  app_color: any = '#16742d';
  app_status: any = 1;
  city: any = '';
  country: any = '';
  country_modal: any = '';
  currencyCode: any = '';
  currencySide: any = '';
  currencySymbol: any = '';
  default_city_id: any = '';
  default_country_code: any = '';
  default_delivery_zip: any = '';
  delivery_charge: any = 5;
  delivery_type: any = 1;
  email: any = '';
  fcm_token: any = '';
  findType: any = 0;
  freelancer_login: any = 0;
  have_shop: any = 0;
  logo: any = '';
  mobile: any = '';
  name: any = '';
  reset_pwd: any = 0;
  searchResultKind: any = 0;
  search_radius: any = 50;
  sms_creds: any = '';
  sms_name: any = '2';
  social: any = {
    website: '',
    playstore: '',
    appstore: '',
    facebook: '',
    twitter: '',
    instagram: '',
  };
  state: any = '';
  status: any = 1;
  tax: any = 5;
  user_login: any = 0;
  user_verify_with: any = 0;
  zip: any = '';

  twilloCreds = {
    sid: '',
    token: '',
    from: ''
  };

  msgCreds = {
    key: '',
    sender: ''
  }

  countries: any[] = [];
  dummy: any[] = [];
  dummyLoad: any[] = [];
  selected: any[] = [];

  cities: any[] = [];
  constructor(
    public util: UtilService,
    public api: ApiService,
  ) {
    this.getData();
    this.getAllCities();
  }

  getAllCities() {
    this.cities = [];
    this.api.get_private('v1/cities/getAll').then((data: any) => {
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.cities = data.data;
          console.log("====", this.cities);
        }
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  getData() {
    this.util.show();
    this.api.get_private('v1/settings/getById').then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status == 200 && data.data && data.data.id) {
        this.isNew = false;
        const info = data.data;
        this.id = info.id;
        this.address = info.address;
        this.allowDistance = info.allowDistance;
        this.appDirection = info.appDirection;
        this.app_color = info.app_color;
        this.app_status = info.app_status;
        this.city = info.city;
        this.country = info.country;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false; } })(info.country_modal)) {
          this.country_modal = JSON.parse(info.country_modal);
        }
        this.currencyCode = info.currencyCode;
        this.currencySide = info.currencySide;
        this.currencySymbol = info.currencySymbol;
        this.default_city_id = info.default_city_id;
        this.default_country_code = info.default_country_code;
        this.default_delivery_zip = info.default_delivery_zip;
        this.delivery_charge = info.delivery_charge;
        this.delivery_type = info.delivery_type;
        this.email = info.email;
        this.fcm_token = info.fcm_token;
        this.findType = info.findType;
        this.freelancer_login = info.freelancer_login;
        this.have_shop = info.have_shop;
        this.logo = info.logo;
        this.mobile = info.mobile;
        this.name = info.name;
        this.reset_pwd = info.reset_pwd;
        this.searchResultKind = info.searchResultKind;
        this.search_radius = info.search_radius;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.sms_creds)) {
          const creds = JSON.parse(info.sms_creds);
          this.twilloCreds = creds.twilloCreds;
          this.msgCreds = creds.msg;
        }
        this.sms_name = info.sms_name;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.social)) {
          const social = JSON.parse(info.social);
          this.social = social;
        }
        this.state = info.state;
        this.status = info.status;
        this.tax = info.tax;
        this.user_login = info.user_login;
        this.user_verify_with = info.user_verify_with;
        this.zip = info.zip;
        console.log(this);
      } else {
        this.isNew = true;
      }
    }, error => {
      console.log(error);
      this.isNew = true;
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch((error) => {
      console.log(error);
      this.isNew = true;
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

  openCountryModel() {
    console.log('open moda');
    this.dummyLoad = Array(10);
    setTimeout(() => {
      this.dummyLoad = [];
      this.dummy = this.util.countrys;
      this.countries = this.dummy;
      this.util.countrys.forEach(element => {
        const exist = this.country_modal.filter((x: any) => x.country_code == element.country_code);
        element.isChecked = exist && exist.length ? true : false;
      })
      console.log(this.dummy);
    }, 500);
    this.largeModal.show();
  }

  preview_banner(files: any) {
    console.log('fle', files);
    if (files.length == 0) {
      return;
    }
    const mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    if (files) {
      console.log('ok');
      this.util.show();
      this.api.uploadFile(files).subscribe((data: any) => {
        console.log('==>>>>>>', data.data);
        this.util.hide();
        if (data && data.data.image_name) {
          this.logo = data.data.image_name;
        }
      }, error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      });
    } else {
      console.log('no');
    }
  }



  onSearchChange(events: any) {
    console.log(events);
    if (events !== '') {
      this.countries = this.dummy.filter((item) => {
        return item.country_name.toLowerCase().indexOf(events.toLowerCase()) > -1;
      });
    } else {
      this.countries = [];
    }
  }

  changed() {
    this.selected = this.util.countrys.filter(x => x.isChecked == true);
    console.log(this.selected);
  }

  saveCountries() {
    this.country_modal = this.selected;
    this.largeModal.hide();
  }

  createInfo() {
    console.log('create');
    console.log(this.address);
    console.log(this.allowDistance);
    console.log(this.appDirection);
    console.log(this.app_color);
    console.log(this.app_status);
    console.log(this.city);
    console.log(this.country);
    console.log(this.country_modal);
    console.log(this.currencyCode);
    console.log(this.currencySide);
    console.log(this.currencySymbol);
    console.log(this.default_city_id);
    console.log(this.default_country_code);
    console.log(this.default_delivery_zip);
    console.log(this.delivery_charge);
    console.log(this.delivery_type);
    console.log(this.email);
    console.log(this.fcm_token);
    console.log(this.findType);
    console.log(this.freelancer_login);
    console.log(this.have_shop);
    console.log(this.logo);
    console.log(this.mobile);
    console.log(this.name);
    console.log(this.reset_pwd);
    console.log(this.searchResultKind);
    console.log(this.search_radius);
    console.log(this.twilloCreds);
    console.log(this.msgCreds);
    console.log(this.sms_name);
    console.log(this.social);
    console.log(this.state);
    console.log(this.status);
    console.log(this.tax);
    console.log(this.user_login);
    console.log(this.user_verify_with);
    console.log(this.zip);
    const creds = {
      twilloCreds: this.twilloCreds,
      msg: this.msgCreds,
    };

    const param = {
      address: this.address,
      allowDistance: this.allowDistance,
      appDirection: this.appDirection,
      app_color: this.app_color,
      app_status: 1,
      city: this.city,
      country: this.country,
      country_modal: JSON.stringify(this.country_modal),
      currencyCode: this.currencyCode,
      currencySide: this.currencySide,
      currencySymbol: this.currencySymbol,
      default_city_id: this.default_city_id,
      default_country_code: this.default_country_code,
      default_delivery_zip: this.default_delivery_zip,
      delivery_charge: this.delivery_charge,
      delivery_type: this.delivery_type,
      email: this.email,
      fcm_token: this.fcm_token,
      findType: this.findType,
      freelancer_login: 1,
      have_shop: this.have_shop,
      logo: this.logo,
      mobile: this.mobile,
      name: this.name,
      reset_pwd: this.reset_pwd,
      searchResultKind: this.searchResultKind,
      search_radius: this.search_radius,
      sms_creds: JSON.stringify(creds),
      sms_name: this.sms_name,
      social: JSON.stringify(this.social),
      state: this.state,
      status: 1,
      tax: this.tax,
      user_login: this.user_login,
      user_verify_with: this.user_verify_with,
      zip: this.zip
    };
    console.log(param);
    this.util.show();
    this.api.post_private('v1/setttings/save', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status == 200) {
        this.getData();
        window.location.reload();
      }

    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }

  updateInfo() {
    if (this.address == '' || this.address == null || this.allowDistance == '' || this.allowDistance == null || this.allowDistance == 0 ||
      this.country == '' || this.country == null || this.currencyCode == '' || this.currencyCode == null || this.currencySymbol == '' || this.currencySymbol == null ||
      this.default_city_id == '' || this.default_city_id == null || this.default_country_code == null || this.default_country_code == null || this.default_delivery_zip == '' ||
      this.default_delivery_zip == null || this.delivery_charge == '' || this.delivery_charge == null || this.email == '' || this.email == null || this.fcm_token == '' || this.fcm_token == null ||
      this.logo == '' || this.logo == null || this.mobile == '' || this.mobile == null || this.name == '' || this.name == null || this.search_radius == null || this.search_radius == '' ||
      this.state == '' || this.state == null || this.tax == '' || this.tax == null || this.zip == '' || this.zip == null) {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }

    if (this.sms_name == '0') {
      if (this.twilloCreds.sid == '' || !this.twilloCreds.sid || this.twilloCreds.token == '' || !this.twilloCreds.token || this.twilloCreds.from == '' || !this.twilloCreds.from) {
        this.util.error(this.util.translate('Twilio credentials missings'));
        return false;
      }
    }

    if (this.sms_name == '1') {
      if (this.msgCreds.key == '' || !this.msgCreds.key || this.msgCreds.sender == '' || !this.msgCreds.sender) {
        this.util.error(this.util.translate('Msg91 credentials missings'));
        return false;
      }
    }

    console.log('update');
    console.log(this.address);
    console.log(this.allowDistance);
    console.log(this.appDirection);
    console.log(this.app_color);
    console.log(this.app_status);
    console.log(this.city);
    console.log(this.country);
    console.log(this.country_modal);
    console.log(this.currencyCode);
    console.log(this.currencySide);
    console.log(this.currencySymbol);
    console.log(this.default_city_id);
    console.log(this.default_country_code);
    console.log(this.default_delivery_zip);
    console.log(this.delivery_charge);
    console.log(this.delivery_type);
    console.log(this.email);
    console.log(this.fcm_token);
    console.log(this.findType);
    console.log(this.freelancer_login);
    console.log(this.have_shop);
    console.log(this.logo);
    console.log(this.mobile);
    console.log(this.name);
    console.log(this.reset_pwd);
    console.log(this.searchResultKind);
    console.log(this.search_radius);
    console.log(this.twilloCreds);
    console.log(this.msgCreds);
    console.log(this.sms_name);
    console.log(this.social);
    console.log(this.state);
    console.log(this.status);
    console.log(this.tax);
    console.log(this.user_login);
    console.log(this.user_verify_with);
    console.log(this.zip);
    const creds = {
      twilloCreds: this.twilloCreds,
      msg: this.msgCreds,
    };

    const param = {
      id: this.id,
      address: this.address,
      allowDistance: this.allowDistance,
      appDirection: this.appDirection,
      app_color: this.app_color,
      app_status: 1,
      city: this.city,
      country: this.country,
      country_modal: JSON.stringify(this.country_modal),
      currencyCode: this.currencyCode,
      currencySide: this.currencySide,
      currencySymbol: this.currencySymbol,
      default_city_id: this.default_city_id,
      default_country_code: this.default_country_code,
      default_delivery_zip: this.default_delivery_zip,
      delivery_charge: this.delivery_charge,
      delivery_type: this.delivery_type,
      email: this.email,
      fcm_token: this.fcm_token,
      findType: this.findType,
      freelancer_login: 1,
      have_shop: this.have_shop,
      logo: this.logo,
      mobile: this.mobile,
      name: this.name,
      reset_pwd: this.reset_pwd,
      searchResultKind: this.searchResultKind,
      search_radius: this.search_radius,
      sms_creds: JSON.stringify(creds),
      sms_name: this.sms_name,
      social: JSON.stringify(this.social),
      state: this.state,
      status: 1,
      tax: this.tax,
      user_login: this.user_login,
      user_verify_with: this.user_verify_with,
      zip: this.zip
    };
    console.log(param);
    this.util.show();
    this.api.post_private('v1/setttings/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status == 200) {
        this.getData();
        window.location.reload();
      }

    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }
}
