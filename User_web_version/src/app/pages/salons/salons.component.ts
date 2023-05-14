/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import { ApiService } from 'src/app/services/api.service';
import { ProductCartService } from 'src/app/services/product-cart.service';
import { ServiceCartService } from 'src/app/services/service-cart.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-salons',
  templateUrl: './salons.component.html',
  styleUrls: ['./salons.component.scss']
})
export class SalonsComponent implements OnInit {
  @ViewChild('serviceDetails', { static: false }) public serviceDetails: ModalDirective;
  @ViewChild('packageDetails', { static: false }) public packageDetails: ModalDirective;

  id: any = '';
  categories: any[] = [];
  packages: any[] = [];
  specialist: any[] = [];
  productList: any[] = [];
  reviewList: any[] = [];
  name: any = '';
  adddress: any = '';
  rating: any = '';
  totalRating: any = '';
  about: any = '';
  timing: any[] = [];
  lat: any = '';
  lng: any = '';
  gallery: any[] = [];
  website: any = '';
  mobile: any = '';
  cover: any = '';
  apiCalled: boolean = false;
  currentTab: any = '1';
  serviceTab: any = '1';

  serviceId: any = '';
  serviceName: any = '';
  servicesList: any[] = [];

  packageId: any = '';
  packageName: any = '';
  packageInfo: any;
  isBooked: boolean = false;
  packageCover: any = '';
  packageDescriptions: any = '';
  packageDiscount: any = '';
  packageDuration: any = '';
  packageImages: any[] = [];
  packageOff: any = '';
  packagePrice: any = '';
  packageServices: any[] = [];
  packageSpecialist: any[] = [];

  productsCalled: boolean = false;
  reviewsCalled: boolean = false;
  constructor(
    private router: Router,
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    public serviceCart: ServiceCartService,
    public productCart: ProductCartService
  ) {
    if (this.navParam.snapshot.paramMap.get('id')) {
      this.id = this.navParam.snapshot.paramMap.get('id');
      this.getData();
    }

  }

