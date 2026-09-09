<?php

namespace App\Services;

use App\Models\Achievement;
use App\Models\User;
use App\Models\UserAchievement;
use Illuminate\Support\Facades\DB;

class AchievementService
{
    public function checkSavingAchievements(User $user): void
    {
        $totalSavings = $user->transactions()
            ->where('type', 'saving')
            ->where('status', 'completed')
            ->sum('amount');

        $savingCount = $user->transactions()
            ->where('type', 'saving')
            ->where('status', 'completed')
            ->count();

        $this->unlock(
            $user,
            'first-saving',
            $savingCount >= 1
        );

        $this->unlock(
            $user,
            'saved-1000',
            $totalSavings >= 1000
        );

        $this->unlock(
            $user,
            'saved-10000',
            $totalSavings >= 10000
        );
    }

    public function unlock(
        User $user,
        string $slug,
        bool $condition
    ): void {
        if (! $condition) {
            return;
        }

        $achievement = Achievement::where('slug', $slug)
            ->where('active', true)
            ->first();

        if (! $achievement) {
            return;
        }

        $alreadyUnlocked = UserAchievement::where('user_id', $user->id)
            ->where('achievement_id', $achievement->id)
            ->exists();

        if ($alreadyUnlocked) {
            return;
        }

        DB::transaction(function () use ($user, $achievement) {

            UserAchievement::create([
                'user_id' => $user->id,
                'achievement_id' => $achievement->id,
                'unlocked_at' => now(),
            ]);

            if ($achievement->xp_reward > 0) {
                app(XpService::class)->award(
                    $user,
                    $achievement->xp_reward,
                    'achievement',
                    "Achievement unlocked: {$achievement->name}"
                );
            }

            if ($achievement->points_reward > 0) {
                $user->increment(
                    'reward_points',
                    $achievement->points_reward
                );
            }
        });
    }
}