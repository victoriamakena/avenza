<?php

namespace Database\Seeders;

use App\Models\Reward;
use Illuminate\Database\Seeder;

class RewardSeeder extends Seeder
{
    public function run(): void
    {
        $rewards = [
            [
                'name' => 'Avenza Saver Badge',
                'description' =>
                    'A digital recognition badge for consistent savers.',
                'type' => 'digital_badge',
                'points_cost' => 100,
                'stock' => null,
            ],
            [
                'name' => 'Learning Certificate',
                'description' =>
                    'A simulated certificate for completing learning milestones.',
                'type' => 'certificate',
                'points_cost' => 250,
                'stock' => null,
            ],
            [
                'name' => 'Partner Discount Voucher',
                'description' =>
                    'Demo voucher for a future Avenza partner.',
                'type' => 'voucher',
                'points_cost' => 500,
                'stock' => 50,
            ],
        ];

        foreach ($rewards as $reward) {
            Reward::updateOrCreate(
                ['name' => $reward['name']],
                $reward
            );
        }
    }
}