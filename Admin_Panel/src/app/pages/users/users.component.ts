/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { NavigationExtras } from '@angular/router';
import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  dummy = Array(10);
  dummyUsers: any[] = [];
  users: any[] = [];
  page: number = 1;

  constructor(
    private router: Router,
    public api: ApiService,
    public util: UtilService) {

  }

  ngOnInit(): void {
    this.getAllUsers();
  }

  getAllUsers() {
    this.api.get_private('v1/users/getAllUsers').then((data: any) => {
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.success) {
        console.log(">>>>>", data);
        if (data && data.data.length > 0) {
          this.users = data.data;
          this.dummyUsers = data.data;
          console.log("======", this.users);
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

  search(str: any) {
    this.resetChanges();
    console.log('string', str);
    this.users = this.filterItems(str);
  }


  protected resetChanges = () => {
    this.users = this.dummyUsers;
  }

  filterItems(searchTerm: any) {
    return this.users.filter((item) => {
      var name = item.first_name + " " + item.last_name;
      return name.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1;
    });
  }

  setFilteredItems() {
    console.log('clear');
    this.users = [];
    this.users = this.dummyUsers;
  }

  getClass(item: any) {
    if (item == '1' || item == 1) {
      return 'badge badge-success';
    } else if (item == '0' || item == 0) {
      return 'badge badge-danger';
    }
    return 'badge badge-warning';
  }

  viewsInfo(item: any) {
    console.log(item);
    const param: NavigationExtras = {
      queryParams: {
        id: item
      }
    };
    this.router.navigate(['users-details'], param);
  }

  deleteItem(item: any) {
    console.log(item);
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To Delete this user!'),
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
        this.util.show();
        this.api.post_private('v1/users/deleteUser', item).then((datas) => {
          this.util.hide();
          this.util.success(this.util.translate('Deleted'));
          this.getAllUsers();
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

  addNew() {

  }


  statusUpdate(item: any) {
    console.log(item);
    const text = item.status == 1 ? 'Deactive' : 'Active';
    Swal.fire({
      title: this.util.translate('Are you sure?'),
      text: this.util.translate('To ') + this.util.translate(text) + this.util.translate(' this user!'),
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
        const query = item.status == 1 ? 0 : 1;
        item.status = query;
        this.util.show();
        this.api.post_private('v1/profile/update', item).then((datas) => {
          this.util.hide();
          this.util.success(this.util.translate('Updated'));
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

  exportCSV() {
    let data: any = [];
    this.users.forEach(element => {
      const info = {
        'id': this.util.replaceWithDot(element.id),
        'first_name': this.util.replaceWithDot(element.first_name),
        'last_name': this.util.replaceWithDot(element.last_name),
        'cover': this.util.replaceWithDot(element.cover),
        'country_code': this.util.replaceWithDot(element.country_code),
        'mobile': this.util.replaceWithDot(element.mobile),
        'email': this.util.replaceWithDot(element.email),
      }
      data.push(info);
    });
    const name = 'users';
    this.util.downloadFile(data, name, ['id', 'first_name', 'last_name', 'cover', 'country_code', 'mobile', 'email']);
  }
}
