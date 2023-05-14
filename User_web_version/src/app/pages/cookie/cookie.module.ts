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

import { CookieRoutingModule } from './cookie-routing.module';
import { CookieComponent } from './cookie.component';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';

@NgModule({
  declarations: [
    CookieComponent
  ],
  imports: [
    CommonModule,
    CookieRoutingModule,
    NgxSkeletonLoaderModule
  ]
})
export class CookieModule { }
