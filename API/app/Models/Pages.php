<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pages extends Model
{
    use HasFactory;

    protected $table = 'pages';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['name','content','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
