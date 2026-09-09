<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        $admin = User::updateOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Super Admin',
                'phone' => '0712345679',
                'password' => 'Qwerty1.',
                'role' => 'admin',
                'language' => 'en',
                'email_verified_at' => now(),
            ]
        );

        $admin->settings()->firstOrCreate([]);
    }
}