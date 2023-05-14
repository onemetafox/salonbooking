<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Services extends Model
{
    use HasFactory;

    protected $table = 'services';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','cate_id','name','cover','duration','price','off','discount','descriptions','images','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];

    protected $casts = [
        'uid' => 'integer',
        'cate_id' => 'integer',
        'status' => 'integer',
    ];
}
