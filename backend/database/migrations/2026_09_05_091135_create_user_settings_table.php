<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
       Schema::create('user_settings', function (Blueprint $table) {
    $table->id();

    $table->foreignId('user_id')
        ->unique()
        ->constrained()
        ->cascadeOnDelete();

    $table->boolean('large_text')->default(false);
    $table->boolean('high_contrast')->default(false);
    $table->boolean('reduced_motion')->default(false);

    $table->boolean('saving_reminders')->default(true);
    $table->boolean('goal_reminders')->default(true);
    $table->boolean('learning_reminders')->default(true);
    $table->boolean('weekly_summary')->default(true);

    $table->boolean('dark_mode')->default(false);

    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_settings');
    }
};
