/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, NavigationEnd, Router } from '@angular/router';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { ApiService } from 'src/app/services/api.service';
import { ProductCartService } from 'src/app/services/product-cart.service';
import { UtilService } from 'src/app/services/util.service';


@Component({
  selector: 'app-product-detail',
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.scss']
})
export class ProductDetailComponent implements OnInit {
  public radioModel: string = 'Left';

  productId: any = '';


  productCover: any = '';
  productName: any = '';
  originalPrice: any = '';
  sellPrice: any = '';
  soldBy: any = '';
  rating: any = '';
  totalRating: any = '';
  descriptions: any = '';
  highlight: any = '';
  disclaimer: any = '';
  images: any[] = [];

  relatedProductsList: any[] = [];
  reviewList: any[] = [];

  currentTab = '1';

  customOptions: OwlOptions = {
    loop: true,
    mouseDrag: true,
    touchDrag: true,
    pullDrag: true,
    dots: true,
    navSpeed: 700,
    nav: false,
    responsive: {
      0: {
        items: 1
      },
    },
  }

  customOptionTestimonial: OwlOptions = {
    loop: true,
    mouseDrag: true,
    touchDrag: true,
    pullDrag: true,
    dots: false,
    navSpeed: 700,
    nav: false,
    responsive: {
      0: {
        items: 3
      },
    },
  };

  productInfo: any;
  apiCalled: boolean;
  constructor(private router: Router,
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    public productCart: ProductCartService
  ) {
    if (this.navParam.snapshot.paramMap.get('id')) {
      this.apiCalled = false;
      this.productId = this.navParam.snapshot.paramMap.get('id');
      this.getProductInfo();
      this.getProductReviews();
    }

    this.router.events.subscribe((data: any) => {
      if (data instanceof NavigationEnd) {
        this.apiCalled = false;
        console.log('call now');
        this.getProductInfo();
        this.getProductReviews();
      }
    });
  }



  getProductInfo() {
    this.apiCalled = false;
    this.api.post('v1/products/getProductInfo', { "id": this.productId }).then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status == 200) {
        this.productCover = data.data.cover;
        this.productName = data.data.name;
        this.rating = data.data.rating;
        this.totalRating = data.data.total_rating;
        this.originalPrice = data.data.original_price;
        this.sellPrice = data.data.sell_price;
        this.soldBy = data.soldby.name;
        this.descriptions = data.data.descriptions != '' && data.data.descriptions != null ? data.data.descriptions : '';
        this.highlight = data.data.key_features != '' && data.data.key_features != null ? data.data.key_features : '';
        this.disclaimer = data.data.disclaimer != '' && data.data.disclaimer != null ? data.data.disclaimer : '';

        this.relatedProductsList = data.related.filter(x => x.id != this.productId);
        console.log('related ----------', this.relatedProductsList);
        console.log('gallary --------', data.data.images);
        if (this.productCart.itemId.includes(data.data.id)) {
          data.data['quantity'] = this.getQuanity(data.data.id);
        } else {
          data.data['quantity'] = 0;
        }
        this.productInfo = data.data;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.data.images)) {
          this.images = JSON.parse(data.data.images);
        } else {
          this.images = [];
        }

        console.log(this.productInfo);
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


  getProductReviews() {
    this.util.start();
    this.api.post('v1/product_reviews/getMyReviews', { "id": this.productId }).then((data: any) => {
      console.log(data);
      this.util.stop();
      if (data && data.status == 200) {
        this.reviewList = data.data;
        console.log(this.reviewList);
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

  addToCart() {
    console.log(this.productInfo);
    if (this.productCart.cart.length == 0) {
      this.productInfo.quantity = 1;
      this.productCart.addItem(this.productInfo);
    } else {
      if (this.productCart.cart[0].freelacer_id == this.productInfo.freelacer_id) {
        this.productInfo.quantity = 1;
        this.productCart.addItem(this.productInfo);
      } else {
        this.util.errorMessage(this.util.translate('We already have product with other freelancer'));
      }
    }

  }

  getQuanity(id: any) {
    const data = this.productCart.cart.filter(x => x.id == id);
    return data[0].quantity;
  }

  remove() {
    console.log(this.productInfo);
    if (this.productInfo.quantity == 1) {
      this.productInfo.quantity = 0;
      this.productCart.removeItem(this.productInfo.id);
    } else {
      this.productInfo.quantity = this.productInfo.quantity - 1;
      this.productCart.updateQuantity(this.productInfo.id, this.productInfo.quantity);
    }
  }

  add() {
    console.log(this.productInfo);
    this.productInfo.quantity = this.productInfo.quantity + 1;
    this.productCart.updateQuantity(this.productInfo.id, this.productInfo.quantity);
  }

  ngOnInit(): void {
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
    console.log('open product', productId);
    this.router.navigate(['product-detail', productId]);
  }
}
