<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\v1\AuthController;
use App\Http\Controllers\v1\CitiesController;
use App\Http\Controllers\v1\TimeslotController;
use App\Http\Controllers\v1\SalonController;
use App\Http\Controllers\v1\CategoryController;
use App\Http\Controllers\v1\IndividualController;
use App\Http\Controllers\v1\BannersController;
use App\Http\Controllers\v1\ProductCategoryController;
use App\Http\Controllers\v1\ProductSubCategoryController;
use App\Http\Controllers\v1\ProductsController;
use App\Http\Controllers\v1\ServicesController;
use App\Http\Controllers\v1\SpecialistController;
use App\Http\Controllers\v1\PackagesController;
use App\Http\Controllers\v1\PaytmPayController;
use App\Http\Controllers\v1\PaymentsController;
use App\Http\Controllers\v1\AppointmentsController;
use App\Http\Controllers\v1\OffersController;
use App\Http\Controllers\v1\SettingsController;
use App\Http\Controllers\v1\AddressController;
use App\Http\Controllers\v1\ProductOrdersController;
use App\Http\Controllers\v1\BlogsController;
use App\Http\Controllers\v1\PagesController;
use App\Http\Controllers\v1\ReferralController;
use App\Http\Controllers\v1\ReferralCodesController;
use App\Http\Controllers\v1\ContactsController;
use App\Http\Controllers\v1\CommissionController;
use App\Http\Controllers\v1\OtpController;
use App\Http\Controllers\v1\ChatRoomsController;
use App\Http\Controllers\v1\ConversionsController;
use App\Http\Controllers\v1\OwnerReviewsController;
use App\Http\Controllers\v1\ServiceReviewsController;
use App\Http\Controllers\v1\PackagesReviewsController;
use App\Http\Controllers\v1\ProductReviewsController;
use App\Http\Controllers\v1\ComplaintsController;
use App\Http\Controllers\v1\RegisterRequestController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/', function () {
    return [
        'app' => 'Ultimate Salon Appointments API by initappz',
        'version' => '1.0.0',
    ];
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('/v1')->group(function () {
    Route::get('users/get_admin', [AuthController::class, 'get_admin']);
    Route::post('auth/login', [AuthController::class, 'login']);
    Route::post('auth/loginWithPhonePassword', [AuthController::class, 'loginWithPhonePassword']);
    Route::post('auth/verifyPhoneForFirebase', [AuthController::class, 'verifyPhoneForFirebase']);
    Route::post('otp/verifyPhone',[OtpController::class, 'verifyPhone'] );
    Route::post('auth/loginWithMobileOtp', [AuthController::class, 'loginWithMobileOtp']);
    Route::post('auth/create_admin_account', [AuthController::class, 'create_admin_account']);
    Route::post('auth/create_user_account', [AuthController::class, 'create_user_account']);
    Route::post('auth/adminLogin', [AuthController::class, 'adminLogin']);
    Route::post('uploadImage', [AuthController::class, 'uploadImage']);
    Route::post('auth/createSalonAccount', [AuthController::class, 'createSalonAccount']);
    Route::post('auth/createIndividualAccount', [AuthController::class, 'createIndividualAccount']);
    Route::post('auth/verifyEmailForReset', [AuthController::class, 'verifyEmailForReset']);
    Route::get('auth/firebaseauth', [AuthController::class, 'firebaseauth']);
    Route::group(['middleware' => ['jwt', 'jwt.auth']], function () {

        Route::post('profile/getByID', [AuthController::class,'getByID']);
        Route::post('profile/update', [AuthController::class,'update']);
        Route::post('profile/logout', [AuthController::class,'logout']);
        Route::post('users/userInfoAdmin', [AuthController::class,'userInfoAdmin']);
        // ADMIN Routes
        Route::post('cities/importData', [CitiesController::class, 'importData']);
        // Cities Routes
        Route::get('cities/getAll', [CitiesController::class, 'getAll']);
        Route::post('cities/create', [CitiesController::class, 'save']);
        Route::post('cities/update', [CitiesController::class, 'update']);
        Route::post('cities/destroy', [CitiesController::class, 'delete']);
        Route::post('cities/getById', [CitiesController::class, 'getById']);


        // Timeslots Routes
        Route::get('timeslots/getAll', [TimeslotController::class, 'getAll']);
        Route::post('timeslots/create', [TimeslotController::class, 'save']);
        Route::post('timeslots/update', [TimeslotController::class, 'update']);
        Route::post('timeslots/destroy', [TimeslotController::class, 'delete']);
        Route::post('timeslots/getById', [TimeslotController::class, 'getById']);
        Route::post('timeslots/getByUid', [TimeslotController::class, 'getByUid']);

        // Salon Routes
        Route::get('salon/getAll', [SalonController::class, 'getAll']);
        Route::post('salon/create', [SalonController::class, 'save']);
        Route::post('salon/update', [SalonController::class, 'update']);
        Route::post('salon/destroy', [SalonController::class, 'delete']);
        Route::post('salon/getById', [SalonController::class, 'getById']);

        Route::get('salon/getListForOffers', [SalonController::class, 'getListForOffers']);

        // individual Routes
        Route::get('individual/getAll', [IndividualController::class, 'getAll']);
        Route::post('individual/create', [IndividualController::class, 'save']);
        Route::post('individual/update', [IndividualController::class, 'update']);
        Route::post('individual/destroy', [IndividualController::class, 'delete']);
        Route::post('individual/getById', [IndividualController::class, 'getById']);

        Route::post('individual/getIndividualInfo', [IndividualController::class, 'getIndividualInfo']);

        // Blogs Routes
        Route::get('blogs/getAll', [BlogsController::class, 'getAll']);
        Route::post('blogs/create', [BlogsController::class, 'save']);
        Route::post('blogs/update', [BlogsController::class, 'update']);
        Route::post('blogs/destroy', [BlogsController::class, 'delete']);
        Route::post('blogs/getById', [BlogsController::class, 'getById']);

        // Category Routes
        Route::get('category/getAll', [CategoryController::class, 'getAll']);
        Route::get('category/getStores', [CategoryController::class, 'getStores']);
        Route::post('category/create', [CategoryController::class, 'save']);
        Route::post('category/update', [CategoryController::class, 'update']);
        Route::post('category/destroy', [CategoryController::class, 'delete']);
        Route::post('category/getById', [CategoryController::class, 'getById']);
        Route::get('category/getActiveItem', [CategoryController::class, 'getActiveItem']);
        Route::post('category/updateStatus', [CategoryController::class, 'updateStatus']);
        Route::post('salon/getMySelectedCategory', [CategoryController::class, 'getMySelectedCategory']);
        Route::post('individual/getMySavedCategory', [CategoryController::class, 'getMySavedCategory']);


        // Banners Routes
        Route::post('banners/create',[BannersController::class, 'save'] );
        Route::post('banners/getById', [BannersController::class, 'getById']);
        Route::post('banners/getInfoById', [BannersController::class, 'getInfoById']);
        Route::get('banners/getAll', [BannersController::class, 'getAll']);
        Route::get('banners/getMoreData', [BannersController::class, 'getMoreData']);
        Route::post('banners/update', [BannersController::class, 'update']);
        Route::post('banners/destroy', [BannersController::class, 'delete']);

        // Pages Routes
        Route::post('pages/getById', [PagesController::class, 'getById']);
        Route::get('pages/getAll', [PagesController::class, 'getAllPages']);
        Route::post('pages/update', [PagesController::class, 'update']);

        Route::get('referral/getAll', [ReferralController::class, 'getAll']);
        Route::post('referral/save', [ReferralController::class, 'save']);
        Route::post('referral/update', [ReferralController::class, 'update']);

        Route::post('referral/redeemReferral', [ReferralController::class, 'redeemReferral']);
        Route::post('referralcode/getMyCode', [ReferralCodesController::class, 'getMyCode']);


        // product categories Routes
        Route::post('product_categories/importData', [ProductCategoryController::class, 'importData']);
        Route::get('product_categories/getAll', [ProductCategoryController::class, 'getAll']);
        Route::get('product_categories/getActive', [ProductCategoryController::class, 'getActive']);
        Route::post('product_categories/create', [ProductCategoryController::class, 'save']);
        Route::post('product_categories/update', [ProductCategoryController::class, 'update']);
        Route::post('product_categories/destroy', [ProductCategoryController::class, 'delete']);
        Route::post('product_categories/getById', [ProductCategoryController::class, 'getById']);
        Route::post('product_categories/updateStatus', [ProductCategoryController::class, 'updateStatus']);

        // subCategory Routes
        Route::post('product_sub_categories/importData', [ProductSubCategoryController::class, 'importData']);
        Route::get('product_sub_categories/getAll', [ProductSubCategoryController::class, 'getAll']);
        Route::get('product_sub_categories/getStores', [ProductSubCategoryController::class, 'getStores']);
        Route::post('product_sub_categories/create', [ProductSubCategoryController::class, 'save']);
        Route::post('product_sub_categories/update', [ProductSubCategoryController::class, 'update']);
        Route::post('product_sub_categories/destroy', [ProductSubCategoryController::class, 'delete']);
        Route::post('product_sub_categories/getById', [ProductSubCategoryController::class, 'getById']);
        Route::post('product_sub_categories/updateStatus', [ProductSubCategoryController::class, 'updateStatus']);
        Route::post('product_sub_categories/getFromCateId', [ProductSubCategoryController::class, 'getFromCateId']);


        // Products Routes
        Route::get('products/getAll', [ProductsController::class, 'getAll']);
        Route::post('products/getWithFreelancers', [ProductsController::class, 'getWithFreelancers']);
        Route::post('products/create', [ProductsController::class, 'save']);
        Route::post('products/update', [ProductsController::class, 'update']);
        Route::post('products/destroy', [ProductsController::class, 'delete']);
        Route::post('products/getById', [ProductsController::class, 'getById']);
        Route::post('products/updateStatus', [ProductsController::class, 'updateStatus']);
        Route::post('products/updateOffers', [ProductsController::class, 'updateOffers']);
        Route::post('products/updateHome', [ProductsController::class, 'updateHome']);

        Route::post('products_reviews/getProductsReviews', [ProductReviewsController::class, 'getProductsReviews']);
        Route::post('products_reviews/save', [ProductReviewsController::class, 'save']);


        // Freelancer Service Routes
        Route::get('freelancer_services/getAll', [ServicesController::class, 'getAll']);
        Route::post('freelancer_services/create', [ServicesController::class, 'save']);
        Route::post('freelancer_services/update', [ServicesController::class, 'update']);
        Route::post('freelancer_services/destroy', [ServicesController::class, 'delete']);
        Route::post('freelancer_services/getById', [ServicesController::class, 'getByUID']);
        Route::post('freelancer_services/getServiceById', [ServicesController::class, 'getServiceById']);
        Route::post('freelancer_services/getMyServices', [ServicesController::class, 'getMyServices']);



         // Specialist Routes
         Route::get('specialist/getAll', [SpecialistController::class, 'getAll']);
         Route::post('specialist/create', [SpecialistController::class, 'save']);
         Route::post('specialist/update', [SpecialistController::class, 'update']);
         Route::post('specialist/destroy', [SpecialistController::class, 'delete']);
         Route::post('specialist/getById', [SpecialistController::class, 'getById']);
         Route::post('specialist/getBySalonID', [SpecialistController::class, 'getBySalonID']);


         // Packages Routes
         Route::get('packages/getAll', [PackagesController::class, 'getAll']);
         Route::post('packages/create', [PackagesController::class, 'save']);
         Route::post('packages/update', [PackagesController::class, 'update']);
         Route::post('packages/destroy', [PackagesController::class, 'delete']);
         Route::post('packages/getById', [PackagesController::class, 'getById']);
         Route::post('packages/getBySalonID', [PackagesController::class, 'getBySalonID']);
         Route::post('packages/getPackageById', [PackagesController::class, 'getPackageById']);

          // Admin Routes For Payments
        Route::post('payments/paytmRefund',[PaytmPayController::class, 'refundUserRequest']);
        Route::post('payments/paytmRefund',[PaytmPayController::class, 'refundUserRequest']);
        Route::post('payments/getById', [PaymentsController::class, 'getById']);
        Route::post('payments/getPaymentInfo', [PaymentsController::class, 'getPaymentInfo']);
        Route::get('payments/getAll', [PaymentsController::class, 'getAll']);
        Route::post('payments/update', [PaymentsController::class, 'update']);
        Route::post('payments/delete', [PaymentsController::class, 'delete']);
        Route::post('payments/refundFlutterwave', [PaymentsController::class, 'refundFlutterwave']);
        Route::post('payments/payPalRefund', [PaymentsController::class, 'payPalRefund']);
        Route::post('payments/refundPayStack',[PaymentsController::class, 'refundPayStack']);
        Route::post('payments/razorPayRefund',[PaymentsController::class, 'razorPayRefund']);
        Route::post('payments/refundStripePayments',[PaymentsController::class, 'refundStripePayments']);
        Route::post('payments/instaMOJORefund',[PaymentsController::class, 'instaMOJORefund']);

        // Payments Routes For Users
        Route::post('payments/createStripeToken', [PaymentsController::class, 'createStripeToken']);
        Route::post('payments/createCustomer', [PaymentsController::class, 'createCustomer']);
        Route::post('payments/getStripeCards', [PaymentsController::class, 'getStripeCards']);
        Route::post('payments/addStripeCards', [PaymentsController::class, 'addStripeCards']);
        Route::post('payments/createStripePayments', [PaymentsController::class, 'createStripePayments']);
        Route::get('getPayPalKey', [PaymentsController::class, 'getPayPalKey']);
        Route::get('getFlutterwaveKey', [PaymentsController::class, 'getFlutterwaveKey']);
        Route::get('getPaystackKey', [PaymentsController::class, 'getPaystackKey']);
        Route::get('getRazorPayKey', [PaymentsController::class, 'getRazorPayKey']);
        Route::get('payments/getPayments', [PaymentsController::class, 'getPayments']);

        Route::post('timeslots/getSlotsByForBookings', [TimeslotController::class, 'getSlotsByForBookings']);

        Route::post('specialist/getSpecialist', [SpecialistController::class, 'getBySalonID']);
        // appoinments Routes
        Route::get('appoinments/getAll', [AppointmentsController::class, 'getAll']);
        Route::get('appoinments/getAllSalonAppointments', [AppointmentsController::class, 'getAllSalonAppointments']);
        Route::get('appoinments/getAllFreelancerAppointments', [AppointmentsController::class, 'getAllFreelancerAppointments']);
        Route::post('appoinments/create', [AppointmentsController::class, 'save']);
        Route::post('appoinments/update', [AppointmentsController::class, 'update']);
        Route::post('appoinments/destroy', [AppointmentsController::class, 'delete']);
        Route::post('appoinments/getById', [AppointmentsController::class, 'getById']);
        Route::post('appoinments/getMyList', [AppointmentsController::class,'getMyList']);
        Route::post('appoinments/getInfo', [AppointmentsController::class,'getInfo']);
        Route::post('appoinments/getInfoAdmin', [AppointmentsController::class,'getInfoAdmin']);
        Route::post('appoinments/getInfoOwner', [AppointmentsController::class,'getInfoOwner']);
        Route::post('appoinments/getSalonList', [AppointmentsController::class,'getSalonList']);
        Route::post('appoinments/getIndividualList', [AppointmentsController::class,'getIndividualList']);

        Route::post('appointments/getStats',[AppointmentsController::class, 'getStats'] );
        Route::post('appointments/getMonthsStats',[AppointmentsController::class, 'getMonthsStats']);
        Route::post('appointments/getAllStats',[AppointmentsController::class, 'getAllStats']);

        Route::post('appointments/calendarView',[AppointmentsController::class, 'calendarView']);
        Route::post('appointments/getByDate',[AppointmentsController::class, 'getByDate']);

        Route::post('salon/getAppointmentsSalonStats', [AppointmentsController::class, 'getAppointmentsSalonStats']);
        Route::post('salon/getAppointmentsFreelancersStats', [AppointmentsController::class, 'getAppointmentsFreelancersStats']);

        Route::post('stats/getOrderStats', [ProductOrdersController::class, 'getOrderStats']);

        // Offers Routes //

        Route::get('offers/getAll', [OffersController::class, 'getAll']);
        Route::get('offers/getStores', [OffersController::class, 'getStores']);
        Route::post('offers/create', [OffersController::class, 'save']);
        Route::post('offers/update', [OffersController::class, 'update']);
        Route::post('offers/destroy', [OffersController::class, 'delete']);
        Route::post('offers/getById', [OffersController::class, 'getById']);
        Route::post('offers/updateStatus', [OffersController::class, 'updateStatus']);

        Route::get('offers/getActive', [OffersController::class, 'getActive']);

        // address routes Routes
        Route::post('address/save',[AddressController::class, 'save'] );
        Route::post('address/getById', [AddressController::class, 'getById']);
        Route::post('address/getByUID', [AddressController::class, 'getByUID']);
        Route::get('address/getAll', [AddressController::class, 'getAll']);
        Route::post('address/update', [AddressController::class, 'update']);
        Route::post('address/delete', [AddressController::class, 'delete']);

        // ProductsOrder Routes
        Route::post('product_order/save',[ProductOrdersController::class, 'save'] );
        Route::post('product_order/getById', [ProductOrdersController::class, 'getById']);
        Route::post('product_order/update', [ProductOrdersController::class, 'update']);
        Route::post('product_order/delete', [ProductOrdersController::class, 'delete']);
        Route::post('product_order/getFreelancerOrder', [ProductOrdersController::class, 'getFreelancerOrder']);
        Route::post('product_order/getOrderDetailsFromFreelancer', [ProductOrdersController::class, 'getOrderDetailsFromFreelancer']);
        Route::post('product_order/getByUID', [ProductOrdersController::class, 'getByUID']);
        Route::post('product_order/getInfo', [ProductOrdersController::class, 'getInfo']);
        Route::post('product_order/getInfoOwner', [ProductOrdersController::class, 'getInfoOwner']);
        Route::post('product_order/getInfoAdmin', [ProductOrdersController::class, 'getInfoAdmin']);
        Route::post('product_order/getIndividualOrders', [ProductOrdersController::class, 'getIndividualOrders']);
        Route::post('product_order/getSalonOrders', [ProductOrdersController::class, 'getSalonOrders']);
        Route::post('product_order/getStats',[ProductOrdersController::class, 'getStats'] );
        Route::post('product_order/getMonthsStats',[ProductOrdersController::class, 'getMonthsStats']);
        Route::post('product_order/getAllStats',[ProductOrdersController::class, 'getAllStats']);
        Route::get('product_order/getAllOrderAdmin',[ProductOrdersController::class, 'getAllOrderAdmin']);

        Route::post('owner_reviews/getOwnerReviews', [OwnerReviewsController::class, 'getOwnerReviews']);
        Route::post('owner_reviews/save', [OwnerReviewsController::class, 'save']);
        Route::post('owner_reviews/updateOwnerReviews', [OwnerReviewsController::class, 'updateOwnerReviews']);

        Route::post('service_reviews/getServiceReview', [ServiceReviewsController::class, 'getServiceReview']);
        Route::post('service_reviews/save', [ServiceReviewsController::class, 'save']);


        Route::post('packages_reviews/save', [PackagesReviewsController::class, 'save']);


        Route::get('contacts/getAll',[ContactsController::class, 'getAll'] );
        Route::post('contacts/update',[ContactsController::class, 'update'] );
        Route::post('mails/replyContactForm',[ContactsController::class, 'replyContactForm']);

        Route::get('settings/getById', [SettingsController::class, 'getById']);
        Route::post('setttings/update', [SettingsController::class, 'update']);
        Route::post('setttings/save', [SettingsController::class, 'save']);

        Route::get('users/admins', [AuthController::class, 'admins']);
        Route::post('users/deleteUser', [AuthController::class, 'delete']);
        Route::post('users/adminNewAdmin', [AuthController::class, 'adminNewAdmin']);
        Route::get('users/getAllUsers', [AuthController::class, 'getAllUsers']);

        Route::post('notification/sendToAllUsers', [AuthController::class, 'sendToAllUsers']);
        Route::post('notification/sendToUsers', [AuthController::class, 'sendToUsers']);
        Route::post('notification/sendToStores', [AuthController::class, 'sendToStores']);
        Route::post('notification/sendToSalon', [AuthController::class, 'sendToSalon']);
        Route::post('notification/sendNotification', [AuthController::class, 'sendNotification']);

        Route::get('freelancer/getAdminHome', [AuthController::class, 'getAdminHome']);

        Route::post('users/sendMailToUsers', [AuthController::class, 'sendMailToUsers']);
        Route::post('users/sendMailToAll', [AuthController::class, 'sendMailToAll']);
        Route::post('users/sendMailToSalon', [AuthController::class, 'sendMailToSalon']);
        Route::post('users/sendMailToStores', [AuthController::class, 'sendMailToStores']);

        Route::post('profile/getMyWalletBalance', [AuthController::class,'getMyWalletBalance']);
        Route::post('profile/getMyWallet', [AuthController::class,'getMyWallet']);

        Route::post('commission/save', [CommissionController::class, 'save']);

        Route::post('password/updateUserPasswordWithEmail', [AuthController::class, 'updateUserPasswordWithEmail']);

        Route::post('chats/getChatRooms', [ChatRoomsController::class, 'getChatRooms']);
        Route::post('chats/createChatRooms', [ChatRoomsController::class, 'createChatRooms']);
        Route::post('chats/getChatListBUid', [ChatRoomsController::class, 'getChatListBUid']);
        Route::post('chats/getById', [ConversionsController::class, 'getById']);
        Route::post('chats/sendMessage', [ConversionsController::class, 'save']);

        // Complaints Routes
        Route::get('complaints/getAll',[ComplaintsController::class, 'getAll'] );
        Route::post('complaints/update',[ComplaintsController::class, 'update'] );
        Route::post('complaints/replyContactForm',[ComplaintsController::class, 'replyContactForm']);
        Route::post('complaints/registerNewComplaints', [ComplaintsController::class, 'save']);

        Route::get('request/getSalonRequest',[RegisterRequestController::class, 'getSalonRequest'] );
        Route::get('request/getIndividualRequest',[RegisterRequestController::class, 'getIndividualRequest'] );
        Route::post('request/delete', [RegisterRequestController::class, 'delete']);
    });


    Route::post('freelancer_services/getFreelancerServices', [ServicesController::class, 'getMyServices']);
    Route::post('freelancer_services/getInfo', [ServicesController::class, 'getServiceById']);

    Route::post('salon/getHomeData', [SalonController::class, 'getHomeData']);
    Route::post('salon/getHomeDataWeb', [SalonController::class, 'getHomeDataWeb']);
    Route::post('salon/getSearchResult', [SalonController::class, 'getSearchResult']);
    Route::post('salon/getDataFromCategory', [SalonController::class, 'getDataFromCategory']);
    Route::post('salon/getDataFromCategoryWeb', [SalonController::class, 'getDataFromCategoryWeb']);
    Route::post('salon/getTopFreelancer', [SalonController::class, 'getTopFreelancer']);
    Route::post('salon/getTopSalon', [SalonController::class, 'getTopSalon']);
    Route::get('category/getAllCategories', [CategoryController::class, 'getActiveItem']);
    Route::post('specialist/getActiveSpecialist', [SpecialistController::class, 'getActiveSpecialist']);
    Route::post('salon/salonDetails', [SalonController::class, 'salonDetails']);
    Route::post('freelancer_services/getByCategoryId', [ServicesController::class, 'getByCategoryId']);
    Route::post('packages/getPackageDetails', [PackagesController::class, 'getPackageById']);

    Route::get('success_payments',[PaymentsController::class, 'success_payments']);
    Route::get('failed_payments',[PaymentsController::class, 'failed_payments']);
    Route::get('instaMOJOWebSuccess',[PaymentsController::class, 'instaMOJOWebSuccess']);
    Route::get('instaMOJOWebSuccessAppointments',[PaymentsController::class, 'instaMOJOWebSuccessAppointments']);
    Route::get('payments/payPalPay', [PaymentsController::class, 'payPalPay']);
    Route::get('payments/razorPay', [PaymentsController::class, 'razorPay']);
    Route::get('payments/VerifyRazorPurchase', [PaymentsController::class, 'VerifyRazorPurchase']);
    Route::post('payments/capureRazorPay', [PaymentsController::class, 'capureRazorPay']);
    Route::post('payments/instamojoPay', [PaymentsController::class, 'instamojoPay']);
    Route::get('payments/flutterwavePay', [PaymentsController::class, 'flutterwavePay']);
    Route::get('payments/paystackPay', [PaymentsController::class, 'paystackPay']);
    Route::get('payments/payKunPay', [PaymentsController::class, 'payKunPay']);

    // Payments Routes For User Public
    Route::get('payNow',[PaytmPayController::class, 'payNow']);
    Route::get('payNowWeb',[PaytmPayController::class, 'payNowWeb']);
    Route::get('payProductWeb',[PaytmPayController::class, 'payProductWeb']);
    Route::post('paytm-callback',[PaytmPayController::class, 'paytmCallback']);
    Route::post('paytm-webCallback',[PaytmPayController::class, 'webCallback']);
    Route::post('paytm-webCallbackProduct',[PaytmPayController::class, 'webCallbackProduct']);
    Route::get('refundUserRequest',[PaytmPayController::class, 'refundUserRequest']);
    Route::get('settings/getDefault', [SettingsController::class, 'getDefault']);

    Route::post('individual/individualDetails', [IndividualController::class, 'individualDetails']);
    Route::get('product_categories/getHome', [ProductCategoryController::class, 'getHome']);
    Route::post('products/getProducts', [ProductsController::class, 'getProducts']);
    Route::post('products/getFreelancerProducts', [ProductsController::class, 'getFreelancerProducts']);
    Route::post('products/getProductInfo', [ProductsController::class, 'getById']);
    Route::post('profile/getOwnerInfo', [AuthController::class,'getOwnerInfo']);
    Route::post('freelancer/getByUID', [AuthController::class,'getInfoForProductCart']);

    Route::post('products/topProducts', [ProductsController::class, 'topProducts']);

    Route::get('blogs/getTop', [BlogsController::class, 'getTop']);
    Route::get('blogs/getPublic', [BlogsController::class, 'getPublic']);
    Route::post('blogs/getDetails', [BlogsController::class, 'getById']);
    Route::post('pages/getContent', [PagesController::class, 'getById']);

    Route::post('contacts/create',[ContactsController::class, 'save'] );
    Route::post('sendMailToAdmin',[ContactsController::class, 'sendMailToAdmin']);
    Route::get('success_verified',[AuthController::class, 'success_verified']);
    Route::post('sendVerificationOnMail', [AuthController::class, 'sendVerificationOnMail']);
    Route::post('otp/verifyOTP',[OtpController::class, 'verifyOTP'] );
    Route::post('otp/verifyOTPReset',[OtpController::class, 'verifyOTPReset'] );

    Route::post('auth/verifyPhoneForFirebaseRegistrations', [AuthController::class, 'verifyPhoneForFirebaseRegistrations']);
    Route::post('verifyPhoneSignup', [AuthController::class, 'verifyPhoneSignup']);

    Route::get('appointments/printInvoice', [AppointmentsController::class, 'printInvoice']);
    Route::get('appointments/orderInvoice', [AppointmentsController::class, 'orderInvoice']);

    Route::get('product_order/printInvoice', [ProductOrdersController::class, 'printInvoice']);
    Route::get('product_order/orderInvoice', [ProductOrdersController::class, 'orderInvoice']);

    Route::post('owner_reviews/getMyReviews', [OwnerReviewsController::class, 'getMyReviews']);
    Route::post('product_reviews/getMyReviews', [ProductReviewsController::class, 'getMyReviews']);

    Route::get('cities/getActiveCities', [CitiesController::class, 'getActiveCities']);
    Route::get('category/getPublic', [CategoryController::class, 'getActiveItem']);

    Route::post('auth/verifyEmail', [AuthController::class, 'verifyEmail']);
    Route::post('auth/verifyPhone', [AuthController::class, 'verifyPhone']);
    Route::post('auth/checkPhoneExist', [AuthController::class, 'checkPhoneExist']);

    Route::post('register_request/save', [RegisterRequestController::class, 'save']);

});
