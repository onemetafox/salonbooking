/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { INavData } from '@coreui/angular';

export const navItems: INavData[] = [
  {
    name: 'Dashboard',
    url: '/dashboard',
    iconComponent: { name: 'cil-speedometer' }
  },
  {
    name: 'Categories',
    url: '/categories',
    iconComponent: { name: 'cil-grid' }
  },
  {
    name: 'Cities',
    url: '/cities',
    iconComponent: { name: 'cil-location-pin' }
  },
  {
    name: 'Banners',
    url: '/banners',
    iconComponent: { name: 'cil-spreadsheet' }
  },
  {
    name: 'Salons',
    url: '/salons',
    iconComponent: { name: 'cil-bank' },
    children: [
      {
        name: 'Salons',
        url: '/salons',
        iconComponent: { name: 'cil-bank' }
      },
      {
        name: 'Appointments',
        url: '/appointments',
        iconComponent: { name: 'cil-calendar' },
      },
      {
        name: 'Joining Request',
        url: '/salon-request',
        iconComponent: { name: 'cil-face' }
      },
      {
        name: 'Salon Stats',
        url: '/salon-stats',
        iconComponent: { name: 'cil-chart-line' }
      }
    ]
  },
  {
    name: 'Freelancer',
    url: '/freelancer',
    iconComponent: { name: 'cil-walk' },
    children: [
      {
        name: 'Freelancers',
        url: '/freelancer',
        iconComponent: { name: 'cil-walk' },
      },
      {
        name: 'Appointments',
        url: '/freelancer-appointments',
        iconComponent: { name: 'cil-calendar' },
      },
      {
        name: 'Joining Request',
        url: '/freelancer-request',
        iconComponent: { name: 'cil-face' }
      },
      {
        name: 'Freelancer Stats',
        url: '/freelancer-stats',
        iconComponent: { name: 'cil-chart-line' }
      }
    ]
  },
  {
    name: 'Shop',
    url: '/product-category',
    iconComponent: { name: 'cil-puzzle' },
    children: [
      {
        name: 'Categories',
        url: '/product-category',
        iconComponent: { name: 'cil-notes' }
      },
      {
        name: 'Sub Categories',
        url: '/product-sub-category',
        iconComponent: { name: 'cil-clear-all' }
      },
      {
        name: 'Products',
        url: '/products',
        iconComponent: { name: 'cil-paint' }
      },
      {
        name: 'Orders',
        url: '/orders',
        iconComponent: { name: 'cil-cart' },
      },
      {
        name: 'Orders Stats',
        url: '/product-stats',
        iconComponent: { name: 'cil-chart-line' }
      }
    ]
  },
  {
    name: 'Users',
    url: '/users',
    iconComponent: { name: 'cil-user' }
  },
  {
    name: 'Offers',
    url: '/offers',
    iconComponent: { name: 'cil-link' }
  },
  {
    name: 'App Pages',
    url: '/app-pages',
    iconComponent: { name: 'cil-description' }
  },
  {
    name: 'Blogs',
    url: '/blogs',
    iconComponent: { name: 'cil-inbox' }
  },
  {
    name: 'Referral',
    url: '/referral',
    iconComponent: { name: 'cil-tags' }
  },
  {
    name: 'Supports',
    url: '/supports',
    iconComponent: { name: 'cil-info' }
  },
  {
    name: 'Complaints',
    url: '/complaints',
    iconComponent: { name: 'cil-volume-high' }
  },
  {
    name: 'Payments',
    url: '/payments',
    iconComponent: { name: 'cil-credit-card' }
  },
  {
    name: 'Address',
    url: '/address',
    iconComponent: { name: 'cil-location-pin' }
  },
  {
    name: 'Contact Forms',
    url: '/contact-forms',
    iconComponent: { name: 'cil-address-book' }
  },
  {
    name: 'Administrator',
    url: '/administrator',
    iconComponent: { name: 'cil-line-weight' }
  },
  {
    name: 'Notifications',
    url: '/notifications',
    iconComponent: { name: 'cil-bell-exclamation' }
  },
  {
    name: 'Send Mail',
    url: '/send-mail',
    iconComponent: { name: 'cil-address-book' }
  },
  {
    name: 'Settings',
    url: '/settings',
    iconComponent: { name: 'cil-settings' }
  },
];
