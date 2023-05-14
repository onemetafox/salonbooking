<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Packages extends Model
{
    use HasFactory;

    protected $table = 'packages';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','package_from','name','cover','service_id','specialist_ids','duration','price','off','discount','descriptions','images','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'uid' => 'integer',
        'package_from' => 'integer',
        'status' => 'integer',
    ];
}
