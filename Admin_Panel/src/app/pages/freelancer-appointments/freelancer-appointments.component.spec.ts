/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FreelancerAppointmentsComponent } from './freelancer-appointments.component';

describe('FreelancerAppointmentsComponent', () => {
  let component: FreelancerAppointmentsComponent;
  let fixture: ComponentFixture<FreelancerAppointmentsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [FreelancerAppointmentsComponent]
    })
      .compileComponents();

    fixture = TestBed.createComponent(FreelancerAppointmentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
