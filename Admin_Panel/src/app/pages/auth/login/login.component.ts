/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from './../../../services/api.service';
import { UtilService } from './../../../services/util.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  email: any = '';
  password: any = '';
  submited: any = false;
  langId: any = 'en';
  constructor(
    public api: ApiService,
    public util: UtilService,
    private router: Router
  ) {
    this.langId = localStorage.getItem('selectedLanguage');
  }

  onLogin() {
    this.submited = true;
    if (this.email == null || this.password == null || this.email == '' || this.password == '') {
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }
    const emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailfilter.test(this.email)) {
      this.util.error(this.util.translate('Please enter valid email'));
      return false;
    }

    this.util.show();
    const param = {
      email: this.email,
      password: this.password
    }
    this.api.post('v1/auth/adminLogin', param).then((data: any) => {
      console.log("+++++++++++++++", data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.user && data.user.type == 'admin') {
        localStorage.setItem('uid', data.user.id);
        localStorage.setItem('token', data.token);
        this.router.navigate(['']);
      } else if (data && data.status == 401 && data.error.error) {
        this.util.error(data.error.error);
      } else if (data && data.user && data.user.type != 0) {
        this.util.error(this.util.translate('Access denied'));
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }, error => {
      this.util.hide();
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  forgot() {
    console.log('item');
    this.router.navigate(['forgot']);
  }

  changeLanguages() {
    console.log(this.langId);
    const item = this.util.allLanguages.filter((x: any) => x.code == this.langId);
    console.log(item);
    if (item && item.length > 0) {
      localStorage.setItem('selectedLanguage', item[0].code);
      localStorage.setItem('direction', item[0].direction);
      window.location.reload();
    }
  }
}
