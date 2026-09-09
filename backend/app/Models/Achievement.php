<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Achievement extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'slug',
        'description',
        'icon',
        'xp_reward',
        'points_reward',
        'criteria_type',
        'criteria_value',
        'active',
    ];

    protected function casts(): array
    {
        return [
            'active' => 'boolean',
            'xp_reward' => 'integer',
            'points_reward' => 'integer',
            'criteria_value' => 'integer',
        ];
    }

    public function userAchievements(): HasMany
    {
        return $this->hasMany(UserAchievement::class);
    }
}