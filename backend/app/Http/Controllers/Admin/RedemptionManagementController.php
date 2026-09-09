<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\RewardRedemption;
use Illuminate\Http\Request;

class RedemptionManagementController extends Controller
{
    /**
     * Display all reward redemptions.
     */
    public function index()
    {
        $redemptions = RewardRedemption::with([
            'user',
            'reward'
        ])
            ->latest()
            ->paginate(20);

        return response()->json([
            'message' => 'Reward redemptions retrieved successfully.',
            'redemptions' => $redemptions,
        ]);
    }

    /**
     * Update the status of a redemption.
     */
    public function update(
        Request $request,
        RewardRedemption $redemption
    ) {
        $request->validate([
            'status' => 'required|in:pending,approved,rejected,fulfilled',
            'notes' => 'nullable|string|max:1000',
        ]);

        $redemption->update([
            'status' => $request->status,
            'notes' => $request->notes,
        ]);

        return response()->json([
            'message' => 'Redemption updated successfully.',
            'redemption' => $redemption->fresh([
                'user',
                'reward'
            ]),
        ]);
    }
}