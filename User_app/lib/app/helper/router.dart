/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:salon_user/app/backend/binding/account_binding.dart';
import 'package:salon_user/app/backend/binding/account_chat_binding.dart';
import 'package:salon_user/app/backend/binding/add_card_binding.dart';
import 'package:salon_user/app/backend/binding/add_review_binding.dart';
import 'package:salon_user/app/backend/binding/address_binding.dart';
import 'package:salon_user/app/backend/binding/address_list_binding.dart';
import 'package:salon_user/app/backend/binding/all_categories_binding.dart';
import 'package:salon_user/app/backend/binding/app_pages_binding.dart';
import 'package:salon_user/app/backend/binding/appointment_detail_binding.dart';
import 'package:salon_user/app/backend/binding/booking_binding.dart';
import 'package:salon_user/app/backend/binding/cart_binding.dart';
import 'package:salon_user/app/backend/binding/categories_binding.dart';
import 'package:salon_user/app/backend/binding/categories_list_binding.dart';
import 'package:salon_user/app/backend/binding/chat_binding.dart';
import 'package:salon_user/app/backend/binding/checkout_binding.dart';
import 'package:salon_user/app/backend/binding/choose_location_binding.dart';
import 'package:salon_user/app/backend/binding/complaints_binding.dart';
import 'package:salon_user/app/backend/binding/contact_us_binding.dart';
import 'package:salon_user/app/backend/binding/coupon_binding.dart';
import 'package:salon_user/app/backend/binding/edit_profile_binding.dart';
import 'package:salon_user/app/backend/binding/filter_binding.dart';
import 'package:salon_user/app/backend/binding/find_location_binding.dart';
import 'package:salon_user/app/backend/binding/firebase_binding.dart';
import 'package:salon_user/app/backend/binding/home_binding.dart';
import 'package:salon_user/app/backend/binding/individual_categories_binding.dart';
import 'package:salon_user/app/backend/binding/individual_checkout_binding.dart';
import 'package:salon_user/app/backend/binding/individual_list_binding.dart';
import 'package:salon_user/app/backend/binding/individual_packages_binding.dart';
import 'package:salon_user/app/backend/binding/individual_payment_binding.dart';
import 'package:salon_user/app/backend/binding/individual_slot_binding.dart';
import 'package:salon_user/app/backend/binding/intro_binding.dart';
import 'package:salon_user/app/backend/binding/languages_binding.dart';
import 'package:salon_user/app/backend/binding/login_binding.dart';
import 'package:salon_user/app/backend/binding/near_binding.dart';
import 'package:salon_user/app/backend/binding/new_address_binding.dart';
import 'package:salon_user/app/backend/binding/packages_details_binding.dart';
import 'package:salon_user/app/backend/binding/payment_binding.dart';
import 'package:salon_user/app/backend/binding/product_order_binding.dart';
import 'package:salon_user/app/backend/binding/product_order_detail_binding.dart';
import 'package:salon_user/app/backend/binding/product_payment_binding.dart';
import 'package:salon_user/app/backend/binding/products_binding.dart';
import 'package:salon_user/app/backend/binding/products_details_binding.dart';
import 'package:salon_user/app/backend/binding/refer_and_earn_binding.dart';
import 'package:salon_user/app/backend/binding/register_binding.dart';
import 'package:salon_user/app/backend/binding/reset_password_binding.dart';
import 'package:salon_user/app/backend/binding/search_binding.dart';
import 'package:salon_user/app/backend/binding/selected_services_binding.dart';
import 'package:salon_user/app/backend/binding/services_binding.dart';
import 'package:salon_user/app/backend/binding/slot_binding.dart';
import 'package:salon_user/app/backend/binding/sortby_binding.dart';
import 'package:salon_user/app/backend/binding/specialist_binding.dart';
import 'package:salon_user/app/backend/binding/splash_binding.dart';
import 'package:salon_user/app/backend/binding/stripe_pay_binding.dart';
import 'package:salon_user/app/backend/binding/stripe_pay_product_binding.dart';
import 'package:salon_user/app/backend/binding/tabs_binding.dart';
import 'package:salon_user/app/backend/binding/top_offers_binding.dart';
import 'package:salon_user/app/backend/binding/top_packages_binding.dart';
import 'package:salon_user/app/backend/binding/top_products_binding.dart';
import 'package:salon_user/app/backend/binding/top_specialist_binding.dart';
import 'package:salon_user/app/backend/binding/wallet_binding.dart';
import 'package:salon_user/app/backend/binding/web_payment_binding.dart';
import 'package:salon_user/app/backend/binding/web_product_payment_binding.dart';
import 'package:salon_user/app/backend/binding/welcome_binding.dart';
import 'package:salon_user/app/view/account.dart';
import 'package:salon_user/app/view/account_chat.dart';
import 'package:salon_user/app/view/add_card.dart';
import 'package:salon_user/app/view/add_review.dart';
import 'package:salon_user/app/view/address.dart';
import 'package:salon_user/app/view/address_list.dart';
import 'package:salon_user/app/view/all_categories.dart';
import 'package:salon_user/app/view/app_pages.dart';
import 'package:salon_user/app/view/appointment_detail.dart';
import 'package:salon_user/app/view/booking.dart';
import 'package:salon_user/app/view/cart.dart';
import 'package:salon_user/app/view/categories.dart';
import 'package:salon_user/app/view/categories_list.dart';
import 'package:salon_user/app/view/chat.dart';
import 'package:salon_user/app/view/checkout.dart';
import 'package:salon_user/app/view/choose_location.dart';
import 'package:salon_user/app/view/complaints.dart';
import 'package:salon_user/app/view/contact_us.dart';
import 'package:salon_user/app/view/coupon.dart';
import 'package:salon_user/app/view/edit_profile.dart';
import 'package:salon_user/app/view/error.dart';
import 'package:salon_user/app/view/filter.dart';
import 'package:salon_user/app/view/find_location.dart';
import 'package:salon_user/app/view/firebase.dart';
import 'package:salon_user/app/view/home.dart';
import 'package:salon_user/app/view/individual_categories.dart';
import 'package:salon_user/app/view/individual_checkout.dart';
import 'package:salon_user/app/view/individual_list.dart';
import 'package:salon_user/app/view/individual_packages.dart';
import 'package:salon_user/app/view/individual_payment.dart';
import 'package:salon_user/app/view/individual_slot.dart';
import 'package:salon_user/app/view/intro.dart';
import 'package:salon_user/app/view/languages.dart';
import 'package:salon_user/app/view/login.dart';
import 'package:salon_user/app/view/near.dart';
import 'package:salon_user/app/view/new_address.dart';
import 'package:salon_user/app/view/packages_details.dart';
import 'package:salon_user/app/view/payment.dart';
import 'package:salon_user/app/view/product_order.dart';
import 'package:salon_user/app/view/product_order_detail.dart';
import 'package:salon_user/app/view/product_payment.dart';
import 'package:salon_user/app/view/product_stripe_pay.dart';
import 'package:salon_user/app/view/products.dart';
import 'package:salon_user/app/view/products_details.dart';
import 'package:salon_user/app/view/refer_and_earn.dart';
import 'package:salon_user/app/view/register.dart';
import 'package:salon_user/app/view/reset_password.dart';
import 'package:salon_user/app/view/search.dart';
import 'package:salon_user/app/view/selected_services.dart';
import 'package:salon_user/app/view/services.dart';
import 'package:salon_user/app/view/slot.dart';
import 'package:salon_user/app/view/sortby.dart';
import 'package:salon_user/app/view/specialist.dart';
import 'package:salon_user/app/view/splash.dart';
import 'package:salon_user/app/view/stripe_pay.dart';
import 'package:salon_user/app/view/tabs.dart';
import 'package:salon_user/app/view/top_offers.dart';
import 'package:salon_user/app/view/top_packages.dart';
import 'package:salon_user/app/view/top_products.dart';
import 'package:salon_user/app/view/top_specialist.dart';
import 'package:salon_user/app/view/wallet.dart';
import 'package:salon_user/app/view/web_payment.dart';
import 'package:salon_user/app/view/web_product_payment.dart';
import 'package:salon_user/app/view/welcome.dart';

