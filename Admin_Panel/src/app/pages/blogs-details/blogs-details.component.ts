/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from '../../services/api.service';
import { Location } from '@angular/common';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-blogs-details',
  templateUrl: './blogs-details.component.html',
  styleUrls: ['./blogs-details.component.scss']
})
export class BlogsDetailsComponent implements OnInit {
  title: any = '';
  cover: any = '';
  cotent: any = '';
  shortContent: any = '';
  edit: boolean;
  id: any;
  constructor(
    public api: ApiService,
    private route: ActivatedRoute,
    private navCtrl: Location,
    public util: UtilService
  ) {

    this.route.queryParams.subscribe((data: any) => {
      if (data && data.id) {
        this.edit = true;
        this.id = data.id;
        this.getById();
      } else {
        this.edit = false;
      }
    });

  }

  ngOnInit(): void {
  }

  getById() {
    const param = {
      id: this.id
    };

    this.util.show();
    this.api.post_private('v1/blogs/getById', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status == 200 && data.data) {
        const info = data.data;
        console.log(info);
        this.title = info.title;
        this.cotent = info.content;
        this.shortContent = info.short_content;
        this.cover = info.cover;
      } else {
        this.navCtrl.back();
        this.util.error(this.util.translate('Something went wrong'));
      }
    }).catch((error) => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }



  preview_banner(files: any) {

    console.log('fle', files);
    if (files.length == 0) {
      return;
    }
    const mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }

    if (files) {
      console.log('ok');
      this.util.show();
      this.api.uploadFile(files).subscribe((data: any) => {
        console.log('==>>>>>>', data.data);
        this.util.hide();
        if (data && data.data.image_name) {
          this.cover = data.data.image_name;
        }
      }, err => {
        console.log(err);
        this.util.hide();
      });
    } else {
      console.log('no');
    }
  }

  onChange(event: any) {
  }

  onEditorChange(event: any) {
  }

  submit() {
    console.log('its', this.edit);
    if (!this.title || this.title == '' || !this.cotent || this.cotent == '' || this.shortContent == '') {
      this.util.error(this.util.translate('All Fields are required'));
      return false;
    }
    if (!this.cover || this.cover == '') {
      this.util.error(this.util.translate('Please add image'));
      return false;
    }
    if (this.edit) {
      this.updateContent();
    } else {
      this.createContent();
    }

  }

  createContent() {
    const param = {
      title: this.title,
      short_content: this.shortContent,
      content: this.cotent,
      cover: this.cover,
      status: 1
    }
    console.log(param);
    this.util.show();
    this.api.post_private('v1/blogs/create', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.util.success(this.util.translate('Added'));
        this.navCtrl.back();
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }

    }, error => {
      this.util.hide();
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log(error);
      this.util.apiErrorHandler(error);
    });
  }

  updateContent() {
    const param = {
      id: this.id,
      title: this.title,
      short_content: this.shortContent,
      content: this.cotent,
      cover: this.cover,
    }
    console.log(param);
    this.util.show();
    this.api.post_private('v1/blogs/update', param).then((data: any) => {
      this.util.hide();
      console.log(data);
      if (data && data.status && data.status == 200) {
        this.util.success(this.util.translate('Updated'));
        this.navCtrl.back();
      } else {
        this.util.error(this.util.translate('Something went wrong'));
      }

    }, error => {
      this.util.hide();
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.util.hide();
      console.log(error);
      this.util.apiErrorHandler(error);
    });
  }
}
