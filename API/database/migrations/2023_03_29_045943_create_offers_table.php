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
        Schema::create('offers', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->text('short_descriptions');
            $table->text('code');
            $table->tinyInteger('type');
            $table->tinyInteger('for'); // 0 individuals // 1 = salons
            $table->double('discount',10,2);
            $table->double('upto',10,2);
            $table->date('expire');
            $table->text('freelancer_ids');
            $table->integer('max_usage');
            $table->double('min_cart_value',10,2);
            $table->tinyInteger('validations');
            $table->integer('user_limit_validation')->nullable();
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
        Schema::dropIfExists('offers');
    }
};
