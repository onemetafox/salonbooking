<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Otp;
use Validator;
use App\Models\User;
use App\Models\Settings;
use Carbon\Carbon;
use JWTAuth;
use DB;

class OtpController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'otp' => 'required',
            'email' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Otp::create([
            'otp'=>$request->otp,
            'email'=>$request->key,
            'status'=>0,
        ]);

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

        $data = Otp::find($request->id);

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
        $data = Otp::find($request->id)->update($request->all());

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
        $data = Otp::find($request->id);
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

    public function verifyOTP(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'otp'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $match =  ['otp'=>$request->otp,'id'=>$request->id,'status'=>0];
        $data = Otp::where($match)->first();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $data->update(['status'=>1]);

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function sendMsg91(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile' => 'required',
            'otp' =>'required',
            'message' =>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('settings')
        ->select('*')->first();
        if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
            $response = [
                'success' => false,
                'message' => 'sms gateway issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->sms_creds);
        if(is_null($credsData) || is_null($credsData->msg) || is_null($credsData->msg->key)){
            $response = [
                'success' => false,
                'message' => 'sms gateway issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $clientId = $credsData->msg->key;
        $smsSender = $credsData->msg->sender;
        $client = new \GuzzleHttp\Client();
        $res = $client->get('http://api.msg91.com/api/sendotp.php?authkey='.$clientId.'&message='.$request->message.'&mobile='.$request->mobile.'&sender='.$smsSender.'&otp='.$request->otp);
        $data = json_decode($res->getBody()->getContents());
        $response = [
            'data' => $data,
            'message' => 'success',
            'status' => 200
        ];
        return $response;
    }

    public function sendTwillo(Request $request){
        $validator = Validator::make($request->all(), [
            'mobile' => 'required',
            'otp' =>'required',
            'message' =>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
    }

    public function verifyPhone(Request $request){
        $validator = Validator::make($request->all(), [
            'country_code'=>'required',
            'mobile'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data= User::where($matchThese)->first();
        if (is_null($data)) {
            return response()->json(['error' => 'User not found.'], 500);
        }

        $settings = Settings::take(1)->first();
        if($settings->sms_name =='0'){ // send with twillo
            $payCreds = DB::table('settings')
            ->select('*')->first();
            if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
                $response = [
                    'success' => false,
                    'message' => 'sms gateway issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->sms_creds);
            if(is_null($credsData) || is_null($credsData->twilloCreds) || is_null($credsData->twilloCreds->sid)){
                $response = [
                    'success' => false,
                    'message' => 'sms gateway issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }

            $id = $credsData->twilloCreds->sid;
            $token = $credsData->twilloCreds->token;
            $url = "https://api.twilio.com/2010-04-01/Accounts/$id/Messages.json";
            $from = $credsData->twilloCreds->from;
            $to = $request->country_code.$request->mobile; // twilio trial verified number
            try{
                $otp = random_int(100000, 999999);
                $client = new \GuzzleHttp\Client();
                $response = $client->request('POST', $url, [
                    'headers' =>
                    [
                        'Accept' => 'application/json',
                        'Content-Type' => 'application/x-www-form-urlencoded',
                    ],
                    'form_params' => [
                    'Body' => 'Your Verification code is : '.$otp, //set message body
                    'To' => $to,
                    'From' => $from //we get this number from twilio
                    ],
                    'auth' => [$id, $token, 'basic']
                    ]
                );
                $savedOTP = Otp::create([
                    'otp'=>$otp,
                    'email'=>$to,
                    'status'=>0,
                ]);
                $response = [
                    'data'=>true,
                    'otp_id'=>$savedOTP->id,
                    'success' => true,
                    'status' => 200,
                ];
                return response()->json($response, 200);
            }catch (Exception $e){
                echo "Error: " . $e->getMessage();
            }

        }else{ // send with msg91
            $payCreds = DB::table('settings')
            ->select('*')->first();
            if (is_null($payCreds) || is_null($payCreds->sms_creds)) {
                $response = [
                    'success' => false,
                    'message' => 'sms gateway issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $credsData = json_decode($payCreds->sms_creds);
            if(is_null($credsData) || is_null($credsData->msg) || is_null($credsData->msg->key)){
                $response = [
                    'success' => false,
                    'message' => 'sms gateway issue please contact administrator',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $clientId = $credsData->msg->key;
            $smsSender = $credsData->msg->sender;
            $otp = random_int(100000, 999999);
            $client = new \GuzzleHttp\Client();
            $to = $request->country_code.$request->mobile;
            $res = $client->get('http://api.msg91.com/api/sendotp.php?authkey='.$clientId.'&message=Your Verification code is : '.$otp.'&mobile='.$to.'&sender='.$smsSender.'&otp='.$otp);
            $data = json_decode($res->getBody()->getContents());
            $savedOTP = Otp::create([
                'otp'=>$otp,
                'email'=>$to,
                'status'=>0,
            ]);
            $response = [
                'data'=>true,
                'otp_id'=>$savedOTP->id,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
    }

    public function getTestSMSId(Request $request){
        $validator = Validator::make($request->all(), [
            'country_code'=>'required',
            'mobile'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $matchThese = ['country_code' => $request->country_code, 'mobile' => $request->mobile];
        $data= User::where($matchThese)->first();
        if (is_null($data)) {
            return response()->json(['error' => 'User not found.'], 500);
        }
        $otp = random_int(100000, 999999);
        $to = $request->country_code.$request->mobile;
        $savedOTP = Otp::create([
            'otp'=>$otp,
            'email'=>$to,
            'status'=>0,
        ]);
        $response = [
            'data'=>true,
            'otp_id'=>$savedOTP->id,
            'otp'=>$savedOTP->otp,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function verifyOTPReset(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'otp'=>'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $match =  ['otp'=>$request->otp,'id'=>$request->id,'status'=>0];
        $data = Otp::where($match)->first();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $data->update(['status'=>1]);
        $token = '';

        $user = User::where('email',$request->email)->first();
        try {
            JWTAuth::factory()->setTTL(10); // Expired Time 28days

        if (! $token = JWTAuth::fromUser($user, ['exp' => Carbon::now()->addMinutes(5)->timestamp])) {

            return response()->json(['error' => 'invalid_credentials'], 401);

        }
        } catch (JWTException $e) {
            return response()->json(['error' => 'could_not_create_token'], 500);
        }



        $response = [
            'data'=>$data,
            'temp'=>$token,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
