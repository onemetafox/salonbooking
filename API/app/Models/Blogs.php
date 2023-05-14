<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Blogs extends Model
{
    use HasFactory;

    protected $table = 'blogs';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['title','cover','short_content','content','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
