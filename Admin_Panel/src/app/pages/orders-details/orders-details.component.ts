/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-orders-details',
  templateUrl: './orders-details.component.html',
  styleUrls: ['./orders-details.component.scss']
})
export class OrdersDetailsComponent implements OnInit {
  id: any = '';
  address: any = '';
  discount: any = '';
  distance_cost: any = '';
  freelancerName: any = '';
  freelancerEmail: any = '';
  freelancerCover: any = '';
  freelancerMobile: any = '';
  freelancerId: any = '';
  grand_total: any = '';
  orders: any[] = [];
  notes: any = '';
  paid: any = '';
  pay_method: any = '';
  save_date: any = '';
  serviceTax: any = '';
  slot: any = '';
  status: any = '';
  orderStatus: any = '';
  total: any = '';
  uid: any = '';
  userName: any = '';
  userEmail: any = '';
  userCover: any = '';
  userMobile: any = '';
  userFCM: any = '';
  wallet_price: any = '';
  paymentRef: any = '';
  payName: any = '';
  changeStatusOrder: any;
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
  payment = [
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
  loaded: boolean = false;
  constructor(
    public util: UtilService,
    public api: ApiService,
    private route: ActivatedRoute,
    private navCtrl: Location
  ) {
    this.route.queryParams.subscribe((data: any) => {
      console.log(data);
      if (data && data.id) {
        this.id = data.id;
        console.log(this.id);
        this.getData();
      }
    });
  }

  getData() {
    this.loaded = false;
    this.api.post_private('v1/product_order/getInfoAdmin', { id: this.id }).then((data: any) => {
      console.log(data);
      this.loaded = true;
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        const info = data.data;
        console.log(info);
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.orders)) {
          this.orders = JSON.parse(info.orders);
        }

        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.address)) {
          const address = JSON.parse(info.address);
          console.log(address);
          if (address && address.address) {
            this.address = address.house + ' ' + address.address + ' ' + address.landmark + ' ' + address.pincode;
          }
        }
        this.discount = info.discount;
        this.distance_cost = info.distance_cost;
        if (info && info.freelancerInfo) {
          this.freelancerName = info.freelancerInfo.first_name + ' ' + info.freelancerInfo.last_name;
          this.freelancerCover = info.freelancerInfo.cover;
          this.freelancerEmail = info.ownerInfo.email;
          this.freelancerMobile = info.ownerInfo.mobile;
          this.freelancerId = info.freelancerInfo.id;
        }

        if (info && info.salonInfo) {
          this.freelancerName = info.salonInfo.name;
          this.freelancerCover = info.salonInfo.cover;
          this.freelancerEmail = info.ownerInfo.email;
          this.freelancerMobile = info.ownerInfo.mobile;
          this.freelancerId = info.salon_id;
        }

