/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-referral',
  templateUrl: './referral.component.html',
  styleUrls: ['./referral.component.scss']
})
export class ReferralComponent implements OnInit {
  submited: boolean = false;
  amount: any = '';
  limit: any = '';
  title: any = '';
  message: any = '';
  who_received: any = '';
  status: any = '';
  referralId: any = '';
  edit: boolean = false;
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getReferral();
  }

  ngOnInit(): void {
  }

  getReferral() {
    this.util.show();
    this.api.get_private('v1/referral/getAll').then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        const info = data.data[0];
        console.log(info);
        this.edit = true;
        this.referralId = info.id;
        this.title = info.title;
        this.message = info.message;
        this.amount = info.amount;
        this.limit = info.limit;
        this.who_received = info.who_received;
        this.status = info.status;
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

  create() {
    this.submited = true;
    if (this.title == '' || this.message == '' || this.amount == '' || this.limit == '' || this.who_received == '' || this.status == '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }
    const param = {
      amount: this.amount,
      title: this.title,
      message: this.message,
      limit: this.limit,
      who_received: this.who_received,
      status: this.status
    };
    this.util.show();
    this.api.post_private('v1/referral/save', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200) {
        this.util.success(this.util.translate('Referral program created'));
        this.getReferral();
      } else {
        this.util.error(this.util.translate('Something went wrong while saving reffral'));
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

  update() {
    this.submited = true;
    if (this.title == '' || this.message == '' || this.amount == '' || this.limit == '' || this.who_received == '' || this.status == '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }
    const param = {
      id: this.referralId,
      amount: this.amount,
      title: this.title,
      message: this.message,
      limit: this.limit,
      who_received: this.who_received,
      status: this.status
    };
    this.util.show();
    this.api.post_private('v1/referral/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200) {
        this.util.success(this.util.translate('Referral program updated'));
        this.getReferral();
      } else {
        this.util.error(this.util.translate('Something went wrong while saving reffral'));
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
