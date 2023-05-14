/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router } from '@angular/router';
import { CollapseComponent, ModalDirective } from 'angular-bootstrap-md';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { ServiceCartService } from 'src/app/services/service-cart.service';
import { UtilService } from 'src/app/services/util.service';
import Swal from 'sweetalert2';
import {
  IPayPalConfig,
  ICreateOrderRequest
} from 'ngx-paypal';

declare let FlutterwaveCheckout: any;
declare let PaystackPop: any;
declare let Razorpay: any;
declare var google;

@Component({
  selector: 'app-freelancer-checkout',
  templateUrl: './freelancer-checkout.component.html',
  styleUrls: ['./freelancer-checkout.component.scss']
})
export class FreelancerCheckoutComponent implements OnInit {
  @ViewChild('deliveryAddress', { static: true }) public deliveryAddress: ModalDirective;
  @ViewChild('couponModal', { static: true }) public couponModal: ModalDirective;
  @ViewChild('successModal', { static: true }) public successModal: ModalDirective;
  @ViewChild('stripeModal', { static: true }) public stripeModal: ModalDirective;
  @ViewChild('addCardModal', { static: true }) public addCardModal: ModalDirective;
  @ViewChild('payPalModal') public payPalModal: ModalDirective;
  @ViewChild('id2') collapse: CollapseComponent;
  @ViewChild('id3') sloptCollapse: CollapseComponent;

  public payPalConfig?: IPayPalConfig;
  public checkModel: any = { left: true, middle: false, right: false };
  public radioModel: string = 'Left';

  currentDate: any;
  currentWeek = 0;
  days: any[] = [];
  initDate: any;
  selectedDate: any;
  selectedSlot: any;
  selectedAddress: any;
  orderNotes: any = '';
  paymentId: any = '';
  payMethodName: any = '';
  addressList: any[] = [];
  addressTitle: any[] = ['Home', 'Office', 'Other'];
  slotList: any[] = [];
  bookedSlots: any[] = [];
  offersList: any[] = [];
  selectedSlotIndex = '';
  freelancerCover: any = '';
  freelancerName: any = '';
  rating: any = 0;
  totalRating: any = 0;
  dayList: any[] = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  addressId = 0;
  title = '';
  address = '';
  house = '';
  landmark = '';
  zipcode = '';
  lat = 0;
  lng = 0;
  isNewAddress = true;
  currency_code: any = '';
  cardNumber: any = '';
  cvv: any = '';
  expiryDate: any = '';
  cardHolderName: any = '';
  cardEmail: any = '';
  stripeKey: any = '';
  stripeCardList: any[] = [];
  selectedCard: any = '';
  paymentMethodList: any[] = [];

  balance: any = 0.0;
  walletDiscount: any = 0.0;
  walletCheck: boolean = false;
  storeInfo: any;
  constructor(private router: Router,
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    public serviceCart: ServiceCartService) {
    if (this.serviceCart && this.serviceCart.totalItemInCart > 0) {
      setTimeout(() => {
        this.dateConfi();
        this.selectedDate = moment().format().split('T')[0];
        this.getSlotsForBookings();
        this.getAddress();
        this.getPayments();
        this.getFreelancerByID();
        this.getProfile();
        this.getWalletAmount();
      }, 1000);
    } else {
      this.router.navigate(['']);
    }
  }

  removeService(item: any) {
    item.isChecked = false;
    this.serviceCart.removeItem(item.id);
    if (this.serviceCart.serviceCart.length == 0 && this.serviceCart.packagesCart.length == 0) {
      this.router.navigate(['']);
    }
  }

  removePackage(item: any) {
    item.isChecked = false;
    this.serviceCart.removePackage(item.id);
    if (this.serviceCart.serviceCart.length == 0 && this.serviceCart.packagesCart.length == 0) {
      this.router.navigate(['']);
    }
  }

  getWalletAmount() {
    this.api.post_private('v1/profile/getMyWalletBalance', { id: localStorage.getItem('uid') }).then((data: any) => {
      console.log('------------------', data);
      if (data && data.status && data.status == 200 && data.data) {
        this.balance = parseFloat(data.data.balance);
        this.walletDiscount = parseFloat(data.data.balance);
        console.log(this.balance, this.walletDiscount);
      }
    }, error => {
      console.log(error);
    }).catch(error => {
      console.log(error);
    });
  }

