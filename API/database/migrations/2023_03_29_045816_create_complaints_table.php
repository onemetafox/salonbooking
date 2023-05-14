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
        Schema::create('complaints', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->integer('order_id')->nullable();
            $table->integer('appointment_id')->nullable();
            $table->tinyInteger('complaints_on');
            $table->tinyInteger('issue_with');
            $table->integer('driver_id')->nullable();
            $table->integer('freelancer_id')->nullable();
            $table->integer('product_id')->nullable();
            $table->integer('reason_id')->nullable();
            $table->text('title')->nullable();
            $table->text('short_message')->nullable();
            $table->text('images')->nullable();
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
        Schema::dropIfExists('complaints');
    }
};
