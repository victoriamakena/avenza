<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Lesson;
use Illuminate\Http\Request;

class LessonManagementController extends Controller
{
    public function index()
    {
        return response()->json([
            'lessons' => Lesson::latest()->paginate(25),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'content' => ['required', 'string'],
            'category' => ['required', 'string', 'max:100'],
            'language' => ['required', 'string', 'max:10'],
            'xp_reward' => ['required', 'integer', 'min:0'],
            'estimated_minutes' => ['required', 'integer', 'min:1'],
        ]);

        $lesson = Lesson::create($validated);

        return response()->json([
            'message' => 'Lesson created successfully.',
            'lesson' => $lesson,
        ], 201);
    }

    public function update(
        Request $request,
        Lesson $lesson
    ) {
        $validated = $request->validate([
            'title' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'content' => ['sometimes', 'required', 'string'],
            'category' => ['sometimes', 'required', 'string'],
            'language' => ['sometimes', 'required', 'string'],
            'xp_reward' => ['sometimes', 'required', 'integer', 'min:0'],
            'estimated_minutes' => [
                'sometimes',
                'required',
                'integer',
                'min:1'
            ],
            'active' => ['sometimes', 'boolean'],
        ]);

        $lesson->update($validated);

        return response()->json([
            'message' => 'Lesson updated successfully.',
            'lesson' => $lesson->fresh(),
        ]);
    }

    public function destroy(Lesson $lesson)
    {
        $lesson->update([
            'active' => false,
        ]);

        return response()->json([
            'message' => 'Lesson deactivated successfully.',
        ]);
    }
}