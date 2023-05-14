/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { ProductCartService } from 'src/app/services/product-cart.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-headers',
  templateUrl: './headers.component.html',
  styleUrls: ['./headers.component.scss']
})
export class HeadersComponent implements OnInit {
  activeTab = 'home';
  headerMode: boolean;
  activeFilter: any;
  totalRest: any;
  selectedLanguage: any = 'English';
  constructor(
    private router: Router,
    public api: ApiService,
    public util: UtilService,
    private chmod: ChangeDetectorRef,
    public cart: ProductCartService
  ) {
    this.headerMode = false;
    this.selectedLanguage = 'English';
    if (localStorage.getItem('selectedLanguage') && localStorage.getItem('selectedLanguage') != null && localStorage.getItem('selectedLanguage') != '') {
      var items = this.util.allLanguages.filter(x => x.code == localStorage.getItem('selectedLanguage'));
      console.log(items);
      if (items && items.length > 0) {
        this.selectedLanguage = items[0].name;
        localStorage.setItem('direction', items[0].direction);
      }
    }
    this.util.subscribeHeader().subscribe(data => {
      if (data) {
        this.headerMode = data.header;
        this.totalRest = data.total;
        if (data && data.active !== undefined) {
          this.activeFilter = data.active;
        }
      }

      this.chmod.detectChanges();
    });
  }

  addFilter(item) {
    this.activeFilter = item;
    this.util.publishFilterCode(item);
  }

  changeLanguage(value) {
    const item = this.util.allLanguages.filter(x => x.code == value.code);
    if (item && item.length > 0) {
      localStorage.setItem('selectedLanguage', value.code);
      localStorage.setItem('direction', value.direction);
      window.location.reload();
    }
  }

  haveLocation() {
    const location = localStorage.getItem('location');
    if (location && location != null && location !== 'null') {
      return true;
    }
    return false;
  }

  haveSigned() {
    const uid = localStorage.getItem('uid');
    if (uid && uid != null && uid !== 'null') {
      return true;
    }
    return false;
  }


  ngOnInit(): void {
  }

  goToHome() {
    this.activeTab = 'home';
    this.router.navigate(['/home']);
  }

  goToSearch() {
    this.activeTab = 'search';
    this.router.navigate(['/search']);
  }

  goToOffers() {
    this.activeTab = 'offers';
    this.router.navigate(['/offers']);
  }

  goToSettings(item) {
    this.activeTab = 'settings';
    const name = (this.util.userInfo.first_name + '-' + this.util.userInfo.last_name).toLowerCase();
    this.router.navigate(['user', name, item]);
  }

  goToAccount() {
    this.activeTab = 'account';
    this.router.navigate(['/account']);
  }

  goToCart() {
    this.activeTab = 'cart';
    this.router.navigate(['/cart']);
  }

  goToShop() {
    this.activeTab = 'shop';
    this.router.navigate(['shop']);
  }

  getAddress() {
    const location = localStorage.getItem('address');
    if (location && location != null && location !== 'null') {
      return location.length > 30 ? location.slice(0, 30) + '....' : location;;
    }
    return this.util.translate('Choose your Location');
  }

  logout() {
    this.util.start();
    this.api.post_private('v1/profile/logout', {}).then((data: any) => {
      console.log(data);
      this.util.stop();
      localStorage.removeItem('uid');
      localStorage.removeItem('token');
      // this.cart.cart = [];
      // this.cart.itemId = [];
      // this.cart.totalPrice = 0;
      // this.cart.grandTotal = 0;
      // this.cart.coupon = null;
      // this.cart.discount = null;
      this.util.clearKeys('cart');
      this.router.navigate(['']);
    }, error => {
      console.log(error);
      this.util.stop();
    }).catch((error: any) => {
      console.log(error);
      this.util.stop();
    });

  }

  goToHelp() {
    this.activeTab = 'help';
    this.router.navigate(['help']);
  }

  goToFaqs() {
    this.activeTab = 'faq';
    this.router.navigate(['faq']);
  }
}
