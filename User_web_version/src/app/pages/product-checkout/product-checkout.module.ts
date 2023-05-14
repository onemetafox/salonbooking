/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ProductCheckoutRoutingModule } from './product-checkout-routing.module';
import { ProductCheckoutComponent } from './product-checkout.component';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { NgxPayPalModule } from 'ngx-paypal';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    ProductCheckoutComponent
  ],
  imports: [
    CommonModule,
    ProductCheckoutRoutingModule,
    MDBBootstrapModule,
    FormsModule,
    NgxPayPalModule
  ]
})
export class ProductCheckoutModule { }
