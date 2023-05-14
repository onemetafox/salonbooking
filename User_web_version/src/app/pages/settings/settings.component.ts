/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ChangeDetectorRef, Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, NavigationEnd, NavigationExtras, Router } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import * as moment from 'moment';
import Swal from 'sweetalert2';
declare var google;

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.scss']
})
export class SettingsComponent implements OnInit {
  @ViewChild('addressFromMap') public addressFromMap: ModalDirective;
  @ViewChild('map', { static: true }) mapElement: ElementRef;
  @ViewChild('changedPlace') public changedPlace: ModalDirective;

  tabId = 'profile';
  haveItems: boolean = false;
  myOrders: any[] = [];
  dummy = Array(10);
  dummyOrders = Array(10);
  dummyAddress = Array(10);
  myaddress: any[] = [];
  page = 1;

  address_id: any;
  lat: any;
  lng: any;
  address: any = '';
  house: any = '';
  landmark: any = '';
  title: any = 0;
  pincode: any = '';
  map: any;
  marker: any;

  // autocomplete1: { 'query': string };
  query: any = '';
  autocompleteItems1: any = [];
  GoogleAutocomplete;
  geocoder: any;
  addressSelected: boolean;

  editClicked: boolean;

  editProfileClick: boolean;

  first_name: any = '';
  last_name: any = '';
  mobile: any;
  gender: any;

  addressName = ['Home', 'Work', 'Other'];
  optionalPhone: any = '';

  orderList: any[] = [];
  constructor(
    private route: ActivatedRoute,
    public util: UtilService,
    public api: ApiService,
    private router: Router,
    private chmod: ChangeDetectorRef
  ) {
    if (this.route.snapshot.paramMap.get('id') && this.route.snapshot.paramMap.get('from') && this.util.userInfo && this.util.userInfo.first_name) {
      const id = this.route.snapshot.paramMap.get('id');
      console.log(id);
      this.tabId = this.route.snapshot.paramMap.get('from');
      this.GoogleAutocomplete = new google.maps.places.AutocompleteService();
      this.geocoder = new google.maps.Geocoder();
      this.query = '';
      this.gender = this.util.userInfo.gender;
      this.first_name = this.util.userInfo.first_name;
      this.last_name = this.util.userInfo.last_name;
      this.mobile = this.util.userInfo.mobile;
      this.autocompleteItems1 = [];
      this.addressSelected = false;
      this.editProfileClick = true;
      if (this.tabId == 'appointment') {
        this.getMyAppointments('', false);
      } else if (this.tabId == 'address') {
        this.getAddress();
      } else if (this.tabId == 'product-order') {
        this.getMyOrders();
      } else {
        this.getProfileInfo();
      }
    } else {
      this.router.navigate(['']);
    }
    this.router.events.subscribe((data: any) => {

      if (data instanceof NavigationEnd) {
        this.tabId = this.route.snapshot.paramMap.get('from');
        console.log('router event', this.tabId);
        if (this.tabId == 'appointment') {
          this.getMyAppointments('', false);
        } else if (this.tabId == 'address') {
          this.getAddress();
        } else if (this.tabId == 'product-order') {
          this.getMyOrders();
        } else {
          this.getProfileInfo();
        }
      }
    });
  }

  ngOnInit(): void {
  }

