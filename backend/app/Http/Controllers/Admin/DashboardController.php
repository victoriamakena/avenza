<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Goal;
use App\Models\Transaction;

class DashboardController extends Controller
{
    public function index()
    {
        $totalUsers = User::where('role', 'user')->count();
        $verifiedUsers = User::where('role', 'user')
            ->whereNotNull('email_verified_at')
            ->count();
        $totalAdmins = User::where('role', 'admin')->count();

        $activeGoals = Goal::where('status', 'active')->count();
        $totalSaved = Transaction::where('type', 'saving')
            ->where('status', 'completed')
            ->sum('amount');

        return response()->json([
            'statistics' => [
                'total_users' => $totalUsers,
                'verified_users' => $verifiedUsers,
                'total_admins' => $totalAdmins,
                'active_goals' => $activeGoals,
                'total_saved' => $totalSaved,
            ],
        ]);
    }
}