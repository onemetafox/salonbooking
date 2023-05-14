/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import * as moment from 'moment';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';


@Component({
  selector: 'app-contact-forms',
  templateUrl: './contact-forms.component.html',
  styleUrls: ['./contact-forms.component.scss']
})
export class ContactFormsComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;
  dummy: any[] = [];
  list: any[] = [];
  dummyList: any[] = [];
  page: number = 1;
  name: any = '';
  email: any = '';
  message: any = '';
  reply: any = '';
  id: any = '';
  constructor(
    public api: ApiService,
    public util: UtilService
  ) {
    this.getForms();
  }

  ngOnInit(): void {
  }

  getForms() {
    this.list = [];
    this.dummy = Array(5);
    this.api.get_private('v1/contacts/getAll').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.list = data.data;
        this.dummyList = data.data;
      }
    }, error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    });
  }

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.list = this.filterItems(str);
  }

  protected resetChanges = () => {
    this.list = this.dummyList;
  }

  filterItems(searchTerm: any) {
    return this.list.filter((item) => {
      return item.name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.list = [];
    this.list = this.dummyList;
  }


  getDate(date: any) {
    return moment(date).format('ll');
  }
  openItem(item: any) {
    console.log(item);
    this.name = item.name;
    this.email = item.email;
    this.message = item.message;
    this.id = item.id;
    this.myModal.show();
  }

  sendMail() {
    if (this.reply == '' || !this.reply) {
      this.util.error(this.util.translate('Please add your reply text'));
      return false;
    }
    const param = {
      id: this.id,
      status: 1
    };
    this.util.show();
    this.api.post_private('v1/contacts/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200) {
        this.util.success(this.util.translate('Mail sent'));
        const param = {
          id: this.id,
          mediaURL: this.api.imageUrl,
          subject: this.util.appName + ' ' + this.util.translate('Replied on your mail'),
          thank_you_text: this.util.translate('You have received new mail'),
          header_text: this.util.appName + ' ' + this.util.translate('Replied on your mail'),
          email: this.email,
          from_username: this.name,
          to_respond: this.reply
        };
        console.log(param);
        this.api.post_private('v1/mails/replyContactForm', param).then((data: any) => {
          console.log(data);
        }, error => {
          console.log(error);
        });
        this.reply = '';
        this.myModal.hide();
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
