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

import { AwaitPaymentsProductRoutingModule } from './await-payments-product-routing.module';
import { AwaitPaymentsProductComponent } from './await-payments-product.component';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { NgxPayPalModule } from 'ngx-paypal';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AwaitPaymentsProductComponent
  ],
  imports: [
    CommonModule,
    AwaitPaymentsProductRoutingModule,
    MDBBootstrapModule.forRoot(),
    NgxPayPalModule,
    FormsModule,
  ]
})
export class AwaitPaymentsProductModule { }
