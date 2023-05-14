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

import { AwaitPaymentsRoutingModule } from './await-payments-routing.module';
import { AwaitPaymentsComponent } from './await-payments.component';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { NgxPayPalModule } from 'ngx-paypal';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AwaitPaymentsComponent
  ],
  imports: [
    CommonModule,
    AwaitPaymentsRoutingModule,
    MDBBootstrapModule.forRoot(),
    NgxPayPalModule,
    FormsModule,
  ]
})
export class AwaitPaymentsModule { }
