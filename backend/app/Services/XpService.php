<?php

namespace App\Services;

use App\Models\User;
use App\Models\XpTransaction;

class XpService
{
    public function award(
        User $user,
        int $amount,
        string $type,
        ?string $description = null
    ): XpTransaction {

        $transaction = $user->xpTransactions()->create([
            'amount' => $amount,
            'type' => $type,
            'description' => $description,
            'reference' => 'XP-' . strtoupper(uniqid()),
        ]);

        $user->increment('xp', $amount);

        return $transaction;
    }
}