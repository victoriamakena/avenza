<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\EmailVerificationController;
use App\Http\Controllers\Auth\PasswordResetController;
use App\Http\Controllers\Auth\ResendVerificationController;
use App\Http\Controllers\User\AchievementController;
use App\Http\Controllers\User\DashboardController;
use App\Http\Controllers\User\GoalController;
use App\Http\Controllers\User\LearningController;
use App\Http\Controllers\User\NotificationController;
use App\Http\Controllers\User\RewardController;
use App\Http\Controllers\User\SavingsController;
use App\Http\Controllers\User\TransactionController;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\GoalManagementController;
use App\Http\Controllers\Admin\LessonManagementController;
use App\Http\Controllers\Admin\AchievementManagementController;
use App\Http\Controllers\Admin\RewardManagementController;
use App\Http\Controllers\Admin\RedemptionManagementController;
use App\Http\Controllers\Admin\NotificationManagementController;
use App\Http\Controllers\Admin\UserManagementController;
use App\Http\Controllers\UssdController;

/*
|--------------------------------------------------------------------------
| Public Authentication Routes
|--------------------------------------------------------------------------
*/

Route::prefix('auth')->group(function () {

    Route::post('/register', [AuthController::class,'register']);
    Route::post('/login', [AuthController::class,'login']);
    Route::post('/forgot-password', [PasswordResetController::class,'forgot']);
    Route::post('/reset-password', [PasswordResetController::class,'reset']);
    Route::post('/verify-password', [EmailVerificationController::class,'verify']);
    Route::post('/ussd', [UssdController::class,'handle',]);

});


/*
|--------------------------------------------------------------------------
| Authenticated Routes
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->group(function () {

    Route::post('/auth/logout', [AuthController::class,'logout']);

    Route::get('/auth/me', [AuthController::class, 'me']);

    Route::post('/auth/email/resend', [ResendVerificationController::class,'resend']);

    Route::get('/auth/email/verify/{id}/{hash}', [
        EmailVerificationController::class,
        'verify'
    ])->middleware(['signed', 'throttle:6,1'])
    ->name('verification.verify');

    Route::get('/transactions', [TransactionController::class,'index',]);
    Route::get('/notifications', [NotificationController::class,'index']);
    Route::get('/notifications/unread-count', [NotificationController::class,'unreadCount']);
    Route::post('/notifications/{notification}/read', [NotificationController::class,'read']);
    Route::get('/rewards', [RewardController::class,'index']);
    Route::post('/rewards/{reward}/redeem', [RewardController::class,'redeem']);
    Route::get('/rewards/redemptions', [RewardController::class,'history']);

});


/*
|--------------------------------------------------------------------------
| Verified User Routes
|--------------------------------------------------------------------------
*/

Route::middleware([
    'auth:sanctum',
    'verified'
])->group(function () {

    Route::get('/dashboard', function () {
        return response()->json([
            'message' => 'Welcome to Avenza.',
        ]);
    });

     Route::get('/dashboard', [DashboardController::class,'index',]);

    Route::get('/users', [UserManagementController::class,'index',]);
    Route::get('/users/{user}', [UserManagementController::class,'show',]);
    Route::put('/users/{user}', [UserManagementController::class,'update',]);
    Route::get('/goals', [GoalManagementController::class,'index',]);
    Route::get('/goals/{goal}', [GoalManagementController::class,'show',]);
    Route::get('/lessons', [LessonManagementController::class,'index',]);
    Route::post('/lessons', [LessonManagementController::class,'store',]);
    Route::put('/lessons/{lesson}', [LessonManagementController::class,'update',]);
    Route::delete('/lessons/{lesson}', [LessonManagementController::class,'destroy',]);
    Route::get('/achievements', [AchievementManagementController::class,'index',]);
    Route::post('/achievements', [AchievementManagementController::class,'store',]);
    Route::put('/achievements/{achievement}', [AchievementManagementController::class,'update',]);
    Route::get('/rewards', [RewardManagementController::class,'index',]);
    Route::post('/rewards', [RewardManagementController::class,'store',]);
    Route::put('/rewards/{reward}', [RewardManagementController::class,'update',]);
    Route::delete('/rewards/{reward}', [ RewardManagementController::class,'destroy',]);
    Route::get('admin/redemptions', [RedemptionManagementController::class,'index',]);
    Route::put('/redemptions/{redemption}', [RedemptionManagementController::class, 'update',]);
    Route::post('/notifications', [NotificationManagementController::class,'store',]);
    // Goals
    Route::prefix('goals')->group(function () {
    Route::get('/', [GoalController::class, 'index']);
    Route::post('/', [GoalController::class, 'store']);
    Route::get('/{goal}', [GoalController::class, 'show']);
    Route::put('/{goal}', [GoalController::class, 'update']);
    Route::delete('/{goal}', [GoalController::class, 'destroy']);
    Route::post('/{goal}/pause', [GoalController::class, 'pause']);
    Route::post('/{goal}/resume', [GoalController::class, 'resume']);
    Route::post('/{goal}/cancel', [GoalController::class, 'cancel']);
    });

    // Savings
    Route::post('/savings', [SavingsController::class, 'store', ]);

        // Dashboard
    Route::get('/dashboard', [DashboardController::class, 'index']);
        
        // Learning
    Route::get('/lessons', [LearningController::class, 'index']);
    Route::get('/lessons/{lesson}', [LearningController::class, 'show']);
    Route::post('/lessons/{lesson}/complete',[LearningController::class, 'complete']
    );

    // Achievement
    Route::get('/achievements', [AchievementController::class,'index']);
});