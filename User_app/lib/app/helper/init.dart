/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:salon_user/app/backend/api/api.dart';
import 'package:salon_user/app/backend/parse/account_chat_parse.dart';
import 'package:salon_user/app/backend/parse/account_parse.dart';
import 'package:salon_user/app/backend/parse/add_card_parse.dart';
import 'package:salon_user/app/backend/parse/add_review_parse.dart';
import 'package:salon_user/app/backend/parse/address_list_parse.dart';
import 'package:salon_user/app/backend/parse/address_parse.dart';
import 'package:salon_user/app/backend/parse/all_categories_parse.dart';
import 'package:salon_user/app/backend/parse/app_pages_parse.dart';
import 'package:salon_user/app/backend/parse/appointment_detail_parse.dart';
import 'package:salon_user/app/backend/parse/booking_parse.dart';
import 'package:salon_user/app/backend/parse/cart_parse.dart';
import 'package:salon_user/app/backend/parse/categories_list_parse.dart';
import 'package:salon_user/app/backend/parse/categories_parse.dart';
import 'package:salon_user/app/backend/parse/chat_parse.dart';
import 'package:salon_user/app/backend/parse/checkout_parse.dart';
import 'package:salon_user/app/backend/parse/choose_location_parse.dart';
import 'package:salon_user/app/backend/parse/complaints_parse.dart';
import 'package:salon_user/app/backend/parse/contact_us_parse.dart';
import 'package:salon_user/app/backend/parse/coupon_parse.dart';
import 'package:salon_user/app/backend/parse/edit_profile_parse.dart';
import 'package:salon_user/app/backend/parse/favorite_parse.dart';
import 'package:salon_user/app/backend/parse/filter_parse.dart';
import 'package:salon_user/app/backend/parse/find_location_parse.dart';
import 'package:salon_user/app/backend/parse/firebase_parse.dart';
import 'package:salon_user/app/backend/parse/home_parse.dart';
import 'package:salon_user/app/backend/parse/individual_categories_parse.dart';
import 'package:salon_user/app/backend/parse/individual_checkout_parse.dart';
import 'package:salon_user/app/backend/parse/individual_list_parse.dart';
import 'package:salon_user/app/backend/parse/individual_packages_parse.dart';
import 'package:salon_user/app/backend/parse/individual_payment_parse.dart';
import 'package:salon_user/app/backend/parse/individual_slot_parse.dart';
import 'package:salon_user/app/backend/parse/intro_parse.dart';
import 'package:salon_user/app/backend/parse/languages_parse.dart';
import 'package:salon_user/app/backend/parse/login_parse.dart';
import 'package:salon_user/app/backend/parse/near_parse.dart';
import 'package:salon_user/app/backend/parse/new_address_parse.dart';
import 'package:salon_user/app/backend/parse/packages_details_parse.dart';
import 'package:salon_user/app/backend/parse/payment_parse.dart';
import 'package:salon_user/app/backend/parse/product_cart_parse.dart';
import 'package:salon_user/app/backend/parse/product_order_detail_parse.dart';
import 'package:salon_user/app/backend/parse/product_order_parse.dart';
import 'package:salon_user/app/backend/parse/product_payment_parse.dart';
import 'package:salon_user/app/backend/parse/products_details_parse.dart';
import 'package:salon_user/app/backend/parse/products_parse.dart';
import 'package:salon_user/app/backend/parse/refer_and_earn_parse.dart';
import 'package:salon_user/app/backend/parse/register_parse.dart';
import 'package:salon_user/app/backend/parse/reset_password_parse.dart';
import 'package:salon_user/app/backend/parse/search_parse.dart';
import 'package:salon_user/app/backend/parse/selected_services_parse.dart';
import 'package:salon_user/app/backend/parse/service_cart_parse.dart';
import 'package:salon_user/app/backend/parse/services_parse.dart';
import 'package:salon_user/app/backend/parse/sidemenu_parse.dart';
import 'package:salon_user/app/backend/parse/slot_parse.dart';
import 'package:salon_user/app/backend/parse/sortby_parse.dart';
import 'package:salon_user/app/backend/parse/specialist_parse.dart';
import 'package:salon_user/app/backend/parse/splash_parse.dart';
import 'package:salon_user/app/backend/parse/stripe_pay_parse.dart';
import 'package:salon_user/app/backend/parse/stripe_pay_product_parse.dart';
import 'package:salon_user/app/backend/parse/tabs_parse.dart';
import 'package:salon_user/app/backend/parse/top_offers_parse.dart';
import 'package:salon_user/app/backend/parse/top_packages_parse.dart';
import 'package:salon_user/app/backend/parse/top_products_parse.dart';
import 'package:salon_user/app/backend/parse/top_specialist_parse.dart';
import 'package:salon_user/app/backend/parse/wallet_parse.dart';
import 'package:salon_user/app/backend/parse/web_payment_parse.dart';
import 'package:salon_user/app/backend/parse/web_product_payment_parse.dart';
import 'package:salon_user/app/backend/parse/welcome_parse.dart';
import 'package:salon_user/app/controller/account_controller.dart';
import 'package:salon_user/app/controller/address_controller.dart';
import 'package:salon_user/app/controller/address_list_controller.dart';
import 'package:salon_user/app/controller/booking_controller.dart';
import 'package:salon_user/app/controller/categories_controller.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/near_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/controller/product_payment_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/controller/tabs_controller.dart';
import 'package:salon_user/app/controller/top_products_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/helper/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    // Parser LazyLoad
    Get.lazyPut(
        () => IntroParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SplashParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WelcomeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LoginParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => RegisterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ResetPasswordParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TabsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HomeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CategoriesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => NearParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => BookingParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AccountParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FilterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SearchParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChatParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServicesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SpecialistParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppointmentDetailParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddressParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WalletParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ReferAndEarnParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LanguagesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AccountChatParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ContactUsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => NewAddressParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppPagesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductsDetailsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SortByParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CartParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CheckoutParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AllCategoriesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TopSpecialistParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TopOffersParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TopPackagesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SideMenuParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChooseLocationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FindLocationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CategoriesListParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SelectedServicesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => PackagesDetailsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServiceCartParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductCartParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FavoritesParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CouponParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SlotParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => PaymentParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddCardParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => StripePayParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => StripePayProductParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WebPaymentParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WebProductPaymentParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IndividualCategoriesParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IndividualPackagesParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IndividualCheckoutParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IndividualListParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IndividualSlotParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => IndividualPaymentParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductPaymentParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddressListParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductOrderParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductOrderDetailParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FirebaseParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => EditProfileParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TopProductsParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddReviewParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ComplaintsParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(() => TabsController(parser: Get.find()));
    Get.lazyPut(() => HomeController(parser: Get.find()));
    Get.lazyPut(() => NearController(parser: Get.find()));
    Get.lazyPut(() => CategoriesController(parser: Get.find()));
    Get.lazyPut(() => BookingController(parser: Get.find()));
    Get.lazyPut(() => AccountController(parser: Get.find()));
    Get.lazyPut(() => AddressListController(parser: Get.find()));
    Get.lazyPut(() => AddressController(parser: Get.find()));
    Get.lazyPut(() => TopProductsControllrer(parser: Get.find()));

    Get.lazyPut(() => ServiceCartController(parser: Get.find()));
    Get.lazyPut(() => ProductCartController(parser: Get.find()));
    Get.lazyPut(() => ProductPaymentController(parser: Get.find()));
  }
}
