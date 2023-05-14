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

import { FreelancerCheckoutRoutingModule } from './freelancer-checkout-routing.module';
import { FreelancerCheckoutComponent } from './freelancer-checkout.component';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { FormsModule } from '@angular/forms';
import { NgxPayPalModule } from 'ngx-paypal';

@NgModule({
  declarations: [
    FreelancerCheckoutComponent
  ],
  imports: [
    CommonModule,
    FreelancerCheckoutRoutingModule,
    MDBBootstrapModule.forRoot(),
    FormsModule,
    NgxPayPalModule
  ]
})
export class FreelancerCheckoutModule { }
