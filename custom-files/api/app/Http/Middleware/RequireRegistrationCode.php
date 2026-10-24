<?php

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;

/**
 * POST /register only with the access code (opnform-custom-deploy). The code is
 * checked on the server by RegistrationCodeController, which sets a short-lived
 * signed ticket in an HttpOnly cookie; this asks for that ticket. An invite
 * (OpnForm's own flow: the controller checks the token against the email) and
 * the very first account (setup) need no code.
 */
class RequireRegistrationCode
{
    public const COOKIE = 'opnform_registration';

    public static function ticket(int $expires): string
    {
        return $expires . '.' . hash_hmac('sha256', 'registration|' . $expires, (string) config('app.key'));
    }

    public function handle(Request $request, Closure $next)
    {
        if ($request->filled('invite_token') || !User::query()->exists()) {
            return $next($request);
        }
        $ticket = (string) $request->cookie(self::COOKIE, '');
        $expires = explode('.', $ticket, 2)[0];
        if (!ctype_digit($expires) || (int) $expires < now()->getTimestamp() || !hash_equals(self::ticket((int) $expires), $ticket)) {
            return response()->json(['message' => 'Registration needs the access code.'], 403);
        }

        return $next($request);
    }
}
