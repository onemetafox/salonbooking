<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductOrders extends Model
{
    use HasFactory;

    protected $table = 'products_orders';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','freelancer_id','salon_id','driver_id','date_time','paid_method','order_to','orders','notes','address',
    'assignee','total','tax','grand_total','discount','delivery_charge','wallet_used','wallet_price',
    'extra','pay_key','coupon_code','status','payStatus','extra_field'];

    protected $hidden = [
        'updated_at'
    ];

    protected $casts = [
        'wallet_used' => 'integer',
        'payStatus' => 'integer'
    ];
}
