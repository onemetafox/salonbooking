/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:ultimate_salon_owner_flutter/app/backend/models/language_model.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String companyName = Environments.companyName;
  static const int userLogin = 0;
  static const String defaultCurrencyCode =
      'USD'; // your currency code in 3 digit
  static const String defaultCurrencySide =
      'right'; // default currency position
  static const String defaultCurrencySymbol = '\$'; // default currency symbol
  static const int defaultMakeingOrder =
      0; // 0=> from multiple stores // 1 = single store only
  static const String defaultSMSGateway = '1'; // 2 = firebase // 1 = rest
  static const String defaultLanguageApp = 'en';
  // API Routes

  static const String getAppSettings = 'api/v1/settings/getDefault';
  static const String onLogin = 'api/v1/auth/login';
  static const String loginWithPhonePassword =
      'api/v1/auth/loginWithPhonePassword';
  static const String verifyPhoneFirebase =
      'api/v1/auth/verifyPhoneForFirebase';
  static const String verifyPhone = 'api/v1/otp/verifyPhone';
  static const String loginWithMobileToken = 'api/v1/auth/loginWithMobileOtp';
  static const String openFirebaseVerification = 'api/v1/auth/firebaseauth?';
  static const String updateFCM = 'api/v1/profile/update';
  static const String verifyOTP = 'api/v1/otp/verifyOTP';
  static const String categories = 'api/v1/category/getAll';
  static const String getSelectedCategories =
      'api/v1/salon/getMySelectedCategory';
  static const String getIndividualCategories =
      'api/v1/individual/getMySavedCategory';
  static const String getSalonById = 'api/v1/salon/getById';
  static const String getAllCities = 'api/v1/cities/getAll';
  static const String salonUpdate = 'api/v1/salon/update';
  static const String updateIndividual = 'api/v1/individual/update';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String getAllProductsCate =
      'api/v1/product_categories/getActive';
  static const String getSubCateById =
      'api/v1/product_sub_categories/getFromCateId';
  static const String createProducts = 'api/v1/products/create';
  static const String getProductWFreelancer =
      'api/v1/products/getWithFreelancers';
  static const String destroyProduct = 'api/v1/products/destroy';
  static const String updateProduct = 'api/v1/products/update';
  static const String getProductById = 'api/v1/products/getById';
  static const String createTimeSlot = 'api/v1/timeslots/create';
  static const String getTimeSlotById = 'api/v1/timeslots/getByUid';
  static const String getSlotInfoById = 'api/v1/timeslots/getById';
  static const String updateSlot = 'api/v1/timeslots/update';
  static const String destroyTimeSlot = 'api/v1/timeslots/destroy';
  static const String serviceCreate = 'api/v1/freelancer_services/create';
  static const String getMyServices =
      'api/v1/freelancer_services/getMyServices';
  static const String getServiceByID =
      'api/v1/freelancer_services/getServiceById';
  static const String updateService = 'api/v1/freelancer_services/update';
  static const String servicesDestroy = 'api/v1/freelancer_services/destroy';
  static const String createSpecialist = 'api/v1/specialist/create';
  static const String getBySalonId = 'api/v1/specialist/getBySalonID';
  static const String getById = 'api/v1/specialist/getById';
  static const String updateSalon = 'api/v1/specialist/update';
  static const String destroySalon = 'api/v1/specialist/destroy';
  static const String createPackages = 'api/v1/packages/create';
  static const String getPackagesBySalonId = 'api/v1/packages/getBySalonID';
  static const String getPackagesById = 'api/v1/packages/getPackageById';
  static const String packagesUpdate = 'api/v1/packages/update';
  static const String packagesDestroy = 'api/v1/packages/destroy';
  static const String getIndividualById = 'api/v1/individual/getIndividualInfo';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String getSalonAppointmentsList =
      'api/v1/appoinments/getSalonList';
  static const String getIndividualAppointmentsList =
      'api/v1/appoinments/getIndividualList';
  static const String getIndividualOrdersList =
      'api/v1/product_order/getIndividualOrders';
  static const String getSalonOrdersList =
      'api/v1/product_order/getSalonOrders';
  static const String getStats = 'api/v1/appointments/getStats';
  static const String getMonthsStats = 'api/v1/appointments/getMonthsStats';
  static const String getAllStats = 'api/v1/appointments/getAllStats';

  static const String getStatsProducts = 'api/v1/product_order/getStats';
  static const String getMonthsStatsProducts =
      'api/v1/product_order/getMonthsStats';
  static const String getAllStatsProducts = 'api/v1/product_order/getAllStats';
  static const String calendarView = 'api/v1/appointments/calendarView';
  static const String getByDate = 'api/v1/appointments/getByDate';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String sendNotification = 'api/v1/notification/sendNotification';
  static const String getAppointmnetsDetails =
      'api/v1/appoinments/getInfoOwner';
  static const String updateAppointments = 'api/v1/appoinments/update';
  static const String getProductOrderInfo = 'api/v1/product_order/getInfoOwner';
  static const String updateProductOrder = 'api/v1/product_order/update';
  static const String getAppointmentInvoice =
      'api/v1/appointments/orderInvoice?id=';
  static const String getProductOrderInvoice =
      'api/v1/product_order/orderInvoice?id=';
  static const String logout = 'api/v1/profile/logout';

  static const String verifyEmail = 'api/v1/auth/verifyEmail';
  static const String verifyPhoneRegister = 'api/v1/auth/verifyPhone';
  static const String verifyOTPEmail = 'api/v1/otp/verifyOTP';
  static const String getHomeCities = 'api/v1/cities/getActiveCities';
  static const String checkPhoneExist = 'api/v1/auth/checkPhoneExist';
  static const String saveMyRequest = 'api/v1/register_request/save';
  static const String getMyReviews = 'api/v1/owner_reviews/getMyReviews';
  static const String getActiveCategories = 'api/v1/category/getPublic';

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
