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
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-blog',
  templateUrl: './blog.component.html',
  styleUrls: ['./blog.component.scss']
})
export class BlogComponent implements OnInit {
  list: any[] = [];
  apiCalled: boolean = false;
  constructor(
    public api: ApiService,
    public util: UtilService,
    private router: Router
  ) {
    this.api.get('v1/blogs/getPublic').then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status && data.status == 200 && data.data) {
        this.list = data.data;
      }
    }, error => {
      console.log(error);
      this.apiCalled = true;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    }).catch(error => {
      console.log(error);
      this.apiCalled = true;
      this.util.errorMessage(this.util.translate('Something went wrong'));
    });
  }

  ngOnInit(): void {
  }

  goToBlogDetail(item) {
    console.log(item);
    const param: NavigationExtras = {
      queryParams: {
        id: item.id,
        title: item.title.replace(/\s+/g, '-').toLowerCase()
      }
    }
    this.router.navigate(['/blog-detail'], param);
  }

  getContent(item) {
    return (item.short_content.length > 50) ? item.short_content.slice(0, 50) + '...' : item.short_content;
  }


  getDate(item) {
    return moment(item).format('DD');
  }

  getMonth(item) {
    return moment(item).format('MMM');
  }
}
