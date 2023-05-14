<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ChatRooms;
use Validator;
use DB;

class ChatRoomsController extends Controller
{
    public function createChatRooms(Request $request){
        $validator = Validator::make($request->all(), [
            'sender_id' => 'required',
            'receiver_id' => 'required',
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

        $data = ChatRooms::create($request->all());
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
        $data = ChatRooms::find($request->id)->update($request->all());

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

    public function getChatRooms(Request $request){
        $validator = Validator::make($request->all(), [
            'sender_id' => 'required',
            'receiver_id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        \DB::enableQueryLog();

        $matchThese = ['sender_id' => $request->sender_id, 'receiver_id' => $request->receiver_id];
        $matchTheseToo = ['sender_id' => $request->receiver_id, 'receiver_id' => $request->sender_id];
        $data = ChatRooms::where($matchThese)->first();
        $data2 = ChatRooms::where($matchTheseToo)->first();

        $query = \DB::getQueryLog();
        if (is_null($data) && is_null($data2)) {
            $response = [
                'data' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'data2'=>$data2,
            'success' => true,
            'status' => 200,
            'query' => $query
        ];
        return response()->json($response, 200);
    }


    public function getChatListBUid(Request $request){
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

        $data = DB::table('chat_rooms')
        ->select('a.first_name as sender_first_name','a.id as sender_id','b.first_name as receiver_name','b.id as receiver_id','a.last_name as sender_last_name','a.cover as sender_cover','b.last_name as receiver_last_name','b.cover as receiver_cover','a.type as sender_type','b.type as receiver_type','chat_rooms.last_message as last_message','chat_rooms.last_message_type as last_message_type','chat_rooms.updated_at as updated_at')
        ->join('users as a', 'chat_rooms.sender_id', '=', 'a.id')
        ->join('users as b', 'chat_rooms.receiver_id', '=', 'b.id')
        ->where('chat_rooms.sender_id',$request->id)
        ->orWhere('chat_rooms.receiver_id',$request->id)
        ->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
