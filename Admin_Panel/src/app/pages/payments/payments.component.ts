/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ModalDirective } from 'ngx-bootstrap/modal';
import Swal from 'sweetalert2';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-payments',
  templateUrl: './payments.component.html',
  styleUrls: ['./payments.component.scss']
})
export class PaymentsComponent implements OnInit {
  @ViewChild('largeModal') public largeModal: ModalDirective;
  dummyPayments: any[] = [];
  paymentID: any = '';
  payments: any[] = [];
  page: any = 1;

  name: any;
  currency_code: any;

  paypalCreds = {
    client_id: '',
    client_secret: ''
  }

  razorCreds = {
    key: '',
    secret: ''
  }

  stripeCreds = {
    key: '',
    secret: ''
  }

  payTMCreds = {
    env: '',
    key: '',
    mid: '',
    stage: ''
  }

  instaMOJO = {
    env: '',
    key: '',
    token: ''
  }

  flutterwaveCreds = {
    key: '',
    secret: ''
  }

  paystackCreds = {
    sk: '',
    pk: ''
  }

  languages: any[] = [];
  translations: any[] = [];

  constructor(
    public api: ApiService,
    public util: UtilService
  ) {
    this.getPayments();
  }

  ngOnInit(): void {
  }

  getPayments() {
    this.payments = [];
    this.dummyPayments = Array(5);
    this.api.get_private('v1/payments/getAll').then((data: any) => {
      console.log(data);
      this.dummyPayments = [];
      if (data && data.status == 200 && data.data && data.data.length) {
        data.data.forEach((info: any) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false; } })(info.extra_field)) {
            const extra_field = JSON.parse(info.extra_field);
            if (extra_field && extra_field.translation) {
              const currentTranslation = extra_field.translation.filter((x: any) => x.id == localStorage.getItem('translateKey'));
              if (currentTranslation && currentTranslation.length) {
                info.name = currentTranslation[0].title;
              }
            }
          }
        });
        this.payments = data.data;
      }
    }, error => {
      console.log(error);
      this.dummyPayments = [];
      this.payments = [];
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.dummyPayments = [];
      this.payments = [];
      this.util.apiErrorHandler(error);
    });
  }


  updateStatus(item: any) {
    console.log(item);

    console.log('update status', item);
    const text = item.status == 1 ? 'Deactived' : 'Activate';
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To') + ' ' + this.util.translate(text) + ' ' + this.util.translate('this item?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        item.status = item.status == 0 ? 1 : 0;
        console.log(item.status);
        this.util.show();
        const param = {
          id: item.id,
          status: item.status
        }
        this.api.post_private('v1/payments/update', param).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status == 200) {
            this.getPayments();
          }
        }, error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        }).catch(error => {
          this.util.hide();
          console.log(error);
          this.util.apiErrorHandler(error);
        });
      }
    });
  }


  updateItem(item: any) {
    console.log(item);
    this.paymentID = item;
    this.getPaymentInfo();
  }

  getPaymentInfo() {
    this.util.show();
    this.api.post_private('v1/payments/getPaymentInfo', { id: this.paymentID }).then((data: any) => {
      this.util.hide();
      console.log('data', data);
      if (data && data.status && data.status == 200 && data.data) {
        const info = data.data;
        this.currency_code = info.currency_code;
        this.name = info.name;
        this.translations = [];
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.extra_field)) {
          const extra_field = JSON.parse(info.extra_field);
          if (extra_field && extra_field.translation) {
            this.translations = extra_field.translation;
          }
        }
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false; } })(info.extra_field)) {
          const extra_field = JSON.parse(info.extra_field);
          if (extra_field && extra_field.translation) {
            const currentTranslation = extra_field.translation.filter((x: any) => x.id == localStorage.getItem('translateKey'));
            if (currentTranslation && currentTranslation.length) {
              info.name = currentTranslation[0].title;
            }
          }
        }
        // stripe
        if (info.id == 2) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.stripeCreds = payCreds;
            }
          }
        }

        // paypal
        if (info.id == 3) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.paypalCreds = payCreds;
            }
          }
        }

        if (info.id == 4) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.payTMCreds = payCreds;
            }
          }
        }

        if (info.id == 5) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.razorCreds = payCreds;
            }
          }
        }

        if (info.id == 6) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.instaMOJO = payCreds;
            }
          }
        }

        if (info.id == 7) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.paystackCreds = payCreds;
            }
          }
        }

        if (info.id == 8) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.creds)) {
            const payCreds = JSON.parse(info.creds);
            console.log(payCreds);
            if (payCreds && payCreds != null && payCreds != 'null') {
              console.log('assign', payCreds);
              this.flutterwaveCreds = payCreds;
            }
          }
        }
        this.largeModal.show();
      }
    }, error => {
      this.util.hide();
      console.log('error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log('error', error);
      this.util.apiErrorHandler(error);
    });
  }


  updatePayment() {
    if (this.name && this.name !== '' && this.currency_code && this.currency_code !== '') {
      const langTitle = this.languages.map(x => x.title);
      if (langTitle.includes("")) {
        this.util.error(this.util.translate('Translations missings'));
        return false;
      }
      const extra_data = {
        translation: this.languages,
      }
      let credentials = 'NA';
      if (this.paymentID == 2) {
        if (this.stripeCreds.key == '' || !this.stripeCreds.key || this.stripeCreds.secret == '' || !this.stripeCreds.secret) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.stripeCreds);
      }

      if (this.paymentID == 3) {
        if (this.paypalCreds.client_id == '' || !this.paypalCreds.client_id || this.paypalCreds.client_secret == '' || !this.paypalCreds.client_secret) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.paypalCreds);
      }

      if (this.paymentID == 4) {
        if (this.payTMCreds.env == '' || !this.payTMCreds.env || this.payTMCreds.key == '' || !this.payTMCreds.key || this.payTMCreds.mid == '' || !this.payTMCreds.mid ||
          this.payTMCreds.stage == '' || !this.payTMCreds.stage) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.payTMCreds);
      }

      if (this.paymentID == 5) {
        if (this.razorCreds.key == '' || !this.razorCreds.key || this.razorCreds.secret == '' || !this.razorCreds.secret) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.razorCreds);
      }

      if (this.paymentID == 6) {
        if (this.instaMOJO.env == '' || !this.instaMOJO.env || this.instaMOJO.key == '' || !this.instaMOJO.key || this.instaMOJO.token == '' || !this.instaMOJO.token) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.instaMOJO);
      }

      if (this.paymentID == 7) {
        if (this.paystackCreds.sk == '' || !this.paystackCreds.sk || this.paystackCreds.pk == '' || !this.paystackCreds.pk) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.paystackCreds);
      }

      if (this.paymentID == 8) {
        if (this.flutterwaveCreds.key == '' || !this.flutterwaveCreds.key || this.flutterwaveCreds.secret == '' || !this.flutterwaveCreds.secret) {
          this.util.error(this.util.translate('Credentials missings'));
          return false;
        }
        credentials = JSON.stringify(this.flutterwaveCreds);
      }

      const param = {
        id: this.paymentID,
        name: this.name,
        currency_code: this.currency_code,
        creds: credentials,
        extra_field: JSON.stringify(extra_data)
      };
      this.util.show();
      this.api.post_private('v1/payments/update', param).then((data: any) => {
        console.log(data);
        this.util.hide();
        if (data && data.status == 200) {
          this.largeModal.hide();
          this.getPayments();
        }
      }, error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      }).catch(error => {
        this.util.hide();
        console.log(error);
        this.util.apiErrorHandler(error);
      });
    } else {
      this.util.error(this.util.translate('All Fields are required'));
    }
  }
}
