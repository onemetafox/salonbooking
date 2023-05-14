/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { UtilService } from '../../services/util.service';

@Component({
  selector: 'app-send-mail',
  templateUrl: './send-mail.component.html',
  styleUrls: ['./send-mail.component.scss']
})
export class SendMailComponent implements OnInit {
  subject: any = '';
  message: any = '';

  ckeConfig: any;
  sendTo: any = 1;
  constructor(
    public util: UtilService,
    public api: ApiService
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
  }

  ngOnInit(): void {
  }

  sendToAll() {
    const param = {
      subjects: this.subject,
      content: this.message
    };
    this.util.show();
    this.api.post_private('v1/users/sendMailToAll', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data) {
        this.util.success(this.util.translate('Email sent'));
        this.subject = '';
        this.message = '';
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

  sendToStores() {
    const param = {
      subjects: this.subject,
      content: this.message
    };
    this.util.show();
    this.api.post_private('v1/users/sendMailToStores', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data) {
        this.util.success(this.util.translate('Email sent'));
        this.subject = '';
        this.message = '';
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

  sendToDrivers() {
    const param = {
      subjects: this.subject,
      content: this.message
    };
    this.util.show();
    this.api.post_private('v1/users/sendMailToSalon', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data) {
        this.util.success(this.util.translate('Email sent'));
        this.subject = '';
        this.message = '';
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

  save() {
    if (this.subject == '' || this.message == '' || !this.subject || !this.message || this.subject == null || this.message == null) {
      this.util.error(this.util.translate('All fields required'));
      return false;
    }
    if (this.sendTo == 1) {
      this.sendToAll();
      return false;
    }

    if (this.sendTo == 2) {
      this.sendToUsers();
    }

    if (this.sendTo == 3) {
      this.sendToStores();
    }

    if (this.sendTo == 4) {
      this.sendToDrivers();
    }
  }

  sendToUsers() {
    const param = {
      subjects: this.subject,
      content: this.message
    };
    this.util.show();
    this.api.post_private('v1/users/sendMailToUsers', param).then((data: any) => {
      console.log(data);
      this.util.hide();
      if (data) {
        this.util.success(this.util.translate('Email sent'));
        this.subject = '';
        this.message = '';
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