class AppRouter {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String resetPassword = '/reset_password';
  static const String tabsBarRoutes = '/tabs';
  static const String homeRoutes = '/home';
  static const String categoriesRoutes = '/categories';
  static const String nearRoutes = '/near';
  static const String bookingRoutes = '/bookings';
  static const String accountRoutes = '/account';
  static const String filterRoutes = '/filter';
  static const String searchRoutes = '/search';
  static const String chatRoutes = '/chat';
  static const String servicesRoutes = '/services';
  static const String specialistRoutes = '/specialist';
  static const String appointmentDetailRoutes = '/appointment_detail';
  static const String addressRoutes = '/address';
  static const String walletRoutes = '/wallet';
  static const String referAndEarnRoutes = '/referAndEarn';
  static const String languagesRoutes = '/languages';
  static const String accountChatRoutes = '/account_chat';
  static const String contactUsRoutes = '/contact_us';
  static const String newAddressRoutes = '/new_address';
  static const String appPagesRoutes = '/app_pages';
  static const String productsRoutes = '/products';
  static const String productsDetailsRoutes = '/products_details';
  static const String sortByRoutes = '/sortby';
  static const String cartRoutes = '/cart';
  static const String checkoutRoutes = '/checkout';
  static const String allCategoriesRoutes = '/all_categories';
  static const String topSpecialistRoutes = '/top_specialist';
  static const String topOffersRoutes = '/top_offers';
  static const String topPackagesRoutes = '/top_packages';
  static const String chooseLocationRoutes = '/choose_location';
  static const String findLocationRoutes = '/find_location';
  static const String categoriesListRoutes = '/categories_list';
  static const String selectedServicesRoutes = '/selected_services';
  static const String packagesDetailsRoutes = '/packages_details';
  static const String couponRoutes = '/coupon';
  static const String slotRoutes = '/slot';
  static const String paymentRoutes = '/payment';
  static const String errorRoutes = '/error';
  static const String addNewCardRoutes = '/add_new_card';
  static const String stripePayRoutes = '/stripePay';
  static const String stripePayProductRoutes = '/stripePay_product';
  static const String webPaymentRoutes = '/web_payment';
  static const String webProductPaymentRoutes = '/web_product_payment';
  static const String individualCategoriesRoutes = '/individual_categories';
  static const String individualPackagesRoutes = '/individual_packages';
  static const String individualCheckoutRoutes = '/individual_checkout';
  static const String individualListRoutes = '/individual_list';
  static const String individualSlotRoutes = '/individual_slot';
  static const String individualPaymentRoutes = '/individual_payment';
  static const String productPaymentRoutes = '/product_payment';
  static const String addressListRoutes = '/address_list';
  static const String productOrderRoutes = '/product_order';
  static const String productOrderDetailRoutes = '/product_order_detail';
  static const String firebaseRoutes = '/firebase_auth';
  static const String editProfile = '/edit_profile';
  static const String topProducts = '/top_products';
  static const String addReviewsRoutes = '/add_review';
  static const String complaintsRoutes = '/complaints';

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getWelcomeRoute() => welcome;
  static String getLoginRoute() => login;
  static String getRegisterRoute() => register;
  static String getResetPasswordRoute() => resetPassword;
  static String getTabsBarRoute() => tabsBarRoutes;
  static String getHomeRoutes() => homeRoutes;
  static String getCategoriesRoutes() => categoriesRoutes;
  static String getNearRoutes() => nearRoutes;
  static String getBookingRoutes() => bookingRoutes;
  static String getAccountRoutes() => accountRoutes;
  static String getFilterRoutes() => filterRoutes;
  static String getSearchRoutes() => searchRoutes;
  static String getChatRoutes() => chatRoutes;
  static String getServicesRoutes() => servicesRoutes;
  static String getSpecialistRoutes() => specialistRoutes;
  static String getAppointmentDetailRoutes() => appointmentDetailRoutes;
  static String getAddressRoutes() => addressRoutes;
  static String getWalletRoutes() => walletRoutes;
  static String getReferAndEarnRoutes() => referAndEarnRoutes;
  static String getLanguagesRoutes() => languagesRoutes;
  static String getAccountChatRoutes() => accountChatRoutes;
  static String getContactUsRoutes() => contactUsRoutes;
  static String getNewAddressRoutes() => newAddressRoutes;
  static String getAppPagesRoutes() => appPagesRoutes;
  static String getProductsRoutes() => productsRoutes;
  static String getProductsDetailsRoutes() => productsDetailsRoutes;
  static String getSortByRoutes() => sortByRoutes;
  static String getCartRoutes() => cartRoutes;
  static String getCheckoutRoutes() => checkoutRoutes;
  static String getAllCategoriesRoutes() => allCategoriesRoutes;
  static String getTopSpecialistRoutes() => topSpecialistRoutes;
  static String getTopOffersRoutes() => topOffersRoutes;
  static String getTopPackagesRoutes() => topPackagesRoutes;
  static String getChooseLocationRoutes() => chooseLocationRoutes;
  static String getFindLocationRoutes() => findLocationRoutes;
  static String getCategoriesListRoutes() => categoriesListRoutes;
  static String getSelectedServicesRoutes() => selectedServicesRoutes;
  static String getPackagesDetailsRoutes() => packagesDetailsRoutes;
  static String getCouponRoutes() => couponRoutes;
  static String getSlotRoutes() => slotRoutes;
  static String getPaymentRoutes() => paymentRoutes;
  static String getErrorRoutes() => errorRoutes;
  static String getAddCard() => addNewCardRoutes;
  static String getStripePay() => stripePayRoutes;
  static String getProductStripePay() => stripePayProductRoutes;
  static String getWebPayment() => webPaymentRoutes;
  static String getWebProductPayment() => webProductPaymentRoutes;
  static String getIndividualCategories() => individualCategoriesRoutes;
  static String getIndividualPackages() => individualPackagesRoutes;
  static String getIndividualCheckout() => individualCheckoutRoutes;
  static String getIndividualList() => individualListRoutes;
  static String getIndividualSlot() => individualSlotRoutes;
  static String getIndividualPayment() => individualPaymentRoutes;
  static String getProductPayment() => productPaymentRoutes;
  static String getAddressList() => addressListRoutes;
  static String getProductOrder() => productOrderRoutes;
  static String getProductOrderDetail() => productOrderDetailRoutes;
  static String getFirebaseAuthRoutes() => firebaseRoutes;
  static String getEditProfileRoutes() => editProfile;
  static String getTopProductsRoutes() => topProducts;
  static String getAddReviewsRoutes() => addReviewsRoutes;
  static String getComplaintsRoutes() => complaintsRoutes;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const IntroScreen(),
        binding: IntroBinding()),
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: welcome,
        page: () => const WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(
        name: login, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: register,
        page: () => const RegisterScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: resetPassword,
        page: () => const ResetPasswordScreen(),
        binding: ResetPasswordBinding()),
    GetPage(
        name: tabsBarRoutes,
        page: () => const TabScreen(),
        binding: TabsBinding()),
    GetPage(
        name: homeRoutes,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: categoriesRoutes,
        page: () => const CategoriesScreen(),
        binding: CategoriesBinding()),
    GetPage(
        name: nearRoutes,
        page: () => const NearScreen(),
        binding: NearBinding()),
    GetPage(
        name: bookingRoutes,
        page: () => const BookingScreen(),
        binding: BookingBinding()),
    GetPage(
        name: accountRoutes,
        page: () => const AccountScreen(),
        binding: AccountBinding()),
    GetPage(
        name: filterRoutes,
        page: () => const FilterScreen(),
        binding: FilterBinding(),
        fullscreenDialog: true),
    GetPage(
        name: searchRoutes,
        page: () => const SearchScreen(),
        binding: SearchBinding(),
        fullscreenDialog: true),
    GetPage(
        name: chatRoutes,
        page: () => const ChatScreen(),
        binding: ChatBinding()),
    GetPage(
        name: servicesRoutes,
        page: () => const ServicesScreen(),
        binding: ServicesBinding()),
    GetPage(
        name: specialistRoutes,
        page: () => const SpecialistScreen(),
        binding: SpecialistBinding()),
    GetPage(
        name: appointmentDetailRoutes,
        page: () => const AppointmentDetailScreen(),
        binding: AppointmentDetailBinding()),
    GetPage(
        name: addressRoutes,
        page: () => const AddressScreen(),
        binding: AddressBinding()),
    GetPage(
        name: walletRoutes,
        page: () => const WalletScreen(),
        binding: WalletBinding()),
    GetPage(
        name: referAndEarnRoutes,
        page: () => const ReferAndEarnScreen(),
        binding: ReferAndEarnBinding()),
    GetPage(
        name: languagesRoutes,
        page: () => const LanguagesScreen(),
        binding: LanguagesBinding()),
    GetPage(
        name: accountChatRoutes,
        page: () => const AccountChatScreen(),
        binding: AccountChatBinding()),
    GetPage(
        name: contactUsRoutes,
        page: () => const ContactUsScreen(),
        binding: ContactUsBinding()),
    GetPage(
        name: newAddressRoutes,
        page: () => const NewAddressScreen(),
        binding: NewAddressBinding()),
    GetPage(
        name: appPagesRoutes,
        page: () => const AppPagesScreen(),
        binding: AppPagesBinding()),
    GetPage(
        name: productsRoutes,
        page: () => const ProductsScreen(),
        binding: ProductsBinding()),
    GetPage(
        name: productsDetailsRoutes,
        page: () => const ProductsDetailsScreen(),
        binding: ProductsDetailsBinding()),
    GetPage(
        name: sortByRoutes,
        page: () => const SortByScreen(),
        binding: SortByBinding(),
        fullscreenDialog: true),
    GetPage(
        name: cartRoutes,
        page: () => const CartScreen(),
        binding: CartBinding()),
    GetPage(
        name: checkoutRoutes,
        page: () => const CheckoutScreen(),
        binding: CheckoutBinding()),
    GetPage(
        name: allCategoriesRoutes,
        page: () => const AllCategoriesScreen(),
        binding: AllCategoriesBinding()),
    GetPage(
        name: topSpecialistRoutes,
        page: () => const TopSpecialistScreen(),
        binding: TopSpecialistBinding()),
    GetPage(
        name: topOffersRoutes,
        page: () => const TopOffersScreen(),
        binding: TopOffersBinding()),
    GetPage(
        name: topPackagesRoutes,
        page: () => const TopPackagesScreen(),
        binding: TopPackagesBinding()),
    GetPage(
        name: chooseLocationRoutes,
        page: () => const ChooseLocationScreen(),
        binding: ChooseLocationBinding()),
    GetPage(
        name: findLocationRoutes,
        page: () => const FindLocationScreen(),
        binding: FindLocationBinding(),
        fullscreenDialog: true),
    GetPage(
        name: categoriesListRoutes,
        page: () => const CategoriesListScreen(),
        binding: CategoriesListBinding()),
    GetPage(
        name: selectedServicesRoutes,
        page: () => const SelectedServicesScreen(),
        binding: SelectedServicesBinding(),
        fullscreenDialog: true),
    GetPage(
        name: packagesDetailsRoutes,
        page: () => const PackagesDetailsScreen(),
        binding: PackagesDetailsBinding(),
        fullscreenDialog: true),
    GetPage(
        name: couponRoutes,
        page: () => const CouponScreen(),
        binding: CouponBinding(),
        fullscreenDialog: true),
    GetPage(
        name: slotRoutes,
        page: () => const SlotScreen(),
        binding: SlotBinding()),
    GetPage(
        name: paymentRoutes,
        page: () => const PaymentScreen(),
        binding: PaymentBinding()),
    GetPage(name: errorRoutes, page: () => const ErrorScreen()),
    GetPage(
        name: addNewCardRoutes,
        page: () => const AddCardScreen(),
        binding: AddCardBinding()),
    GetPage(
        name: stripePayRoutes,
        page: () => const StripePay(),
        binding: StripePayBinding()),
    GetPage(
        name: stripePayProductRoutes,
        page: () => const ProductStripePay(),
        binding: StripePayProductBinding()),
    GetPage(
        name: webPaymentRoutes,
        page: () => const WebPayment(),
        binding: WebPaymentBinding()),
    GetPage(
        name: webProductPaymentRoutes,
        page: () => const WebProductPayment(),
        binding: WebProductPaymentBinding()),
    GetPage(
        name: individualCategoriesRoutes,
        page: () => const IndividualCategoriesScreen(),
        binding: IndividualCategoriesBinding()),
    GetPage(
        name: individualPackagesRoutes,
        page: () => const IndividualPackagesScreen(),
        binding: IndividualPackagesBinding(),
        fullscreenDialog: true),
    GetPage(
        name: individualCheckoutRoutes,
        page: () => const IndividualCheckoutScreen(),
        binding: IndividualCheckoutBinding()),
    GetPage(
        name: individualListRoutes,
        page: () => const IndividualListScreen(),
        binding: IndividualListBinding(),
        fullscreenDialog: true),
    GetPage(
        name: individualSlotRoutes,
        page: () => const IndividualSlotScreen(),
        binding: IndividualSlotBinding()),
    GetPage(
        name: individualPaymentRoutes,
        page: () => const IndividualPaymentScreen(),
        binding: IndividualPaymentBinding()),
    GetPage(
        name: productPaymentRoutes,
        page: () => const ProductPaymentScreen(),
        binding: ProductPaymentBinding()),
    GetPage(
        name: addressListRoutes,
        page: () => const AddressListScreen(),
        binding: AddressListBinding(),
        fullscreenDialog: true),
    GetPage(
        name: productOrderRoutes,
        page: () => const ProductOrderScreen(),
        binding: ProductOrderBinding()),
    GetPage(
        name: productOrderDetailRoutes,
        page: () => const ProductOrderDetail(),
        binding: ProductOrderDetailBinding()),
    GetPage(
        name: firebaseRoutes,
        page: () => const FirebaseVerificationScreen(),
        binding: FirebaseBinding(),
        fullscreenDialog: true),
    GetPage(
        name: editProfile,
        page: () => const EditProfileScreen(),
        binding: EditProfileBindings()),
    GetPage(
        name: topProducts,
        page: () => const TopProductScreen(),
        binding: TopProductsBinding()),
    GetPage(
        name: addReviewsRoutes,
        page: () => const AddReviewScreen(),
        binding: AddReviewBinding(),
        fullscreenDialog: true),
    GetPage(
        name: complaintsRoutes,
        page: () => const ComplaintScreen(),
        binding: ComplaintsBinding(),
        fullscreenDialog: true)
  ];
}
