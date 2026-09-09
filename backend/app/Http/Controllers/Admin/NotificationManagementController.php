<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use App\Models\User;
use Illuminate\Http\Request;

class NotificationManagementController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => ['nullable', 'integer', 'exists:users,id'],
            'title' => ['required', 'string', 'max:255'],
            'message' => ['required', 'string'],
            'type' => ['nullable', 'string', 'max:100'],
        ]);

        if ($validated['user_id'] ?? null) {

            $notification = Notification::create([
                'user_id' => $validated['user_id'],
                'title' => $validated['title'],
                'message' => $validated['message'],
                'type' => $validated['type'] ?? 'general',
            ]);

            return response()->json([
                'message' => 'Notification sent successfully.',
                'notification' => $notification,
            ], 201);
        }

        $users = User::where('role', 'user')->get();

        foreach ($users as $user) {
            Notification::create([
                'user_id' => $user->id,
                'title' => $validated['title'],
                'message' => $validated['message'],
                'type' => $validated['type'] ?? 'general',
            ]);
        }

        return response()->json([
            'message' => 'Notification sent to all users.',
        ], 201);
    }
}