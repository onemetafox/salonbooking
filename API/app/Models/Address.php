<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    use HasFactory;

    protected $table = 'address';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','title','address','house','landmark','pincode','lat','lng','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
