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
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-mobile-header',
  templateUrl: './mobile-header.component.html',
  styleUrls: ['./mobile-header.component.scss']
})
export class MobileHeaderComponent implements OnInit {

  constructor(
    public util: UtilService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  goToHome() {
    this.router.navigate(['/home']);
  }


  getAddress() {
    const location = localStorage.getItem('address');
    if (location && location != null && location !== 'null') {
      return location.length > 30 ? location.slice(0, 30) + '....' : location;;
    }
    return this.util.translate('Choose your Location');
  }
}
