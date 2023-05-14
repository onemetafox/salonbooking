/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-forgot',
  templateUrl: './forgot.component.html',
  styleUrls: ['./forgot.component.scss']
})
export class ForgotComponent implements OnInit {
  email: any = '';

  otp: any = '';

  password: any = '';
  confirm: any = '';
  div: any = 1;
  otp_id: any;
  submited: boolean = false;
  temp: any = '';
  constructor(
    public api: ApiService,
    public util: UtilService,
    private location: Location
  ) { }

  ngOnInit(): void {
  }

  goToTabs() {

    this.submited = true;
    const emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailfilter.test(this.email)) {
      this.util.error(this.util.translate('Please enter valid email'));
      return false;
    }
    console.log('login');
    const param = {
      email: this.email,
      subject: this.util.translate('Reset Password'),
      header_text: this.util.translate('Use this code to reset your password'),
      thank_you_text: this.util.translate("Don't share this OTP to anybody else"),
      mediaURL: this.api.imageUrl,
    }
    this.util.show();
    this.api.post('v1/auth/verifyEmailForReset', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status && data.status == 200 && data.data && data.data == true && data.otp_id) {
        this.otp_id = data.otp_id;
        this.submited = false;
        this.div = 2;
      } else {
        this.util.error(this.util.translate('This email is not exist'));
      }

    }, error => {
      this.util.hide();
      console.log(error);
      if (error && error.status == 401 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      if (error && error.status == 500 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }

      this.util.error(this.util.translate('Something went wrong'));
    }).catch((error) => {
      this.util.hide();

      console.log(error);
      if (error && error.status == 401 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      if (error && error.status == 500 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      this.util.hide();
      this.util.error(this.util.translate('Something went wrong'));
    });

  }

  onOTP() {
    if (this.otp == '' || !this.otp) {
      this.util.error(this.util.translate('Please enter OTP'));
      return false;
    }
    this.util.show();

    const param = {
      'id': this.otp_id,
      'otp': this.otp,
      'email': this.email,
    };
    this.submited = true;
    this.api.post('v1/otp/verifyOTPReset', param).then((data: any) => {
      console.log(data);
      this.util.hide();

      if (data && data.status && data.status == 200 && data.data) {
        this.submited = false;
        this.div = 3;
        this.temp = data.temp;
      }
    }, error => {
      this.util.hide();
      console.log(error);
      if (error && error.status == 401 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      if (error && error.status == 500 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      this.util.hide();
      this.util.error(this.util.translate('Wrong OTP'));
    }).catch((error) => {
      this.util.hide();
      console.log(error);
      if (error && error.status == 401 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      if (error && error.status == 500 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      this.util.hide();
      this.util.error(this.util.translate('Wrong OTP'));
    });
  }

  onOtpChange(event: any) {
    console.log(event);
    this.otp = event;
  }

  goToBack() {
    this.location.back();
  }
  updatePassword() {
    if (this.password != this.confirm) {
      this.util.error(this.util.translate('Password does not match'));
      return false;
    }
    this.util.show();
    const param = {
      'id': this.otp_id,
      'email': this.email,
      'password': this.password
    };
    this.api.postTemp('v1/password/updateUserPasswordWithEmail', param, this.temp).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.data) {
        this.util.success(this.util.translate('Password Updated'));
        this.goToBack();
      }
    }, error => {
      this.util.hide();
      console.log(error);
      if (error && error.status == 401 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      if (error && error.status == 500 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      this.util.hide();
      this.util.error(this.util.translate('Wrong OTP'));
    }).catch((error) => {
      this.util.hide();
      console.log(error);
      if (error && error.status == 401 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      if (error && error.status == 500 && error.error.error) {
        this.util.error(error.error.error);
        return false;
      }
      this.util.hide();
      this.util.error(this.util.translate('Wrong OTP'));
    });
  }

}
