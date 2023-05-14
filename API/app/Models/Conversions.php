<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Conversions extends Model
{
    use HasFactory;

    protected $table = 'conversions';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['room_id','sender_id','message_type','message','reported','extra_fields','status'];

    protected $hidden = [
         'created_at',
    ];
}
