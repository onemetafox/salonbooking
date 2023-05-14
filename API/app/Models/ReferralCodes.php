<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReferralCodes extends Model
{
    use HasFactory;

    protected $table = 'referralcodes';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','code','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
