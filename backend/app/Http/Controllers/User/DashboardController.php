<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $goals = $user->goals()
            ->where('status', 'active')
            ->latest()
            ->get();

        $totalSaved = $user->transactions()
            ->where('type', 'saving')
            ->where('status', 'completed')
            ->sum('amount');

        $completedLessons = $user->lessons()
            ->wherePivot('completed', true)
            ->count();

        return response()->json([
            'message' => 'Dashboard retrieved successfully.',

            'user' => [
                'name' => $user->name,
                'xp' => $user->xp,
                'reward_points' => $user->reward_points,
                'current_streak' => $user->current_streak,
                'longest_streak' => $user->longest_streak,
            ],

            'summary' => [
                'total_saved' => $totalSaved,
                'active_goals' => $goals->count(),
                'completed_lessons' => $completedLessons,
            ],

            'goals' => $goals,
        ]);
    }
}