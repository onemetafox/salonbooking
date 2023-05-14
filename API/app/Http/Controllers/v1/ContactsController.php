<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Contacts;
use Illuminate\Support\Facades\Mail;
use App\Models\Settings;
use Carbon\Carbon;
use Validator;

class ContactsController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required',
            'message' => 'required',
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

        $data = Contacts::create($request->all());
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

        $data = Contacts::find($request->id);

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
        $data = Contacts::find($request->id)->update($request->all());

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
        $data = Contacts::find($request->id);
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
        $data = Contacts::all();
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

    public function sendMailToAdmin(Request $request){

        try {
            $validator = Validator::make($request->all(), [
                'mediaURL' => 'required',
                'subject' => 'required',
                'thank_you_text' => 'required',
                'header_text' => 'required',
                'from_mail' =>'required',
                'from_username' => 'required',
                'from_message' => 'required',
                'email' =>'required',
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
            $toMail = $request->from_mail;
            $generalInfo = Settings::take(1)->first();
            $data = Mail::send('mails/contact',
             [
                'app_name'      =>$generalInfo->name,
                'date'          => Carbon::now()->year,
                'email'         =>$request->from_mail,
                'name'          =>$request->from_username,
                'contents'       =>$request->from_message,
             ]
             , function($message) use($mail,$username,$subject,$generalInfo){
                $message->to($mail, $username)
                ->subject($subject);
                $message->from($generalInfo->email,$generalInfo->name);
            });
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
                'success' => $data,
                'message' => 'success',
                'status' => 200
            ];
            return $response;
        } catch (Exception $e) {
            return response()->json($e->getMessage(),200);
        }
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
