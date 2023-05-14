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
  selector: 'app-notifications',
  templateUrl: './notifications.component.html',
  styleUrls: ['./notifications.component.scss']
})
export class NotificationsComponent implements OnInit {
  title: any = '';
  descriptions: any = '';
  sendTo: any = 1;
  constructor(
    public api: ApiService,
    public util: UtilService
  ) { }

  ngOnInit(): void {
  }

  sendToAll() {
    const param = {
      title: this.title,
      message: this.descriptions
    }
    this.util.show();
    this.api.post_private('v1/notification/sendToAllUsers', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      this.util.success(this.util.translate('Notification sent'));
      this.title = '';
      this.descriptions = '';
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

  sendToUsers() {
    const param = {
      title: this.title,
      message: this.descriptions
    }
    this.util.show();
    this.api.post_private('v1/notification/sendToUsers', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      this.util.success(this.util.translate('Notification sent'));
      this.title = '';
      this.descriptions = '';
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
    //
  }

  sendToStores() {
    const param = {
      title: this.title,
      message: this.descriptions
    }
    this.util.show();
    this.api.post_private('v1/notification/sendToStores', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      this.util.success(this.util.translate('Notification sent'));
      this.title = '';
      this.descriptions = '';
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
    //
  }

  sendToSalon() {
    const param = {
      title: this.title,
      message: this.descriptions
    }
    this.util.show();
    this.api.post_private('v1/notification/sendToSalon', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      this.util.success(this.util.translate('Notification sent'));
      this.title = '';
      this.descriptions = '';
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
    //
  }
  sendNotifications() {
    console.log(this.title, this.descriptions, this.sendTo);
    if (this.title == '' || this.title == null || this.descriptions == '' || this.descriptions == null) {
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }
    if (this.sendTo == 1) {
      this.sendToAll();
      return false;
    }

    if (this.sendTo == 2) {
      this.sendToUsers();
    }

    if (this.sendTo == 3) {
      this.sendToStores();
    }

    if (this.sendTo == 4) {
      this.sendToSalon();
    }

  }
}