  getAddress() {
    const param = {
      id: localStorage.getItem('uid')
    };
    this.api.post_private('v1/address/getByUID', param).then((data: any) => {
      if (data && data.status == 200) {
        console.log(data);
        this.addressList = data.data;
        console.log(this.addressList);
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getLatLngFromAddress() {
    if (this.address == '' || this.house == '' ||
      this.landmark == '' || this.zipcode == '') {
      this.util.apiErrorHandler(this.util.translate('all fields are required'));
      return false;
    }
    const geocoder = new google.maps.Geocoder;
    this.util.start();
    geocoder.geocode({ address: this.house + ' ' + this.landmark + ' ' + this.address + ' ' + this.zipcode }, (results, status) => {
      console.log(results, status);
      if (status == 'OK' && results && results.length) {
        this.lat = results[0].geometry.location.lat();
        this.lng = results[0].geometry.location.lng();
        console.log('----->', this.lat, this.lng);
        if (this.isNewAddress == true) {
          this.saveAddress();
        } else {
          this.updateAddress();
        }
      } else {
        this.util.stop();
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    });

  }

  saveAddress() {
    if (this.address == '' || this.house == '' ||
      this.landmark == '' || this.zipcode == '') {
      this.util.apiErrorHandler(this.util.translate('all fields are required'));
      return false;
    }
    const param = {
      uid: localStorage.getItem('uid'),
      title: this.title,
      address: this.address,
      house: this.house,
      landmark: this.landmark,
      pincode: this.zipcode,
      lat: this.lat,
      lng: this.lng,
      status: 1,
    }
    this.util.start();
    this.api.post_private('v1/address/save', param).then((data: any) => {
      if (data && data.status == 200) {
        this.util.stop();
        console.log(data);
        this.deliveryAddress.hide();
        this.getAddress();
        this.util.suucessMessage(this.util.translate('Address Added'));
      }
    }, error => {
      console.log('Error', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    },
    ).catch(error => {
      console.log('Err', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    },
    );
  }

  addNewAddress() {
    this.isNewAddress = true;
    this.house = '';
    this.landmark = '';
    this.address = '';
    this.addressId = 0;
    this.zipcode = '';
    this.deliveryAddress.show();
  }

  onEditAddress(item: any) {
    this.addressId = item.id;
    this.isNewAddress = false;
    this.address = item.address;
    this.house = item.house;
    this.landmark = item.landmark;
    this.zipcode = item.pincode;
    this.title = item.title;
    this.deliveryAddress.show();
  }

  updateAddress() {
    const param = {
      uid: localStorage.getItem('uid'),
      title: this.title,
      address: this.address,
      id: this.addressId,
      house: this.house,
      landmark: this.landmark,
      pincode: this.zipcode,
      lat: this.lat,
      lng: this.lng,
      status: 1,
    }
    this.util.start();
    this.api.post_private('v1/address/update', param).then((data: any) => {
      if (data && data.status == 200) {
        this.util.stop();
        this.deliveryAddress.hide();
        this.getAddress();
        console.log(data);
        this.util.suucessMessage(this.util.translate('Address Updated'));
      }
    }, error => {
      console.log('Error', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    },
    ).catch(error => {
      console.log('Err', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    },
    );
  }

  selectAddress(item: any) {
    console.log(item);
    this.calculateDistance(item.lat, item.lng, item);
    this.collapse.toggle();
  }

  async calculateDistance(addressLat: any, addressLng: any, address) {
    console.log(this.serviceCart.deliveredAddress);
    console.log(this.storeInfo);
    let distance;

    if (this.storeInfo && this.storeInfo.lat) {
      distance = await this.distanceInKmBetweenEarthCoordinates(addressLat, addressLng,
        this.storeInfo.lat, this.storeInfo.lng);
    } else {
      distance = 0;
    }

    console.log(distance, this.util.allowDistance);

    if (distance >
      parseFloat(this.util.allowDistance)) {
      this.util.errorMessage(this.util.translate(
        'Sorry we deliver the order near to ' + this.util.allowDistance));
    } else {
      if (this.util.deliveryType == 0) {
        let distanceParse = distance * this.util.deliveryCharge;
        this.serviceCart.deliveryCharge = distanceParse;
        this.serviceCart.deliveredAddress = address;
      } else {
        this.serviceCart.deliveryCharge = this.util.deliveryCharge;
      }
      this.serviceCart.deliveryCharge = parseFloat(this.serviceCart.deliveryCharge).toFixed(2);
      this.serviceCart.calculateAllCharges();
    }

    console.log('delivery charge', this.serviceCart.deliveryCharge);
  }

  distanceInKmBetweenEarthCoordinates(lat1: any, lon1: any, lat2: any, lon2: any) {
    console.log(lat1, lon1, lat2, lon2);
    const earthRadiusKm = 6371;
    const dLat = this.degreesToRadians(lat2 - lat1);
    const dLon = this.degreesToRadians(lon2 - lon1);
    lat1 = this.degreesToRadians(lat1);
    lat2 = this.degreesToRadians(lat2);
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  degreesToRadians(degrees: any) {
    return degrees * Math.PI / 180;
  }

  getSlotsForBookings() {
    let uid = '';
    if (this.serviceCart.serviceCart.length > 0) {
      uid = this.serviceCart.serviceCart[0].uid;
    } else if (this.serviceCart.packagesCart.length > 0) {
      uid = this.serviceCart.packagesCart[0].uid;
    }
    const param = {
      week_id: this.dayList.indexOf(moment(this.selectedDate).format('dddd')),
      date: this.selectedDate,
      uid: uid,
      "from": "individual"
    };
    this.bookedSlots = [];
    this.slotList = [];
    this.api.post_private('v1/timeslots/getSlotsByForBookings', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.data && data.data.slots && data.bookedSlots) {
        this.slotList = JSON.parse(data.data.slots);
        this.bookedSlots = [];
        data.bookedSlots.forEach((element: any) => {
          this.bookedSlots.push(element.slot);
        });
        console.log(this.slotList);
        console.log(this.bookedSlots);
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  selectSlot(item: any) {
    console.log(item)
    this.selectedSlotIndex = item;
    this.sloptCollapse.toggle();
  }

  getFreelancerByID() {
    let uid = '';
    if (this.serviceCart.serviceCart.length > 0) {
      uid = this.serviceCart.serviceCart[0].uid;
    } else if (this.serviceCart.packagesCart.length > 0) {
      uid = this.serviceCart.packagesCart[0].uid;
    }
    const param = {
      id: uid
    };
    this.api.post('v1/individual/individualDetails', param).then((data: any) => {
      if (data && data.status == 200) {
        console.log(data);
        this.freelancerCover = data.userInfo.cover;
        this.freelancerName = data.userInfo.first_name + ' ' + data.userInfo.last_name;
        this.rating = data.data.rating;
        this.totalRating = data.data.total_rating;
        this.storeInfo = data.data;
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  dateConfi() {
    this.selectedDate = moment().format().split('T')[0];
    this.currentDate = moment().format().split('T')[0];

    this.days = [];
    this.initDate = moment().format();
    const startOfWeek = moment().startOf('week');
    const endOfWeek = moment().endOf('week');
    let day = startOfWeek;
    while (day <= endOfWeek) {
      const data = {
        date: day.toDate().getDate(),
        day: day.format('ddd'),
        val: day.format(),
        selectDay: day.format('dddd DD MMMM')
      }
      this.days.push(data);
      day = day.clone().add(1, 'd');
    }
  }

  previousWeek() {
    if (this.currentWeek !== 0) {
      this.days = [];
      this.currentWeek = this.currentWeek - 1;
      const startOfWeek = moment().add(this.currentWeek, 'weeks').startOf('week');
      const endOfWeek = moment().add(this.currentWeek, 'weeks').endOf('week');
      let day = startOfWeek;
      while (day <= endOfWeek) {
        const data = {
          date: day.toDate().getDate(),
          day: day.format('ddd'),
          val: day.format(),
          selectDay: day.format('dddd DD MMMM')
        }
        this.days.push(data);
        day = day.clone().add(1, 'd');
      }
      console.log(this.days);
    }
  }

  selectDate(date: any) {
    console.log(date)
    if (this.currentDate <= date.val.split('T')[0]) {
      this.selectedDate = date.val.split('T')[0];
      console.log(this.selectedDate);
      this.getSlotsForBookings();
    }
  }

  nextWeek() {
    this.days = [];
    this.currentWeek++;
    console.log(this.currentWeek);
    const startOfWeek = moment().add(this.currentWeek, 'weeks').startOf('week');
    const endOfWeek = moment().add(this.currentWeek, 'weeks').endOf('week');
    let day = startOfWeek;
    while (day <= endOfWeek) {
      const data = {
        date: day.toDate().getDate(),
        day: day.format('ddd'),
        val: day.format(),
        selectDay: day.format('dddd DD MMMM')
      }
      this.days.push(data);
      day = day.clone().add(1, 'd');
    }
    console.log(this.days);
  }

  addCoupon() {
    this.getActiveOffers();
    this.couponModal.show();
  }

  removeOffer() {
    this.serviceCart.coupon = null;
    this.serviceCart.calcuate();
    localStorage.removeItem('selectedOffer');
  }

  selectedOffers(item: any) {
    if (this.serviceCart && this.serviceCart.walletDiscount && this.serviceCart.walletDiscount > 0) {
      this.util.errorMessage(this.util.translate('Sorry you have already added a wallet discount to cart'));
      return false;
    }
    console.log(item, this.storeInfo);
    const ids = item.freelancer_ids.split(',').map(Number);
    console.log(ids);
    console.log(ids.includes(this.storeInfo.uid))
    if (ids.includes(this.storeInfo.uid)) {
      this.serviceCart.coupon = item;
      this.serviceCart.calculateAllCharges();
      this.couponModal.hide();
    } else {
      this.util.errorMessage(this.util.translate('This coupon is not valid for ') + this.freelancerName);
    }
  }

  getActiveOffers() {
    this.util.start();
    this.api.get_private('v1/offers/getActive').then((data: any) => {
      this.util.stop();
      console.log(data);
      if (data && data.status == 200) {
        this.offersList = data.data;
        console.log(this.offersList);
      }
    }, error => {
      console.log('Error', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });
  }

  getPayments() {
    this.api.get_private('v1/payments/getPayments').then((data: any) => {
      if (data && data.status == 200) {
        console.log(data);
        this.paymentMethodList = data.data;
        console.log(this.paymentMethodList);

        const haveFlutterwave = this.paymentMethodList.filter(x => x.id == 8); // flutterwave id
        if (haveFlutterwave.length) {
          this.util.loadScript('https://checkout.flutterwave.com/v3.js');
        }
        const havePaystack = this.paymentMethodList.filter(x => x.id == 7);
        if (havePaystack.length) {
          this.util.loadScript('https://js.paystack.co/v1/inline.js'); // paystack id
        }

        const haveRazorPay = this.paymentMethodList.filter(x => x.id == 5); // razorpay id
        if (haveRazorPay.length) {
          this.util.loadScript('https://checkout.razorpay.com/v1/checkout.js');
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

  savePayment(id: any) {
    console.log(id)
    this.paymentId = id;
    if (this.paymentId == 1) {
      this.payMethodName = 'cod';
    } else if (this.paymentId == 2) {
      this.payMethodName = 'stripe';
    } else if (this.paymentId == 3) {
      this.payMethodName = 'paypal';
    } else if (this.paymentId == 4) {
      this.payMethodName = 'paytm';
    } else if (this.paymentId == 5) {
      this.payMethodName = 'razorpay';
    } else if (this.paymentId == 6) {
      this.payMethodName = 'instamojo';
    } else if (this.paymentId == 7) {
      this.payMethodName = 'paystack';
    } else if (this.paymentId == 8) {
      this.payMethodName = 'flutterwave';
    }

  }

  onCheckout() {
    if (!this.serviceCart.deliveredAddress || !this.serviceCart.deliveredAddress.address || !this.serviceCart.deliveredAddress.lat) {
      console.log('Please select Address');
      this.util.errorMessage(this.util.translate('Please select Address'))
      return false;
    } else if (this.selectedSlotIndex == '') {
      console.log('Please select Slot');
      this.util.errorMessage(this.util.translate('Please select Slot'))
      return false;
    }
    if (this.paymentId == 0) {
      this.util.errorMessage(this.util.translate('Please select payment method'));
      return;
    } else if (this.paymentId == 1) {
      this.createOrder
        ('COD');
    } else if (this.paymentId == 2) {
      this.stripeModal.show();
    } else if (this.paymentId == 3) {
      this.payPalWebPay();
    } else if (this.paymentId == 4) {
      this.payTmWeb();
    } else if (this.paymentId == 5) {
      this.razoryPayWeb();
    } else if (this.paymentId == 6) {
      this.payWithInstaMOJOWeb();
    } else if (this.paymentId == 7) {
      this.paystackWeb();
    } else if (this.paymentId == 8) {
      this.flutterwaveWeb();
    }
  }

  flutterwaveWeb() {
    this.util.start();
    this.api.get_private('v1/getFlutterwaveKey').then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data) {
        const payMethod = this.paymentMethodList.filter(x => x.id == this.paymentId);
        console.log(payMethod);
        FlutterwaveCheckout({
          public_key: data.data,
          tx_ref: '' + Math.floor((Math.random() * 1000000000) + 1),
          amount: this.serviceCart.grandTotal,
          currency: payMethod[0].currency_code,
          payment_options: 'card, mobilemoneyghana, ussd',

          meta: {
            consumer_id: 23,
            consumer_mac: '92a3-912ba-1192a',
          },
          customer: {
            email: this.getEmail(),
            phone_number: localStorage.getItem('mobile'),
            name: this.getName(),
          },
          callback: (data: any) => {
            console.log(data);
            document.getElementsByName('checkout')[0].setAttribute('style',
              'position:fixed;top:0;left:0;z-index:-1;border:none;opacity:0;pointer-events:none;width:100%;height:100%;');
            document.body.style.overflow = '';
            this.createOrder
              (JSON.stringify(data));
          },
          onclose: (data: any) => {
            console.log('closed', data);
          },
          customizations: {
            title: this.util.app_name,
            description: this.util.app_name + ' Order',
            logo: this.api.mediaURL + this.util.logo,
          },
        });
      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });

  }

  paystackWeb() {
    this.util.start();
    this.api.get_private('v1/getPaystackKey').then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data) {
        const payMethod = this.paymentMethodList.filter(x => x.id == this.paymentId);
        console.log(payMethod);
        const handler = PaystackPop.setup({
          key: data.data,
          currency: payMethod[0].currency_code,
          email: this.getEmail(),
          amount: this.serviceCart.grandTotal * 100,
          firstname: this.getFirstName(),
          lastname: this.getLastName(),
          ref: '' + Math.floor((Math.random() * 1000000000) + 1),
          onClose: () => {
            console.log('closed');
          },
          callback: (response: any) => {
            console.log(response);
            // response.reference
            this.createOrder
              (response.reference);
          }
        });
        handler.openIframe();
      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });
  }

  async payWithInstaMOJOWeb() {
    let uid = '';
    if (this.serviceCart.serviceCart.length > 0) {
      uid = this.serviceCart.serviceCart[0].uid;
    } else if (this.serviceCart.packagesCart.length > 0) {
      uid = this.serviceCart.packagesCart[0].uid;
    }
    const param = {
      "uid": localStorage.getItem('uid'),
      "freelancer_id": uid,
      "salon_id": 0,
      "specialist_id": 0,
      "appointments_to": 1,
      "address": JSON.stringify(this.serviceCart.deliveredAddress),
      "items": localStorage.getItem('userCart'),
      "coupon_id": this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id ? this.serviceCart.coupon.id : 0,
      "coupon": this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id ? JSON.stringify(this.serviceCart.coupon) : 'NA',
      "discount": this.serviceCart.discount,
      "distance_cost": this.serviceCart.deliveryCharge,
      "total": this.serviceCart.totalPrice,
      "serviceTax": this.serviceCart.orderTax,
      "grand_total": this.serviceCart.grandTotal,
      "pay_method": this.paymentId,
      "paid": 'NA',
      "save_date": this.selectedDate,
      "slot": this.selectedSlotIndex,
      wallet_used: this.walletCheck == true && this.walletDiscount > 0 ? 1 : 0,
      wallet_price:
        this.walletCheck == true && this.walletDiscount > 0 ? this.walletDiscount : 0,
      "notes": this.orderNotes == '' || this.orderNotes == null ? 'NA' : this.orderNotes,
      "status": 8
    };
    console.log('param----->', param);

    this.util.start();
    this.api.post_private('v1/appoinments/create', param).then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        const grandTotal = this.serviceCart.grandTotal;
        const orderId = data.data.id;
        const param = {
          allow_repeated_payments: 'False',
          amount: grandTotal,
          buyer_name: this.getName(),
          purpose: this.util.app_name + ' Orders',
          redirect_url: this.api.baseUrl + 'v1/instaMOJOWebSuccessAppointments?id=' + orderId,
          phone: localStorage.getItem('mobile') && localStorage.getItem('mobile') != null ? localStorage.getItem('mobile') : '',
          send_email: 'True',
          webhook: this.api.baseUrl,
          send_sms: 'True',
          email: this.getEmail()
        };

        this.util.start();
        this.api.post_private('v1/payments/instamojoPay', param).then((data: any) => {
          console.log('instamojo response', data);
          this.util.stop();
          if (data && data.status && data.status == 200 && data.success && data.success.success == true) {

            const navParma: NavigationExtras = {
              queryParams: {
                id: orderId,
                payLink: data.success.payment_request.longurl
              }
            }
            this.serviceCart.clearCart();
            this.router.navigate(['/await-payments'], navParma);
            // Instamojo.open();

          } else {
            const error = JSON.parse(data.error);
            console.log('error message', error);
            if (error && error.message) {
              this.util.errorMessage(error.message);
              return false;
            }
            this.util.errorMessage(this.util.translate('Something went wrong while payments. please contact administrator'));
          }
        }, error => {
          console.log(error);
          this.util.stop();
          this.util.apiErrorHandler(error);
        }).catch(error => {
          console.log(error);
          this.util.stop();
          this.util.apiErrorHandler(error);
        });

      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });
  }

  async payTmWeb() {
    let uid = '';
    if (this.serviceCart.serviceCart.length > 0) {
      uid = this.serviceCart.serviceCart[0].uid;
    } else if (this.serviceCart.packagesCart.length > 0) {
      uid = this.serviceCart.packagesCart[0].uid;
    }
    const param = {
      "uid": localStorage.getItem('uid'),
      "freelancer_id": uid,
      "salon_id": 0,
      "specialist_id": 0,
      "appointments_to": 1,
      "address": JSON.stringify(this.serviceCart.deliveredAddress),
      "items": localStorage.getItem('userCart'),
      "coupon_id": this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id ? this.serviceCart.coupon.id : 0,
      "coupon": this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id ? JSON.stringify(this.serviceCart.coupon) : 'NA',
      "discount": this.serviceCart.discount,
      "distance_cost": this.serviceCart.deliveryCharge,
      "total": this.serviceCart.totalPrice,
      "serviceTax": this.serviceCart.orderTax,
      "grand_total": this.serviceCart.grandTotal,
      "pay_method": this.paymentId,
      "paid": 'NA',
      "save_date": this.selectedDate,
      "slot": this.selectedSlotIndex,
      wallet_used: this.walletCheck == true && this.walletDiscount > 0 ? 1 : 0,
      wallet_price:
        this.walletCheck == true && this.walletDiscount > 0 ? this.walletDiscount : 0,
      "notes": this.orderNotes == '' || this.orderNotes == null ? 'NA' : this.orderNotes,
      "status": 8
    };
    console.log('param----->', param);
    this.util.start();
    this.api.post_private('v1/appoinments/create', param).then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        const grandTotal = this.serviceCart.grandTotal;

        const navParma: NavigationExtras = {
          queryParams: {
            id: data.data.id,
            payLink: this.api.baseUrl + 'v1/payNowWeb?amount=' + grandTotal + '&standby_id=' + data.data.id
          }
        }
        this.serviceCart.clearCart();
        this.router.navigate(['/await-payments'], navParma);


      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });
  }

  payPalWebPay() {
    this.util.start();
    this.api.get_private('v1/getPayPalKey').then(async (data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data) {
        const payMethod = this.paymentMethodList.filter(x => x.id == this.paymentId);
        console.log(payMethod);
        this.payPalModal.show();
        this.initConfig(payMethod[0].currency_code, data.data);
      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    })
  }

  private initConfig(code: any, clientId: any): void {
    this.payPalConfig = {
      currency: code,
      clientId: clientId,
      createOrderOnClient: (data) => <ICreateOrderRequest>{
        intent: 'CAPTURE',
        purchase_units: [{
          amount: {
            currency_code: code,
            value: this.serviceCart.grandTotal,
            breakdown: {
              item_total: {
                currency_code: code,
                value: this.serviceCart.grandTotal
              }
            }
          },
        }]
      },
      advanced: {
        commit: 'true'
      },
      style: {
        label: 'paypal',
        layout: 'vertical'
      },
      onApprove: (data, actions) => {
        console.log('onApprove - transaction was approved, but not authorized', data, actions);
        actions.order.get().then((details: any) => {
          console.log('onApprove - you can get full order details inside onApprove: ', details);
        });
      },
      onClientAuthorization: (data) => {
        console.log('onClientAuthorization - you should probably inform your server about completed transaction at this point', data);
        this.payPalModal.hide();
        this.createOrder(JSON.stringify(data));
      },
      onCancel: (data, actions) => {
        console.log('OnCancel', data, actions);
      },
      onError: err => {
        console.log('OnError', err);
        // this.showError = true;
      },
      onClick: (data, actions) => {
        console.log('onClick', data, actions);
        // this.resetStatus();
      },
    };
  }

  addNewCard() {
    this.stripeModal.hide();
    this.addCardModal.show();
  }

  getProfile() {
    this.api.post_private('v1/profile/getByID', { "id": localStorage.getItem('uid') }).then((data: any) => {
      console.log('profile', data);
      if (data && data.status == 200 && data.data && data.data.id) {
        this.cardEmail = data.data.email;
        this.stripeKey = data.data.stripe_key;
        console.log('i am stripeeeeeeeeeeeeee', this.stripeKey);
        if (this.stripeKey && this.stripeKey != null) {
          this.getStripeCard();
        }
      }
    }, error => {
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  submitData() {
    if (this.cardNumber == '' || this.cvv == '' ||
      this.expiryDate == '' || this.cardHolderName == '' || this.cardEmail == '') {
      this.util.errorMessage(this.util.translate('all fields are required'));
      return false;
    }
    const param = {
      'number': this.cardNumber,
      'exp_month': moment(this.expiryDate).format('MM'),
      'exp_year': moment(this.expiryDate).format('YYYY'),
      'cvc': this.cvv,
      'email': this.cardEmail
    };
    this.util.start();
    console.log("constant", param);
    this.api.post_private('v1/payments/createStripeToken', param).then((data: any) => {
      console.log(data);
      this.util.stop();//
      // stripe key
      if (data && data.status && data.status == 200 && data.success && data.success.id) {
        console.log('***********************************', this.stripeKey);
        console.log(this.stripeKey != '' && this.stripeKey && this.stripeKey != null);
        if (this.stripeKey != '' && this.stripeKey && this.stripeKey != null) {
          this.addStripe(data.success.id);
        }
        else {
          this.createCustomer(data.success.id);
        }
      } else {
        this.util.errorMessage(this.util.translate('Something went wrong'))
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
  }

  addStripe(id: any) {
    const param = {
      "token": id,
      "id": this.stripeKey,
    }
    this.util.start();
    this.api.post_private('v1/payments/addStripeCards', param).then((data: any) => {
      this.util.suucessMessage('Card Information Saved');
      this.util.stop();
      this.addCardModal.hide();
      this.stripeModal.show();
      this.getStripeCard();
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  createCustomer(id: any) {
    this.util.start();
    const param = { 'email': this.cardEmail, 'source': id };
    this.api.post_private('v1/payments/createCustomer', param).then((data: any) => {
      this.util.stop();
      console.log('customer id', data);
      if (data && data.status == 200) {
        this.stripeKey = data.success.id;
        this.updateUserStripeKey(data.success.id);
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
  }

  updateUserStripeKey(id: any) {
    const param = { 'id': localStorage.getItem('uid'), 'stripe_key': id };
    this.util.start();
    this.api.post_private('v1/profile/update', param).then((data: any) => {
      this.util.suucessMessage('Card Information Saved');
      this.addCardModal.hide();
      this.stripeModal.show();
      this.getStripeCard();
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  getStripeCard() {
    this.api.post_private('v1/payments/getStripeCards', { "id": this.stripeKey }).then((data: any) => {
      console.log(data);
      if (data && data.status == 200) {
        this.stripeCardList = data.success.data;
        console.log(this.stripeCardList);
      }
    }, error => {
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  saveCard(id: any) {
    this.selectedCard = id;
  }

  createPayment() {
    if (this.selectedCard != '') {
      this.stripeModal.hide();
      this.makePayment();
    }
    else {
      this.util.errorMessage(this.util.translate('Please Select Card'));
    }
  }

  makePayment() {
    var savedPayment = this.paymentMethodList.filter(x => x.id == this.paymentId);
    console.log(savedPayment);
    if (savedPayment.length > 0) {
      var param = {
        'amount': parseInt(this.serviceCart.grandTotal),
        'currency': savedPayment[0].currency_code,
        'customer': this.stripeKey,
        'card': this.selectedCard
      };
      this.util.start();
      this.api.post_private('v1/payments/createStripePayments', param).then((data: any) => {
        this.util.stop();
        console.log(data);
        if (data && data.status == 200 && data.success && data.success.id) {
          this.createOrder
            (JSON.stringify(data.success));

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
    }
  }

  onOrderHistory() {
    this.successModal.hide();
    const name = (this.util.userInfo.first_name + '-' + this.util.userInfo.last_name).toLowerCase();
    this.router.navigate(['user', name, 'appointment']);
  }

  onHome() {
    this.successModal.hide();
    this.router.navigate(['']);
  }

  async createOrder(payKey: any) {
    console.log(this.address);
    let uid = '';
    if (this.serviceCart.serviceCart.length > 0) {
      uid = this.serviceCart.serviceCart[0].uid;
    } else if (this.serviceCart.packagesCart.length > 0) {
      uid = this.serviceCart.packagesCart[0].uid;
    }
    const param = {
      "uid": localStorage.getItem('uid'),
      "freelancer_id": uid,
      "salon_id": 0,
      "specialist_id": 0,
      "appointments_to": 1,
      "address": JSON.stringify(this.serviceCart.deliveredAddress),
      "items": localStorage.getItem('userCart'),
      "coupon_id": this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id ? this.serviceCart.coupon.id : 0,
      "coupon": this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id ? JSON.stringify(this.serviceCart.coupon) : 'NA',
      "discount": this.serviceCart.discount,
      "distance_cost": this.serviceCart.deliveryCharge,
      "total": this.serviceCart.totalPrice,
      "serviceTax": this.serviceCart.orderTax,
      "grand_total": this.serviceCart.grandTotal,
      "pay_method": this.paymentId,
      "paid": payKey,
      "save_date": this.selectedDate,
      "slot": this.selectedSlotIndex,
      wallet_used: this.walletCheck == true && this.walletDiscount > 0 ? 1 : 0,
      wallet_price:
        this.walletCheck == true && this.walletDiscount > 0 ? this.walletDiscount : 0,
      "notes": this.orderNotes == '' || this.orderNotes == null ? 'NA' : this.orderNotes,
      "status": 0
    };
    console.log('param----->', param);
    this.util.start();
    this.api.post_private('v1/appoinments/create', param).then((data: any) => {
      if (data && data.status == 200) {
        this.util.stop();
        console.log(data);
        this.serviceCart.clearCart();
        this.successModal.show();
      }
    }, error => {
      console.log('Error', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });
  }


  walletChange() {
    if (this.balance <= 0 || this.serviceCart.coupon) {
      return false;
    }
    console.log('ok');
    this.walletCheck = !this.walletCheck;
    if (this.walletCheck == true) {
      if (this.serviceCart && this.serviceCart.coupon && this.serviceCart.coupon.id) {
        this.util.errorMessage(this.util.translate('Sorry you have already added a offers discount to cart'));
        this.walletCheck = false;
        return false;
      }
      this.serviceCart.walletDiscount = parseFloat(this.balance);
      this.serviceCart.calcuate();
    } else {
      this.serviceCart.walletDiscount = 0;
      this.serviceCart.calcuate();
    }
  }

  ngOnInit(): void {
  }

  razoryPayWeb() {
    this.util.start();
    this.api.get_private('v1/getRazorPayKey').then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status && data.status == 200 && data.data) {
        const payMethod = this.paymentMethodList.filter(x => x.id == this.paymentId);
        console.log(payMethod);

        var options = {
          amount: this.serviceCart.grandTotal ? this.serviceCart.grandTotal * 100 : 5,
          email: this.getEmail(),
          logo: this.util && this.util.logo ? this.api.mediaURL + this.util.logo : 'null',
          name: this.getName(),
          app_color: this.util && this.util.app_color ? this.util.app_color : '#f47878',
          key: data.data, // Enter the Key ID generated from the Dashboard
          currency: payMethod[0].currency_code,
          description: this.util.app_name + ' Order Of ' + this.serviceCart.grandTotal + ' amount',

          handler: (response: any) => {
            console.log(response);
            this.verifyPurchaseRazorPay(response.razorpay_payment_id);
          }
        };
        console.log(options);
        var rzp1 = new Razorpay(options);
        rzp1.open();
      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.apiErrorHandler(error);
    });
  }

  getName() {
    return localStorage.getItem('lastName') != null && localStorage.getItem('lastName') != '' ? localStorage.getItem('firstName') + ' ' +
      localStorage.getItem('lastName') : 'Foodies';
  }

  getEmail() {
    return localStorage.getItem('email') != null && localStorage.getItem('email') ? localStorage.getItem('email') : 'info@initappz.com';
  }

  getFirstName() {
    return localStorage.getItem('firstName') && localStorage.getItem('firstName') != null ? localStorage.getItem('firstName') : '';
  }

  getLastName() {
    return localStorage.getItem('lastName') && localStorage.getItem('lastName') != null ? localStorage.getItem('lastName') : '';
  }

  verifyPurchaseRazorPay(paymentId: any) {
    this.util.start();
    this.api.get_private('v1/payments/VerifyRazorPurchase?id=' + paymentId).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.success && data.success.status && data.success.status == 'captured') {
        this.util.stop();
        this.createOrder(JSON.stringify(data.success));
      } else {
        this.util.stop();
        this.util.errorMessage(this.util.translate('Something went wrong while payments. please contact administrator'));
      }
    }, error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong while payments. please contact administrator'));
    }).catch(error => {
      console.log(error);
      this.util.stop();
      this.util.errorMessage(this.util.translate('Something went wrong while payments. please contact administrator'));
    });
  }
}
