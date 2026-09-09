<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class TransactionController extends Controller
{
    public function index(Request $request)
    {
        try {
            $transactions = $request->user()
                ->transactions()
                ->with('goal:id,name')
                ->latest()
                ->paginate(20);

            return response()->json([
                'message' => 'Transactions retrieved successfully.',
                'transactions' => $transactions,
            ], 200);

        } catch (\Throwable $e) {

            Log::error('Failed to retrieve transactions.', [
                'user_id' => $request->user()?->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to retrieve your transactions at this time.',
            ], 500);
        }
    }
}