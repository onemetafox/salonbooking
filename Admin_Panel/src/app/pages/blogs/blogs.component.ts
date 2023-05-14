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
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-blogs',
  templateUrl: './blogs.component.html',
  styleUrls: ['./blogs.component.scss']
})
export class BlogsComponent implements OnInit {
  dummy = Array(5);
  blogs: any[] = [];
  page = 1;

  constructor(
    private router: Router,
    public api: ApiService,
    public util: UtilService
  ) {
    this.getBanners();
  }

  ngOnInit(): void {
  }

  getBanners() {
    this.dummy = Array(5);
    this.blogs = [];
    this.api.get_private('v1/blogs/getAll').then((data: any) => {
      console.log('data', data);
      this.dummy = [];
      this.blogs = [];
      if (data && data.status == 200) {
        this.blogs = data.data;
      }
    }).catch((error: any) => {
      console.log('error=>', error);
    });
  }

  addNew() {
    this.router.navigate(['blogs-details']);
  }

  exportCSV() {

  }

  onChange(event: any) {
  }

  onEditorChange(event: any) {
  }

  getClass(item: any) {
    if (item == 1) {
      return 'btn btn-primary btn-round';
    } else if (item == 0) {
      return 'btn btn-danger btn-round';
    }
    return 'btn btn-warning btn-round';
  }

  changeStatus(item: any) {
    const text = item.status == 1 ? 'deactive' : 'active';
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To ') + text + this.util.translate(' this banner!'),
      icon: 'question',
      showConfirmButton: true,
      confirmButtonText: this.util.translate('Yes'),
      showCancelButton: true,
      cancelButtonText: this.util.translate('Cancle'),
      backdrop: false,
      background: 'white'
    }).then((data) => {
      if (data && data.value) {
        console.log('update it');
        console.log(item);
        const param = {
          id: item.id,
          status: item.status == 1 ? 0 : 1
        };
        this.util.show();
        this.api.post_private('v1/blogs/update', param).then((info) => {
          this.util.hide();
          this.getBanners();
        }, error => {
          console.log(error);
          this.util.hide();
        }).catch(error => {
          this.util.hide();
          console.log(error);
        });
      }
    });
  }
  view(item: any) {
    const param: NavigationExtras = {
      queryParams: {
        id: item
      }
    };
    console.log(param);
    this.router.navigate(['blogs-details'], param);
  }

  deleteItem(item: any) {
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
        console.log(item);
        this.util.show();
        this.api.post_private('v1/blogs/destroy', { id: item.id }).then((data: any) => {
          console.log(data);
          this.util.hide();
          if (data && data.status && data.status == 200) {
            this.getBanners();
          }
        }).catch(error => {
          console.log(error);
          this.util.hide();
          this.util.apiErrorHandler(error);
        });
      }
    });

  }

}
