/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_services_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_slot_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_timing_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/analytics_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/cities_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/firebase_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/individual_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/individual_cities_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/individual_profile_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/packages_specialist_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/product_order_details_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/register_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/salon_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_packages_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_stylist_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/app_pages_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/appointment_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/calendar_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/chat_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/contact_us_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/create_products_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/profile_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/gallary_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/history_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/inbox_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/languages_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/login_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/order_details_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/packages_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/products_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/profile_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/review_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/packages_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/services_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/services_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/slot_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/splash_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/stylist_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/shop_categories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/shop_subcategories_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/signup_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/stylist_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/tabs_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/backend/binding/verify_binding.dart';
import 'package:ultimate_salon_owner_flutter/app/view/add_services.dart';
import 'package:ultimate_salon_owner_flutter/app/view/add_slot.dart';
import 'package:ultimate_salon_owner_flutter/app/view/add_timing.dart';
import 'package:ultimate_salon_owner_flutter/app/view/analytics.dart';
import 'package:ultimate_salon_owner_flutter/app/view/cities_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/error.dart';
import 'package:ultimate_salon_owner_flutter/app/view/firebase.dart';
import 'package:ultimate_salon_owner_flutter/app/view/individual_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/individual_cities.dart';
import 'package:ultimate_salon_owner_flutter/app/view/individual_profile.dart';
import 'package:ultimate_salon_owner_flutter/app/view/packages_specialist.dart';
import 'package:ultimate_salon_owner_flutter/app/view/product_order_details.dart';
import 'package:ultimate_salon_owner_flutter/app/view/register_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/salon_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/add_packages.dart';
import 'package:ultimate_salon_owner_flutter/app/view/add_stylist.dart';
import 'package:ultimate_salon_owner_flutter/app/view/app_pages.dart';
import 'package:ultimate_salon_owner_flutter/app/view/appointment.dart';
import 'package:ultimate_salon_owner_flutter/app/view/calendar.dart';
import 'package:ultimate_salon_owner_flutter/app/view/chat.dart';
import 'package:ultimate_salon_owner_flutter/app/view/contact_us.dart';
import 'package:ultimate_salon_owner_flutter/app/view/create_product.dart';
import 'package:ultimate_salon_owner_flutter/app/view/profile_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/gallary.dart';
import 'package:ultimate_salon_owner_flutter/app/view/history.dart';
import 'package:ultimate_salon_owner_flutter/app/view/inbox.dart';
import 'package:ultimate_salon_owner_flutter/app/view/languages.dart';
import 'package:ultimate_salon_owner_flutter/app/view/login.dart';
import 'package:ultimate_salon_owner_flutter/app/view/order_details.dart';
import 'package:ultimate_salon_owner_flutter/app/view/packages.dart';
import 'package:ultimate_salon_owner_flutter/app/view/products.dart';
import 'package:ultimate_salon_owner_flutter/app/view/profile.dart';
import 'package:ultimate_salon_owner_flutter/app/view/review.dart';
import 'package:ultimate_salon_owner_flutter/app/view/packages_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/service_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/services.dart';
import 'package:ultimate_salon_owner_flutter/app/view/slot.dart';
import 'package:ultimate_salon_owner_flutter/app/view/splash.dart';
import 'package:ultimate_salon_owner_flutter/app/view/stylist_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/shop_categories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/shop_subcategories.dart';
import 'package:ultimate_salon_owner_flutter/app/view/signup.dart';
import 'package:ultimate_salon_owner_flutter/app/view/stylist.dart';
import 'package:ultimate_salon_owner_flutter/app/view/tabs.dart';
import 'package:ultimate_salon_owner_flutter/app/view/verify.dart';

class AppRouter {
  static const String initial = '/';
  static const String verifyRoutes = '/verify';
  static const String signUpRoutes = '/signup';
  static const String tabRoutes = '/tabs';
  static const String appointmentRoutes = '/appointment';
  static const String calendarRoutes = '/calendar';
  static const String inboxRoutes = '/inbox';
  static const String profileRoutes = '/profile';
  static const String orderDetailsRoutes = '/order_details';
  static const String chatRoutes = '/chat';
  static const String historyRoutes = '/history';
  static const String stylistRoutes = '/stylist';
  static const String addStylistRoutes = '/add_stylist';
  static const String stylistCategoriesRoutes = '/select_stylist';
  static const String profileCategoriesRoutes = '/profile_categories';
  static const String addTimingRoutes = '/timing';
  static const String gallaryRoutes = '/gallary';
  static const String reviewRoutes = '/review';
  static const String languagesRoutes = '/languages';
  static const String contactUsRoutes = '/contact_us';
  static const String appPagesRoutes = '/app_pages';
  static const String packagesRoutes = '/packages';
  static const String addPackagesRoutes = '/add_packages';
  static const String packagesCategoriesRoutes = '/select_packages';
  static const String productsRoutes = '/products';
  static const String createProductsRoutes = '/create_products';
  static const String shopCategoriesRoutes = '/shop_categories';
  static const String shopSubCategoriesRoutes = '/shop_subcategories';
  static const String salonCategoriesRoutes = '/salon_categories';
  static const String citiesCategoriesRoutes = '/select_cities';
  static const String slotRoutes = '/slot';
  static const String addSlotRoutes = '/add_slot';
  static const String servicesRoutes = '/services';
  static const String addServicesRoutes = '/add_services';
  static const String servicesCategoriesRoutes = '/services_categories';
  static const String packagesSpecialistRoutes = '/packages_specialist';
  static const String individualProfileRoutes = '/individual_profile';
  static const String individualProfileCategoriesRoutes =
      '/individual_profile_categories';
  static const String individualCitiesRoutes = '/individual_cities';
  static const String errorRoutes = '/error';
  static const String splash = '/splash';
  static const String analyticsRoutes = '/analytics';
  static const String firebaseRoutes = '/firebase_auth';
  static const String productOrderDetailsRoutes = '/product_order_details';
  static const String registerCategoriesRoutes = '/register_categories';

