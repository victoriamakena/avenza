<?php

namespace App\Services;

use App\Models\User;
use Carbon\Carbon;

class StreakService
{
    public function update(User $user): void
    {
        $today = Carbon::today();

        if (! $user->last_activity_at) {
            $user->update([
                'current_streak' => 1,
                'longest_streak' => max(1, $user->longest_streak),
                'last_activity_at' => now(),
            ]);

            return;
        }

        $lastActivity = Carbon::parse($user->last_activity_at)->startOfDay();

        if ($lastActivity->isSameDay($today)) {
            return;
        }

        if ($lastActivity->isYesterday()) {
            $current = $user->current_streak + 1;

            $user->update([
                'current_streak' => $current,
                'longest_streak' => max(
                    $current,
                    $user->longest_streak
                ),
                'last_activity_at' => now(),
            ]);

            return;
        }

        $user->update([
            'current_streak' => 1,
            'last_activity_at' => now(),
        ]);
    }
}