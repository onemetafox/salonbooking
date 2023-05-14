<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Specialist extends Model
{
    use HasFactory;

    protected $table = 'specialist';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['salon_uid','cate_id','first_name','cover','last_name','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'uid' => 'integer',
        'status' => 'integer',
    ];
}