  getData() {
    this.api.post('v1/salon/salonDetails', { id: this.id }).then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status && data.status == 200) {
        const info = data.data;
        this.categories = data.categories;
        this.packages = data.packages;
        this.specialist = data.specialist;
        this.name = info.name;
        this.adddress = info.address;
        this.rating = info.rating;
        this.totalRating = info.total_rating;
        this.about = info.about;
        this.lng = info.lng;
        this.lat = info.lat;
        this.website = info.website;
        this.mobile = info.mobile;
        this.cover = info.cover;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.images)) {
          this.gallery = JSON.parse(info.images);
        } else {
          this.gallery = [];
        }

        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.timing)) {
          this.timing = JSON.parse(info.timing);
        } else {
          this.timing = [];
        }

        console.log(this.gallery);
        console.log(this.timing);
      }
    }, error => {
      console.log('Error', error);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }
  changeTab(id: any) {
    this.currentTab = id;
    console.log(this.currentTab);
    if (this.currentTab == '1') {
      console.log('services');
    } else if (this.currentTab == '2') {
      console.log('shop');
      this.getAllProducts();
    } else if (this.currentTab == '3') {
      console.log('reviews');
      this.getReviews();
    } else if (this.currentTab == '4') {
      console.log('overviews')
    } else if (this.currentTab == '5') {
      console.log('gallery');
    }
  }

  getReviews() {
    this.reviewsCalled = false;
    this.api.post('v1/owner_reviews/getMyReviews', { id: this.id }).then((data: any) => {
      console.log(data);
      this.reviewsCalled = true;
      if (data && data.status && data.status == 200) {
        this.reviewList = data.data;
      }
    }, error => {
      console.log('Error', error);
      this.reviewsCalled = true;
      this.util.apiErrorHandler(error);
    },
    ).catch(error => {
      console.log('Err', error);
      this.reviewsCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  getAllProducts() {
    this.productsCalled = false;
    this.api.post('v1/products/getFreelancerProducts', { "id": this.id, }).then((data: any) => {
      console.log(data);
      this.productsCalled = true;
      if (data && data.status == 200) {
        if (data && data.data && data.data.length > 0) {
          data.data.forEach((productList: any) => {
            if (this.productCart.itemId.includes(productList.id)) {
              productList['quantity'] = this.getQuanity(productList.id);
            } else {
              productList['quantity'] = 0;
            }
          });
        }
        this.productList = data.data;
        console.log('productlist ------------------', this.productList);
      }
    }, error => {
      console.log('Error', error);
      this.productsCalled = true;
      this.util.apiErrorHandler(error);
    },
    ).catch(error => {
      console.log('Err', error);
      this.productsCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  getQuanity(id: any) {
    const data = this.productCart.cart.filter(x => x.id == id);
    return data[0].quantity;
  }

  remove(index: any) {
    console.log(this.productList[index]);
    if (this.productList[index].quantity == 1) {
      this.productList[index].quantity = 0;
      this.productCart.removeItem(this.productList[index].id);
    } else {
      this.productList[index].quantity = this.productList[index].quantity - 1;
      this.productCart.updateQuantity(this.productList[index].id, this.productList[index].quantity);
    }
  }

  add(index: any) {
    console.log(this.productList[index]);
    this.productList[index].quantity = this.productList[index].quantity + 1;
    this.productCart.updateQuantity(this.productList[index].id, this.productList[index].quantity);
  }

  addToCart(index: any) {
    console.log(this.productList[index]);
    if (this.productCart.cart.length == 0) {
      this.productList[index].quantity = 1;
      this.productCart.addItem(this.productList[index]);
    } else {
      if (this.productCart.cart[0].freelacer_id == this.productList[index].freelacer_id) {
        this.productList[index].quantity = 1;
        this.productCart.addItem(this.productList[index]);
      } else {
        this.util.errorMessage(this.util.translate('We already have product with other freelancer'));
      }
    }
  }

  goToProductCheckout() {
    const uid = localStorage.getItem('uid');
    if (uid && uid != null && uid !== 'null') {
      this.router.navigate(['/product-checkout']);
    } else {
      this.util.publishModalPopup('login');
    }
  }

  openProduct(productId: any) {
    this.router.navigate(['product-detail', productId]);
  }

  openService(id: any, name: any) {
    console.log(id);
    this.serviceId = id;
    this.serviceName = name;
    this.util.start();
    this.api.post('v1/freelancer_services/getByCategoryId', { "id": id, "uid": this.id }).then((data: any) => {
      this.util.stop();
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.serviceDetails.show();
        this.servicesList = data.data;
        this.servicesList.forEach((element: any) => {
          if (this.serviceCart.serviceItemId.includes(element.id)) {
            element['isChecked'] = true;
          } else {
            element['isChecked'] = false;
          }
        });
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

  openPackage(id: any, name: any) {
    console.log(id);
    this.packageId = id;
    this.packageName = name;
    this.util.start();
    this.api.post('v1/packages/getPackageDetails', { "id": id }).then((data: any) => {
      this.util.stop();
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.packageDetails.show();
        const info = data.data;
        this.packageInfo = info;
        if (this.serviceCart.packageItemId.includes(this.packageId)) {
          this.packageInfo['isBooked'] = true;
          this.isBooked = true;
        } else {
          this.packageInfo['isBooked'] = false;
          this.isBooked = false;
        }
        this.packageCover = info.cover;
        this.packageDescriptions = info.descriptions;
        this.packageDiscount = info.discount;
        this.packageDuration = info.duration;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.images)) {
          this.packageImages = JSON.parse(info.images);
        } else {
          this.packageImages = [];
        }
        this.packageOff = info.off;
        this.packagePrice = info.price;
        this.packageServices = info.services;
        this.packageSpecialist = info.specialist;
        console.log(this.packageInfo);
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

  addService(item: any, index: any) {
    console.log(index);
    console.log(item);
    if (this.serviceCart.serviceCart.length == 0 && this.serviceCart.packagesCart.length == 0) {
      this.servicesList[index].isChecked = true;
      this.serviceCart.addItem(this.servicesList[index], 'salon');
    } else if (this.serviceCart.packagesCart.length > 0) {
      const freelancerPackagesId = this.serviceCart.getPackageFreelancerId();
      if (freelancerPackagesId == this.id) {
        this.servicesList[index].isChecked = true;
        this.serviceCart.addItem(this.servicesList[index], 'salon');
      } else {
        this.util.errorMessage('We already have service or package with other salon or with freelancer');
      }
    } else {
      const freelancerIdServices = this.serviceCart.getServiceFreelancerId();
      if (freelancerIdServices == this.id) {
        this.servicesList[index].isChecked = true;
        this.serviceCart.addItem(this.servicesList[index], 'salon');
      } else {
        this.util.errorMessage('We already have service or package with other salon or with freelancer');
      }
    }

  }

  removeService(item: any, index: any) {
    console.log(index);
    console.log(item);
    this.servicesList[index].isChecked = false;
    this.serviceCart.removeItem(this.servicesList[index].id);
  }

  addPackage() {
    if (this.serviceCart.serviceCart.length == 0 && this.serviceCart.packagesCart.length == 0) {
      this.packageInfo['isBooked'] = true;
      this.isBooked = true;
      this.serviceCart.addPackage(this.packageInfo, 'salon');
    } else if (this.serviceCart.serviceCart.length > 0) {
      const freenlancerServiceId = this.serviceCart.getServiceFreelancerId();
      if (freenlancerServiceId == this.id) {
        this.packageInfo['isBooked'] = true;
        this.isBooked = true;
        this.serviceCart.addPackage(this.packageInfo, 'salon');
      } else {
        this.util.errorMessage('We already have service or package with other salon or with freelancer');
      }
    } else {
      const freelancerId = this.serviceCart.getPackageFreelancerId();
      if (freelancerId == this.id) {
        this.packageInfo['isBooked'] = true;
        this.isBooked = true;
        this.serviceCart.addPackage(this.packageInfo, 'salon');
      } else {
        this.util.errorMessage('We already have service or package with other salon or with freelancer');
      }
    }

  }

  removePackage() {
    this.packageInfo['isBooked'] = false;
    this.isBooked = false;
    this.serviceCart.removePackage(this.packageId);
  }

  clearServiceCart() {
    this.serviceCart.clearCart();
    this.servicesList.forEach((element) => {
      element.isChecked = false;
    });
  }

  clearProductCart() {
    this.productCart.clearCart();
    this.productList.forEach((element) => {
      element.quantity = 0;
    });
  }

  goToCheckout() {
    const uid = localStorage.getItem('uid');
    if (uid && uid != null && uid !== 'null') {
      console.log(this.serviceCart.fromService);
      if (this.serviceCart.fromService == 'salon') {
        this.router.navigate(['/checkout']);
      } else {
        this.router.navigate(['/freelancer-checkout']);
      }
    } else {
      this.util.publishModalPopup('login');
    }
  }
}
