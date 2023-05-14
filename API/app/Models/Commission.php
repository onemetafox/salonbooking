<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Commission extends Model
{
    use HasFactory;

    protected $table = 'commission';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','rate','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
