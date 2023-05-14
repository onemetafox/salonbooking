<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Payments;

class PaymentsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Payments::truncate();
        Payments::create([
            'name'              => 'COD',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'USD'
        ]);

        Payments::create([
            'name'              => 'Stripe',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'USD'
        ]);

        Payments::create([
            'name'              => 'PayPal',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'USD'
        ]);

        Payments::create([
            'name'              => 'PayTM',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'INR'
        ]);

        Payments::create([
            'name'              => 'RazorPay',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'INR'
        ]);

        Payments::create([
            'name'              => 'InstaMOJO',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'INR'
        ]);

        Payments::create([
            'name'              => 'PayStack',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'NGN'
        ]);

        Payments::create([
            'name'              => 'Flutterwave',
            'env'             => 1,
            'status'          => 1,
            'cover'           => 'NA',
            'currency_code'   => 'NGN'
        ]);

    }
}
