<?php

namespace App\Http\Controllers;

use App\Http\Middleware\RequireRegistrationCode;
use Illuminate\Http\Request;

/**
 * POST /registration-code {code}: checks the access code on the server
 * (opnform-custom-deploy). A right code gets a signed ticket, valid for
 * registration.ticket_minutes, in an HttpOnly cookie that
 * RequireRegistrationCode asks for on POST /register. Throttled by its route.
 */
class RegistrationCodeController extends Controller
{
    public function verify(Request $request)
    {
        $expected = mb_strtolower(trim((string) config('registration.code')));
        $given = mb_strtolower(trim((string) $request->input('code', '')));
        if ($expected === '' || !hash_equals($expected, $given)) {
            return response()->json(['message' => 'Invalid access code.'], 422);
        }
        $minutes = max(1, (int) config('registration.ticket_minutes'));
        $ticket = RequireRegistrationCode::ticket(now()->addMinutes($minutes)->getTimestamp());

        return response()->noContent()->cookie(
            RequireRegistrationCode::COOKIE, $ticket, $minutes, '/', null, $request->isSecure(), true, false, 'strict'
        );
    }
}
