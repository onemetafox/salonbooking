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
        Schema::create('owner_reviews', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->string('freelancer_id');
            $table->text('notes')->nullable();
            $table->double('rating',10,2)->nullable();
            $table->tinyInteger('status')->default(1);
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
        Schema::dropIfExists('owner_reviews');
    }
};
