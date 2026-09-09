<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Goal;

class GoalManagementController extends Controller
{
    public function index()
    {
        return response()->json([
            'goals' => Goal::with('user:id,name,email')
                ->latest()
                ->paginate(25),
        ]);
    }

    public function show(Goal $goal)
    {
        return response()->json([
            'goal' => $goal->load([
                'user:id,name,email',
                'transactions',
            ]),
        ]);
    }
}