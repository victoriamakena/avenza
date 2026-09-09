<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserSetting extends Model
{
    use HasFactory;

    protected $fillable = [
        'large_text',
        'high_contrast',
        'reduced_motion',
        'saving_reminders',
        'goal_reminders',
        'learning_reminders',
        'weekly_summary',
        'dark_mode',
    ];

    protected function casts(): array
    {
        return [
            'large_text' => 'boolean',
            'high_contrast' => 'boolean',
            'reduced_motion' => 'boolean',
            'saving_reminders' => 'boolean',
            'goal_reminders' => 'boolean',
            'learning_reminders' => 'boolean',
            'weekly_summary' => 'boolean',
            'dark_mode' => 'boolean',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}