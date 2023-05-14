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
import { AwaitLeaveGuard } from './await-leaved/leaved.guard';
import { AuthGuard } from './guard/auth.guard';
import { ErrorComponent } from './layouts/error/error.component';
import { UserComponent } from './layouts/user/user.component';
import { LeaveGuard } from './leaved/leaved.guard';
import { LocationGuard } from './locationGuard/location.guard';

const routes: Routes = [
  {
    path: '',
    component: UserComponent,
    children: [
      {
        path: '',
        redirectTo: 'home',
        pathMatch: 'full'
      },
      {
        path: 'welcome',
        loadChildren: () => import('./pages/welcome/welcome.module').then(m => m.WelcomeModule),
        data: { title: 'Welcome' }
      },
      {
        path: 'home',
        loadChildren: () => import('./pages/home/home.module').then(m => m.HomeModule),
        data: { title: 'Home' },
        canActivate: [LocationGuard],
        canDeactivate: [LeaveGuard]
      },
      {
        path: 'about',
        loadChildren: () => import('./pages/about/about.module').then(m => m.AboutModule),
        data: { title: 'About' }
      },
      {
        path: 'contact',
        loadChildren: () => import('./pages/contact/contact.module').then(m => m.ContactModule),
        data: { title: 'Contact' }
      },
      {
        path: 'freelancers',
        loadChildren: () => import('./pages/freelancers/freelancers.module').then(m => m.FreelancersModule),
        data: { title: 'Freelancers' },
      },
      {
        path: 'salons/:id/:name',
        loadChildren: () => import('./pages/salons/salons.module').then(m => m.SalonsModule),
        data: { title: 'Salons' }
      },
      {
        path: 'faq',
        loadChildren: () => import('./pages/faq/faq.module').then(m => m.FaqModule),
        data: { title: 'Faqs' }
      },
      {
        path: 'help',
        loadChildren: () => import('./pages/help/help.module').then(m => m.HelpModule),
        data: { title: 'Help' }
      },

      {
        path: 'notice',
        loadChildren: () => import('./pages/notice/notice.module').then(m => m.NoticeModule),
        data: { title: 'Notice' }
      },
      {
        path: 'cookie',
        loadChildren: () => import('./pages/cookie/cookie.module').then(m => m.CookieModule),
        data: { title: 'Cookies' }
      },
      {
        path: 'blog',
        loadChildren: () => import('./pages/blog/blog.module').then(m => m.BlogModule),
        data: { title: 'Blog' }
      },
      {
        path: 'blog-detail',
        loadChildren: () => import('./pages/blog-detail/blog-detail.module').then(m => m.BlogDetailModule),
        data: { title: 'Blog details' }
      },
      {
        path: 'service-listing/:id/:name',
        loadChildren: () => import('./pages/service-listing/service-listing.module').then(m => m.ServiceListingModule),
        data: { title: 'Top Freelancers' }
      },
      {
        path: 'service/:id/:name',
        loadChildren: () => import('./pages/service/service.module').then(m => m.ServiceModule),
        data: { title: 'Freelancer' }
      },
      {
        path: 'product-detail/:id',
        loadChildren: () => import('./pages/product-detail/product-detail.module').then(m => m.ProductDetailModule),
        data: { title: 'Product' }
      },
      {
        path: 'shop',
        loadChildren: () => import('./pages/shop/shop.module').then(m => m.ShopModule),
        data: { title: 'Shop' }
      },
      {
        path: 'checkout',
        loadChildren: () => import('./pages/checkout/checkout.module').then(m => m.CheckoutModule),
        data: { title: 'Checkout' }
      },
      {
        path: 'freelancer-checkout',
        loadChildren: () => import('./pages/freelancer-checkout/freelancer-checkout.module').then(m => m.FreelancerCheckoutModule),
        data: { title: 'Freelancer Checkout' }
      },
      {
        path: 'product-checkout',
        loadChildren: () => import('./pages/product-checkout/product-checkout.module').then(m => m.ProductCheckoutModule),
        data: { title: 'Checkout' }
      },
      {
        path: 'await-payments',
        loadChildren: () => import('./pages/await-payments/await-payments.module').then(m => m.AwaitPaymentsModule),
        data: { title: 'Await Payments' },
        canDeactivate: [LeaveGuard]
      },
      {
        path: 'await-payments-product',
        loadChildren: () => import('./pages/await-payments-product/await-payments-product.module').then(m => m.AwaitPaymentsProductModule),
        data: { title: 'Await Payments' },
        canDeactivate: [LeaveGuard]
      },
      {
        path: 'user/:id/:from',
        loadChildren: () => import('./pages/settings/settings.module').then(m => m.SettingsModule),
        data: { title: 'User Informations' }
      },
      {
        path: 'appointment-details/:id',
        loadChildren: () => import('./pages/appointment-details/appointment-details.module').then(m => m.AppointmentDetailsModule),
        data: { title: 'Appointments Details' }
      },
      {
        path: 'order-details/:id',
        loadChildren: () => import('./pages/orders-details/orders-details.module').then(m => m.OrdersDetailsModule),
        data: { title: 'Order Details' }
      },
      {
        path: 'top-freelancers',
        loadChildren: () => import('./pages/top-freelancers/top-freelancers.module').then(m => m.TopFreelancersModule),
        data: { title: 'Top Freelancers' }
      },
      {
        path: 'top-products',
        loadChildren: () => import('./pages/top-products/top-products.module').then(m => m.TopProductsModule),
        data: { title: 'Top Products' }
      }
    ]
  },
  {
    path: '**',
    component: ErrorComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
