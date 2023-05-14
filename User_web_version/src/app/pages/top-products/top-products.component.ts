/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { ProductCartService } from 'src/app/services/product-cart.service';
import { UtilService } from 'src/app/services/util.service';


@Component({
  selector: 'app-top-products',
  templateUrl: './top-products.component.html',
  styleUrls: ['./top-products.component.scss']
})
export class TopProductsComponent implements OnInit {
  apiCalled: boolean = false;
  productList: any[] = [];
  haveData: boolean = false;
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router,
    public productCart: ProductCartService
  ) {
    this.getProducts();
  }

  getProducts() {
    this.apiCalled = false;
    const param = { id: localStorage.getItem('top-products'), "lat": localStorage.getItem('lat'), "lng": localStorage.getItem('lng') };
    this.api.post('v1/products/topProducts', param).then((data: any) => {
      this.apiCalled = true;
      console.log(data);
      if (data && data.status == 200 && data.data && data.data.length) {
        this.haveData = true;
        data.data.forEach((productList: any) => {
          if (this.productCart.itemId.includes(productList.id)) {
            productList['quantity'] = this.getQuanity(productList.id);
          } else {
            productList['quantity'] = 0;
          }
        });
        this.productList = data.data;
      } else {
        this.haveData = false;
      }
    }, error => {
      console.log(error);
      this.productList = [];
      this.haveData = false;
      this.router.navigate(['']);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.productList = [];
      this.haveData = false;
      this.router.navigate(['']);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  getAddressName() {
    const location = localStorage.getItem('address');
    if (location && location != null && location !== 'null') {
      return location.length > 30 ? location.slice(0, 30) + '....' : location;;
    }
    localStorage.clear();
    return 'No address';
  }

  onProductDetail(productId: any) {
    this.router.navigate(['product-detail', productId]);
  }

  getQuanity(id: any) {
    const data = this.productCart.cart.filter(x => x.id == id);
    return data[0].quantity;
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
}
