<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Complaints extends Model
{
    use HasFactory;

    protected $table = 'complaints';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','order_id','appointment_id','complaints_on','issue_with','driver_id','freelancer_id','product_id','reason_id','title','short_message','images','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'status' => 'integer',
        'issue_with' => 'integer',
    ];
}
