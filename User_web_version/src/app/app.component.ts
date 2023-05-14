/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ChangeDetectorRef, Component, ElementRef, ViewChild } from '@angular/core';
import { NavigationCancel, NavigationEnd, NavigationError, NavigationExtras, NavigationStart, Router, RouterEvent } from '@angular/router';
import { ApiService } from './services/api.service';
import { UtilService } from './services/util.service';
import { filter } from 'rxjs/operators';
import { Title } from '@angular/platform-browser';
import { ModalDirective } from 'angular-bootstrap-md';
import { login } from './interfaces/login';
import { mobile } from './interfaces/mobile';
import { mobileLogin } from './interfaces/mobileLogin';
import { register } from './interfaces/register';
import { NgForm } from '@angular/forms';
import * as moment from 'moment';
import Swal from 'sweetalert2';
import { Subscription } from 'rxjs';
import { TranslateService } from '@ngx-translate/core';
import { environment } from './../environments/environment';
import * as firebase from 'firebase';
import { ProductCartService } from './services/product-cart.service';
import { ServiceCartService } from './services/service-cart.service';
declare var google: any;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  @ViewChild('verifyModal', { static: false }) public verifyModal: ModalDirective;
  @ViewChild('registerModal', { static: false }) public registerModal: ModalDirective;
  @ViewChild('loginModal', { static: false }) public loginModal: ModalDirective;
  @ViewChild('otpModal', { static: false }) public otpModal: ModalDirective;
  @ViewChild('locationModal', { static: false }) public locationModal: ModalDirective;
  @ViewChild('forgotPwd', { static: false }) public forgotPwd: ModalDirective;
  @ViewChild('sideMenu', { static: false }) public sideMenu: ModalDirective;
  @ViewChild('basicModal', { static: false }) public basicModal: ModalDirective;
  @ViewChild('scrollMe', { static: false }) private scrollMe: ElementRef;
  @ViewChild('topScrollAnchor', { static: false }) topScroll: ElementRef;
  @ViewChild('firebaseOTP') public firebaseOTP: ModalDirective;
  @ViewChild('firebaseOTPRegister') public firebaseOTPRegister: ModalDirective;

  login: login = { email: '', password: '' };
  mobile: mobile = { ccCode: this.api.default_country_code, phone: '', password: '' };
  mobileLogin: mobileLogin = { ccCode: this.api.default_country_code, phone: '' };
  registerForm: register = {
    email: '',
    first_name: '',
    last_name: '',
    password: '',
    gender: '1',
    mobile: '',
    fcm_token: '',
    type: '',
    lat: '',
    lng: '',
    cover: '',
    status: '',
    verified: '',
    others: '',
    date: '',
    stripe_key: '',
    referral: '',
    cc: this.api.default_country_code,
    check: false
  };
  viewAcc = false;
  autocomplete1: string;
  autocompleteItems1: any = [];
  GoogleAutocomplete;
  geocoder: any;
  submitted = false;
  ccCode: any;
  userCode: any = '';
  resendCode: boolean;
  otpId: any;
  uid: any;

  firebaseOTPText: any = '';

  languageClicked: boolean = false;
  title = 'Ultimate Salon';
  loaded: boolean;
  loading = true;
  loadingWidth: any = 70;
  deviceType = 'desktop';
  innerHeight: string;
  windowWidth: number;

  verticalNavType = 'expanded';
  verticalEffect = 'shrink';
  isLogin: boolean = false;

  div_type;
  sent: boolean;
  reset_email: any;
  reset_otp: any;
  reset_myOPT: any;
  reset_verified: any;
  reset_userid: any;
  reset_password: any;
  reset_repass: any;
  reset_loggedIn: boolean;
  reset_id: any;

  reset_phone: any;
  reset_cc: any = this.api.default_country_code;
  temp: any = '';
  name: any;
  msg: any = '';
  messages: any[] = [];
  uid_chat: any;
  id_chat: any;
  loaded_chat: boolean;
  yourMessage: boolean;
  interval: any;
  router$: Subscription;
  authToken: any;
  recaptchaVerifier: firebase.default.auth.RecaptchaVerifier;
  constructor(
    public api: ApiService,
    public util: UtilService,
    private router: Router,
    private titleService: Title,
    private chmod: ChangeDetectorRef,
    private translate: TranslateService,
    public productCart: ProductCartService,
    public serviceCart: ServiceCartService
  ) {
    const lng = localStorage.getItem('selectedLanguage');
    if (!lng || lng == null) {
      localStorage.setItem('selectedLanguage', 'en');
      localStorage.setItem('direction', 'ltr');
    }

    this.translate.use(localStorage.getItem('selectedLanguage'));
    document.documentElement.dir = localStorage.getItem('direction');
    const selectedLanguages = this.util.allLanguages.filter(x => x.code == localStorage.getItem('selectedLanguage'));
    if (selectedLanguages && selectedLanguages.length) {
      this.util.savedLanguages = selectedLanguages[0].name;
    }
    this.div_type = 1;
    const scrollHeight = window.screen.height - 150;
    this.innerHeight = scrollHeight + 'px';
    this.windowWidth = window.innerWidth;
    this.setMenuAttributs(this.windowWidth);
    this.router.events.pipe(filter(event => event instanceof NavigationEnd)).subscribe((event: any) => {
      console.log('end--->');
      window.scrollTo(10, 10);
    });
    this.router.events.subscribe((e: any) => {
      this.navigationInterceptor(e);
    });
    this.util.onSubscribe().subscribe(() => {
      this.loginModal.show();
    })
    this.resendCode = false;
    this.GoogleAutocomplete = new google.maps.places.AutocompleteService();
    this.geocoder = new google.maps.Geocoder();
    this.autocomplete1 = '';
    this.autocompleteItems1 = [];
    this.util.subscribeAddressPopup().subscribe(() => {
      this.locationModal.show();
    });
    this.util.subscribeModalPopup().subscribe((data: any) => {
      console.log('data', data);
      if (data && data == 'location') {
        this.locationModal.show();
      } else if (data && data == 'login') {
        this.loginModal.show();
      } else if (data && data == 'register') {
        this.registerModal.show();
      } else if (data && data == 'sideMenu') {
        this.sideMenu.show();
      }
    });
    this.api.getLocalAssets('country.json').then((data: any) => {
      this.util.countrys = data;
    }, error => {
      console.log(error);
    }).catch(error => {
      console.log(error);
    });
    this.initializeApp();
  }



  navigationInterceptor(event: RouterEvent): void {

    if (event instanceof NavigationStart) {
      console.log('start-----><>');
      this.loading = true;
      this.loaded = false;
    }
    if (event instanceof NavigationEnd) {
      console.log('endedd--->>>>')
      this.loading = false;
      this.loadingWidth = 99;
      this.loaded = true;
      window.scrollTo(0, 0);
      const data = this.getTitle(this.router.routerState, this.router.routerState.root);
      this.titleService.setTitle(data && data[0] ? this.util.translate(data[0]) + ' | ' + environment.app_name :
        this.util.translate('Home') + ' | ' + environment.app_name);
    }

    if (event instanceof NavigationCancel) {
      this.loading = false;
      this.loadingWidth = 99;
      this.loaded = true;
    }
    if (event instanceof NavigationError) {
      this.loading = false;
      this.loadingWidth = 99;
      this.loaded = true;
    }
  }

  getTitle(state: any, parent: any) {
    const data: any[] = [];
    if (parent && parent.snapshot.data && parent.snapshot.data.title) {
      data.push(parent.snapshot.data.title);
    }

    if (state && parent) {
      data.push(... this.getTitle(state, state.firstChild(parent)));
    }
    return data;
  }

  onResize(event) {
    this.innerHeight = event.target.innerHeight + 'px';
    /* menu responsive */
    this.windowWidth = event.target.innerWidth;
    let reSizeFlag = true;
    if (this.deviceType == 'tablet' && this.windowWidth >= 768 && this.windowWidth <= 1024) {
      reSizeFlag = false;
    } else if (this.deviceType == 'mobile' && this.windowWidth < 768) {
      reSizeFlag = false;
    }
    this.util.deviceType = this.deviceType;
    if (reSizeFlag) {
      this.setMenuAttributs(this.windowWidth);
    }
  }

  setMenuAttributs(windowWidth) {
    if (windowWidth >= 768 && windowWidth <= 1024) {
      this.deviceType = 'mobile';
      this.verticalNavType = 'offcanvas';
      this.verticalEffect = 'push';
    } else if (windowWidth < 768) {
      this.deviceType = 'mobile';
      this.verticalNavType = 'offcanvas';
      this.verticalEffect = 'overlay';
    } else {
      this.deviceType = 'desktop';
      this.verticalNavType = 'expanded';
      this.verticalEffect = 'shrink';
    }
    this.util.deviceType = this.deviceType;
    console.log('type', this.util.deviceType);
  }

  private smoothScrollTop(): void {
    this.topScroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
  }

  private onRouteUpdated(event: any): void {
    if (event instanceof NavigationEnd) {
      this.smoothScrollTop();
    }
  }

  ngOnInit() {
    this.router$ = this.router.events.subscribe(next => this.onRouteUpdated(next));
    setTimeout(() => {

      firebase.default.initializeApp(environment.firebase);

      this.recaptchaVerifier = new firebase.default.auth.RecaptchaVerifier('sign-in-button', {
        size: 'invisible',
        callback: (response) => {

        },
        'expired-callback': () => {
        }
      });
    }, 5000);
  }

  initializeApp() {
    this.util.cityAddress = localStorage.getItem('address');
    console.log('%c Copyright and Good Faith Purchasers © 2020-present initappz. ', 'background: #222; color: #bada55');
    this.api.get('v1/settings/getDefault').then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.data && data.data.settings && data.data.support) {
        const settings = data.data.settings;
        const support = data.data.support;

        this.util.direction = settings.appDirection;
        this.util.allowDistance = settings.allowDistance;
        this.util.cside = settings.currencySide;
        this.util.currecny = settings.currencySymbol;
        this.util.logo = settings.logo;
        this.util.user_login = settings.user_login;
        this.util.sms_name = settings.sms_name;
        this.api.default_country_code = settings.default_country_code;
        this.util.deliveryCharge = parseFloat(settings.delivery_charge);;
        this.util.delivery = settings.delivery_type;
        this.productCart.serviceTax = parseFloat(settings.tax);
        this.serviceCart.serviceTax = parseFloat(settings.tax);
        this.productCart.orderTax = parseFloat(settings.tax);
        this.serviceCart.orderTax = parseFloat(settings.tax);
        document.documentElement.dir = this.util.direction;

        this.util.general = settings;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(settings.social)) {
          const links = JSON.parse(settings.social);
          console.log(links);
          this.util.google_playstore = links.playstore;
          this.util.apple_appstore = links.appstore;

          this.util.facebook_link = links.facebook;
          this.util.instagram_link = links.instagram;
          this.util.twitter_link = links.twitter;
        }

        this.util.app_color = settings.app_color;
        this.util.user_verify_with = settings.user_verify_with;

        console.log(this);
      } else {
        this.util.direction = 'ltr';
        this.util.cside = 'right';
        this.util.currecny = '$';
        document.documentElement.dir = this.util.direction;
      }
    }, error => {
      console.log('default settings by id', error);
      this.util.appClosed = false;
      this.util.direction = 'ltr';
      this.util.cside = 'right';
      this.util.currecny = '$';
      document.documentElement.dir = this.util.direction;
    }).catch((error: any) => {
      console.log('default settings by id', error);
      this.util.appClosed = false;
      this.util.direction = 'ltr';
      this.util.cside = 'right';
      this.util.currecny = '$';
      document.documentElement.dir = this.util.direction;
    });

    const uid = localStorage.getItem('uid');
    if (uid && uid !== null && uid !== 'null') {

      this.api.post_private('v1/profile/getByID', { id: localStorage.getItem('uid') }).then((data: any) => {
        console.log('*******************', data);
        if (data && data.status && data.status == 200 && data.data && data.data.type == 'user') {
          this.util.userInfo = data.data;
        }
      }, error => {
        console.log(error);
      });
    }

  }

  locate(modal) {
    if (window.navigator && window.navigator.geolocation) {
      window.navigator.geolocation.getCurrentPosition(
        position => {
          console.log(position);
          this.locationModal.hide();
          this.getAddressOf(position.coords.latitude, position.coords.longitude);
        },
        error => {
          switch (error.code) {
            case 1:
              console.log('Permission Denied');
              this.util.errorMessage(this.util.translate('Location Permission Denied'));
              break;
            case 2:
              console.log('Position Unavailable');
              this.util.errorMessage(this.util.translate('Position Unavailable'));
              break;
            case 3:
              console.log('Timeout');
              this.util.errorMessage(this.util.translate('Failed to fetch location'));
              break;
          }
        }
      );
    };
  }

  onSearchChange(event) {
    console.log(event);
    if (this.autocomplete1 == '') {
      this.autocompleteItems1 = [];
      return;
    }
    const addsSelected = localStorage.getItem('addsSelected');
    if (addsSelected && addsSelected != null) {
      localStorage.removeItem('addsSelected');
      return;
    }

    this.GoogleAutocomplete.getPlacePredictions({ input: this.autocomplete1 }, (predictions, status) => {
      console.log(predictions);
      if (predictions && predictions.length > 0) {
        this.autocompleteItems1 = predictions;
        console.log(this.autocompleteItems1);
      }
    });
  }

  selectSearchResult1(item) {
    console.log('select', item);
    localStorage.setItem('addsSelected', 'true');
    this.autocompleteItems1 = [];
    this.autocomplete1 = item.description;
    this.geocoder.geocode({ placeId: item.place_id }, (results, status) => {
      if (status == 'OK' && results[0]) {
        console.log(status);
        localStorage.setItem('location', 'true');
        localStorage.setItem('lat', results[0].geometry.location.lat());
        localStorage.setItem('lng', results[0].geometry.location.lng());
        localStorage.setItem('address', this.autocomplete1);
        this.locationModal.hide();
        this.chmod.detectChanges();
        this.util.publishNewAddress();
        this.router.navigate(['']);
      }
    });
  }

  getAddressOf(lat, lng) {

    const geocoder = new google.maps.Geocoder();
    const location = new google.maps.LatLng(lat, lng);
    geocoder.geocode({ 'location': location }, (results, status) => {
      console.log(results);
      console.log('status', status);
      if (results && results.length) {
        localStorage.setItem('location', 'true');
        localStorage.setItem('lat', lat);
        localStorage.setItem('address', results[0].formatted_address);
        localStorage.setItem('lng', lng);
        this.util.publishNewAddress();
        this.router.navigate(['home']);
      }
    });
  }

  loginWithEmailPassword(form: NgForm, modal) {
    console.log('form', form, this.login);
    this.submitted = true;
    if (form.valid && this.login.email && this.login.password) {
      console.log('valid');
      const emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
      if (!emailfilter.test(this.login.email)) {
        this.util.errorMessage(this.util.translate('Please enter valid email'));
        return false;
      }
      console.log('login');

      this.isLogin = true;
      this.api.post('v1/auth/login', this.login).then((data: any) => {
        this.isLogin = false;
        console.log(data);
        if (data && data.status == 200) {
          if (data && data.user && data.user.type == 'user') {
            console.log(data.user.status);
            if (data && data.user && data.user.status == 1) {
              localStorage.setItem('uid', data.user.id);
              localStorage.setItem('token', data.token);
              localStorage.setItem('firstName', data.user.first_name);
              localStorage.setItem('lastName', data.user.last_name);
              localStorage.setItem('email', data.user.email);
              localStorage.setItem('mobile', data.user.mobile);
              this.util.userInfo = data.user;
              this.loginModal.hide();
            } else {
              this.loginModal.hide();
              Swal.fire({
                title: this.util.translate('Error'),
                text: this.util.translate('Your are blocked please contact administrator'),
                icon: 'error',
                showConfirmButton: true,
                showCancelButton: true,
                confirmButtonText: this.util.translate('OK'),
                backdrop: false,
                background: 'white'
              }).then(status => {
              });
            }

          } else {
            this.util.errorMessage(this.util.translate('Not valid user'));
          }

        } else if (data && data.status == 401) {
          this.util.errorMessage(data.error.error);
        } else {
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }
      }, error => {
        console.log(error);
        this.isLogin = false;
        this.util.errorMessage(this.util.translate('Something went wrong'));
      }).catch(error => {
        console.log(error);
        this.isLogin = false;
        this.util.errorMessage(this.util.translate('Something went wrong'));
      });


    } else {
      console.log('not valid');
    }
  }

  onOtpChangeFirebase(event) {
    console.log(event);
    this.firebaseOTPText = event;
  }

  loginWithMobileAndPassword(form: NgForm, modal) {
    console.log('form', form, this.mobile);
    this.submitted = true;
    if (form.valid && this.mobile.ccCode && this.mobile.phone && this.mobile.password) {
      console.log('valid');
      const param = {
        country_code: '+' + this.mobile.ccCode,
        mobile: this.mobile.phone,
        password: this.mobile.password
      };
      this.isLogin = true;
      this.api.post('v1/auth/loginWithPhonePassword', param).then((data: any) => {
        this.isLogin = false;
        console.log(data);
        if (data && data.status == 200) {
          if (data && data.user && data.user.type == 1) {
            console.log(data.user.status);
            if (data && data.user && data.user.status == 1) {
              localStorage.setItem('uid', data.user.id);
              localStorage.setItem('token', data.token);
              localStorage.setItem('firstName', data.user.first_name);
              localStorage.setItem('lastName', data.user.last_name);
              localStorage.setItem('email', data.user.email);
              localStorage.setItem('mobile', data.user.mobile);
              this.mobile.phone = '';
              this.mobile.password = '';
              this.util.userInfo = data.user;
              this.loginModal.hide();
            } else {
              this.loginModal.hide();
              Swal.fire({
                title: this.util.translate('Error'),
                text: this.util.translate('Your are blocked please contact administrator'),
                icon: 'error',
                showConfirmButton: true,
                showCancelButton: true,
                confirmButtonText: this.util.translate('OK'),
                backdrop: false,
                background: 'white'
              }).then(status => {
              });
            }

          } else {
            this.util.errorMessage(this.util.translate('Not valid user'));
          }

        } else if (data && data.status == 401) {
          this.util.errorMessage(data.error.error);
        } else {
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }
      }, error => {
        console.log(error);
        this.isLogin = false;
        this.util.errorMessage(this.util.translate('Something went wrong'));
      }).catch(error => {
        console.log(error);
        this.isLogin = false;
        this.util.errorMessage(this.util.translate('Something went wrong'));
      });

    } else {
      console.log('not valid');
    }
  }

  otpLogin() {


    console.log(this.userCode);
    if (this.userCode == '' || !this.userCode) {
      this.util.errorMessage(this.util.translate('Not valid code'));
      return false;
    }
    if (this.userCode) {
      const param = {
        id: this.otpId,
        otp: this.userCode
      };
      this.isLogin = true;
      this.api.post('v1/otp/verifyOTP', param).then((data: any) => {
        console.log(data);
        this.isLogin = false;
        if (data && data.status == 200) {
          const param = {
            mobile: this.mobileLogin.phone,
            country_code: '+' + this.mobileLogin.ccCode
          };

          this.api.post('v1/auth/loginWithMobileOtp', param).then((data: any) => {
            console.log('user data', data);
            if (data && data.status == 200) {
              if (data && data.user && data.user.type == 1) {
                console.log(data.user.status);
                if (data && data.user && data.user.status == 1) {
                  localStorage.setItem('uid', data.user.id);
                  localStorage.setItem('token', data.token);
                  localStorage.setItem('firstName', data.user.first_name);
                  localStorage.setItem('lastName', data.user.last_name);
                  localStorage.setItem('email', data.user.email);
                  localStorage.setItem('mobile', data.user.mobile);
                  this.mobile.phone = '';
                  this.mobile.password = '';
                  this.util.userInfo = data.user;
                  this.otpModal.hide();
                  this.loginModal.hide();
                } else {
                  this.otpModal.hide();
                  this.loginModal.hide();
                  Swal.fire({
                    title: this.util.translate('Error'),
                    text: this.util.translate('Your are blocked please contact administrator'),
                    icon: 'error',
                    showConfirmButton: true,
                    showCancelButton: true,
                    confirmButtonText: this.util.translate('OK'),
                    backdrop: false,
                    background: 'white'
                  }).then(status => {
                  });
                }

              } else {
                this.util.errorMessage(this.util.translate('Not valid user'));
              }

            } else if (data && data.status == 401) {
              this.util.errorMessage(data.error.error);
            } else {
              this.util.errorMessage(this.util.translate('Something went wrong'));
            }

          }, error => {

            console.log(error);
          }).catch(error => {

            console.log(error);
          });


        } else {
          if (data && data.status == 500 && data.data && data.data.message) {
            this.util.errorMessage(data.data.message);
            return false;
          }
          this.util.errorMessage(this.util.translate('Something went wrong'));
          return false;
        }
      }, error => {
        this.isLogin = false;
        console.log(error);
        this.util.errorMessage(this.util.translate('Something went wrong'));
      });
    } else {
      this.util.errorMessage(this.util.translate('Not valid code'));
      return false;
    }
  }

  onVerifyOTPFirebase() {
    if (this.firebaseOTPText == '' || !this.firebaseOTPText || this.firebaseOTPText == null) {
      this.util.errorMessage('OTP Missing');
      return false;
    }
    this.util.start();
    this.api.enterVerificationCode(this.firebaseOTPText).then(
      userData => {
        this.util.stop();
        this.loginModal.hide();
        this.firebaseOTP.hide();
        const param = {
          mobile: this.mobileLogin.phone,
          country_code: '+' + this.mobileLogin.ccCode
        };

        this.api.post('v1/auth/loginWithMobileOtp', param).then((data: any) => {
          console.log('user data', data);
          if (data && data.status == 200) {
            if (data && data.user && data.user.type == 1) {
              console.log(data.user.status);
              if (data && data.user && data.user.status == 1) {
                localStorage.setItem('uid', data.user.id);
                localStorage.setItem('token', data.token);
                localStorage.setItem('firstName', data.user.first_name);
                localStorage.setItem('lastName', data.user.last_name);
                localStorage.setItem('email', data.user.email);
                localStorage.setItem('mobile', data.user.mobile);
                this.mobile.phone = '';
                this.mobile.password = '';
                this.util.userInfo = data.user;
                this.otpModal.hide();
                this.loginModal.hide();
              } else {
                this.otpModal.hide();
                this.loginModal.hide();
                Swal.fire({
                  title: this.util.translate('Error'),
                  text: this.util.translate('Your are blocked please contact administrator'),
                  icon: 'error',
                  showConfirmButton: true,
                  showCancelButton: true,
                  confirmButtonText: this.util.translate('OK'),
                  backdrop: false,
                  background: 'white'
                }).then(status => {
                });
              }

            } else {
              this.util.errorMessage(this.util.translate('Not valid user'));
            }

          } else if (data && data.status == 401) {
            this.util.errorMessage(data.error.error);
          } else {
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }

        }, error => {

          console.log(error);
        }).catch(error => {

          console.log(error);
        });
        console.log(userData);
      }
    ).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  loginWithMobileAndOTP(form: NgForm, modal) {
    console.log('form', form, this.mobileLogin);
    this.submitted = true;
    if (form.valid && this.mobileLogin.ccCode && this.mobileLogin.phone) {
      console.log('valid');
      console.log('sms name', this.util.sms_name);
      if (this.util.sms_name == '2' || this.util.sms_name == 2) {
        console.log('firebase login');
        this.isLogin = true;
        const param = {
          mobile: this.mobileLogin.phone,
          country_code: '+' + this.mobileLogin.ccCode
        };
        this.api.post('v1/auth/verifyPhoneForFirebase', param).then((data: any) => {
          this.isLogin = false;
          console.log(data);
          this.api.signInWithPhoneNumber(this.recaptchaVerifier, '+' + this.mobileLogin.ccCode + this.mobileLogin.phone).then(
            success => {
              this.isLogin = false;
              this.firebaseOTP.show();
            }
          ).catch(error => {
            this.isLogin = false;
            console.log(error);
            this.util.errorMessage(error);
          });
        }, error => {
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }).catch(error => {
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      } else {
        console.log('other otp');
        const param = {
          mobile: this.mobileLogin.phone,
          country_code: '+' + this.mobileLogin.ccCode
        };
        this.isLogin = true;
        this.api.post('v1/otp/verifyPhone', param).then((data) => {
          this.isLogin = false;
          console.log(data);
          if (data && data.status == 200) {
            console.log('open modal');
            this.uid = data.otp_id;
            this.otpId = data.otp_id;
            this.otpModal.show();
          } else if (data && data.status == 500 && data.error && data.error.error) {
            this.util.errorMessage(data.error.error);
          } else {
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }
        }, error => {
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }).catch(error => {
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      }

    } else {
      console.log('not valid');
    }
  }

  onOtpChange(event) {
    console.log(event);
    this.userCode = event;
  }

  verify() {

    console.log(this.userCode);
    if (this.userCode == '' || !this.userCode) {
      this.util.errorMessage(this.util.translate('Not valid code'));
      return false;
    }
    if (this.userCode) {
      const param = {
        id: this.otpId,
        otp: this.userCode
      };
      this.isLogin = true;
      this.api.post('v1/otp/verifyOTP', param).then((data: any) => {
        console.log(data);
        this.isLogin = false;
        if (data && data.status == 200) {
          const registerParam = {
            first_name: this.registerForm.first_name,
            last_name: this.registerForm.last_name,
            email: this.registerForm.email,
            password: this.registerForm.password,
            gender: this.registerForm.gender,
            mobile: this.registerForm.mobile,
            country_code: '+' + this.registerForm.cc,
          };

          console.log('param', registerParam);
          this.util.start();
          this.api.post('v1/auth/create_user_account', registerParam).then((data: any) => {
            this.isLogin = false;
            this.util.stop();
            console.log(data);
            if (data && data.status == 200) {
              this.util.userInfo = data.user;
              localStorage.setItem('uid', data.user.id);
              localStorage.setItem('token', data.token);
              localStorage.setItem('firstName', data.user.first_name);
              localStorage.setItem('lastName', data.user.last_name);
              localStorage.setItem('email', data.user.email);
              localStorage.setItem('mobile', data.user.mobile);
              this.redeemCode();
              this.verifyModal.hide();
              this.registerModal.hide();
            } else if (data && data.status == 500) {
              this.util.errorMessage(data.error.error);
            } else {
              this.util.errorMessage(this.util.translate('Something went wrong'));
            }
          }, error => {
            console.log(error);
            this.util.stop();
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }).catch(error => {
            this.util.stop();
            console.log(error);
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          });

        } else {
          if (data && data.status == 500 && data.data && data.data.message) {
            this.util.errorMessage(data.data.message);
            return false;
          }
          this.util.errorMessage(this.util.translate('Something went wrong'));
          return false;
        }
      }, error => {
        this.isLogin = false;
        console.log(error);
        this.util.errorMessage(this.util.translate('Something went wrong'));
      });
    } else {
      this.util.errorMessage(this.util.translate('Not valid code'));
      return false;
    }
  }

  redeemCode() {
    if (this.registerForm.referral && this.registerForm.referral != '' && this.registerForm.referral != null) {
      console.log('have redeem code');
      const body = { "id": localStorage.getItem('uid'), "code": this.registerForm.referral };
      this.util.start();
      this.api.post_private('v1/referral/redeemReferral', body).then((data: any) => {
        console.log(data);
        this.util.stop();
        if (data && data.status && data.status == 200) {
          const info = data.data;
          let msg = '';
          if (info && info.who_received == 1) {
            msg = this.util.translate('Congratulations your friend have received the') +
              this.util.currencySymbol +
              info.amount +
              ' ' +
              this.util.translate('on wallet');
          } else if (info && info.who_received == 2) {
            msg = this.util.translate('Congratulations you have received the ') +
              this.util.currencySymbol +
              info.amount +
              ' ' +
              this.util.translate('on wallet');
          } else if (info && info.who_received == 3) {
            msg = this.util.translate('Congratulations you & your friend have received the ') +
              this.util.currencySymbol +
              info.amount +
              ' ' +
              this.util.translate('on wallet');
          }
          Swal.fire({
            title: this.util.translate('Success'),
            text: msg,
            icon: 'success',
            showConfirmButton: true,
            showCancelButton: true,
            confirmButtonText: this.util.translate('OK'),
            backdrop: false,
            background: 'white'
          }).then(status => {

          });
        }
      }, error => {
        console.log(error);
        this.util.stop();
        this.util.errorMessage(this.util.translate('Something went wrong'));
      }).catch(error => {
        console.log(error);
        this.util.stop();
        this.util.errorMessage(this.util.translate('Something went wrong'));
      });
    } else {
      console.log('no redeem code');
    }
  }

  onRegister(form: NgForm, registerModal, verification) {
    console.log(form);
    console.log(this.util.user_verify_with);
    console.log('form', this.registerForm, this.ccCode);
    console.log(this.util.twillo);
    this.submitted = true;
    console.log(this.registerForm.check);
    if (form.valid && this.registerForm.check && this.registerForm.email && this.registerForm.password && this.registerForm.first_name
      && this.registerForm.last_name && this.registerForm.mobile && this.registerForm.cc) {
      console.log('valid data');
      const emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
      if (!emailfilter.test(this.registerForm.email)) {
        this.util.errorMessage(this.util.translate('Please enter valid email'));
        return false;
      }
      if (this.util.user_verify_with == 0) {
        console.log('email verification');
        const param = {
          'email': this.registerForm.email,
          'subject': this.util.translate('Verification'),
          'header_text': this.util.translate('Use this code for verification'),
          'thank_you_text': this.util.translate("Don't share this otp to anybody else"),
          'mediaURL': this.api.baseUrl,
          'country_code': '+' + this.registerForm.cc,
          'mobile': this.registerForm.mobile
        };
        this.isLogin = true;
        this.api.post('v1/sendVerificationOnMail', param).then((data: any) => {
          console.log(data);
          this.isLogin = false;
          if (data && data.status == 200) {
            verification.show();
            this.otpId = data.otp_id;

          } else if (data && data.status == 401) {
            this.isLogin = false;
            this.util.errorMessage(data.error.error);
          } else if (data && data.status == 500) {
            this.isLogin = false;
            this.util.errorMessage(data.message);
          } else {
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }
        }, error => {
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }).catch(error => {
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      } else {
        if (this.util.sms_name == '2') {
          console.log('firebase verification');
          const param = {
            'country_code': '+' + this.registerForm.cc,
            'mobile': this.registerForm.mobile,
            'email': this.registerForm.email
          };
          this.api.post('v1/auth/verifyPhoneForFirebaseRegistrations', param).then((data: any) => {
            console.log(data);

            if (data && data.status == 200) {

              this.api.signInWithPhoneNumber(this.recaptchaVerifier, '+' + this.registerForm.cc + this.registerForm.mobile).then(
                success => {
                  this.isLogin = false;
                  this.registerModal.hide();
                  this.firebaseOTPRegister.show();
                }
              ).catch(error => {
                this.isLogin = false;
                console.log(error);
                this.util.errorMessage(error);
              });

            } else if (data && data.status == 401) {
              this.isLogin = false;
              this.util.errorMessage(data.error.error);
            } else if (data && data.status == 500) {
              this.isLogin = false;
              this.util.errorMessage(data.message);
            } else {
              this.isLogin = false;
              this.util.errorMessage(this.util.translate('Something went wrong'));
            }
          }, error => {
            console.log(error);
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }).catch(error => {
            console.log(error);
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          });
        } else {
          console.log('other otp');
          this.isLogin = true;
          const param = {
            'country_code': '+' + this.registerForm.cc,
            'mobile': this.registerForm.mobile,
            'email': this.registerForm.email
          };
          this.api.post('v1/verifyPhoneSignup', param).then((data: any) => {
            console.log(data);
            this.isLogin = false;
            if (data && data.status == 200) {
              verification.show();
              this.otpId = data.otp_id;

            } else if (data && data.status == 401) {
              this.isLogin = false;
              this.util.errorMessage(data.error.error);
            } else if (data && data.status == 500) {
              this.isLogin = false;
              this.util.errorMessage(data.message);
            } else {
              this.isLogin = false;
              this.util.errorMessage(this.util.translate('Something went wrong'));
            }
          }, error => {
            console.log(error);
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }).catch(error => {
            console.log(error);
            this.isLogin = false;
            this.util.errorMessage(this.util.translate('Something went wrong'));
          });
        }
      }

    } else {
      console.log('not valid data...');
      this.util.errorMessage('All fields are required');
    }
  }

  verifyRegisterFirebaseOTP() {
    if (this.firebaseOTPText == '' || !this.firebaseOTPText || this.firebaseOTPText == null) {
      this.util.errorMessage('OTP Missing');
      return false;
    }
    this.util.start();
    this.api.enterVerificationCode(this.firebaseOTPText).then(
      userData => {
        this.util.stop();
        this.firebaseOTPRegister.hide();
        const registerParam = {
          first_name: this.registerForm.first_name,
          last_name: this.registerForm.last_name,
          email: this.registerForm.email,
          password: this.registerForm.password,
          gender: this.registerForm.gender,
          mobile: this.registerForm.mobile,
          country_code: '+' + this.registerForm.cc,
        };

        console.log('param', registerParam);
        this.util.start();
        this.api.post('v1/auth/create_user_account', registerParam).then((data: any) => {
          this.isLogin = false;
          this.util.stop();
          console.log(data);
          if (data && data.status == 200) {
            this.util.userInfo = data.user;
            localStorage.setItem('uid', data.user.id);
            localStorage.setItem('token', data.token);
            localStorage.setItem('firstName', data.user.first_name);
            localStorage.setItem('lastName', data.user.last_name);
            localStorage.setItem('email', data.user.email);
            localStorage.setItem('mobile', data.user.mobile);
            this.redeemCode();
          } else if (data && data.status == 500) {
            this.util.errorMessage(data.error.error);
          } else {
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }
        }, error => {
          console.log(error);
          this.util.stop();
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }).catch(error => {
          this.util.stop();
          console.log(error);
          this.isLogin = false;
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      }
    ).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  sendVerification(mail, link) {
    const param = {
      email: mail,
      url: link
    };

    this.api.post('users/sendVerificationMail', param).then((data) => {
      console.log('mail', data);
    }, error => {
      console.log(error);
    });
  }

  openLink(type) {
    if (type == 'eula') {
      window.open('https://initappz.com/foodiesaagya/eula.html');
    } else {
      window.open('https://initappz.com/foodiesaagya/privacy.html');
    }
  }

  sendResetLink() {
    console.log(this.reset_email, ';sendOTPDriver');
    if (!this.reset_email) {
      this.util.errorMessage(this.util.translate('Email is required'));
      return false;
    }
    const emailfilter = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailfilter.test(this.reset_email)) {
      this.util.errorMessage(this.util.translate('Please enter valid email'));
      return false;
    }
    this.isLogin = true;
    const param = {
      email: this.reset_email
    };
    this.api.post('v1/auth/verifyEmailForReset', param).then((data: any) => {
      console.log(data);
      this.isLogin = false;
      if (data && data.status == 200) {
        this.reset_id = data.otp_id;
        this.isLogin = false;
        this.div_type = 2;
      } else {
        if (data && data.status == 500 && data.error && data.error.error) {
          this.util.errorMessage(data.error.error);
          return false;
        }
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    }, error => {
      console.log(error);
      this.isLogin = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  verifyOTPOfReset() {
    if (!this.reset_otp || this.reset_otp == '') {
      this.util.errorMessage(this.util.translate('otp is required'));
      return false;
    }
    this.isLogin = true;
    const param = {
      id: this.reset_id,
      otp: this.reset_otp,
      email: this.reset_email
    };
    this.api.post('v1/otp/verifyOTPReset', param).then((data: any) => {
      console.log(data);
      this.isLogin = false;
      if (data && data.status == 200) {
        this.isLogin = false;
        this.temp = data.temp;
        console.log(this.temp);
        this.div_type = 3;
      } else {
        if (data && data.status == 500 && data.error && data.error.error) {
          this.util.errorMessage(data.error.error);
          return false;
        }
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    }, error => {
      console.log(error);
      this.isLogin = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  sendEmailResetPasswordMail() {
    if (!this.reset_password || !this.reset_repass || this.reset_password == '' || this.reset_repass == '') {
      this.util.errorMessage(this.util.translate('All Field are required'));
      return false;
    }
    const param = {
      email: this.reset_email,
      password: this.reset_password,
      id: this.reset_id
    };
    this.isLogin = true;
    this.api.post_temp('v1/password/updateUserPasswordWithEmail', param, this.temp).then((data: any) => {
      console.log(data);
      this.isLogin = false;
      if (data && data.status == 200) {
        this.isLogin = false;
        this.util.suucessMessage(this.util.translate('Password Updated'));
        this.forgotPwd.hide();
      } else {
        if (data && data.status == 500 && data.error && data.error.message) {
          this.util.errorMessage(data.error.error);
          return false;
        }
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    }, error => {
      console.log(error);
      this.isLogin = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  sendOTPOnMobile() {
    const param = {
      phone: this.reset_phone
    };
    this.isLogin = true;
    this.api.post('users/validatePhoneForReset', param).then((data: any) => {
      this.isLogin = false;
      console.log('data', data);
      if (data && data.status == 200) {
        console.log('all done...');
        console.log('+', this.reset_cc, this.reset_phone);
        this.sendOTPForReset();
        this.div_type = 2;
      } else if (data && data.status == 500) {
        this.util.errorMessage(data.data.message);
      } else {
        this.util.errorMessage(this.util.translate('Something went wrong'));
      }
    }, error => {
      console.log(error);
      this.isLogin = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.isLogin = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  sendOTPForReset() {
    const message = this.util.translate('Your Ultimate Salon app verification code : ');
    const param = {
      msg: message,
      to: '+' + this.reset_cc + this.reset_phone
    };
    console.log(param);
    this.util.start();
    this.api.post('users/twilloMessage', param).then((data: any) => {
      console.log(data);
      this.reset_id = data.data.id;
      this.util.stop();
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  verifyResetCode() {
    console.log(this.reset_otp);
    if (this.reset_otp == '' || !this.reset_otp) {
      this.util.errorMessage(this.util.translate('Not valid code'));
      return false;
    }
    if (this.reset_otp) {
      const param = {
        id: this.reset_id,
        otp: this.reset_otp
      };
      this.isLogin = true;
      this.api.post('users/verifyOTP', param).then((data: any) => {
        console.log(data);
        this.isLogin = false;
        if (data && data.status == 200) {
          this.div_type = 3;
          // this.modalCtrl.dismiss('', 'ok');
        } else {
          if (data && data.status == 500 && data.data && data.data.message) {
            this.util.errorMessage(data.data.message);
            return false;
          }
          this.util.errorMessage(this.util.translate('Something went wrong'));
          return false;
        }
      }, error => {
        this.isLogin = false;
        console.log(error);
        this.util.errorMessage(this.util.translate('Something went wrong'));
      });
    } else {
      this.util.errorMessage(this.util.translate('Not valid code'));
      return false;
    }
  }

  resetPasswordWithPhone() {
    console.log('pwddd0<<<<<<', this.reset_password);
    if (!this.reset_password || !this.reset_repass || this.reset_password == '' || this.reset_repass == '') {
      this.util.errorMessage(this.util.translate('All Field are required'));
      return false;
    }
    const param = {
      phone: this.reset_phone,
      pwd: this.reset_password
    };
    this.isLogin = true;
    this.api.post('users/resetPasswordWithPhone', param).then((data: any) => {
      console.log(data);
      this.isLogin = false;
      if (data && data.status == 200) {
        this.isLogin = false;
        this.util.suucessMessage(this.util.translate('Password Updated'));
        this.forgotPwd.hide();
      } else {
        if (data && data.status == 500 && data.data && data.data.message) {
          this.util.errorMessage(data.data.message);
          return false;
        }
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    }, error => {
      console.log(error);
      this.isLogin = false;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  onPage(item) {
    console.log(item);
    this.sideMenu.hide();
    this.router.navigate([item]);
  }

  onProfile(item) {
    this.sideMenu.hide();
    if (this.util && this.util.userInfo && this.util.userInfo.first_name) {
      const name = (this.util.userInfo.first_name + '-' + this.util.userInfo.last_name).toLowerCase();
      this.router.navigate(['user', name, item]);
    } else {
      this.loginModal.show();
    }
  }

  changeLanguage(value) {
    const item = this.util.allLanguages.filter(x => x.code == value.code);
    if (item && item.length > 0) {
      localStorage.setItem('selectedLanguage', value.code);
      localStorage.setItem('direction', value.direction);
      window.location.reload();
    }
  }

  haveSigned() {
    const uid = localStorage.getItem('uid');
    if (uid && uid != null && uid !== 'null') {
      return true;
    }
    return false;
  }

  logout() {
    this.util.start();
    this.api.post_private('v1/profile/logout', {}).then((data: any) => {
      console.log(data);
      this.util.stop();
      this.sideMenu.hide();

      localStorage.removeItem('token');
      this.chmod.detectChanges();
      this.router.navigate(['']);
    }, error => {
      console.log(error);
      this.util.stop();
    }).catch((error: any) => {
      console.log(error);
      this.util.stop();
    });

  }

  closeModal() {
    clearInterval(this.interval);
    this.basicModal.hide();
  }

  sendMessage() {
    // store to opponent
    console.log(this.msg);
    if (!this.msg || this.msg == '') {
      return false;
    }
    const msg = this.msg;
    this.msg = '';
    const param = {
      room_id: this.id_chat,
      uid: this.id_chat + '_' + this.uid_chat,
      from_id: this.uid_chat,
      message: msg,
      message_type: 'users',
      status: 1,
      timestamp: moment().format('YYYY-MM-DD HH:mm:ss')
    };
    // this.myContent.scrollToBottom(300);
    this.yourMessage = false;
    this.api.post_token('chats/save', param, this.authToken).then((data: any) => {
      console.log(data);
      if (data && data.status == 200) {
        this.getInbox();
      } else {
        this.yourMessage = true;
      }
    }, error => {
      console.log(error);
      this.yourMessage = true;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  getInbox() {
    const param = {
      id: this.id_chat + '_' + this.uid_chat,
      oid: this.id_chat
    };
    this.api.post_token('chats/getById', param, this.authToken).then((data: any) => {
      console.log(data);
      this.loaded_chat = true;
      this.yourMessage = true;
      if (data && data.status == 200) {
        this.messages = data.data;
        this.scrollToBottom();
      }
    }, error => {
      console.log(error);
      this.loaded_chat = true;
      this.yourMessage = true;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  scrollToBottom() {
    console.log(this.scrollMe.nativeElement.scrollTop);
    this.scrollMe.nativeElement.scrollTop = this.scrollMe.nativeElement.scrollHeight;
    console.log(this.scrollMe.nativeElement.scrollTop);
    // try {

    // } catch (err) { }
  }
}
