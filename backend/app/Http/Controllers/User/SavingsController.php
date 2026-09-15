<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Goal;
use App\Services\AchievementService;
use App\Services\XpService;
use App\Services\StreakService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class SavingsController extends Controller
{
    public function store(
        Request $request,
        XpService $xpService,
        StreakService $streakService,
        AchievementService $achievementService
    ) {
        $request->validate([
            'goal_id' => 'required|exists:goals,id',
            'amount' => 'required|numeric|min:1',
            'description' => 'nullable|string|max:255',
        ]);

        $user = $request->user();

        $goal = Goal::where('id', $request->goal_id)
            ->where('user_id', $user->id)
            ->where('status', 'active')
            ->first();

        if (! $goal) {
            return response()->json([
                'message' => 'Goal not found or is not active.'
            ], 404);
        }

        $remaining = $goal->target_amount - $goal->current_amount;

        if ($request->amount > $remaining) {
            return response()->json([
                'message' => 'Saving amount cannot be greater than the remaining goal amount.'
            ], 422);
        }

        try {

            DB::transaction(function () use (
                $request,
                $user,
                $goal,
                $xpService,
                $streakService,
                $achievementService
            ) {

                // Create transaction
                $user->transactions()->create([
                    'goal_id' => $goal->id,
                    'type' => 'saving',
                    'amount' => $request->amount,
                    'description' => $request->description,
                    'reference' => 'AVZ-' . strtoupper(Str::random(10)),
                    'status' => 'completed',
                ]);

                // Update goal
                $goal->current_amount += $request->amount;

                // Check if goal is completed
                if ($goal->current_amount >= $goal->target_amount) {
                    $goal->current_amount = $goal->target_amount;
                    $goal->status = 'completed';
                }

                $goal->save();

                // Award XP
                $xpService->award(
                    $user,
                    20,
                    'saving',
                    'Made a saving'
                );

                // Update saving streak
                $streakService->update($user);
                $achievementService->checkAll($user);
            });

            return response()->json([
                'message' => 'Saving added successfully.',
                'goal' => $goal->fresh(),
            ], 201);

        } catch (\Throwable $e) {

            return response()->json([
                'message' => 'Unable to process saving at this time.'
            ], 500);
        }
    }
}