/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Location } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-appointment-details',
  templateUrl: './appointment-details.component.html',
  styleUrls: ['./appointment-details.component.scss']
})
export class AppointmentDetailsComponent implements OnInit {
  @ViewChild('ratingModal', { static: false }) public ratingModal: ModalDirective;
  @ViewChild('addReviews', { static: false }) public addReviews: ModalDirective;
  id: any = '';
  orders: any;
  address: any = '';
  myLat: any = '';
  myLng: any = '';
  itemTotal: any = 0;
  taxCharge: any = 0;
  distance_cost: any = 0;
  discount: any = 0;
  grand_total: any = 0;
  wallet_price: any = 0;
  pay_method: any = 0;
  status: any = 0;
  wallet_used: any = 0;
  save_date: any = '';
  addressName = ['home', 'work', 'other'];  // 1 = home , 2 = work , 3 = other

  freelancerCover: any = '';
  freelancerName: any = '';
  freelancerMobile: any = '';
  freelancerEmail: any = '';
  apiCalled: boolean = false;
  paymentBy = ['NA', 'COD', 'Stripe', 'PayPal', 'PayTM', 'Razorpay', 'Instamojo', 'Paystack', 'Flutterwave']

  rate: any = 2;
  ratingsList: any[] = [];
  isLogin: boolean = false;
  ownerId: any = '';
  externalId: any = '';
  type: any = '';
  cover: any = '';
  name: any = '';
  notes: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService,
    private route: ActivatedRoute,
    private navCtrl: Location,
    private router: Router
  ) {
    this.id = this.route.snapshot.paramMap.get('id');
    console.log(this.id);
    if (this.id && this.id != '' && this.id != null) {
      this.getInfo();
    }

  }

  ngOnInit(): void {
  }

  getInfo() {
    this.apiCalled = false;
    this.api.post_private('v1/appoinments/getInfo', { id: this.id }).then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        const info = data.data;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.items)) {
          this.orders = JSON.parse(info.items);
          console.log(this.orders);
        } else {
          this.orders = [];
        }
        if (info.appointments_to == 1) {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.address)) {
            var address = JSON.parse(info.address);
            console.log(address);
            this.address = address.house + ' ' + address.landmark + ' ' + address.address + ' ' + address.pincode;
            this.myLat = address.lat;
            this.myLng = address.lng;
          }
        } else {
          this.address = 'At Salon';
        }

        if (info.salon_id == 0 && info.individualInfo) {
          this.freelancerCover = info.ownerInfo.cover;
          this.freelancerName = info.ownerInfo.first_name + ' ' + info.ownerInfo.last_name;
          this.freelancerEmail = info.ownerInfo.email;
          this.freelancerMobile = info.ownerInfo.mobile;
          this.ownerId = info.freelancer_id;
        } else {
          this.freelancerCover = info.ownerInfo.cover;
          this.freelancerName = info.salonInfo.name;
          this.freelancerEmail = info.ownerInfo.email;
          this.freelancerMobile = info.ownerInfo.mobile;
          this.ownerId = info.salon_id;
        }

        this.itemTotal = info.total;
        this.taxCharge = info.serviceTax;
        this.distance_cost = info.distance_cost;
        this.discount = info.discount;
        this.grand_total = info.grand_total;
        this.pay_method = info.pay_method;
        this.wallet_price = info.wallet_price;
        this.wallet_used = info.wallet_used;
        this.save_date = moment(info.save_date).format('llll') + ' ' + info.slot;
        this.status = info.status;
      }
    }, error => {
      console.log(error);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    }).catch((error: any) => {
      console.log(error);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  printInvoice() {
    window.open(this.api.baseUrl + 'v1/appointments/printInvoice?id=' + this.id + '&token=' + localStorage.getItem('token'), '_blank');
  }

  changeStatus() {
    this.util.start();
    this.api.post_private('v1/appoinments/update', { id: this.id, status: 5 }).then((data: any) => {
      console.log(data);
      this.util.stop();
      this.util.suucessMessage('Updated');
      this.navCtrl.back();
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  presentAlertConfirm() {
    this.ratingModal.show();
  }

  getOwnerRating() {
    console.log('get ratings', this.ownerId);
    this.ratingModal.hide();
    this.util.start();
    this.ratingsList = [];
    this.api.post_private('v1/owner_reviews/getOwnerReviews', { id: this.ownerId }).then((data: any) => {
      this.util.stop();
      console.log(data);
      if (data && data.status && data.status == 200) {
        // this.ratingsList = data.data;
        data.data.forEach(element => {
          this.ratingsList.push(parseInt(element.rating));
        });
        console.log(this.ratingsList);
      }
      this.type = 'owner';
      this.name = this.freelancerName;
      this.cover = this.freelancerCover;
      this.addReviews.show();
    }, error => {
      this.util.stop();
      console.log(error);
      this.ratingsList = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      this.util.stop();
      console.log(error);
      this.ratingsList = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  openServiceRating(id: any, name: any, cover: any) {
    this.type = 'service';
    this.name = name;
    this.cover = cover;
    this.externalId = id;
    this.ratingModal.hide();
    this.addReviews.show();
  }

  openPackageRating(id: any, name: any, cover: any) {
    this.type = 'package';
    this.name = name;
    this.cover = cover;
    this.externalId = id;
    this.ratingModal.hide();
    this.addReviews.show();
  }

  saveReview() {
    if (this.notes == '') {
      this.util.errorMessage('Please add comments');
      return false;
    }
    if (this.type == 'owner') {
      this.saveOwnerRating();
    } else if (this.type == 'service') {
      this.saveServiceRating();
    } else if (this.type == 'package') {
      this.savePackageRating();
    }
  }

  savePackageRating() {
    const param = {
      "uid": localStorage.getItem('uid'),
      "package_id": this.externalId,
      "freelancer_id": this.ownerId,
      "notes": this.notes,
      "rating": this.rate,
      "status": 1
    };
    console.log(param);
    this.isLogin = true;
    this.api.post_private('v1/packages_reviews/save', param).then((data: any) => {
      this.isLogin = false;
      this.util.suucessMessage('Review saved');
      this.addReviews.hide();
      this.rate = 2;
      this.cover = '';
      this.notes = '';
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

  saveServiceRating() {
    console.log(this.ownerId);
    const param = {
      "uid": localStorage.getItem('uid'),
      "service_id": this.externalId,
      "freelancer_id": this.ownerId,
      "notes": this.notes,
      "rating": this.rate,
      "status": 1
    };
    console.log(param);
    this.isLogin = true;
    this.api.post_private('v1/service_reviews/save', param).then((data: any) => {
      this.isLogin = false;
      this.util.suucessMessage('Review saved');
      this.addReviews.hide();
      this.rate = 2;
      this.cover = '';
      this.notes = '';
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

  saveOwnerRating() {
    console.log('save owner rating', this.rate);
    this.ratingsList.push(this.rate);
    const sum = this.ratingsList.reduce((a, b) => a + b);
    const average = (sum / this.ratingsList.length).toFixed(2);
    console.log(sum, average);
    const param = {
      "uid": localStorage.getItem('uid'),
      "freelancer_id": this.ownerId,
      "notes": this.notes,
      "rating": this.rate,
      "status": 1
    };
    this.isLogin = true;
    this.api.post_private('v1/owner_reviews/save', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        const updateParam = {
          "id": this.ownerId,
          'total_rating': this.ratingsList.length,
          'rating': parseFloat(average).toFixed(2)
        };
        this.api.post_private('v1/owner_reviews/updateOwnerReviews', updateParam).then((updates: any) => {
          this.isLogin = false;
          this.util.suucessMessage('Review saved');
          this.rate = 2;
          this.cover = '';
          this.notes = '';
          this.addReviews.hide();
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
        this.isLogin = false;
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

  getProfile() {
    return this.api.mediaURL + this.cover;
  }
}
