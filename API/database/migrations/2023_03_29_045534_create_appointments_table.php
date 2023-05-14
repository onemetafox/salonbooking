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
        Schema::create('appointments', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->integer('freelancer_id')->default(0);
            $table->integer('salon_id')->default(0);
            $table->integer('specialist_id')->default(0);
            $table->integer('appointments_to');
            $table->text('address')->nullable();
            $table->text('items');
            $table->integer('coupon_id')->nullable();
            $table->text('coupon')->nullable();
            $table->double('discount',10,2);
            $table->double('distance_cost',10,2);
            $table->double('total',10,2);
            $table->double('serviceTax',10,2);
            $table->double('grand_total',10,2);
            $table->integer('pay_method');
            $table->text('paid');
            $table->date('save_date');
            $table->string('slot');
            $table->tinyInteger('wallet_used')->default(0);
            $table->double('wallet_price',10,2)->nullable();
            $table->text('notes')->nullable();
            $table->text('extra_field')->nullable();
            $table->tinyInteger('status');
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
        Schema::dropIfExists('appointments');
    }
};
