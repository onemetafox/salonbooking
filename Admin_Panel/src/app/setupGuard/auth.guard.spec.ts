/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { TestBed, async, inject } from '@angular/core/testing';

import { SetupAuthGuard } from './auth.guard';

describe('AuthGuard', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SetupAuthGuard]
    });
  });

  it('should ...', inject([SetupAuthGuard], (guard: SetupAuthGuard) => {
    expect(guard).toBeTruthy();
  }));
});
