<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Achievement;
use Illuminate\Http\Request;

class AchievementController extends Controller
{
    public function index(Request $request)
    {
        $achievements = Achievement::where('active', true)
            ->get();

        $unlocked = $request->user()
            ->achievements()
            ->pluck('achievements.id')
            ->toArray();

        $achievements->each(function ($achievement) use ($unlocked) {
            $achievement->is_unlocked =
                in_array($achievement->id, $unlocked);
        });

        return response()->json([
            'message' => 'Achievements retrieved successfully.',
            'achievements' => $achievements,
        ]);
    }
}