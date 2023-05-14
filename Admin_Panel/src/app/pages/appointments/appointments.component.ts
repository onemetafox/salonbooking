/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-appointments',
  templateUrl: './appointments.component.html',
  styleUrls: ['./appointments.component.scss']
})
export class AppointmentsComponent implements OnInit {
  dummy = Array(5);
  list: any[] = [];
  dummyList: any[] = [];
  page: number = 1;
  orderStatusNames = [
    this.util.translate('Created'), // 0
    this.util.translate('Accepted'), // 1
    this.util.translate('Rejected'), // 2
    this.util.translate('Ongoing'), // 3
    this.util.translate('Completed'), // 4
    this.util.translate('Cancelled by user'), // 5
    this.util.translate('Refund'), // 6
    this.util.translate('Delayed'), // 7
    this.util.translate('Pending Payments'), // 8
  ];
  paymentName = [
    this.util.translate('NA'),
    this.util.translate('COD'),
    this.util.translate('Stripe'),
    this.util.translate('PayPal'),
    this.util.translate('Paytm'),
    this.util.translate('Razorpay'),
    this.util.translate('Instamojo'),
    this.util.translate('Paystack'),
    this.util.translate('Flutterwave')
  ];
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {
    this.getAll();
  }

  getAll() {
    this.list = [];
    this.dummy = Array(5);
    this.api.get_private('v1/appoinments/getAllSalonAppointments').then((data: any) => {
      console.log(">>>>>", data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.success) {
        if (data.data.length > 0) {
          data.data.forEach((element: any) => {
            if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
              element.items = JSON.parse(element.items);
            }
          });
          this.list = data.data;
          this.dummyList = data.data;
          console.log("====", this.list);
        }
      }
    }, error => {
      this.dummy = [];
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.dummy = [];
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  viewData(id: any) {
    console.log(id);
    const param: NavigationExtras = {
      queryParams: {
        id: id
      }
    }
    this.router.navigate(['appointments-details'], param);
  }
}
