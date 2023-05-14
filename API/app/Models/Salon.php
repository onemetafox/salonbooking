<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Salon extends Model
{
    use HasFactory;

    protected $table = 'salon';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','name','cover','categories','address','lat','lng','about','rating','total_rating','website','timing','images',
    'zipcode','service_at_home','verified','cid','have_stylist','status','in_home','popular','have_shop','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'uid' => 'integer',
        'cid' => 'integer',
        'total_rating' => 'integer',
        'service_at_home' => 'integer',
        'verified' => 'integer',
        'have_stylist' => 'integer',
        'status' => 'integer',
    ];
}
