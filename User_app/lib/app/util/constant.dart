/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:salon_user/app/backend/models/language_model.dart';
import 'package:salon_user/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String companyName = Environments.companyName;
  static const String defaultCurrencyCode =
      'USD'; // your currency code in 3 digit
  static const String defaultCurrencySide =
      'right'; // default currency position
  static const String defaultCurrencySymbol = '\$'; // default currency symbol
  static const String defaultLanguageApp = 'en';
  static const int defaultMakeingOrder =
      0; // 0=> from multiple stores // 1 = single store only
  static const String defaultSMSGateway = '1'; // 2 = firebase // 1 = rest
  static const double defaultDeliverRadius = 50;
  static const int userLogin = 0;
  static const int defaultVerificationForSignup = 0; // 0 = email // 1= phone
  static const int defaultShippingMethod = 0;

  // API Routes
  static const String getAppSettings = 'api/v1/settings/getDefault';
  static const String onlogin = 'api/v1/auth/login';
  static const String loginWithPhonePassword =
      'api/v1/auth/loginWithPhonePassword';
  static const String verifyPhoneFirebase =
      'api/v1/auth/verifyPhoneForFirebase';
  static const String verifyPhone = 'api/v1/otp/verifyPhone';
  static const String loginWithMobileToken = 'api/v1/auth/loginWithMobileOtp';
  static const String updateFCM = 'api/v1/profile/update';
  static const String getHomeData = 'api/v1/salon/getHomeData';
  static const String getAllCategories = 'api/v1/category/getAllCategories';
  static const String getDataFromCategories =
      'api/v1/salon/getDataFromCategory';
  static const String getTopFreelancer = 'api/v1/salon/getTopFreelancer';
  static const String getTopSalon = 'api/v1/salon/getTopSalon';
  static const String salonDetails = 'api/v1/salon/salonDetails';
  static const String getOwnerReviewsList = 'api/v1/owner_reviews/getMyReviews';
  static const String getWalletAmounts = 'api/v1/profile/getMyWallet';
  static const String getUserByID = 'api/v1/profile/getByID';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String updateInfo = 'api/v1/profile/update';
  static const String getTopProducts = 'api/v1/products/topProducts';
  static const String getServicesById =
      'api/v1/freelancer_services/getByCategoryId';
  static const String getPackagesById = 'api/v1/packages/getPackageDetails';
  static const String getSlotsForBookings =
      'api/v1/timeslots/getSlotsByForBookings';
  static const String createUser = 'api/v1/auth/create_user_account';
  static const String getSpecislistById = 'api/v1/specialist/getSpecialist';
  static const String getCoupons = 'api/v1/offers/getActive';
  static const String getPayments = 'api/v1/payments/getPayments';
  static const String createAppointments = 'api/v1/appoinments/create';
  static const String getUserProfile = 'api/v1/profile/getByID';
  static const String updateProfile = 'api/v1/profile/update';
  static const String createStripeToken = 'api/v1/payments/createStripeToken';
  static const String createStripeCustomer = 'api/v1/payments/createCustomer';
  static const String addStripeCard = 'api/v1/payments/addStripeCards';
  static const String getStripeCards = 'api/v1/payments/getStripeCards';
  static const String stripeCheckout = 'api/v1/payments/createStripePayments';
  static const String payPalPayLink = 'api/v1/payments/payPalPay?amount=';
  static const String payTmPayLink = 'api/v1/payNow?amount=';
  static const String razorPayLink = 'api/v1/payments/razorPay?';
  static const String verifyRazorPayments =
      'api/v1/payments/VerifyRazorPurchase?id=';
  static const String payWithInstaMojo = 'api/v1/payments/instamojoPay';
  static const String paystackCheckout = 'api/v1/payments/paystackPay?';
  static const String flutterwaveCheckout = 'api/v1/payments/flutterwavePay?';
  static const String saveAddress = 'api/v1/address/save';
  static const String getSavedAddress = 'api/v1/address/getByUID';
  static const String updateAddress = 'api/v1/address/update';
  static const String deleteAddress = 'api/v1/address/delete';
  static const String getAddressById = 'api/v1/address/getById';
  static const String individualDetails = 'api/v1/individual/individualDetails';
  static const String getProducts = 'api/v1/product_categories/getHome';
  static const String getProductsByIdAndCateId = 'api/v1/products/getProducts';
  static const String getProductsInfo = 'api/v1/products/getProductInfo';
  static const String productCreate = 'api/v1/product_order/save';
  static const String getOwnerInfo = 'api/v1/profile/getOwnerInfo';
  static const String getAppoimentById = 'api/v1/appoinments/getMyList';
  static const String getAppoimentInfo = 'api/v1/appoinments/getInfo';
  static const String getProductOrderList = 'api/v1/product_order/getByUID';
  static const String getProductOrderInfo = 'api/v1/product_order/getInfo';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String openFirebaseVerification = 'api/v1/auth/firebaseauth?';
  static const String referralCode = 'api/v1/referral/redeemReferral';
  static const String sendVerificationMail = 'api/v1/sendVerificationOnMail';
  static const String verifyOTP = 'api/v1/otp/verifyOTP';
  static const String verifyMobileForeFirebase =
      'api/v1/auth/verifyPhoneForFirebaseRegistrations';
  static const String sendVerificationSMS = 'api/v1/verifyPhoneSignup';
  static const String getMyReferralCode = 'api/v1/referralcode/getMyCode';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String searchResult = 'api/v1/salon/getSearchResult';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String sendNotification = 'api/v1/notification/sendNotification';
  static const String getMyWalletBalance = 'api/v1/profile/getMyWalletBalance';
  static const String updateAppointmentStatus = 'api/v1/appoinments/update';
  static const String updateProductOrder = 'api/v1/product_order/update';
  static const String getAppointmentsInvoice =
      'api/v1/appointments/printInvoice?id=';
  static const String getProductInvoice =
      'api/v1/product_order/printInvoice?id=';
  static const String getOwnerReviews = 'api/v1/owner_reviews/getOwnerReviews';
  static const String saveOwnerReview = 'api/v1/owner_reviews/save';
  static const String updateOwnerReview =
      'api/v1/owner_reviews/updateOwnerReviews';

  static const String getServiceReviews =
      'api/v1/service_reviews/getServiceReview';
  static const String saveServiceReview = 'api/v1/service_reviews/save';
  static const String savePackageReview = 'api/v1/packages_reviews/save';
  static const String getProductsReview =
      'api/v1/products_reviews/getProductsReviews';
  static const String saveProductReview = 'api/v1/products_reviews/save';
  static const String updateProductReviews = 'api/v1/products/update';
  static const String registerComplaints =
      'api/v1/complaints/registerNewComplaints';
  static const String logout = 'api/v1/profile/logout';

  // API Routes

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'عربي',
        countryCode: 'AE',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: '',
        languageName: 'हिन्दी',
        countryCode: 'IN',
        languageCode: 'hi'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Español',
        countryCode: 'De',
        languageCode: 'es'),
  ];
}
