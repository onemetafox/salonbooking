<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Referral extends Model
{
    use HasFactory;

    protected $table = 'referral';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['amount','title','message','limit','who_received','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
