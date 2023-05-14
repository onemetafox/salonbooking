/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';
declare var google: any;


@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.scss']
})
export class WelcomeComponent implements OnInit {
  autocomplete1: { 'query': string };
  autocompleteItems1: any = [];
  GoogleAutocomplete;
  geocoder: any;

  blogs: any;
  constructor(
    private router: Router,
    public util: UtilService,
    public api: ApiService
  ) {
    this.GoogleAutocomplete = new google.maps.places.AutocompleteService();
    this.geocoder = new google.maps.Geocoder();
    this.autocomplete1 = { query: '' };
    this.autocompleteItems1 = [];
    this.getBlogs();
  }

  ngOnInit(): void {
  }

  goToRest() {
    this.util.publishModalPopup('location');
  }

  getBlogs() {
    this.api.get('v1/blogs/getTop').then((data: any) => {
      console.log(data);
      if (data && data.status == 200) {
        this.blogs = data.data;
      }
    }, error => {
      console.log(error);
      this.util.errorMessage(this.util.translate('something went wrong'));
    }).catch((error: any) => {
      console.log(error);
      this.util.errorMessage(this.util.translate('something went wrong'));
    });
  }

  goToBlogs(item) {
    console.log(item);
    const param: NavigationExtras = {
      queryParams: {
        id: item.id,
        title: item.title.replace(/\s+/g, '-').toLowerCase()
      }
    }
    this.router.navigate(['/blog-detail'], param);
  }
  locate() {
    if (window.navigator && window.navigator.geolocation) {
      this.util.start();
      window.navigator.geolocation.getCurrentPosition(
        position => {

          console.log(position);
          this.getAddress(position.coords.latitude, position.coords.longitude);
        },
        error => {
          this.util.stop();
          switch (error.code) {
            case 1:
              console.log('Permission Denied');
              this.util.errorMessage(this.util.translate('Location Permission Denied'));
              break;
            case 2:
              console.log('Position Unavailable');
              this.util.errorMessage(this.util.translate('Position Unavailable'));
              break;
            case 3:
              console.log('Timeout');
              this.util.errorMessage(this.util.translate('Failed to fetch location'));
              break;
            default:
              console.log('defual');
          }
        }
      );
    };
  }

  onSearchChange(event) {
    console.log(event);
    if (this.autocomplete1.query == '') {
      this.autocompleteItems1 = [];
      return;
    }
    const addsSelected = localStorage.getItem('addsSelected');
    if (addsSelected && addsSelected != null) {
      localStorage.removeItem('addsSelected');
      return;
    }

    this.GoogleAutocomplete.getPlacePredictions({ input: this.autocomplete1.query }, (predictions, status) => {
      console.log(predictions);
      if (predictions && predictions.length > 0) {
        this.autocompleteItems1 = predictions;
        console.log(this.autocompleteItems1);
      }
    });
  }

  selectSearchResult1(item) {
    console.log('select', item);
    localStorage.setItem('addsSelected', 'true');
    this.autocompleteItems1 = [];
    this.autocomplete1.query = item.description;
    this.geocoder.geocode({ placeId: item.place_id }, (results, status) => {
      if (status == 'OK' && results[0]) {
        console.log(status);
        localStorage.setItem('location', 'true');
        localStorage.setItem('lat', results[0].geometry.location.lat());
        localStorage.setItem('lng', results[0].geometry.location.lng());
        localStorage.setItem('address', this.autocomplete1.query);
        this.router.navigate(['/home']);
      }
    });
  }

  getAddress(lat, lng) {
    this.util.stop();
    const geocoder = new google.maps.Geocoder();
    const location = new google.maps.LatLng(lat, lng);
    geocoder.geocode({ 'location': location }, (results, status) => {
      console.log(results);
      console.log('status', status);
      if (results && results.length) {
        localStorage.setItem('location', 'true');
        localStorage.setItem('lat', lat);
        localStorage.setItem('address', results[0].formatted_address);
        localStorage.setItem('lng', lng);
        this.router.navigate(['home']);
      }
    }, error => {
      console.log('error in geocoder');
    });
  }

  getContent(item) {
    return (item.short_content.length > 50) ? item.short_content.slice(0, 50) + '...' : item.short_content;
  }


  getDate(item) {
    return moment(item).format('DD');
  }

  getMonth(item) {
    return moment(item).format('MMM');
  }

}
