<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RegisterRequest extends Model
{
    use HasFactory;

    protected $table = 'register_request';

    public $timestamps = true; //by default timestamp false

    protected $fillable = [
        'first_name',
        'last_name',
        'country_code',
        'mobile',
        'cover',
        'gender',
        'type',
        'zipcode',
        'categories',
        'extra_field',
        'status',
        'email',
        'password',
        'address',
        'lat',
        'lng',
        'name',
        'about',
        'fee_start',
        'cid'
    ];
}
