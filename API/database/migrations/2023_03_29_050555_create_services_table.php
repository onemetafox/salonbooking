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
        Schema::create('services', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->integer('cate_id');
            $table->string('name')->nullable();
            $table->string('cover')->nullable();
            $table->double('duration',10,2)->nullable();
            $table->double('price',10,2)->nullable();
            $table->integer('off');
            $table->double('discount',10,2)->nullable();
            $table->text('descriptions')->nullable();
            $table->text('images')->nullable();
            $table->text('extra_field')->nullable();
            $table->tinyInteger('status')->default(1);
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
        Schema::dropIfExists('services');
    }
};
