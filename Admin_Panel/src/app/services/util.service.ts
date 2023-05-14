/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import { Subject } from 'rxjs';
import Swal from 'sweetalert2';
import { TranslateService } from '@ngx-translate/core';
@Injectable({
  providedIn: 'root'
})
export class UtilService {
  public appLogo: any;
  public direction: any;
  public app_color: any;
  public app_status: any;
  public driver_assign: any = 1;
  public appName: any = '';
  orderStatus = [
    this.translate('Created'), // 0
    this.translate('Completed'),// 1
    this.translate('Pending Payments'), // 2
    this.translate('Cancelled'), // 3
    this.translate('Refunded'), // 4
    this.translate('Returned'), // 5
  ];

  public cside: any = 'left';
  public currecny: any = '$';
  public general: any;

  public allLanguages: any[] = [
    {
      name: 'English',
      code: 'en',
      direction: 'ltr'
    },
    {
      name: 'Español',
      code: 'es',
      direction: 'ltr'
    },
    {
      name: 'عربي',
      code: 'ar',
      direction: 'rtl'
    },
    {
      name: 'हिन्दी',
      code: 'hi',
      direction: 'ltr'
    }
  ];

  paidMethods = [
    'Index',
    'COD',
    'STRIPE',
    'PAYPAL',
    'PAYTM',
    'RAZORPAY',
    'INSTAMOJO',
    'PAYSTACK',
    'FLUTTERWAVE',
    'PAYKUN'
  ];

  countrys: any[] = [];
  private ejectMessages = new Subject<any>();
  constructor(
    private spinner: NgxSpinnerService,
    private router: Router,
    private translateService: TranslateService
  ) { }

  error(message: any) {
    Swal.fire({
      icon: 'error',
      title: message,
      toast: true,
      showConfirmButton: false,
      timer: 2000,
      position: 'bottom-right'
    });
  }

  show() {
    this.spinner.show();
  }

  hide() {
    this.spinner.hide();
  }

  translate(str: any) {
    return this.translateService.instant(str);
  }

  ejectMsg() {
    this.ejectMessages.next(0);
  }

  successEject(): Subject<any> {
    return this.ejectMessages;
  }

  success(message: any) {
    Swal.fire({
      icon: 'success',
      title: message,
      showConfirmButton: false,
      timer: 1500
    });
  }

  apiErrorHandler(err: any) {
    if (err && err.status == 401 && err.error.error) {
      this.error(err.error.error);
      this.router.navigateByUrl('/login');
      return false;
    }
    if (err && err.status == 500 && err.error.error) {
      this.error(err.error.error);
      return false;
    }
    if (err.status == -1) {
      this.error(this.translate('Failed To Connect With Server'));
    } else if (err.status == 401) {
      this.error(this.translate('Unauthorized Request!'));
      this.router.navigateByUrl('/login');
    } else if (err.status == 500) {
      if (err.status == 500 && err.error && err.error.message) {
        this.error(err.error.message);
        return false;
      }
      this.error(this.translate('Something went wrong'));
    } else if (err.status == 422 && err.error.error) {
      this.error(err.error.error);
    } else {
      this.error(this.translate('Something went wrong'));
    }

  }

  downloadFile(data: any, filename = 'data', keys: any) {
    let csvData = this.ConvertToCSV(data, keys);
    let blob = new Blob(['\ufeff' + csvData], { type: 'text/csv;charset=utf-8;' });
    let dwldLink = document.createElement("a");
    let url = URL.createObjectURL(blob);
    let isSafariBrowser = navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1;
    if (isSafariBrowser) {  //if Safari open in new window to save file with random filename.
      dwldLink.setAttribute("target", "_blank");
    }
    dwldLink.setAttribute("href", url);
    dwldLink.setAttribute("download", filename + ".csv");
    dwldLink.style.visibility = "hidden";
    document.body.appendChild(dwldLink);
    dwldLink.click();
    document.body.removeChild(dwldLink);
  }

  ConvertToCSV(objArray: any, headerList: any) {
    let array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
    let str = '';
    let row = 'S.No,';

    for (let index in headerList) {
      row += headerList[index] + ',';
    }
    row = row.slice(0, -1);
    str += row + '\r\n';
    for (let i = 0; i < array.length; i++) {
      let line = (i + 1) + '';
      for (let index in headerList) {
        let head = headerList[index];

        line += ',' + array[i][head];
      }
      str += line + '\r\n';
    }
    return str;
  }

  replaceWithDot(input: string) {
    return input && input.replace ? input.replace(/,/g, '.') : input;
  }
}
