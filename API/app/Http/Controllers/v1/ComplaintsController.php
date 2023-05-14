<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Complaints;
use App\Models\User;
use App\Models\Settings;
use App\Models\Products;
use Illuminate\Support\Facades\Mail;
use App\Models\Salon;
use App\Models\Individual;
use App\Models\Services;
use App\Models\Packages;
use Validator;
use DB;

class ComplaintsController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'uid' => 'required',
            'order_id' => 'required',
            'appointment_id' => 'required',
            'complaints_on' => 'required',
            'issue_with' => 'required',
            'reason_id' => 'required',
            'title' => 'required',
            'short_message' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Complaints::create($request->all());
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

        $data = Complaints::find($request->id);

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
        $data = Complaints::find($request->id)->update($request->all());

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
        $data = Complaints::find($request->id);
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
        $data = Complaints::orderBy('id','desc')->get();
        foreach($data as $loop){
            $user = User::select('email','first_name','last_name','cover')->where('id',$loop->uid)->first();
            $loop->userInfo = $user;
            if($loop && $loop->freelancer_id && $loop->freelancer_id !=null){
                $owner = User::select('type')->where('id',$loop->freelancer_id)->first();
                if($owner == 'salon'){
                    $store = Salon::select('name','cover')->where('uid',$loop->freelancer_id)->first();
                }else{
                    $store = User::select(DB::raw('CONCAT(last_name, first_name) AS name'),'cover')->where('id',$loop->freelancer_id)->first();
                }
                $storeUser = User::select('email','cover')->where('id',$loop->freelancer_id)->first();
                $loop->storeInfo = $store;
                $loop->storeUiserInfo = $storeUser;
            }

            if($loop && $loop->driver_id && $loop->driver_id !=null){
                $driver = User::select('email','first_name','last_name','cover')->where('id',$loop->driver_id)->first();
                $loop->driverInfo = $driver;
            }

            if($loop && $loop->product_id && $loop->product_id !=null){
                $product = Products::select('name','cover')->where('id',$loop->product_id)->first();
                $loop->productInfo = $product;
            }

            if($loop && $loop->complaints_on == 0 && $loop->product_id && $loop->product_id !=null){
                $product = Services::select('name','cover')->where('id',$loop->product_id)->first();
                $loop->productInfo = $product;
            }

            if($loop && $loop->complaints_on == 0 && $loop->product_id && $loop->product_id !=null){
                $product = Packages::select('name','cover')->where('id',$loop->product_id)->first();
                $loop->productInfo = $product;
            }

        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function replyContactForm(Request $request){

        try {
            $validator = Validator::make($request->all(), [
                'mediaURL' => 'required',
                'subject' => 'required',
                'thank_you_text' => 'required',
                'header_text' => 'required',
                'email' =>'required',
                'from_username' =>'required',
                'to_respond'=>'required',
                'id'=>'required'
            ]);
            if ($validator->fails()) {
                $response = [
                    'success' => false,
                    'message' => 'Validation Error.', $validator->errors(),
                    'status'=> 500
                ];
                return response()->json($response, 404);
            }
            $mail = $request->email;
            $username = $request->from_username;
            $subject = $request->subject;
            $generalInfo = Settings::take(1)->first();
            $toMail = $request->from_mail;
            $mailTo = Mail::send('mails/respond',
             [
                'app_name'      =>$generalInfo->name,
                'respond'        =>$request->to_respond
             ]
             , function($message) use($mail,$username,$subject,$generalInfo){
                $message->to($mail, $username)
                ->subject($subject);
                $message->from($generalInfo->email,$generalInfo->name);
            });
            $response = [
                'success' => $mailTo,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
    }
}
