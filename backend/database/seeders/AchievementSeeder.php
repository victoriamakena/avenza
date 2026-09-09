<?php

namespace Database\Seeders;

use App\Models\Achievement;
use Illuminate\Database\Seeder;

class AchievementSeeder extends Seeder
{
    public function run(): void
    {
        $achievements = [
            [
                'name' => 'First Save',
                'slug' => 'first-saving',
                'description' => 'Make your first saving.',
                'icon' => 'piggy-bank',
                'xp_reward' => 50,
                'points_reward' => 10,
                'criteria_type' => 'saving_count',
                'criteria_value' => 1,
            ],
            [
                'name' => 'KSh 1,000 Saver',
                'slug' => 'saved-1000',
                'description' => 'Save a total of KSh 1,000.',
                'icon' => 'target',
                'xp_reward' => 100,
                'points_reward' => 25,
                'criteria_type' => 'saving_total',
                'criteria_value' => 1000,
            ],
            [
                'name' => 'KSh 10,000 Saver',
                'slug' => 'saved-10000',
                'description' => 'Save a total of KSh 10,000.',
                'icon' => 'trophy',
                'xp_reward' => 250,
                'points_reward' => 75,
                'criteria_type' => 'saving_total',
                'criteria_value' => 10000,
            ],
        ];

        foreach ($achievements as $achievement) {
            Achievement::updateOrCreate(
                ['slug' => $achievement['slug']],
                $achievement
            );
        }
    }
}