        this.grand_total = info.grand_total;
        this.notes = info.notes;
        this.paid = info.pay_key;
        this.pay_method = info.paid_method;
        this.save_date = info.save_date;
        this.serviceTax = info.serviceTax;
        this.slot = info.slot;
        this.status = info.status;
        this.total = info.total;
        this.uid = info.uid;
        this.userCover = info.userInfo.cover;
        this.userName = info.userInfo.first_name + ' ' + info.userInfo.last_name;
        this.userEmail = info.userInfo.email;
        this.userMobile = info.userInfo.mobile;
        this.userFCM = info.userInfo.fcm_token;
        this.wallet_price = info.wallet_price;
        this.paymentRef = info.pay_key;
        this.status = info.status;
        this.orderStatus = this.orderStatusNames[info.status];
        this.payName = this.payment[info.paid_method];
      };
      console.log(this.orders);
    }, error => {
      console.log(error);
      this.loaded = true;
      this.util.apiErrorHandler(error);
    }).catch((error: any) => {
      console.log(error);
      this.loaded = true;
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  call() {
    if (this.userMobile) {
      window.open('tel:' + this.userMobile, '_system')

    } else {
      this.util.error(this.util.translate('Number not found'));
    }
  }

  email() {
    if (this.userEmail) {
      window.open('mailto:' + this.userEmail, '_system')
    } else {
      this.util.error(this.util.translate('Email not found'));
    }
  }

  printOrder() {
    window.open(this.api.baseUrl + 'v1/product_order/orderInvoice?id=' + this.id + '&token=' + localStorage.getItem('token'), '_system');
  }

  changeOrderStatus() {
    console.log(this.changeStatusOrder);
    console.log('stauts', this.orderStatus);
    console.log('paid with', this.payName);
    if (this.changeStatusOrder == 'refund') {
      console.log('refund with API');
      if (this.payName == 'Stripe') {
        this.refundStripe();
      } else if (this.payName == 'PayPal') {
        this.refundPayPal();
      } else if (this.payName == 'Paytm') {
        this.refundPayTM();
      } else if (this.payName == 'Razorpay') {
        this.refundRazorPay();
      } else if (this.payName == 'Instamojo') {
        this.refundInstaMOJO();
      } else if (this.payName == 'Paystack') {
        this.refundPayStack();
      } else if (this.payName == 'Flutterwave') {
        this.refundFlutterwave();
      } else if (this.payName == '9') {
        this.refundPaykun();
      }
    } else {
      console.log('refund with merchant');
      this.refundOrder();
    }

  }


  refundPayPal() {
    console.log('refund paypal');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    let id;
    if (ref && ref.key) {
      id = ref.key;
    } else if (ref && ref.intent && ref.intent == 'CAPTURE') {
      id = ref.purchase_units[0].payments.captures[0].id;
    }
    console.log('transactional id', id);

    const param = {
      ref: id,
      amount: this.grand_total
    }
    console.log('param', param);
    this.util.show();
    this.api.post_private('v1/payments/payPalRefund', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundPayTM() {
    console.log('refund paytm');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    let key;
    let txtId;
    if (ref && ref.key && ref.txtId) {
      key = ref.key;
      txtId = ref.txtId;
      const param = {
        id: key,
        txt_id: txtId,
        amount: this.grand_total
      };
      this.util.show();
      this.api.post_private('v1/payments/paytmRefund', param).then((data: any) => {
        console.log(data);
        if (data && data.status && data.status == 200) {
          this.refundOrder();
        } else {
          this.util.hide();
          this.util.apiErrorHandler(data);
        }
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
  }

  refundRazorPay() {
    console.log('refund razorpay');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    if (ref && ref.id) {
      const param = {
        id: ref.id
      }
      this.util.show();
      this.api.post_private('v1/payments/razorPayRefund', param).then((data: any) => {
        console.log(data);
        if (data && data.status && data.status == 200) {
          this.refundOrder();
        } else {
          this.util.hide();
          this.util.apiErrorHandler(data);
        }
      }, error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      }).catch(error => {
        console.log(error);
        this.util.hide();
        this.util.apiErrorHandler(error);
      });
      //
    }
  }

  refundInstaMOJO() {
    console.log('refund instamojo');
    console.log(this.paymentRef);

    let key;
    if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(this.paymentRef)) {
      const ref = JSON.parse(this.paymentRef);
      console.log('ref=>', ref);
      key = ref.payment_id;
    } else {
      key = this.paymentRef;
    }

    console.log('key', key);
    const param = {
      id: key
    }
    this.util.show();
    this.api.post_private('v1/payments/instaMOJORefund', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundPayStack() {
    console.log('refund paystack');
    const param = {
      id: this.paymentRef
    }
    this.util.show();
    this.api.post_private('v1/payments/refundPayStack', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundFlutterwave() {
    console.log('refund flutterwave');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    let id;
    if (ref && ref.orderId) {
      id = ref.orderId;
    } else if (ref && ref.transaction_id) {
      id = ref.transaction_id;
    }
    console.log('transactional id', id);
    const param = {
      ref: id,
      amount: this.grand_total
    }
    console.log('param', param);
    this.util.show();
    this.api.post_private('v1/payments/refundFlutterwave', param).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.refundOrder();
      } else {
        this.util.hide();
        this.util.apiErrorHandler(data);
      }
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

  refundPaykun() {
    console.log('refund paykun');
  }

  refundStripe() {
    console.log('refund stripe');
    console.log(this.paymentRef);
    const ref = JSON.parse(this.paymentRef);
    console.log('ref=>', ref);
    if (ref && ref.id) {
      const param = {
        charge_id: ref.id,
      };
      this.util.show();
      this.api.post_private('v1/payments/refundStripePayments', param).then((data: any) => {
        console.log(data);
        if (data && data.status && data.status == 200) {
          this.refundOrder();
        } else {
          this.util.hide();
          this.util.apiErrorHandler(data);
        }
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
  }

  refundOrder() {
    this.util.show();
    const param = {
      id: this.id,
      status: 6,
    };
    this.api.post_private('v1/product_order/update', param).then((data: any) => {
      console.log('order', data);
      this.util.hide();
      if (data && data.status == 200) {
        this.sendNotification();
        this.back();
      } else {
        this.util.apiErrorHandler(data);
      }
    }, error => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }


  back() {
    this.navCtrl.back();
  }

  sendNotification() {
    if (this.userFCM && this.userFCM != '' && this.userFCM != null) {
      const param = {
        title: this.util.translate('Order refunded'),
        message: this.util.translate('Your order is rejected by store your refund amount will be credited within 2-3 bussiness days'),
        id: this.userFCM
      };
      this.api.post_private('v1/notification/sendNotification', param).then((data: any) => {
        console.log(data);
      }, error => {
        console.log(error);
      }).catch(error => {
        console.log(error);
      });
    }
  }
}
