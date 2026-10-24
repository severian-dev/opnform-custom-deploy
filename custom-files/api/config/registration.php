<?php

// The registration access code (opnform-custom-deploy). It lives only in the
// server's api/.env as REGISTRATION_CODE, never in the client or this repo.
// Read through config, not env(), because `artisan optimize` caches config.
// Unset or empty: nobody registers without an invite.
return [
    'code' => env('REGISTRATION_CODE', ''),
    // How long a right code lets the browser register, in minutes.
    'ticket_minutes' => (int) env('REGISTRATION_TICKET_MINUTES', 30),
];
