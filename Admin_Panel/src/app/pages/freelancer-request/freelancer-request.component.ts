/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import Swal from 'sweetalert2';
import { ModalDirective } from 'ngx-bootstrap/modal';

@Component({
  selector: 'app-freelancer-request',
  templateUrl: './freelancer-request.component.html',
  styleUrls: ['./freelancer-request.component.scss']
})
export class FreelancerRequestComponent implements OnInit {
  @ViewChild('largeModal') public largeModal: ModalDirective;
  freelancers: any[] = [];
  dummyFreelacer: any[] = [];
  page: number = 1;
  firstName: any = '';
  lastName: any = '';
  email: any = '';
  password: any = '';
  country_code: any = '';
  mobile: any = '';
  gender: any = '1';
  cover: any = '';
  categories: any[] = [];
  selectedItems = [];
  cities: any[] = [];
  hourly: any = '';
  lat: any = '';
  lng: any = '';
  descriptions: any = '';
  cityID: any = '';
  zipcode: any = '';
  experience: any = '';
  freelancerId: any = '';
  rate: any = '';
  address: any = '';
  fee_start: any = '';
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.getFreelancer();
  }

  ngOnInit(): void {
  }
  getFreelancer() {
    this.dummyFreelacer = Array(5);
    this.freelancers = [];
    this.api.get_private('v1/request/getIndividualRequest').then((data: any) => {
      this.dummyFreelacer = [];
      console.log(data);
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data.data.length > 0) {
          this.freelancers = data.data;
        }
      }
    }, error => {
      this.dummyFreelacer = [];
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.dummyFreelacer = [];
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  reject(item: any) {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To delete this item?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        console.log(item);
        console.log(item);
        this.util.show();
        this.api.post_private('v1/request/delete', { id: item.id, uid: item.uid }).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status && data.status == 200) {
            this.getFreelancer();
          }
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
      }
    });
  }

  accept(item: any) {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To accept this request?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        console.log(item);
        console.log(item);
        this.freelancerId = item.id;
        this.firstName = item.first_name;
        this.lastName = item.last_name;
        this.email = item.email;
        this.password = item.password;
        this.country_code = item.country_code;
        this.mobile = item.mobile;
        this.cityID = item.cid;
        this.cover = item.cover;
        this.descriptions = item.descriptions;
        this.gender = item.gender;
        this.selectedItems = item.web_cates_data;
        this.hourly = item.hourly_price;
        this.lat = item.lat;
        this.lng = item.lng;
        this.experience = item.total_experience;
        this.zipcode = item.zipcode;
        this.fee_start = item.fee_start;
        this.address = item.address;
        this.largeModal.show();
      }
    });
  }

  acceptRequest() {
    if (this.rate == '' || this.rate == null) {
      this.util.error(this.util.translate('Please add commission rate'));
      return false;
    }
    const cc: string = (this.country_code).toString();
    if (!cc.includes('+')) {
      this.country_code = '+' + this.country_code
    };

    const param = {
      first_name: this.firstName,
      last_name: this.lastName,
      gender: this.gender,
      cover: this.cover,
      mobile: this.mobile,
      email: this.email,
      country_code: this.country_code,
      password: this.password
    };
    this.util.show();
    this.api.post_private('v1/auth/createIndividualAccount', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data.status == 500) {
        this.util.error(data.message);
      }
      if (data && data.status && data.status == 200 && data.user && data.user.id) {
        console.log(data);
        this.saveSalonProfile(data.user.id);
      } else if (data && data.error && data.error.msg) {
        this.util.error(data.error.msg);
      } else if (data && data.error && data.error.message == 'Validation Error.') {
        for (let key in data.error[0]) {
          console.log(data.error[0][key][0]);
          this.util.error(data.error[0][key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }, error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    }).catch(error => {
      console.log(error);
      this.util.hide();
      if (error && error.error && error.error.status == 500 && error.error.message) {
        this.util.error(error.error.message);
      } else if (error && error.error && error.error.error && error.error.status == 422) {
        for (let key in error.error.error) {
          console.log(error.error.error[key][0]);
          this.util.error(error.error.error[key][0]);
        }
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }
    });
  }

  saveSalonProfile(uid: any) {
    console.log('uid', uid);
    const ids = this.selectedItems.map((x: any) => x.id);
    console.log(ids);
    const body = {
      uid: uid,
      status: 1,
      lat: this.lat,
      lng: this.lng,
      cover: this.cover,
      categories: ids.join(),
      address: this.address,
      about: this.descriptions,
      images: 'NA',
      cid: this.cityID,
      zipcode: this.zipcode,
      rating: 0,
      total_rating: 0,
      website: "NA",
      timing: "NA",
      verified: 1,
      available: 1,
      have_shop: 0,
      fee_start: this.fee_start,
      popular: 0,
      in_home: 1,
      extra_field: 'NA',
      background: 'NA',
      rate: this.rate
    };
    this.util.show();
    this.api.post_private('v1/individual/create', body).then((data: any) => {
      console.log("+++++++++++++++", data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.success) {
        this.largeModal.hide();
        this.util.success(this.util.translate('Individual added !'));
        this.util.show();
        this.api.post_private('v1/request/delete', { id: this.freelancerId }).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status && data.status == 200) {
            this.getFreelancer();
          }
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
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
}
