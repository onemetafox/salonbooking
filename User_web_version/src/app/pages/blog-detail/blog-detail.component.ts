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
import { ActivatedRoute, Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-blog-detail',
  templateUrl: './blog-detail.component.html',
  styleUrls: ['./blog-detail.component.scss']
})
export class BlogDetailComponent implements OnInit {

  title: any;
  cover: any;
  cotent: any;
  id: any;
  loaded: boolean;
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private navCtrl: Location,
    public api: ApiService,
    private util: UtilService
  ) {
    this.route.queryParams.subscribe((data: any) => {
      if (data && data.id) {
        this.id = data.id;
        this.loaded = false;
        this.getById();
      }
    });
  }

  getById() {
    const param = {
      id: this.id
    };

    this.api.post('v1/blogs/getDetails', param).then((data: any) => {
      console.log(data);
      this.loaded = true;
      if (data && data.status == 200) {
        const info = data.data;
        console.log(info);
        this.title = info.title;
        this.cotent = info.content;
        this.cover = info.cover;
      } else {
        this.navCtrl.back();
        this.util.errorMessage(this.util.translate('Something went wrong'));
      }
    }).catch((error) => {
      this.loaded = true;
      console.log(error);
      this.navCtrl.back();
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  ngOnInit(): void { }

}