  static String getInitialRoute() => initial;
  static String getVerifyRoute() => verifyRoutes;
  static String getSignUpRoute() => signUpRoutes;
  static String getTabRoute() => tabRoutes;
  static String getAppointmentRoute() => appointmentRoutes;
  static String getCalendarRoute() => calendarRoutes;
  static String getInboxRoute() => inboxRoutes;
  static String getProfileRoute() => profileRoutes;
  static String getOrderDetailsRoute() => orderDetailsRoutes;
  static String getChatRoute() => chatRoutes;
  static String getHistoryRoute() => historyRoutes;
  static String getStylistRoute() => stylistRoutes;
  static String getAddStylistRoute() => addStylistRoutes;
  static String getStylistCategoriesRoute() => stylistCategoriesRoutes;
  static String getProfileCategoriesRoute() => profileCategoriesRoutes;
  static String getAddTimingRoute() => addTimingRoutes;
  static String getGallaryRoute() => gallaryRoutes;
  static String getReviewRoute() => reviewRoutes;
  static String getLanguagesRoute() => languagesRoutes;
  static String getContactUsRoute() => contactUsRoutes;
  static String getAppPagesRoute() => appPagesRoutes;
  static String getPackagesRoute() => packagesRoutes;
  static String getAddPackagesRoute() => addPackagesRoutes;
  static String getPackagesCategoriesRoute() => packagesCategoriesRoutes;
  static String getProductsRoute() => productsRoutes;
  static String getCreateProductsRoute() => createProductsRoutes;
  static String getShopCategoriesRoute() => shopCategoriesRoutes;
  static String getShopSubCategoriesRoute() => shopSubCategoriesRoutes;
  static String getSalonCategoriesRoute() => salonCategoriesRoutes;
  static String getCitiesCategoriesRoute() => citiesCategoriesRoutes;
  static String getSlotRoute() => slotRoutes;
  static String getAddSlotRoute() => addSlotRoutes;
  static String getServicesRoute() => servicesRoutes;
  static String getAddServicesRoute() => addServicesRoutes;
  static String getServicesCategoriesRoute() => servicesCategoriesRoutes;
  static String getPackagesSpecialistRoute() => packagesSpecialistRoutes;
  static String getIndividualProfileRoute() => individualProfileRoutes;
  static String getIndividualProfileCategoriesRoute() =>
      individualProfileCategoriesRoutes;
  static String getIndividualCitiesRoute() => individualCitiesRoutes;
  static String getErrorRoutes() => errorRoutes;
  static String getSplashRoutes() => splash;
  static String getAnalyticsRoutes() => analyticsRoutes;
  static String getFirebaseAuthRoutes() => firebaseRoutes;
  static String getProductOrderDetailsRoutes() => productOrderDetailsRoutes;
  static String getRegisterCategoriesRoutes() => registerCategoriesRoutes;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: verifyRoutes,
        page: () => const VerifyScreen(),
        binding: VerifyBinding()),
    GetPage(
        name: signUpRoutes,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
        name: tabRoutes, page: () => const TabScreen(), binding: TabsBinding()),
    GetPage(
        name: appointmentRoutes,
        page: () => const AppointmentScreen(),
        binding: AppointmentBinding()),
    GetPage(
        name: calendarRoutes,
        page: () => const CalendarScreen(),
        binding: CalendarsBinding()),
    GetPage(
        name: inboxRoutes,
        page: () => const InboxScreen(),
        binding: InboxBinding()),
    GetPage(
        name: profileRoutes,
        page: () => const ProfileScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: orderDetailsRoutes,
        page: () => const OrderDetailsScreen(),
        binding: OrderDetailsBinding()),
    GetPage(
        name: chatRoutes,
        page: () => const ChatScreen(),
        binding: ChatBinding()),
    GetPage(
        name: historyRoutes,
        page: () => const HistoryScreen(),
        binding: HistoryBinding()),
    GetPage(
        name: stylistRoutes,
        page: () => const StylistScreen(),
        binding: StylistBinding()),
    GetPage(
        name: addStylistRoutes,
        page: () => const AddStylistScreen(),
        binding: AddStylistBinding()),
    GetPage(
        name: stylistCategoriesRoutes,
        page: () => const StylistCategoriesScreen(),
        binding: StylistCategoriesBinding()),
    GetPage(
        name: profileCategoriesRoutes,
        page: () => const ProfileCategoriesScreen(),
        binding: ProfileCategoriesBinding()),
    GetPage(
        name: addTimingRoutes,
        page: () => const AddTimingScreen(),
        binding: AddTimingBinding(),
        fullscreenDialog: true),
    GetPage(
        name: gallaryRoutes,
        page: () => const GallaryScreen(),
        binding: GallaryBinding()),
    GetPage(
        name: reviewRoutes,
        page: () => const ReviewScreen(),
        binding: ReviewBinding()),
    GetPage(
        name: reviewRoutes,
        page: () => const ReviewScreen(),
        binding: ReviewBinding()),
    GetPage(
        name: languagesRoutes,
        page: () => const LanguagesScreen(),
        binding: LanguagesBinding()),
    GetPage(
        name: contactUsRoutes,
        page: () => const ContactUsScreen(),
        binding: ContactUsBinding()),
    GetPage(
        name: appPagesRoutes,
        page: () => const AppPagesScreen(),
        binding: AppPagesBinding()),
    GetPage(
        name: packagesRoutes,
        page: () => const PackagesScreen(),
        binding: PackagesBinding()),
    GetPage(
        name: addPackagesRoutes,
        page: () => const AddPackagesScreen(),
        binding: AddPackagesBinding()),
    GetPage(
        name: packagesCategoriesRoutes,
        page: () => const PackagesCategoriesScreen(),
        binding: PackagesCategoriesBinding()),
    GetPage(
        name: productsRoutes,
        page: () => const ProductsScreen(),
        binding: ProductsBinding()),
    GetPage(
        name: createProductsRoutes,
        page: () => const CreateProductsScreen(),
        binding: CretaeProductsBinding()),
    GetPage(
        name: shopCategoriesRoutes,
        page: () => const ShopCategoriesScreen(),
        binding: ShopCategoriesBinding()),
    GetPage(
        name: shopSubCategoriesRoutes,
        page: () => const ShopSubCategoriesScreen(),
        binding: ShopSubCategoriesBinding()),
    GetPage(
        name: salonCategoriesRoutes,
        page: () => const SalonCategoriesScreen(),
        binding: SalonCategoriesBinding()),
    GetPage(
        name: citiesCategoriesRoutes,
        page: () => const CitiesCategoriesScreen(),
        binding: CitiesCategoriesBinding()),
    GetPage(
        name: slotRoutes,
        page: () => const SlotScreen(),
        binding: SlotBinding()),
    GetPage(
        name: addSlotRoutes,
        page: () => const AddSlotScreen(),
        binding: AddSlotBinding()),
    GetPage(
        name: addServicesRoutes,
        page: () => const AddServicesScreen(),
        binding: AddServicesBinding()),
    GetPage(
        name: servicesRoutes,
        page: () => const ServicesScreen(),
        binding: ServicesBinding()),
    GetPage(
        name: servicesCategoriesRoutes,
        page: () => const ServiceCategoriesScreen(),
        binding: ServicesCategoriesBinding()),
    GetPage(
        name: packagesSpecialistRoutes,
        page: () => const PackagesSpecialistScreen(),
        binding: PackagesSpecialistBinding()),
    GetPage(
        name: individualProfileRoutes,
        page: () => const IndividualProfileScreen(),
        binding: IndividualProfileBinding()),
    GetPage(
        name: individualProfileCategoriesRoutes,
        page: () => const IndividualCategoriesScreen(),
        binding: IndividualProfileCategoriesBinding()),
    GetPage(
        name: individualCitiesRoutes,
        page: () => const IndividualCitiesScreen(),
        binding: IndividualCitiesBinding()),
    GetPage(name: errorRoutes, page: () => const ErrorScreen()),
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: analyticsRoutes,
        page: () => const AnalyticScreen(),
        binding: AnalyticsBinding()),
    GetPage(
        name: firebaseRoutes,
        page: () => const FirebaseVerificationScreen(),
        binding: FirebaseBinding(),
        fullscreenDialog: true),
    GetPage(
        name: productOrderDetailsRoutes,
        page: () => const ProductOrderDetailScreen(),
        binding: ProductOrderDetailsBinding()),
    GetPage(
        name: registerCategoriesRoutes,
        page: () => const RegisterCategoryScreen(),
        binding: RegisterCategoriesBinding(),
        fullscreenDialog: true)
  ];
}
