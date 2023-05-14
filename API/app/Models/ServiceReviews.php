<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceReviews extends Model
{
    use HasFactory;

    protected $table = 'service_reviews';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','service_id','freelancer_id','notes','rating','status','extra_field'];

    protected $hidden = [
        'updated_at',
    ];
}
