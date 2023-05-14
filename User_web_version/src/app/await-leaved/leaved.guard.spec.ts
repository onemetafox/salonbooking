/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { TestBed, async, inject } from '@angular/core/testing';

import { AwaitLeaveGuard } from './leaved.guard';

describe('AwaitLeaveGuard', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [AwaitLeaveGuard]
    });
  });

  it('should ...', inject([AwaitLeaveGuard], (guard: AwaitLeaveGuard) => {
    expect(guard).toBeTruthy();
  }));
});
