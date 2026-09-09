<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Achievement;
use Illuminate\Http\Request;

class AchievementManagementController extends Controller
{
    public function index()
    {
        return response()->json([
            'achievements' => Achievement::latest()->get(),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'slug' => ['required', 'string', 'max:255', 'unique:achievements,slug'],
            'description' => ['required', 'string'],
            'icon' => ['nullable', 'string', 'max:100'],
            'xp_reward' => ['required', 'integer', 'min:0'],
            'points_reward' => ['required', 'integer', 'min:0'],
            'criteria_type' => ['required', 'string', 'max:100'],
            'criteria_value' => ['required', 'integer', 'min:1'],
        ]);

        $achievement = Achievement::create($validated);

        return response()->json([
            'message' => 'Achievement created successfully.',
            'achievement' => $achievement,
        ], 201);
    }

    public function update(
        Request $request,
        Achievement $achievement
    ) {
        $validated = $request->validate([
            'name' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['sometimes', 'required', 'string'],
            'xp_reward' => ['sometimes', 'required', 'integer', 'min:0'],
            'points_reward' => ['sometimes', 'required', 'integer', 'min:0'],
            'active' => ['sometimes', 'boolean'],
        ]);

        $achievement->update($validated);

        return response()->json([
            'message' => 'Achievement updated successfully.',
            'achievement' => $achievement->fresh(),
        ]);
    }
}