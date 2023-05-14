/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
import Swal from 'sweetalert2';
import * as moment from 'moment';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;
  dummy: any[] = [];
  complaints: any[] = [];
  productsOrders: any[] = [];
  appointments: any[] = [];
  user: any[] = [];
  total_appointments: any = 0;
  total_appointments_freelancer: any = 0;
  total_freelancers: any = 0;
  total_salon: any = 0;
  total_orders: any = 0;
  total_products: any = 0;
  total_users: any = 0;

  labelTodayAppointments: any = '';
  labelWeeklyAppointments: any = '';
  labelMonthlyAppointments: any = '';

  lineChartLegend = true;
  lineChartPlugins = [];
  lineChartType = 'line';

  chartBarDataAppointments = {
    labels: [this.util.translate('Appointments')],
    datasets: [
      {
        label: this.util.translate('Appointments'),
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarData2Appointments = {
    labels: [this.util.translate('Appointments')],
    datasets: [
      {
        label: this.util.translate('Appointments'),
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarData3Appointments = {
    labels: [this.util.translate('Appointments')],
    datasets: [
      {
        label: this.util.translate('Appointments'),
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  ///////////////////// Product /////////////////////
  labelTodayProducts: any = '';
  labelWeeklyProducts: any = '';
  labelMonthlyProducts: any = '';


  chartBarDataProducts = {
    labels: [this.util.translate('Orders')],
    datasets: [
      {
        label: this.util.translate('Orders'),
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarData2Products = {
    labels: [this.util.translate('Orders')],
    datasets: [
      {
        label: this.util.translate('Orders'),
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarData3Products = {
    labels: [this.util.translate('Orders')],
    datasets: [
      {
        label: this.util.translate('Orders'),
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };
  ///////////////////// Product /////////////////////

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
    'NA',
    'COD',
    'Stripe',
    'PayPal',
    'Paytm',
    'Razorpay',
    'Instamojo',
    'Paystack',
    'Flutterwave'
  ];

  name: any = '';
  email: any = '';
  message: any = '';

  reply: any = '';
  id: any = '';

  issue_With: any[] = [
    '',
    this.util.translate('Order'),
    this.util.translate('Freelancer'),
    this.util.translate('Driver'),
    this.util.translate('Product'),
    this.util.translate('Service'),
    this.util.translate('Service'),
  ];
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {
    this.getHome();
  }

  getHome() {
    this.dummy = Array(5);
    this.api.get_private('v1/freelancer/getAdminHome').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200) {
        data.appointments.forEach((element: any) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
            element.items = JSON.parse(element.items);
          }
        });
        this.appointments = data.appointments;
        this.complaints = data.complaints;
        data.productsOrders.forEach((element: any) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.orders)) {
            element.orders = JSON.parse(element.orders);
          }
        });
        this.productsOrders = data.productsOrders;
        this.total_appointments = data.total_appointments;
        this.total_appointments_freelancer = data.total_appointments_freelancer;
        this.total_freelancers = data.total_freelancers;
        this.total_orders = data.total_orders;
        this.total_products = data.total_products;
        this.total_users = data.total_users;
        this.total_salon = data.total_salon;
        this.user = data.user;


        if (data && data.today && data.today.label) {
          data.today.label.forEach((element: any) => {
            this.chartBarDataAppointments.labels.push(element);
          });
          data.today.data.forEach((element: any) => {
            this.chartBarDataAppointments.datasets[0].data.push(element);
          });
        }
        this.labelTodayAppointments = data.todayLabel;

        if (data && data.week && data.week.label) {
          data.week.label.forEach((element: any) => {
            this.chartBarData2Appointments.labels.push(element);
          });
          data.week.data.forEach((element: any) => {
            this.chartBarData2Appointments.datasets[0].data.push(element);
          });
        }
        this.labelWeeklyAppointments = data.weekLabel;

        if (data && data.month && data.month.label) {
          data.month.label.forEach((element: any) => {
            this.chartBarData3Appointments.labels.push(element);
          });
          data.month.data.forEach((element: any) => {
            this.chartBarData3Appointments.datasets[0].data.push(element);
          });
        }
        this.labelMonthlyAppointments = data.monthLabel;


        ///////////////////// Product /////////////////////
        if (data && data.todayProducts && data.todayProducts.label) {
          data.todayProducts.label.forEach((element: any) => {
            this.chartBarDataProducts.labels.push(element);
          });
          data.todayProducts.data.forEach((element: any) => {
            this.chartBarDataProducts.datasets[0].data.push(element);
          });
        }
        this.labelTodayProducts = data.todayLabelProducts;

        if (data && data.weekProducts && data.weekProducts.label) {
          data.weekProducts.label.forEach((element: any) => {
            this.chartBarData2Products.labels.push(element);
          });
          data.weekProducts.data.forEach((element: any) => {
            this.chartBarData2Products.datasets[0].data.push(element);
          });
        }
        this.labelWeeklyProducts = data.weekLabelProducts;

        if (data && data.monthProducts && data.monthProducts.label) {
          data.monthProducts.label.forEach((element: any) => {
            this.chartBarData3Products.labels.push(element);
          });
          data.monthProducts.data.forEach((element: any) => {
            this.chartBarData3Products.datasets[0].data.push(element);
          });
        }
        this.labelMonthlyProducts = data.monthLabelProducts;
        ///////////////////// Product /////////////////////
      }
    }, error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.dummy = [];
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  openPage(route: any) {
    console.log(route);
    this.router.navigate([route]);
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

  viewDataProduct(id: any) {
    const param: NavigationExtras = {
      queryParams: {
        id: id
      }
    }
    this.router.navigate(['orders-details'], param);
  }

  getDate(date: any) {
    return moment(date).format('ll');
  }
  openItem(item: any) {
    console.log(item);
    this.name = item.userInfo.first_name + ' ' + item.userInfo.last_name;
    this.email = item.userInfo.email;
    this.message = item.short_message;
    this.id = item.id;
    this.myModal.show();
  }

  sendMail() {
    if (this.reply == '' || !this.reply) {
      this.util.error(this.util.translate('Please add your reply text'));
      return false;
    }
    const param = {
      id: this.id,
      mediaURL: this.api.imageUrl,
      subject: this.util.appName + ' ' + this.util.translate('Replied on your complaints'),
      thank_you_text: this.util.translate('You have received new mail on your complaints'),
      header_text: this.util.appName + ' ' + this.util.translate('Replied on your complaints'),
      email: this.email,
      from_username: this.name,
      to_respond: this.reply
    };
    this.util.show();
    console.log(param);
    this.api.post_private('v1/complaints/replyContactForm', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      this.reply = '';
      this.myModal.hide();
      this.util.success(this.util.translate('Mail sent'));
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });


  }

  statusUpdate(item: any) {
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To update this item?'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancel'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        const body = {
          id: item.id,
          status: item.status == 0 ? 1 : 0
        };
        item.status = body.status;
        console.log("======", body);
        this.util.show();
        this.api.post_private('v1/complaints/update', body).then((data: any) => {
          this.util.hide();
          console.log("+++++++++++++++", data);
          if (data && data.status && data.status == 200 && data.success) {
            this.util.success(this.util.translate('Status Updated !'));

          }
        }, error => {
          this.util.hide();
          console.log('Error', error);
          this.util.apiErrorHandler(error);
        }).catch(error => {
          this.util.hide();
          console.log('Err', error);
          this.util.apiErrorHandler(error);
        });
      }
    });
  }
}
