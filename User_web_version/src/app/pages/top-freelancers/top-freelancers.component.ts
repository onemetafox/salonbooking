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
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-top-freelancers',
  templateUrl: './top-freelancers.component.html',
  styleUrls: ['./top-freelancers.component.scss']
})
export class TopFreelancersComponent implements OnInit {
  apiCalled: boolean = false;
  freelancerList: any[] = [];
  haveData: boolean = false;
  constructor(
    public util: UtilService,
    public api: ApiService,
    private router: Router
  ) {
    this.getFreelancers();
  }

  getFreelancers() {
    this.apiCalled = false;
    const param = { uid: localStorage.getItem('top-freelancers'), "lat": localStorage.getItem('lat'), "lng": localStorage.getItem('lng') };
    this.api.post('v1/topFreelancers', param).then((data: any) => {
      this.apiCalled = true;
      console.log(data);
      if (data && data.status == 200 && data.havedata == true) {
        this.haveData = true;
        this.freelancerList = data.data;
      } else {
        this.haveData = false;
      }
    }, error => {
      console.log(error);
      this.freelancerList = [];
      this.haveData = false;
      this.router.navigate(['']);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.freelancerList = [];
      this.haveData = false;
      this.router.navigate(['']);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  getAddressName() {
    const location = localStorage.getItem('address');
    if (location && location != null && location !== 'null') {
      return location.length > 30 ? location.slice(0, 30) + '....' : location;;
    }
    localStorage.clear();
    return 'No address';
  }

  onFreelancerDetail(freelancerId: any, name: any) {
    const routeName = name.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase();;
    this.router.navigate(['service', freelancerId, routeName]);
  }
}
