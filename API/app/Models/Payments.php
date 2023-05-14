<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payments extends Model
{
    use HasFactory;

    protected $table = 'payments';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['cover','name','env','status','currency_code','extra_field','creds'];

    protected $hidden = [
        'updated_at', 'created_at','creds'
    ];
}
