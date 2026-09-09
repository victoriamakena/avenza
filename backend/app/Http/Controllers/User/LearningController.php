<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Lesson;
use App\Models\LessonProgress;
use App\Services\XpService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class LearningController extends Controller
{
    public function index(Request $request)
    {
        $lessons = Lesson::where('active', true)
            ->where('language', $request->user()->language)
            ->latest()
            ->get();

        $progress = LessonProgress::where('user_id', $request->user()->id)
            ->pluck('completed', 'lesson_id');

        $lessons->each(function ($lesson) use ($progress) {
            $lesson->completed =
                (bool) ($progress[$lesson->id] ?? false);
        });

        return response()->json([
            'message' => 'Lessons retrieved successfully.',
            'lessons' => $lessons,
        ]);
    }

    public function show(Request $request, Lesson $lesson)
    {
        if (! $lesson->active) {
            return response()->json([
                'message' => 'This lesson is currently unavailable.',
            ], 404);
        }

        $progress = LessonProgress::where('user_id', $request->user()->id)
            ->where('lesson_id', $lesson->id)
            ->first();

        return response()->json([
            'message' => 'Lesson retrieved successfully.',
            'lesson' => $lesson,
            'completed' => $progress?->completed ?? false,
        ]);
    }

    public function complete(
        Request $request,
        Lesson $lesson,
        XpService $xpService
    ) {
        if (! $lesson->active) {
            return response()->json([
                'message' => 'This lesson is currently unavailable.',
            ], 404);
        }

        try {
            $result = DB::transaction(function () use (
                $request,
                $lesson,
                $xpService
            ) {
                $progress = LessonProgress::firstOrCreate(
                    [
                        'user_id' => $request->user()->id,
                        'lesson_id' => $lesson->id,
                    ],
                    [
                        'completed' => false,
                    ]
                );

                if ($progress->completed) {
                    return [
                        'already_completed' => true,
                        'xp_earned' => 0,
                    ];
                }

                $progress->update([
                    'completed' => true,
                    'completed_at' => now(),
                ]);

                $xpService->award(
                    $request->user(),
                    $lesson->xp_reward,
                    'learning',
                    "Completed lesson: {$lesson->title}"
                );

                return [
                    'already_completed' => false,
                    'xp_earned' => $lesson->xp_reward,
                ];
            });

            return response()->json([
                'message' => $result['already_completed']
                    ? 'Lesson was already completed.'
                    : 'Lesson completed successfully.',
                'xp_earned' => $result['xp_earned'],
            ]);
        } catch (\Throwable $e) {

            Log::error('Failed to complete lesson.', [
                'user_id' => $request->user()->id,
                'lesson_id' => $lesson->id,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to complete the lesson at this time.',
            ], 500);
        }
    }
}