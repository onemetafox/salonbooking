<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Individual extends Model
{
    use HasFactory;

    protected $table = 'individual';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','background','categories','address','about','rating','total_rating','website','timing','images',
    'zipcode','verified','cid','fee_start','lat','lng','status','in_home','popular','have_shop','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'uid' => 'integer',
        'cid' => 'integer',
        'total_rating' => 'integer',
        'verified' => 'integer',
        'status' => 'integer',
    ];
}
