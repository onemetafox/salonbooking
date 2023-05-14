/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, NgZone, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalDirective } from 'angular-bootstrap-md';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';


@Component({
  selector: 'app-await-payments-product',
  templateUrl: './await-payments-product.component.html',
  styleUrls: ['./await-payments-product.component.scss']
})
export class AwaitPaymentsProductComponent implements OnInit {
  @ViewChild('successModal') public successModal: ModalDirective;
  orderId: any;
  interval: any;
  confirmed: boolean = false;
  payLink: any;
  payClick: boolean = false;
  constructor(
    private route: ActivatedRoute,
    private api: ApiService,
    public util: UtilService,
    private zone: NgZone,
    private router: Router
  ) {
    this.util.changeIntevert().subscribe(() => {
      clearInterval(this.interval);
    })
    this.route.queryParams.subscribe((data: any) => {
      console.log(data);
      if (data && data.id && data.payLink) {
        this.orderId = data.id;
        this.payLink = data.payLink;
        this.interval = setInterval(() => {
          console.log('calling');
          if (this.confirmed == false) {
            this.getOrderStatus();
          }
        }, 5000);
      }
    });
  }

  async openBrowser() {

    this.payClick = true;
    await window.open(this.payLink, '_blank');
  }

  ngOnInit(): void {
  }

  onOrderHistory() {
    this.successModal.hide();
    const name = (this.util.userInfo.first_name + '-' + this.util.userInfo.last_name).toLowerCase();
    this.router.navigate(['user', name, 'product-order']);
  }


  onHome() {
    this.successModal.hide();
    this.router.navigate(['']);
  }

  getOrderStatus() {
    const param = {
      id: this.orderId
    };
    this.api.post_private('v1/product_order/getById', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        if (data && data.data && data.data.status == 0) {
          this.confirmed = true;
          setTimeout(() => {
            clearInterval(this.interval);
            this.openSuccess(this.orderId);
          }, 5000);
        }
      }
    }).catch(error => {
      console.log(error);
      this.router.navigate(['']);
      this.util.errorMessage(this.util.translate('Something went wrong while payments. please contact administrator'));
    });
  }

  async openSuccess(orderID: any) {
    this.successModal.show();
  }
}
