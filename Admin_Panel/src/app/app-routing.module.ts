import { AuthGuard } from './guard/auth.guard';
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DefaultLayoutComponent } from './containers';
import { Page404Component } from './pages/auth/page404/page404.component';
import { Page500Component } from './pages/auth/page500/page500.component';
import { LoginComponent } from './pages/auth/login/login.component';
import { RegisterComponent } from './pages/auth/register/register.component';
import { LeaveGuard } from './leaved/leaved.guard';
import { SetupAuthGuard } from './setupGuard/auth.guard';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'dashboard',
    pathMatch: 'full'
  },
  {
    path: '',
    component: DefaultLayoutComponent,
    data: {
      title: 'Home'
    },
    children: [
      {
        path: 'pages',
        loadChildren: () =>
          import('./pages/auth/pages.module').then((m) => m.PagesModule)
      },
      {
        path: 'dashboard',
        loadChildren: () => import('./pages/dashboard/dashboard.module').then(m => m.DashboardModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'cities',
        loadChildren: () => import('./pages/cities/cities.module').then(m => m.CitiesModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'categories',
        loadChildren: () => import('./pages/categories/categories.module').then(m => m.CategoriesModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'freelancer',
        loadChildren: () => import('./pages/freelancer/freelancer.module').then(m => m.FreelancerModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'product-category',
        loadChildren: () => import('./pages/product-category/product-category.module').then(m => m.ProductCategoryModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'product-sub-category',
        loadChildren: () => import('./pages/product-sub-category/product-sub-category.module').then(m => m.ProductSubCategoryModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'offers',
        loadChildren: () => import('./pages/offers/offers.module').then(m => m.OffersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'app-pages',
        loadChildren: () => import('./pages/app-pages/app-pages.module').then(m => m.AppPagesModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'referral',
        loadChildren: () => import('./pages/referral/referral.module').then(m => m.ReferralModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'products',
        loadChildren: () => import('./pages/products/products.module').then(m => m.ProductsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'payments',
        loadChildren: () => import('./pages/payments/payments.module').then(m => m.PaymentsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'address',
        loadChildren: () => import('./pages/address/address.module').then(m => m.AddressModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'freelancer-request',
        loadChildren: () => import('./pages/freelancer-request/freelancer-request.module').then(m => m.FreelancerRequestModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'banners',
        loadChildren: () => import('./pages/banners/banners.module').then(m => m.BannersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'settings',
        loadChildren: () => import('./pages/settings/settings.module').then(m => m.SettingsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'contact-forms',
        loadChildren: () => import('./pages/contact-forms/contact-forms.module').then(m => m.ContactFormsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'administrator',
        loadChildren: () => import('./pages/administrator/administrator.module').then(m => m.AdministratorModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'notifications',
        loadChildren: () => import('./pages/notifications/notifications.module').then(m => m.NotificationsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'send-mail',
        loadChildren: () => import('./pages/send-mail/send-mail.module').then(m => m.SendMailModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'freelancer-stats',
        loadChildren: () => import('./pages/freelancer-stats/freelancer-stats.module').then(m => m.FreelancerStatsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'product-stats',
        loadChildren: () => import('./pages/products-stats/products-stats.module').then(m => m.ProductsStatsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'blogs',
        loadChildren: () => import('./pages/blogs/blogs.module').then(m => m.BlogsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'blogs-details',
        loadChildren: () => import('./pages/blogs-details/blogs-details.module').then(m => m.BlogsDetailsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'complaints',
        loadChildren: () => import('./pages/complaints/complaints.module').then(m => m.ComplaintsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'supports',
        loadChildren: () => import('./pages/supports/supports.module').then(m => m.SupportsModule),
        canActivate: [AuthGuard],
        canDeactivate: [LeaveGuard]
      },
      {
        path: 'appointments',
        loadChildren: () => import('./pages/appointments/appointments.module').then(m => m.AppointmentsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'orders',
        loadChildren: () => import('./pages/orders/orders.module').then(m => m.OrdersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'appointments-details',
        loadChildren: () => import('./pages/appointments-details/appointments-details.module').then(m => m.AppointmentsDetailsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'orders-details',
        loadChildren: () => import('./pages/orders-details/orders-details.module').then(m => m.OrdersDetailsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'users',
        loadChildren: () => import('./pages/users/users.module').then(m => m.UsersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'users-details',
        loadChildren: () => import('./pages/users-details/users-details.module').then(m => m.UsersDetailsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'salons',
        loadChildren: () => import('./pages/salons/salons.module').then(m => m.SalonsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'freelancer-appointments',
        loadChildren: () => import('./pages/freelancer-appointments/freelancer-appointments.module').then(m => m.FreelancerAppointmentsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'salon-stats',
        loadChildren: () => import('./pages/salon-stats/salon-stats.module').then(m => m.SalonStatsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'salon-request',
        loadChildren: () => import('./pages/salon-request/salon-request.module').then(m => m.SalonRequestModule),
        canActivate: [AuthGuard]
      }
    ]
  },
  {
    path: '404',
    component: Page404Component,
    data: {
      title: 'Page 404'
    }
  },
  {
    path: '500',
    component: Page500Component,
    data: {
      title: 'Page 500'
    }
  },
  {
    path: 'login',
    component: LoginComponent,
    data: {
      title: 'Login Page'
    },
    canActivate: [SetupAuthGuard]
  },
  {
    path: 'register',
    component: RegisterComponent,
    data: {
      title: 'Register Page'
    },
  },
  {
    path: 'forgot',
    loadChildren: () => import('./pages/forgot/forgot.module').then(m => m.ForgotModule),
  },
  { path: '**', redirectTo: 'dashboard' }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      scrollPositionRestoration: 'top',
      anchorScrolling: 'enabled',
      initialNavigation: 'enabledBlocking',
      relativeLinkResolution: 'legacy',
      useHash: false
    })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
