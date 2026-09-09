<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Goal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class GoalController extends Controller
{
    /**
     * Display all goals belonging to the authenticated user.
     */
    public function index(Request $request)
    {
        try {
            $goals = $request->user()
                ->goals()
                ->latest()
                ->get();

            return response()->json([
                'message' => 'Goals retrieved successfully.',
                'goals' => $goals,
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to retrieve user goals.', [
                'user_id' => $request->user()?->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to retrieve your goals at this time.',
            ], 500);
        }
    }

    /**
     * Create a new goal.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'target_amount' => ['required', 'numeric', 'min:1'],
            'target_date' => ['nullable', 'date', 'after_or_equal:today'],
            'category' => ['nullable', 'string', 'max:100'],
        ]);

        try {
            $goal = $request->user()->goals()->create([
                'name' => $validated['name'],
                'description' => $validated['description'] ?? null,
                'target_amount' => $validated['target_amount'],
                'current_amount' => 0,
                'target_date' => $validated['target_date'] ?? null,
                'category' => $validated['category'] ?? null,
                'status' => 'active',
            ]);

            Log::info('Goal created successfully.', [
                'user_id' => $request->user()->id,
                'goal_id' => $goal->id,
            ]);

            return response()->json([
                'message' => 'Goal created successfully.',
                'goal' => $goal,
            ], 201);

        } catch (\Throwable $e) {
            Log::error('Failed to create goal.', [
                'user_id' => $request->user()?->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to create your goal at this time.',
            ], 500);
        }
    }

    /**
     * Display one goal belonging to the authenticated user.
     */
    public function show(Request $request, Goal $goal)
    {
        if (! $this->userOwnsGoal($request, $goal)) {
            return response()->json([
                'message' => 'You are not authorized to access this goal.',
            ], 403);
        }

        try {
            return response()->json([
                'message' => 'Goal retrieved successfully.',
                'goal' => $goal,
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to retrieve goal.', [
                'user_id' => $request->user()?->id,
                'goal_id' => $goal->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to retrieve this goal at this time.',
            ], 500);
        }
    }

    /**
     * Update a goal.
     */
    public function update(Request $request, Goal $goal)
    {
        if (! $this->userOwnsGoal($request, $goal)) {
            return response()->json([
                'message' => 'You are not authorized to update this goal.',
            ], 403);
        }

        $validated = $request->validate([
            'name' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'target_amount' => ['sometimes', 'required', 'numeric', 'min:1'],
            'target_date' => ['nullable', 'date', 'after_or_equal:today'],
            'category' => ['nullable', 'string', 'max:100'],
        ]);

        /*
         * The current_amount is controlled by the Savings module.
         * Users cannot manually change how much they have saved.
         */
        if (
            isset($validated['target_amount']) &&
            (float) $validated['target_amount'] < (float) $goal->current_amount
        ) {
            return response()->json([
                'message' => 'Target amount cannot be less than the amount already saved.',
            ], 422);
        }

        try {
            $goal->update($validated);

            Log::info('Goal updated successfully.', [
                'user_id' => $request->user()->id,
                'goal_id' => $goal->id,
            ]);

            return response()->json([
                'message' => 'Goal updated successfully.',
                'goal' => $goal->fresh(),
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to update goal.', [
                'user_id' => $request->user()?->id,
                'goal_id' => $goal->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to update your goal at this time.',
            ], 500);
        }
    }

    /**
     * Pause an active goal.
     */
    public function pause(Request $request, Goal $goal)
    {
        if (! $this->userOwnsGoal($request, $goal)) {
            return response()->json([
                'message' => 'You are not authorized to pause this goal.',
            ], 403);
        }

        if ($goal->status !== 'active') {
            return response()->json([
                'message' => 'Only active goals can be paused.',
            ], 422);
        }

        try {
            $goal->update([
                'status' => 'paused',
            ]);

            Log::info('Goal paused successfully.', [
                'user_id' => $request->user()->id,
                'goal_id' => $goal->id,
            ]);

            return response()->json([
                'message' => 'Goal paused successfully.',
                'goal' => $goal->fresh(),
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to pause goal.', [
                'user_id' => $request->user()?->id,
                'goal_id' => $goal->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to pause your goal at this time.',
            ], 500);
        }
    }

    /**
     * Resume a paused goal.
     */
    public function resume(Request $request, Goal $goal)
    {
        if (! $this->userOwnsGoal($request, $goal)) {
            return response()->json([
                'message' => 'You are not authorized to resume this goal.',
            ], 403);
        }

        if ($goal->status !== 'paused') {
            return response()->json([
                'message' => 'Only paused goals can be resumed.',
            ], 422);
        }

        try {
            $goal->update([
                'status' => 'active',
            ]);

            Log::info('Goal resumed successfully.', [
                'user_id' => $request->user()->id,
                'goal_id' => $goal->id,
            ]);

            return response()->json([
                'message' => 'Goal resumed successfully.',
                'goal' => $goal->fresh(),
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to resume goal.', [
                'user_id' => $request->user()?->id,
                'goal_id' => $goal->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to resume your goal at this time.',
            ], 500);
        }
    }

    /**
     * Cancel a goal.
     */
    public function cancel(Request $request, Goal $goal)
    {
        if (! $this->userOwnsGoal($request, $goal)) {
            return response()->json([
                'message' => 'You are not authorized to cancel this goal.',
            ], 403);
        }

        if ($goal->status === 'completed') {
            return response()->json([
                'message' => 'A completed goal cannot be cancelled.',
            ], 422);
        }

        if ($goal->status === 'cancelled') {
            return response()->json([
                'message' => 'Goal is already cancelled.',
            ], 422);
        }

        try {
            $goal->update([
                'status' => 'cancelled',
            ]);

            Log::info('Goal cancelled successfully.', [
                'user_id' => $request->user()->id,
                'goal_id' => $goal->id,
            ]);

            return response()->json([
                'message' => 'Goal cancelled successfully.',
                'goal' => $goal->fresh(),
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to cancel goal.', [
                'user_id' => $request->user()?->id,
                'goal_id' => $goal->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to cancel your goal at this time.',
            ], 500);
        }
    }

    /**
     * Delete a goal.
     *
     * Goals with savings cannot be deleted.
     */
    public function destroy(Request $request, Goal $goal)
    {
        if (! $this->userOwnsGoal($request, $goal)) {
            return response()->json([
                'message' => 'You are not authorized to delete this goal.',
            ], 403);
        }

        if ((float) $goal->current_amount > 0) {
            return response()->json([
                'message' => 'A goal with savings cannot be deleted. Cancel it instead.',
            ], 422);
        }

        try {
            $goal->delete();

            Log::info('Goal deleted successfully.', [
                'user_id' => $request->user()->id,
                'goal_id' => $goal->id,
            ]);

            return response()->json([
                'message' => 'Goal deleted successfully.',
            ], 200);

        } catch (\Throwable $e) {
            Log::error('Failed to delete goal.', [
                'user_id' => $request->user()?->id,
                'goal_id' => $goal->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to delete your goal at this time.',
            ], 500);
        }
    }

    /**
     * Check whether the authenticated user owns the goal.
     */
    private function userOwnsGoal(Request $request, Goal $goal): bool
    {
        return $goal->user_id === $request->user()->id;
    }
}