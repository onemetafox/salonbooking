<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductReviews extends Model
{
    use HasFactory;

    protected $table = 'product_reviews';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','product_id','notes','rating','status','extra_field'];

    protected $hidden = [
        'updated_at',
    ];
}
