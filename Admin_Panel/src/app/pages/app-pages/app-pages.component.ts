/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ApiService } from './../../services/api.service';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { Component, OnInit, ViewChild } from '@angular/core';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-app-pages',
  templateUrl: './app-pages.component.html',
  styleUrls: ['./app-pages.component.scss']
})
export class AppPagesComponent implements OnInit {
  @ViewChild('myModal') public myModal: ModalDirective;
  dummy: any[] = [];
  list: any[] = [];
  page: number = 1;

  id: any = '1';
  content: any = '';
  name: any = '';
  ckeConfig: any;
  constructor(
    public api: ApiService,
    public util: UtilService
  ) {
    this.ckeConfig = {
      height: 300,
      language: "en",
      allowedContent: true,
      toolbar: [
        { name: "editing", items: ["Scayt", "Find", "Replace", "SelectAll"] },
        { name: "clipboard", items: ["Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"] },
        { name: "links", items: ["Link", "Unlink", "Anchor"] },
        { name: "tools", items: ["Maximize", "ShowBlocks", "Preview", "Print", "Templates"] },
        { name: "document", items: ["Source"] },
        { name: "insert", items: ["Image", "Table", "HorizontalRule", "SpecialChar", "Iframe", "imageExplorer"] },
        { name: "basicstyles", items: ["Bold", "Italic", "Underline", "Strike", "Subscript", "Superscript", "-", "RemoveFormat"] },
        { name: "paragraph", items: ["NumberedList", "BulletedList", "-", "Outdent", "Indent", "CreateDiv", "-", "Blockquote"] },
        { name: "justify", items: ["JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"] },
        { name: "styles", items: ["Styles", "Format", "FontSize", "-", "TextColor", "BGColor"] }
      ]
    };
    this.getPages();
  }

  ngOnInit(): void {
  }

  getPages() {
    this.list = [];
    this.dummy = Array(10);
    this.api.get_private('v1/pages/getAll').then((data: any) => {
      console.log(data);
      this.dummy = [];
      if (data && data.status && data.status == 200 && data.data && data.data.length) {
        this.list = data.data;
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

  openItem(item: any) {
    console.log(item);
    this.id = item.id;
    this.name = item.name;
    this.content = item.content;
    this.myModal.show();
  }

  saveChange() {
    if (!this.name || this.name == '' || !this.content || this.content == '') {
      this.util.error(this.util.translate('All fields are required'));
      return false;
    }
    const param = {
      id: this.id,
      name: this.name,
      content: this.content
    };
    this.util.show();
    this.api.post_private('v1/pages/update', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data && data.status && data.status == 200 && data.data) {
        this.util.success(this.util.translate('Updated'));
        this.content = '';
        this.name = '';
        this.id = '';
        this.myModal.hide();
        this.getPages();
      }
    }).catch((error) => {
      console.log(error);
      this.util.hide();
      this.util.apiErrorHandler(error);
    });
  }
}
