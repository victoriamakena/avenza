<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Reward;
use App\Models\RewardRedemption;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class RewardController extends Controller
{
    public function index(Request $request)
    {
        $rewards = Reward::where('active', true)
            ->where(function ($query) {
                $query->whereNull('stock')
                    ->orWhere('stock', '>', 0);
            })
            ->get();

        return response()->json([
            'message' => 'Rewards retrieved successfully.',
            'reward_points' => $request->user()->reward_points,
            'rewards' => $rewards,
        ]);
    }

    public function redeem(Request $request, Reward $reward)
    {
        $user = $request->user();

        if (! $reward->active) {
            return response()->json([
                'message' => 'This reward is not available.'
            ], 404);
        }

        if ($reward->stock !== null && $reward->stock <= 0) {
            return response()->json([
                'message' => 'This reward is out of stock.'
            ], 422);
        }

        if ($user->reward_points < $reward->points_cost) {
            return response()->json([
                'message' => 'You do not have enough reward points.'
            ], 422);
        }

        DB::transaction(function () use ($user, $reward) {

            $user->decrement(
                'reward_points',
                $reward->points_cost
            );

            if ($reward->stock !== null) {
                $reward->decrement('stock');
            }

            RewardRedemption::create([
                'user_id' => $user->id,
                'reward_id' => $reward->id,
                'points_spent' => $reward->points_cost,
                'status' => 'pending',
                'reference' => 'RED-' . strtoupper(Str::random(10)),
            ]);
        });

        return response()->json([
            'message' => 'Reward redemption submitted successfully.',
        ], 201);
    }

    public function history(Request $request)
    {
        $redemptions = RewardRedemption::where(
            'user_id',
            $request->user()->id
        )
            ->with('reward')
            ->latest()
            ->paginate(20);

        return response()->json([
            'message' => 'Redemption history retrieved successfully.',
            'redemptions' => $redemptions,
        ]);
    }
}