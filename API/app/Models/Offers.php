<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Offers extends Model
{
    use HasFactory;

    protected $table = 'offers';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['name','short_descriptions','code','type','discount','upto','for',
    'expire','freelancer_ids','max_usage','min_cart_value','validations','user_limit_validation','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