  getMyOrders() {
    const param = {
      id: localStorage.getItem('uid')
    };
    this.dummyOrders = Array(5);
    this.api.post_private('v1/product_order/getByUID', param).then((data: any) => {
      console.log(data);
      this.dummyOrders = [];
      if (data && data.status == 200 && data.data && data.data) {
        data.data.forEach((element: any) => {
          element.orders = JSON.parse(element.orders);
        });
        data.data.forEach((element: any) => {
          element.address = JSON.parse(element.address);
        });
        console.log('data--------------------', data);
        this.orderList = data.data;
      }
    }, error => {
      this.dummyOrders = [];
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.dummyOrders = [];
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  changeTab(val) {
    this.tabId = val;
  }

  getProfile() {
    return this.util.userInfo && this.util.userInfo.cover ? this.api.mediaURL + this.util.userInfo.cover : '';
  }

  openLink(item) {
    const name = (this.util.userInfo.first_name + '-' + this.util.userInfo.last_name).toLowerCase();
    this.tabId = item;
    if (this.tabId == 'appointment') {
      this.getMyAppointments('', false);
    }
    if (this.tabId == 'address') {
      this.getAddress();
    }
    this.router.navigate(['user', name, item]);
    this.chmod.detectChanges();
  }

  doRefresh(event) {
    console.log(event);
    this.getMyAppointments(event, true);
  }

  getMyAppointments(event, haveRefresh) {
    const param = {
      id: localStorage.getItem('uid')
    };
    this.dummy = Array(10);
    this.api.post_private('v1/appoinments/getMyList', param).then((data: any) => {
      this.dummy = [];
      console.log(data);
      if (data && data.status == 200 && data.data.length) {
        this.haveItems = true;
        data.data.forEach(element => {
          // element.orders = JSON.parse(element.orders);
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
            element.items = JSON.parse(element.items);
          }
        });
        this.myOrders = data.data;
      } else {
        this.haveItems = false;
        // this.router.navigate(['']);
      }
      this.chmod.detectChanges();
      if (haveRefresh) {
        event.target.complete();
      }

    }, error => {
      console.log(error);
      this.dummy = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.dummy = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  getCart() {
    this.router.navigate(['/tabs']);
  }

  openAppointments(orderId) {
    console.log(orderId);
    console.log('navigate');
    this.router.navigate(['appointment-details', orderId]);
  }

  openOrderDetails(orderId) {
    console.log(orderId);
    console.log('navigate');
    this.router.navigate(['order-details', orderId]);
  }

  getDate(date) {
    return moment(date).format('llll');
  }

  getAddress() {
    const param = {
      id: localStorage.getItem('uid')
    };
    this.api.post_private('v1/address/getByUID', param).then((data) => {
      console.log(data);
      this.dummyAddress = [];
      if (data && data.status == 200) {
        this.myaddress = data.data;
        this.chmod.detectChanges();
      } else {
        // this.router.navigate(['']);
      }
    }, error => {
      console.log(error);
      this.dummyAddress = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.dummyAddress = [];
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  addNewAddress() {
    ///
    this.util.start();
    this.editClicked = false;
    if (window.navigator && window.navigator.geolocation) {
      window.navigator.geolocation.getCurrentPosition(
        position => {
          this.util.stop();
          console.log(position);
          this.addressSelected = false;
          this.addressFromMap.show();
          this.getAddressFromMaps(position.coords.latitude, position.coords.longitude);
        },
        error => {
          this.util.stop();
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
    } else {
      this.util.stop();
    };
  }

  getAddressFromMaps(lat, lng) {
    const geocoder = new google.maps.Geocoder();
    const location = new google.maps.LatLng(lat, lng);
    geocoder.geocode({ 'location': location }, (results, status) => {
      console.log(results);
      console.log('status', status);
      if (results && results.length) {
        this.address = results[0].formatted_address;
        this.chmod.detectChanges();
        this.loadMap(lat, lng);

      }
    });
  }

  loadMap(lat, lng) {
    const location = new google.maps.LatLng(lat, lng);
    const style = [
      {
        featureType: 'all',
        elementType: 'all',
        stylers: [
          { saturation: -100 }
        ]
      }
    ];

    const mapOptions = {
      zoom: 16,
      scaleControl: false,
      streetViewControl: false,
      zoomControl: false,
      overviewMapControl: false,
      center: location,
      mapTypeControl: false,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'Ultimate Salon by initappz']
      }
    };
    this.map = new google.maps.Map(this.mapElement.nativeElement, mapOptions);
    const mapType = new google.maps.StyledMapType(style, { name: 'Grayscale' });
    this.map.mapTypes.set('Ultimate Salon by initappz', mapType);
    this.map.setMapTypeId('Ultimate Salon by initappz');
    this.chmod.detectChanges();
    this.addMarker(location);
  }

  addMarker(location) {
    const dot = {
      url: 'assets/map-marker.png',
      scaledSize: new google.maps.Size(50, 50), // scaled size
    };
    this.marker = new google.maps.Marker({
      position: location,
      map: this.map,
      icon: dot
    });
  }

  changeAddress() {
    this.addressFromMap.hide();
    this.changedPlace.show();
  }

  deleteAddress(item) {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('to delete this address'),
      icon: 'question',
      confirmButtonText: this.util.translate('Yes'),
      backdrop: false,
      background: 'white',
      showCancelButton: true,
      showConfirmButton: true,
      cancelButtonText: this.util.translate('Cancel')
    }).then(data => {
      console.log(data);
      if (data && data.value) {
        this.util.start();
        const param = {
          id: item.id
        };
        this.api.post_private('v1/address/delete', param).then(info => {
          console.log(info);
          this.util.stop();
          this.getAddress();
        }, error => {
          console.log(error);
          this.util.stop();
          this.util.errorMessage(this.util.translate('Something went wrong'));
        }).catch((error) => {
          console.log(error);
          this.util.stop();
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      }
    });
  }

  chooseFromMaps() {
    // console.log(this.mapElement);
    this.addressSelected = true;
    document.getElementById('map').style.height = '150px';
  }

  addAddress() {
    this.addressFromMap.hide();
    if (this.address == '' || this.landmark == '' || this.house == '' || this.pincode == '' || this.optionalPhone == '') {
      this.util.errorMessage(this.util.translate('all fields are required'));
      return false;
    }
    const geocoder = new google.maps.Geocoder;
    this.util.start();
    geocoder.geocode({ address: this.house + ' ' + this.landmark + ' ' + this.address + ' ' + this.pincode }, (results, status) => {
      console.log(results, status);
      if (status == 'OK' && results && results.length) {
        this.lat = results[0].geometry.location.lat();
        this.lng = results[0].geometry.location.lng();
        console.log('----->', this.lat, this.lng);
        console.log('call api');
        var param = {
          uid: localStorage.getItem('uid'),
          is_default: 1,
          optional_phone: this.optionalPhone,
          title: this.title,
          address: this.address,
          house: this.house,
          landmark: this.landmark,
          pincode: this.pincode,
          lat: this.lat,
          lng: this.lng,
          status: 1
        };

        this.api.post_private('v1/address/save', param).then((data: any) => {
          this.util.stop();
          if (data && data.status == 200) {
            this.getAddress();
            const Toast = Swal.mixin({
              toast: true,
              position: 'bottom-end',
              showConfirmButton: false,
              timer: 3000,
              timerProgressBar: true,
            });
            Toast.fire({
              icon: 'success',
              title: this.util.translate('Address added')
            });
          } else {
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }
        }, error => {
          console.log(error);
          this.util.stop();
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      } else {
        this.util.stop();
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    });
  }

  onSearchChange(event) {
    console.log(event);
    if (this.query == '') {
      this.autocompleteItems1 = [];
      return;
    }
    const addsSelected = localStorage.getItem('addsSelected');
    if (addsSelected && addsSelected != null) {
      localStorage.removeItem('addsSelected');
      return;
    }

    this.GoogleAutocomplete.getPlacePredictions({ input: this.query }, (predictions, status) => {
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
    this.query = item.description;
    this.geocoder.geocode({ placeId: item.place_id }, (results, status) => {
      if (status == 'OK' && results[0]) {
        console.log(status);
        this.address = this.query;
        this.lat = results[0].geometry.location.lat();
        this.lng = results[0].geometry.location.lng();
        this.changedPlace.hide();
        this.addressFromMap.show();
        this.chmod.detectChanges();
        this.loadMap(this.lat, this.lng);
      }
    });
  }

  editAddress(item) {
    console.log(item);
    this.editClicked = true;
    this.address = item.address;
    this.lat = item.lat;
    this.lng = item.lng;
    this.pincode = item.pincode;
    this.landmark = item.landmark;
    this.house = item.house;
    this.title = item.title;
    this.address_id = item.id;
    this.optionalPhone = item.optional_phone;
    this.addressFromMap.show();
    this.getAddressFromMaps(this.lat, this.lng);
    this.chooseFromMaps();
  }

  editMyAddress() {
    this.addressFromMap.hide();
    if (this.address == '' || this.landmark == '' || this.house == '' || this.pincode == '' || this.optionalPhone == '') {
      this.util.errorMessage(this.util.translate('all fields are required'));
      return false;
    }
    const geocoder = new google.maps.Geocoder;
    this.util.start();
    geocoder.geocode({ address: this.house + ' ' + this.landmark + ' ' + this.address + ' ' + this.pincode }, (results, status) => {
      console.log(results, status);
      if (status == 'OK' && results && results.length) {
        this.lat = results[0].geometry.location.lat();
        this.lng = results[0].geometry.location.lng();
        console.log('----->', this.lat, this.lng);
        const param = {
          id: this.address_id,
          uid: localStorage.getItem('uid'),
          is_default: 1,
          optional_phone: this.optionalPhone,
          title: this.title,
          address: this.address,
          house: this.house,
          landmark: this.landmark,
          pincode: this.pincode,
          lat: this.lat,
          lng: this.lng,
          status: 1
        };

        this.api.post_private('v1/address/update', param).then((data: any) => {
          this.util.stop();
          this.chmod.detectChanges();
          if (data && data.status == 200) {
            this.getAddress();
            const Toast = Swal.mixin({
              toast: true,
              position: 'bottom-end',
              showConfirmButton: false,
              timer: 3000,
              timerProgressBar: true,

            });

            Toast.fire({
              icon: 'success',
              title: this.util.translate('Address updated')
            });
          } else {
            this.util.errorMessage(this.util.translate('Something went wrong'));
          }
        }, error => {
          console.log(error);
          this.util.stop();
          this.util.errorMessage(this.util.translate('Something went wrong'));
        });
      } else {
        this.util.stop();
        this.util.errorMessage(this.util.translate('Something went wrong'));
        return false;
      }
    });
  }

  updateProfile() {
    if (!this.first_name || this.first_name == '' || !this.last_name || this.last_name == '' || !this.mobile || this.mobile == '') {
      this.util.errorMessage(this.util.translate('all fields are required'));
      return false;
    }
    const param = {
      first_name: this.first_name,
      last_name: this.last_name,
      gender: this.gender,
      mobile: this.mobile,
      id: localStorage.getItem('uid')
    };
    this.util.start();
    this.api.post_private('v1/profile/update', param).then((data: any) => {
      this.util.stop();
      console.log(data);
      this.getProfileInfo();
    }, error => {
      this.util.stop();
      console.log(error);
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  getProfileInfo() {
    this.api.post_private('v1/profile/getByID', { "id": localStorage.getItem('uid') }).then((data: any) => {
      console.log('profile', data);
      if (data && data.status == 200 && data.data && data.data.id) {
        this.util.userInfo = data.data;
      }
    }, error => {
      console.log(error);
    }).catch(error => {
      console.log(error);
    });

  }

  preview_banner(files) {
    console.log('fle', files);
    if (files.length == 0) {
      return;
    }
    const mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }

    if (files) {
      console.log('ok');
      this.util.start();
      this.api.uploadFile(files).subscribe((data: any) => {
        console.log('==>>', data);
        this.util.stop();
        if (data && data.data.image_name) {
          const cover = data.data.image_name;
          const param = {
            cover: cover,
            id: localStorage.getItem('uid')
          };
          this.util.start();
          this.api.post_private('v1/profile/update', param).then((update: any) => {
            this.util.stop();
            console.log(update);
            this.getProfileInfo();
          }, error => {
            this.util.stop();
            console.log(error);
            this.util.errorMessage(this.util.translate('Something went wrong'));
          });
        }
        // if (data && data.status == 200 && data.data) {
        //   // this.coverImage = data.data;

        // }
      }, err => {
        console.log(err);
        this.util.stop();
      });
    } else {
      console.log('no');
    }
  }

  getStatus(status: any) {
    const orderStatus = [
      'Created', // 0
      'Accepted', // 1
      'Rejected', // 2
      'Ongoing', // 3
      'Completed', // 4
      'Cancelled', // 5
      'Refunded', // 6
      'Delayed', // 7
      'Pending Payments', // 8
    ];
    return this.util.translate(orderStatus[status]);
  }
}
