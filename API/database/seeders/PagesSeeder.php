<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Pages;

class PagesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Pages::truncate();
        Pages::create([
            'name'              => 'About us',
            'content'           => 'About us',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Privacy',
            'content'           => 'Privacy',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Terms & Conditions',
            'content'           => 'Terms & Conditions',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Refund Policy',
            'content'           => 'Refund Policy',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Frequently Asked Questions',
            'content'           => 'Frequently Asked Questions',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Help',
            'content'           => 'Help',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Legal Mentions',
            'content'           => 'Legal Mentions',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

        Pages::create([
            'name'              => 'Cookies',
            'content'           => 'Cookies',
            'extra_field'       => 'NA',
            'status'            => 1
        ]);

    }
}
