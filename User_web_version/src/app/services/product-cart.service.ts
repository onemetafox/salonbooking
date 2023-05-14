/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Injectable } from '@angular/core';
import { UtilService } from './util.service';
import { ApiService } from './api.service';
import Swal from 'sweetalert2';

@Injectable({
  providedIn: 'root'
})
export class ProductCartService {

  public cart: any[] = [];
  public itemId: any[] = [];
  public totalPrice: any = 0;
  public grandTotal: any = 0.0;
  public coupon: any;
  public serviceTax: any = 0;
  public discount: any = 0;
  public orderTax: any = 0;
  public orderPrice: any;
  public minOrderPrice: any = 0;
  public freeShipping: any = 0;
  public datetime: any;
  public deliveredAddress: any;

  public storeInfo: any;

  public shippingMethod: 0;
  public shippingPrice: 0;
  public deliveryCharge: any = 0.0;
  public totalItemsInCart: any;

  public deliveryPrice: any = 0;
  public stores: any[] = [];
  public totalItem: any;
  public bulkOrder: any[] = [];
  public flatTax: any;
  public cartStoreInfo: any;

  public havePayment: boolean;
  public haveStripe: boolean;
  public haveRazor: boolean;
  public haveCOD: boolean;
  public havePayPal: boolean;
  public havePayTM: boolean;
  public havePayStack: boolean;
  public haveFlutterwave: boolean;

  public walletDiscount: any = 0.0;
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.util.getKeys('productCart').then((data: any) => {
      console.log('*******************************************', data);

      if (data && data !== null && data !== 'null') {
        const productCart = JSON.parse(data);
        if (productCart && productCart.length > 0) {
          this.cart = productCart;
          this.itemId = [...new Set(this.cart.map(item => item.id))];

          this.calcuate();
          console.log('0???', productCart);
        } else {
          console.log('1???', data);
          this.calcuate();
        }
      } else {
        console.log('2???', data);
        this.calcuate();
      }
    });
  }


  addItem(item: any) {
    console.log('item to adde', item);
    this.cart.push(item);
    this.itemId.push(item.id);
    this.calcuate();
  }

  updateQuantity(id: any, quantity: any) {
    this.cart.forEach(element => {
      if (element.id == id) {
        element.quantity = quantity;
      }
    });
    this.calcuate();
  }
  removeItem(id: any) {
    console.log('remove this item from cart');
    console.log('current cart items', this.cart);
    this.cart = this.cart.filter(x => x.id !== id);
    this.itemId = this.itemId.filter(x => x !== id);

    console.log('===>>>>>>>>>', this.cart);
    console.log('items===>>>', this.itemId);
    this.calcuate();
  }

  calcuate() {

    let total = 0;
    this.cart.forEach(element => {
      if (element.discount > 0) {
        total = total + element.sell_price * element.quantity;
      } else {
        total = total + element.original_price * element.quantity;
      }
    });
    this.totalPrice = total;
    console.log('totalproduct ---------------', this.totalPrice);
    // AKHAND
    localStorage.removeItem('productCart');
    localStorage.setItem('productCart', JSON.stringify(this.cart));
    this.util.clearKeys('productCart');
    this.util.setKeys('productCart', JSON.stringify(this.cart));
    // AKHAND
    this.totalPrice = parseFloat(this.totalPrice).toFixed(1);
    this.orderTax = parseFloat(this.orderTax).toFixed(1);
    this.discount = parseFloat(this.discount).toFixed(1);
    this.calculateAllCharges();
  }

  calculateAllCharges() {

    console.log(this.totalPrice, this.orderTax, this.deliveryCharge);
    let total = parseFloat(this.totalPrice) + parseFloat(this.orderTax.toString()) + parseFloat(this.deliveryCharge);

    if (this.coupon && this.coupon.discount && this.coupon.discount > 0) {
      function percentage(numFirst: any, per: any) {
        return (numFirst / 100) * per;
      }
      this.discount = percentage(this.totalPrice, this.coupon.discount);
      this.discount = parseFloat(this.discount).toFixed(1);
      if (total <= this.discount) {
        this.discount = this.totalPrice;
        total = total - this.discount;
      } else {
        total = total - this.discount;
      }
    }

    console.log('sub totall', total);
    this.grandTotal = total;
    let totalPrice = parseFloat(this.totalPrice) + parseFloat(this.orderTax) + parseFloat(this.deliveryCharge);
    console.log(totalPrice);
    this.grandTotal = totalPrice;
    this.grandTotal = totalPrice - this.discount;
    this.grandTotal = parseFloat(this.grandTotal).toFixed(2);

    if (this.grandTotal <= this.walletDiscount) {
      this.walletDiscount = this.grandTotal;
      this.grandTotal = this.grandTotal - this.walletDiscount;
    } else {
      this.grandTotal = this.grandTotal - this.walletDiscount;
    }

    this.grandTotal = parseFloat(this.grandTotal).toFixed(2);

  }


  async calculateDistance() {
    console.log(this.deliveredAddress);
    console.log(this.storeInfo);
    let distance;

    if (this.deliveredAddress && this.deliveredAddress.address && this.storeInfo && this.storeInfo.lat) {
      distance = await this.distanceInKmBetweenEarthCoordinates(this.deliveredAddress.lat, this.deliveredAddress.lng,
        this.storeInfo.lat, this.storeInfo.lng);
    } else {
      distance = 0;
    }

    if (distance >
      parseFloat(this.util.allowDistance)) {
      this.util.errorMessage(this.util.translate(
        'Sorry we deliver the order near to this.util.allowDistance'));
    } else {
      if (this.util.deliveryType == 0) {
        let distanceParse = distance * this.util.deliveryCharge;
        this.deliveryCharge = distanceParse;

      } else {
        this.deliveryCharge = this.util.deliveryCharge;

      }
    }
    console.log('delivery charge', this.deliveryCharge);
    this.calculateAllCharges();
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


  clearCart() {
    this.cart = [];
    this.itemId = [];
    this.totalPrice = 0;
    this.grandTotal = 0;
    this.coupon = undefined;
    this.discount = 0;
    this.orderPrice = 0;
    this.datetime = undefined;
    this.deliveryCharge = 0;
    this.deliveredAddress = null;
    this.stores = [];
    this.util.clearKeys('productCart');
    this.totalItem = 0;
    this.calcuate();
  }
}
