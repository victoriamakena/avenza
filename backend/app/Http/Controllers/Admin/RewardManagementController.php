<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Reward;
use Illuminate\Http\Request;

class RewardManagementController extends Controller
{
    public function index()
    {
        return response()->json([
        'rewards' => Reward::where('active', true)->latest()->paginate(25)        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'type' => ['required', 'string', 'max:100'],
            'points_cost' => ['required', 'integer', 'min:1'],
            'stock' => ['nullable', 'integer', 'min:0'],
            'image' => ['nullable', 'string'],
        ]);

        $reward = Reward::create($validated);

        return response()->json([
            'message' => 'Reward created successfully.',
            'reward' => $reward,
        ], 201);
    }

    public function update(
        Request $request,
        Reward $reward
    ) {
        $validated = $request->validate([
            'name' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'points_cost' => ['sometimes', 'required', 'integer', 'min:1'],
            'stock' => ['nullable', 'integer', 'min:0'],
            'active' => ['sometimes', 'boolean'],
        ]);

        $reward->update($validated);

        return response()->json([
            'message' => 'Reward updated successfully.',
            'reward' => $reward->fresh(),
        ]);
    }

    public function destroy(Reward $reward)
    {
        $reward->update([
            'active' => false,
        ]);

        return response()->json([
            'message' => 'Reward deactivated successfully.',
        ]);
    }
}