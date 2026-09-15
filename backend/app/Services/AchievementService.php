<?php

namespace App\Services;

use App\Models\Achievement;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class AchievementService
{
    public function checkAll(User $user): void
    {
        $achievements = Achievement::where('active', true)->get();

        foreach ($achievements as $achievement) {
            $this->evaluate($user, $achievement);
        }
    }

    protected function evaluate(User $user, Achievement $achievement): void
    {
        $alreadyUnlocked = $user->achievements()
            ->where('achievement_id', $achievement->id)
            ->exists();

        if ($alreadyUnlocked) {
            return;
        }

        $currentValue = $this->currentValueFor($user, $achievement->criteria_type);

        if ($currentValue === null || $currentValue < $achievement->criteria_value) {
            return;
        }

        $this->unlock($user, $achievement);
    }

    protected function currentValueFor(User $user, string $criteriaType): ?int
    {
        return match ($criteriaType) {
            'total_saved' => (int) $user->transactions()
                ->where('type', 'saving')
                ->where('status', 'completed')
                ->sum('amount'),

            'savings_count' => $user->transactions()
                ->where('type', 'saving')
                ->where('status', 'completed')
                ->count(),

            'goals_completed' => $user->goals()
                ->where('status', 'completed')
                ->count(),

            'lessons_completed' => $user->lessons()
                ->wherePivot('completed', true)
                ->count(),

            'streak_days' => $user->current_streak,

            default => null,
        };
    }

    protected function unlock(User $user, Achievement $achievement): void
    {
        DB::transaction(function () use ($user, $achievement) {
            $user->achievements()->attach($achievement->id, [
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
                $user->increment('reward_points', $achievement->points_reward);
            }
        });
    }
}