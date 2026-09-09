<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UssdController extends Controller
{
    public function handle(Request $request)
    {
        $validated = $request->validate([
            'phone' => ['required', 'string'],
            'text' => ['nullable', 'string'],
        ]);

        $user = User::where('phone', $validated['phone'])
            ->where('role', 'user')
            ->first();

        if (! $user) {
            return response(
                "END User not found. Please register for Avenza.",
                200,
                ['Content-Type' => 'text/plain']
            );
        }

        $text = trim($validated['text'] ?? '');

        if ($text === '') {
            return response(
                "CON Welcome to Avenza\n" .
                "1. My Goals\n" .
                "2. Save\n" .
                "3. Balance\n" .
                "4. Learn\n" .
                "5. Rewards",
                200,
                ['Content-Type' => 'text/plain']
            );
        }

        switch ($text) {

            case '1':
                $goals = $user->goals()
                    ->where('status', 'active')
                    ->get();

                if ($goals->isEmpty()) {
                    return response(
                        "END You have no active goals.",
                        200,
                        ['Content-Type' => 'text/plain']
                    );
                }

                $message = "END Your goals:\n";

                foreach ($goals as $goal) {
                    $message .=
                        $goal->name .
                        ": KSh " .
                        number_format(
                            $goal->current_amount,
                            2
                        ) .
                        " / KSh " .
                        number_format(
                            $goal->target_amount,
                            2
                        ) .
                        "\n";
                }

                return response(
                    $message,
                    200,
                    ['Content-Type' => 'text/plain']
                );

            case '3':
                $totalSaved = $user->transactions()
                    ->where('type', 'saving')
                    ->where('status', 'completed')
                    ->sum('amount');

                return response(
                    "END Total saved: KSh " .
                    number_format($totalSaved, 2),
                    200,
                    ['Content-Type' => 'text/plain']
                );

            case '4':
                return response(
                    "END Visit the Avenza Learning section " .
                    "to learn about saving, budgeting and money management.",
                    200,
                    ['Content-Type' => 'text/plain']
                );

            case '5':
                return response(
                    "END You have " .
                    $user->reward_points .
                    " reward points.",
                    200,
                    ['Content-Type' => 'text/plain']
                );

            default:
                return response(
                    "END Invalid option.",
                    200,
                    ['Content-Type' => 'text/plain']
                );
        }
    }
}