<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChatRooms extends Model
{
    use HasFactory;

    protected $table = 'chat_rooms';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['sender_id','receiver_id','last_message','last_message_type','status','extra_fields'];

    protected $hidden = [
         'created_at',
    ];
}
