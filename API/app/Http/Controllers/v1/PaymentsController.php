<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Payments;
use App\Models\Orders;
use App\Models\Appointments;
use App\Models\ProductOrders;
use Validator;
use Stripe;
use DB;

class PaymentsController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'env' => 'required',
            'creds' => 'required',
            'status' => 'required',
            'cover' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Payments::create($request->all());
        if (is_null($data)) {
            $response = [
            'data'=>$data,
            'message' => 'error',
            'status' => 500,
        ];
        return response()->json($response, 200);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getPaymentInfo(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = DB::table('payments')
        ->select('*')->where('id',$request->id)->first();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getById(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Payments::find($request->id);

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Payments::find($request->id)->update($request->all());

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function delete(Request $request){
     $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Payments::find($request->id);
        if ($data) {
            $data->delete();
            $response = [
                'data'=>$data,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Data not found.',
            'status' => 404
        ];
        return response()->json($response, 404);
    }

    public function getAll(){
        $data = Payments::all();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getPayments(){
        $data = Payments::where('status',1)->get();
        if ($data) {
            $response = [
                'data'=>$data,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Data not found.',
            'status' => 404
        ];
        return response()->json($response, 404);
    }

    public function getPayPalKey(){
        $payCreds = DB::table('payments')
        ->select('*')->where('id',3)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->client_id)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $clientId = $credsData->client_id;
        // $secret = $credsData->client_secret;
        $response = [
            'data'=>$clientId,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getFlutterwaveKey(){
        $payCreds = DB::table('payments')
        ->select('*')->where('id',8)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $clientId = $credsData->key;
        // $secret = $credsData->secret;
        $response = [
            'data'=>$clientId,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getPaystackKey(){
        $payCreds = DB::table('payments')
        ->select('*')->where('id',7)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->sk)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $pk = $credsData->pk;
        $sk = $credsData->sk;
        $response = [
            'data'=>$pk,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getRazorPayKey(){
        $payCreds = DB::table('payments')
        ->select('*')->where('id',5)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $razorKey = $credsData->key;
        $razorSecret = $credsData->secret;
        $response = [
            'data'=>$razorKey,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function createStripeToken(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'email' => 'required',
                'number' => 'required',
                'exp_month' => 'required',
                'exp_year' => 'required',
                'cvc' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',2)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->secret)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $stripe = new \Stripe\StripeClient(
                $credsData->secret
            );
            $data = $stripe->tokens->create([
                'card' => [
                    'number' => $request->number,
                    'exp_month' => $request->exp_month,
                    'exp_year' => $request->exp_year,
                    'cvc' => $request->cvc,
                ],
            ]);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return response()->json($response, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }

    }

    public function createCustomer(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'email' => 'required',
                'source' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',2)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->secret)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $stripe = new \Stripe\StripeClient(
                $credsData->secret
            );
            $data = $stripe->customers->create([
                'description' => 'Foodies-Dining Customer',
                'email'=>$request->email,
                'source'=>$request->source
              ]);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return response()->json($response, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function getStripeCards(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',2)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->secret)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $stripe = new \Stripe\StripeClient(
                $credsData->secret
            );
            $data = $stripe->customers->allSources(
                $request->id,
                ['object' => 'card', 'limit' => 100]
              );
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return response()->json($response, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function addStripeCards(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required',
                'token'=>'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',2)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->secret)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $stripe = new \Stripe\StripeClient(
                $credsData->secret
            );
            $data = $stripe->customers->createSource(
                $request->id,
                ['source' => $request->token]
              );
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return response()->json($response, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function createStripePayments(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'amount' => 'required',
                'currency'=>'required',
                'customer'=>'required',
                'card'=>'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',2)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->secret)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $stripe = new \Stripe\StripeClient(
                $credsData->secret
            );
            $data = $stripe->charges->create([
                'amount' => $request->amount,
                'currency' => $request->currency,
                'source' => $request->card,
                'customer' => $request->customer,
                'description' => 'Foodie Order',
              ]);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return response()->json($response, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function refundStripePayments(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'charge_id' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',2)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->secret)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $stripe = new \Stripe\StripeClient(
                $credsData->secret
            );
            $data = $stripe->refunds->create([
                'charge' => $request->charge_id,
              ]);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return response()->json($response, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function success_payments(){
        return view('payments/success');;
    }

    public function instaMOJOWebSuccess(Request $request){
        // return json_encode($request->all());
        //
        $data = ProductOrders::find($request->id)->update(['status'=>0,'pay_key'=>json_encode($request->all())]);
        if (is_null($data)) {
            return redirect(url('/api/v1/failed_payments?id='.$request['payment_id']));
        }
        return view('payments/instamojoWeb');
    }

    public function instaMOJOWebSuccessAppointments(Request $request){
        $data = Appointments::find($request->id)->update(['status'=>0,'paid'=>json_encode($request->all())]);
        if (is_null($data)) {
            return redirect(url('/api/v1/failed_payments?id='.$request['payment_id']));
        }
        return view('payments/instamojoWeb');
    }

    public function failed_payments(){
        return view('payments/failed');
    }

    public function payPalPay(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
        ->select('*')->where('id',3)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->client_id)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $clientId = $credsData->client_id;
        $url = url('/api/v1/success_payments');
        return view('payments/paypal',['amount'=>$request->amount,'url'=>$url,'client_id'=>$clientId]);
    }

    public function razorPay(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
            'name'=>'required',
            'logo'=>'required',
            'email'=>'required',
            'app_color'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
            ->select('*')->where('id',5)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $razorKey = $credsData->key;
            $razorSecret = $credsData->secret;
        $url = url('/api/v1/success_payments');
        return view('payments/razorpay',['key'=>$razorKey,'amount'=>$request->amount,'url'=>$url,'name'=>$request->name,'logo'=>$request->logo,'email'=>$request->email,'app_color'=>$request->app_color]);
    }

    public function flutterwavePay(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
            'name'=>'required',
            'logo'=>'required',
            'email'=>'required',
            'app_name'=>'required',
            'code'=>'required',
            'phone'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
        ->select('*')->where('id',8)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $clientId = $credsData->key;
        $successURL = url('/api/v1/success_payments');
        $errorCallBack = url('/api/v1/failed_payments');
        return view('payments/flutterwave',
        ['key'=>$clientId,'amount'=>$request->amount,'code'=>$request->code,'callback'=>$successURL,'errorCallBack'=>$errorCallBack,'name'=>$request->name,'logo'=>$request->logo,'phone'=>$request->phone,'email'=>$request->email,'app_name'=>$request->app_name]);
    }

    public function paystackPay(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
            'first_name'=>'required',
            'last_name'=>'required',
            'email'=>'required',
            'ref'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
        ->select('*')->where('id',7)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->sk)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $pk = $credsData->pk;
        $sk = $credsData->sk;
        $successURL = url('/api/v1/success_payments');
        $errorCallBack = url('/api/v1/failed_payments');
        return view('payments/paystack',
        ['key'=>$pk,'ref'=>$request->ref,'amount'=>$request->amount,'sucessCallBack'=>$successURL,'errorCallBack'=>$errorCallBack,'first_name'=>$request->first_name,'last_name'=>$request->last_name,'email'=>$request->email]);
    }

    public function payKunPay(){
        return view('payments/paykun');
    }

    public function VerifyRazorPurchase(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',5)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $razorKey = $credsData->key;
            $razorSecret = $credsData->secret;
            $client = new \GuzzleHttp\Client();
            $res = $client->get('https://api.razorpay.com/v1/payments/'.$request->id, ['auth' =>  [$razorKey, $razorSecret]]);
            $data = json_decode($res->getBody()->getContents());
            $bodyArray = [
                'amount'=>$data->amount,
                'currency'=> $data->currency
            ];

            $response = $client->request('POST', 'https://api.razorpay.com/v1/payments/'.$request->id.'/capture', [
                'headers' =>
                    [
                        'Accept' => 'application/json',
                        // 'Accept-Language' => 'en_US',
                        'Content-Type' => 'application/json',
                    ],
                'body' => json_encode($bodyArray),
                'auth' => [$razorKey, $razorSecret, 'basic']
                ]
            );
            $captureResponse = json_decode($response->getBody()->getContents());
            $response = [
                'success' => $captureResponse,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }

    }

    public function capureRazorPay(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required',
                'currency'=>'required',
                'amount'=>'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',5)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $razorKey = $credsData->key;
            $razorSecret = $credsData->secret;
            $client = new \GuzzleHttp\Client();

            $bodyArray = [
                'amount'=>$request->amount,
                'currency'=> $request->currency
            ];

            $response = $client->request('POST', 'https://api.razorpay.com/v1/payments/'.$request->id.'/capture', [
                'headers' =>
                    [
                        'Accept' => 'application/json',
                        // 'Accept-Language' => 'en_US',
                        'Content-Type' => 'application/json',
                    ],
                'body' => json_encode($bodyArray),
                'auth' => [$razorKey, $razorSecret, 'basic']
                ]
            );
            $data = json_decode($response->getBody(), true);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function instamojoPay(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'amount' => 'required',
                'buyer_name' => 'required',
                'purpose' => 'required',
                'redirect_url' => 'required',
                'phone' => 'required',
                'webhook' => 'required',
                'email' => 'required',
                'allow_repeated_payments' => 'required',
                'send_email' => 'required',
                'send_sms' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',6)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $instaMode = $credsData->env;
            $instaKey = $credsData->key;
            $instaToken = $credsData->token;
            $url;
            if($instaMode ==='TEST'){
                $url = 'https://test.instamojo.com/api/1.1/payment-requests/';
            }else{
                $url = 'https://www.instamojo.com/api/1.1/payment-requests/';
            }
            $paramList = [
                'amount' => $request->amount,
                'buyer_name' => $request->buyer_name,
                'purpose' => $request->purpose,
                'redirect_url' => $request->redirect_url,
                'phone' => $request->phone,
                'webhook' => $request->webhook,
                'email' => $request->email,
                'allow_repeated_payments' => $request->allow_repeated_payments,
                'send_email' => $request->send_email,
                'send_sms' => $request->send_sms,
            ];
            $client = new \GuzzleHttp\Client();

            $res = $client->request('POST', $url, [
                'headers'        => ['X-Api-Key'=>$instaKey,'X-Auth-Token'=>$instaToken],
                'form_params'   =>$paramList
            ]);
            $data = json_decode($res->getBody()->getContents());
             $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function instaMOJORefund(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required',
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',6)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $instaMode = $credsData->env;
            $instaKey = $credsData->key;
            $instaToken = $credsData->token;
            $url;
            if($instaMode ==='TEST'){
                $url = 'https://test.instamojo.com/api/1.1/refunds/';
            }else{
                $url = 'https://www.instamojo.com/api/1.1/refunds/';
            }

            $paramList = [
                'payment_id' => $request->id,
                'type'=>'QFL',
                'body'=>'Refund & Reject Foodies order'
            ];
            $client = new \GuzzleHttp\Client();

            $res = $client->request('POST', $url, [
                'headers'        => ['X-Api-Key'=>$instaKey,'X-Auth-Token'=>$instaToken],
                'form_params'   =>$paramList,
            ]);
            $data = json_decode($res->getBody()->getContents());
             $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }


    public function refundFlutterwave(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'ref' => 'required',
                'amount'=>'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',8)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $clientId = $credsData->key;
            $secret = $credsData->secret;
            $client = new \GuzzleHttp\Client();
            $headers = [
                'Authorization' => 'Bearer ' . $secret,
                'Accept'        => 'application/json',
            ];
            $res = $client->post('https://api.flutterwave.com/v3/transactions/'.$request->ref.'refund',[
                'headers'=>$headers
            ]);
            $data = json_decode($res->getBody()->getContents());

            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function payPalRefund(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'ref' => 'required',
                'amount'=>'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $uri = 'https://api.sandbox.paypal.com/v1/oauth2/token';
            $payCreds = DB::table('payments')
            ->select('*')->where('id',3)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->client_id)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $clientId = $credsData->client_id;
            $secret = $credsData->client_secret;

            $client = new \GuzzleHttp\Client();
            $response = $client->request('POST', $uri, [
                    'headers' =>
                        [
                            'Accept' => 'application/json',
                            'Accept-Language' => 'en_US',
                            'Content-Type' => 'application/x-www-form-urlencoded',
                        ],
                    'body' => 'grant_type=client_credentials',

                    'auth' => [$clientId, $secret, 'basic']
                ]
            );

            $data = json_decode($response->getBody(), true);

            $access_token = $data['access_token'];
            $paymentResponse = $client->request('POST', 'https://api-m.sandbox.paypal.com/v1/payments/sale/'.$request->ref.'/refund', [
                'headers' => array(
                    'Content-Type' => 'application/json',
                    'Authorization' => "Bearer $access_token",
                ),
                // 'body' => $jsonBody
            ]);


            $paymentExecutionBody = json_decode($paymentResponse->getBody()->getContents());
            // return $paymentExecutionBody;
            $response = [
                'success' => $paymentExecutionBody,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }

    public function refundPayStack(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',7)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->sk)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $pk = $credsData->pk;
            $sk = $credsData->sk;
            $client = new \GuzzleHttp\Client();
            $bodyRAW = array();
            $bodyRAW["transaction"] = $request->id;
            $response = $client->request('POST', 'https://api.paystack.co/refund', [
                    'headers' => array(
                        'Content-Type' => 'application/json',
                        'Authorization' => "Bearer ".$sk,
                    ),
                    'body' => json_encode($bodyRAW),
                ]
            );

            $data = json_decode($response->getBody(), true);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }

    }


    public function razorPayRefund(Request $request){
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $payCreds = DB::table('payments')
            ->select('*')->where('id',5)->first();
            if (is_null($payCreds) || is_null($payCreds->creds)) {
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->creds);
            if(is_null($credsData) || is_null($credsData->key)){
                $response = [
                    'success' => false,
                    'message' => 'Payment issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $razorKey = $credsData->key;
            $razorSecret = $credsData->secret;

            $client = new \GuzzleHttp\Client();
            $response = $client->request('POST', 'https://api.razorpay.com/v1/payments/'.$request->id.'/refund', [
                    'headers' =>
                        [
                            'Accept' => 'application/json',
                            'Accept-Language' => 'en_US',
                            'Content-Type' => 'application/x-www-form-urlencoded',
                        ],
                    'auth' => [$razorKey, $razorSecret, 'basic']
                ]
            );

            $data = json_decode($response->getBody(), true);
            $response = [
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }

    }
}
