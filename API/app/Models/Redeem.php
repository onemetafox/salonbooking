<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Redeem extends Model
{
    use HasFactory;

    protected $table = 'redeem';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['owner','redeemer','code','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
