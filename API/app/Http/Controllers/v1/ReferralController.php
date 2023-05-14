<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Referral;
use App\Models\Redeem;
use App\Models\ReferralCodes;
use App\Models\User;
use Validator;

class ReferralController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
            'title' => 'required',
            'message' => 'required',
            'limit' => 'required',
            'who_received' => 'required',
            'status' => 'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Referral::create($request->all());
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

        $data = Referral::find($request->id);

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
        $data = Referral::find($request->id)->update($request->all());

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
        $data = Referral::find($request->id);
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
        $data = Referral::all();
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

    public function redeemReferral(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'code' => 'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = ReferralCodes::where('code',$request->code)->first();
        if ($data) {
            $haveRedeemed = Redeem::where(['owner'=>$data->uid,'code'=>$request->code,'redeemer'=>$request->id])->first();
            if($haveRedeemed){
                $response = [
                    'success' => false,
                    'message' => 'Already Redeemed',
                    'status' => 404
                ];
                return response()->json($response, 404);
            }
            $redeemCount = Redeem::where(['owner'=>$data->uid,'code'=>$request->code])->count();
            $scheme = Referral::first();
            if($scheme && $redeemCount <= $scheme->limit){

                if($scheme->who_received == 1){ // inviter
                    $inviter = User::where('id',$data->uid)->first();
                    $inviter->deposit($scheme->amount);
                }else if($scheme->who_received == 2) { // Who Redeem
                    $redeemer = User::where('id',$request->id)->first();
                    $redeemer->deposit($scheme->amount);
                }else { // both
                    $inviter = User::where('id',$data->uid)->first();
                    $inviter->deposit($scheme->amount);
                    $redeemer = User::where('id',$request->id)->first();
                    $redeemer->deposit($scheme->amount);
                }
                $redeemReferralCode = Redeem::create([
                    'owner'=>$data->uid,
                    'code'=>$request->code,
                    'redeemer'=>$request->id
                ]);

                if($redeemReferralCode){
                    $response = [
                        'data'=>$scheme,
                        // 'scheme'=>$scheme,
                        // 'redeemCount'=>$redeemCount,
                        // 'redeemReferralCode'=>$redeemReferralCode,
                        'success' => true,
                        'status' => 200,
                    ];
                    return response()->json($response, 200);
                }
                $response = [
                    'success' => false,
                    'message' => 'Something went wrong',
                    'status'=> 200
                ];
                return response()->json($response, 200);

            }
            $response = [
                'success' => false,
                'message' => 'Referral limit ended!',
                'status' => 200
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Referral code not found',
            'status' => 200
        ];
        return response()->json($response, 200);
    }
}
