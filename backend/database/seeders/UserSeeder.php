<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $user = User::updateOrCreate(
            ['email' => 'testuser@example.com'],
            [
                'name' => 'Test User',
                'phone' => '0700000000 ',
                'password' => 'Qwerty1.',
                'role' => 'user',
                'language' => 'en',
                'email_verified_at' => now(),
                'xp' => 250,
                'reward_points' => 50,
                'current_streak' => 3,
                'longest_streak' => 5,
            ]
        );

        $user->settings()->firstOrCreate([]);
    }
}