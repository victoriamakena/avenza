<?php

namespace Database\Seeders;

use App\Models\Lesson;
use Illuminate\Database\Seeder;

class LessonSeeder extends Seeder
{
    public function run(): void
    {
        $lessons = [
            [
                'title' => 'Why Saving Matters',
                'description' =>
                    'Understand why small, consistent savings matter.',
                'content' =>
                    'Saving helps you prepare for future needs and goals. ' .
                    'You do not need to start with a large amount. ' .
                    'Small, consistent amounts can build a useful habit.',
                'category' => 'Saving Basics',
                'language' => 'en',
                'xp_reward' => 30,
                'estimated_minutes' => 5,
            ],

            [
                'title' => 'Understanding a Budget',
                'description' =>
                    'Learn how to plan where your money goes.',
                'content' =>
                    'A budget is a simple plan for your income and expenses. ' .
                    'It can help you understand your spending and identify ' .
                    'an amount that you can save regularly.',
                'category' => 'Budgeting',
                'language' => 'en',
                'xp_reward' => 30,
                'estimated_minutes' => 5,
            ],

            [
                'title' => 'Setting a Savings Goal',
                'description' =>
                    'Learn how to create a realistic savings goal.',
                'content' =>
                    'A good savings goal has a clear purpose, target amount ' .
                    'and, where possible, a target date.',
                'category' => 'Goals',
                'language' => 'en',
                'xp_reward' => 30,
                'estimated_minutes' => 5,
            ],
        ];

        foreach ($lessons as $lesson) {
            Lesson::updateOrCreate(
                ['title' => $lesson['title']],
                $lesson
            );
        }
    }
}