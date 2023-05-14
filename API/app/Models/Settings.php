<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Settings extends Model
{
    use HasFactory;

    protected $table = 'settings';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['name','mobile','address','email','city','state','zip','country',
    'tax','delivery_charge','currencySymbol','currencySide','currencyCode','appDirection','logo','sms_name','sms_creds','have_shop','findType','reset_pwd',
    'user_login','freelancer_login','user_verify_with','search_radius','country_modal','default_country_code','default_city_id','default_delivery_zip','social',
    'app_color','app_status','fcm_token','status','allowDistance','searchResultKind','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'have_shop' => 'integer',
        'findType' => 'integer',
        'reset_pwd' => 'integer',
        'user_login' => 'integer',
        'freelancer_login' => 'integer',
        'user_verify_with' => 'integer',
        'app_status' => 'integer',
        'status' => 'integer',
        'searchResultKind' => 'integer',
    ];
}
