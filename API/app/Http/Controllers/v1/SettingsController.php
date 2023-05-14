<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Settings;
use App\Models\User;
use Validator;
use DB;

class SettingsController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'mobile' => 'required',
            'email' => 'required',
            'address' => 'required',
            'city' => 'required',
            'state' => 'required',
            'country' => 'required',
            'zip'  =>'required',
            'tax' => 'required',
            'delivery_type' => 'required',
            'delivery_charge' => 'required',
            'currencySymbol' => 'required',
            'currencySide' => 'required',
            'currencyCode' => 'required',
            'appDirection' => 'required',
            'logo' => 'required',
            'sms_name' => 'required',
            'sms_creds' => 'required',
            'have_shop' => 'required',
            'findType' => 'required',
            'reset_pwd' => 'required',
            'user_login' => 'required',
            'freelancer_login' => 'required',
            'user_verify_with' => 'required',
            'search_radius' => 'required',
            'country_modal' => 'required',
            'default_country_code' => 'required',
            'default_city_id' => 'required',
            'default_delivery_zip' => 'required',
            'social' => 'required',
            'app_color' => 'required',
            'app_status' => 'required',
            'fcm_token' => 'required',
            'status' => 'required',
            'allowDistance' => 'required',
            'searchResultKind' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Settings::create($request->all());
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
        $data = Settings::first();
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
        $data = Settings::find($request->id)->update($request->all());

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
        $data = Settings::find($request->id);
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
        $data = Settings::all();
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

    public function getDefaultSettings(){
        $settings = Settings::take(1)->first();

        $response = [
            'data'=>$settings,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getDefault(Request $request){
        $settings = Settings::first();
        $support = User::select('id','first_name','last_name')->where('type','admin')->first();
        $data = [
            'settings'=>$settings,
            'support'=>$support,
        ];

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getAppSettingsByLanguageId(Request $request){
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
        $settings = Settings::take(1)->first();
        $response = [
            'data'=>$settings,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getSettingsForOwner(){
        $data = DB::table('settings')
        ->select('*')->get();
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
}
