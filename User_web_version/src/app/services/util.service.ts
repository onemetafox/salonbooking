/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { environment } from 'src/environments/environment';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';
import Swal from 'sweetalert2';
import { NgxSpinnerService } from 'ngx-spinner';
import { TranslateService } from '@ngx-translate/core';
@Injectable({
  providedIn: 'root'
})
export class UtilService {
  loader: any;
  isLoading = false;
  details: any;
  private address = new Subject<any>();
  private coupon = new Subject<any>();
  private review = new Subject<any>();
  private filterCode = new Subject<any>();
  private appHeader = new Subject<any>();
  orders: any;
  private changeLocation = new Subject<any>();
  private loggedIn = new Subject<any>();
  private profile = new Subject<any>();
  private newOrder = new Subject<any>();
  private newAddress = new Subject<any>();
  private addressPopup = new Subject<any>();
  private modalPopup = new Subject<any>();
  private loginModalPopup = new Subject<any>();
  public appClosed: boolean;
  public appClosedMessage: any = '';
  public direction: any;
  public currecny: any;
  public cside: any;
  public appPages: any[] = [];
  public userInfo: any;
  public general: any;
  public cityAddress: any = '';
  public haveFav: boolean;
  public user_verify_with: any = 0; //0 = email // 1= phone
  public favIds: any[] = [];

  public twillo: any;
  public delivery: any;
  public logo: any;
  public stripe: any;
  public stripeCode: any;
  public orderDetails: any;
  public user_login: any = '0';
  public sms_name: any = '0';
  public home_type: any = '0';
  public deviceType: any = 'desktop';

  public facebook_link: any;
  public instagram_link: any;
  public twitter_link: any;
  public google_playstore: any;
  public apple_appstore: any;
  public web_footer: any;
  public app_name: any;
  public websiteURL: any;
  public websiteName: any;
  public allowDistance: any = 0;

  public countrys: any[] = [];

  public deliveryCharge: any = 0;
  public deliveryType: any = 0;

  public currencySymbol: any = '$';
  public currencySide: any = 'left';

  public paymentLeavve = new Subject<any>();

  public app_color: any = '#f47878';
  public savedLanguages: any = '';
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
  constructor(
    public router: Router,
    private ngxService: NgxSpinnerService,
    private translateService: TranslateService
  ) {
    this.app_name = environment.app_name;
    this.websiteName = environment.websiteName;
    this.websiteURL = environment.websiteURL;
  }

  publishAddress(data: any) {
    this.address.next(data);
  }

  publishReview(data: any) {
    this.review.next(data);
  }

  publishNewAddress() {
    this.newAddress.next(0);
  }

  onLoginPop() {
    this.loginModalPopup.next(0);
  }

  updatePaymentIssue() {
    this.paymentLeavve.next(0);
  }

  changeIntevert(): Subject<any> {
    return this.paymentLeavve;
  }

  onSubscribe(): Subject<any> {
    return this.loginModalPopup;
  }

  publishFilterCode(data) {
    this.filterCode.next(data);
  }

  publishAddressPopup() {
    this.addressPopup.next(0);
  }

  publishModalPopup(data) {
    this.modalPopup.next(data);
  }

  subscribeModalPopup(): Subject<any> {
    return this.modalPopup;
  }
  subscribeAddressPopup(): Subject<any> {
    return this.addressPopup;
  }

  subscribeFitlerCode(): Subject<any> {
    return this.filterCode;
  }
  subscribeNewAddress(): Subject<any> {
    return this.newAddress;
  }

  publishProfile(data: any) {
    this.profile.next(data);
  }

  publishNewOrder() {
    this.newOrder.next(0);
  }

  subscribeNewOrder(): Subject<any> {
    return this.newOrder;
  }

  publishHeader(data: any) {
    this.appHeader.next(data);
  }

  subscribeHeader(): Subject<any> {
    return this.appHeader;
  }

  observProfile(): Subject<any> {
    return this.profile;
  }

  getKeys(key): Promise<any> {
    return new Promise<any>((resolve, reject) => {
      resolve(localStorage.getItem(key));
    });
  }

  clearKeys(key) {
    localStorage.removeItem(key);
  }

  setKeys(key, value): Promise<any> {
    return new Promise<any>((resolve, reject) => {
      resolve(localStorage.setItem(key, value));
    });
  }

  getLanguage() {
    return '';
  }
  start() {
    this.ngxService.show();
  }

  stop() {
    this.ngxService.hide();
  }

  getReviewObservable(): Subject<any> {
    return this.review;
  }

  publishLocation() {
    this.changeLocation.next(0);
  }

  subscribeLocation(): Subject<any> {
    return this.changeLocation;
  }

  publishLoggedIn(data) {
    this.loggedIn.next(data);
  }
  subscribeLoggedIn(): Subject<any> {
    return this.loggedIn;
  }
  translate(str) {
    return this.translateService.instant(str);
  }


  getObservable(): Subject<any> {
    return this.address;
  }

  publishCoupon(data: any) {
    this.coupon.next(data);
  }
  getCouponObservable(): Subject<any> {
    return this.coupon;
  }

  setOrders(data) {
    this.orders = null;
    this.orders = data;
  }

  gerOrder() {
    return this.orders;
  }

  getString(str) {
    return str;
  }
  errorMessage(str) {
    const Toast = Swal.mixin({
      toast: true,
      position: 'bottom-end',
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
    });

    Toast.fire({
      icon: 'error',
      title: str
    });
  }

  suucessMessage(str) {
    const Toast = Swal.mixin({
      toast: true,
      position: 'bottom-end',
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
    });

    Toast.fire({
      icon: 'success',
      title: str
    });
  }

  makeid(length) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
  }

  public loadScript(url: string) {
    const body = <HTMLDivElement>document.body;
    const script = document.createElement('script');
    script.innerHTML = '';
    script.src = url;
    script.async = false;
    script.defer = true;
    body.appendChild(script);
  }

  apiErrorHandler(err: any) {
    if (err && err.status == 401 && err.error.error) {
      this.errorMessage(err.error.error);
      this.publishModalPopup('login');
      return false;
    }
    if (err && err.status == 500 && err.error.error) {
      this.errorMessage(err.error.error);
      return false;
    }
    if (err.status == -1) {
      this.errorMessage(this.translate('Failed To Connect With Server'));
    } else if (err.status == 401) {
      this.errorMessage(this.translate('Unauthorized Request!'));
      this.publishModalPopup('login');
    } else if (err.status == 500) {
      if (err.status == 500 && err.error && err.error.message) {
        this.errorMessage(err.error.message);
        return false;
      }
      this.errorMessage(this.translate('Something went wrong'));
    } else if (err.status == 422 && err.error.error) {
      this.errorMessage(err.error.error);
    } else {
      this.errorMessage(this.translate('Something went wrong'));
    }

  }
}
