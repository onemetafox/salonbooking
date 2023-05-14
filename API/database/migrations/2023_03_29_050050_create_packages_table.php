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
        Schema::create('packages', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->tinyInteger('package_from'); // 0 =  salon // 1 = individual
            $table->text('name');
            $table->string('cover')->nullable();
            $table->text('service_id');
            $table->text('descriptions')->nullable();
            $table->text('images')->nullable();
            $table->double('duration',10,2)->nullable();
            $table->double('price',10,2)->nullable();
            $table->double('off',10,2)->nullable();
            $table->double('discount',10,2)->nullable();
            $table->text('specialist_ids')->nullable();
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
        Schema::dropIfExists('packages');
    }
};
