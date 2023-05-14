
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocsCalloutComponent } from './docs-callout.component';
import { CalloutModule } from '@coreui/angular';

describe('DocsCalloutComponent', () => {
  let component: DocsCalloutComponent;
  let fixture: ComponentFixture<DocsCalloutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [DocsCalloutComponent],
      imports: [CalloutModule]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DocsCalloutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
