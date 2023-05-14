<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name')->nullable();
            $table->string('mobile')->nullable();
            $table->string('email')->nullable();
            $table->string('address')->nullable();
            $table->string('city')->nullable();
            $table->string('state')->nullable();
            $table->string('zip')->nullable();
            $table->string('country')->nullable();
            $table->double('tax',10,2)->nullable();
            $table->double('delivery_charge',10,2)->nullable();
            $table->string('currencySymbol');
            $table->string('currencySide');
            $table->string('currencyCode');
            $table->string('appDirection');
            $table->string('logo');
            $table->string('sms_name');
            $table->text('sms_creds');
            $table->tinyInteger('have_shop');
            $table->tinyInteger('findType')->default(0);
            $table->tinyInteger('reset_pwd')->default(0);
            $table->tinyInteger('user_login')->default(0);
            $table->tinyInteger('freelancer_login')->default(0);
            $table->tinyInteger('user_verify_with')->default(0);
            $table->double('search_radius',10,2)->default(10);
            $table->text('country_modal');
            $table->string('default_country_code');
            $table->string('default_city_id')->nullable();
            $table->string('default_delivery_zip')->nullable();
            $table->text('social')->nullable();
            $table->text('app_color');
            $table->tinyInteger('app_status')->default(1);
            $table->text('fcm_token')->nullable();
            $table->tinyInteger('status')->default(0);
            $table->double('allowDistance');
            $table->tinyInteger('searchResultKind')->default(0);
            $table->text('extra_field')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('settings');
    }
};
