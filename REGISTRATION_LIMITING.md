# Limiting Registration Access

This guide shows different ways to limit registration to friends only, without completely disabling it.

---

## Option 1: Hide the "Sign Up" Link (Simplest)

**What it does:** Removes the visible "Sign up" link from the login page. Registration still works at `/register` but isn't advertised.

**Security Level:** Low (anyone who guesses `/register` can sign up)

**How to use:**
1. The custom `LoginForm.vue` component is already created in `custom-files/client/components/pages/auth/components/LoginForm.vue`
2. Deploy with `./deploy.sh`
3. Share the direct link with friends: `https://your-domain.com/register`

**Pros:**
- Very simple, no configuration needed
- Friends can bookmark the register URL
- No maintenance required

**Cons:**
- Anyone who discovers `/register` can still sign up
- Not truly secure, just "security through obscurity"

---

## Option 2: Access Code Protection (Moderate)

**What it does:** Adds a simple access code to the registration page. Only people with the code can register.

**Security Level:** Medium (code can be shared easily)

**How to use:**
1. Use the `register-with-code.vue` page instead of `register.vue`
2. Edit the access code on line 95:
   ```javascript
   const VALID_CODE = 'avalon2026'  // Change this to your secret
   ```
3. Rename files:
   ```bash
   cd custom-files/client/pages
   mv register.vue register-original.vue
   mv register-with-code.vue register.vue
   ```
4. Deploy with `./deploy.sh`
5. Share the code with friends: "Go to /register and use code: avalon2026"

**Pros:**
- Easy to implement
- Code can be changed anytime
- Friends can register themselves

**Cons:**
- Code is stored in client-side JavaScript (visible if someone inspects the code)
- Once code is shared, it can spread to strangers
- No way to revoke access for individual users

---

## Option 3: Invite-Only Registration (Most Secure)

**What it does:** Uses OpnForm's built-in invite system. Only users with invite tokens can register.

**Security Level:** High (unique tokens per user)

**How it works:**

OpnForm already supports invite-only registration when `SELF_HOSTED=true`. When enabled:
- Normal registration is blocked
- Users need a URL like: `/register?email=friend@example.com&invite_token=abc123`
- Each invite token is unique and can only be used once

**Setting it up:**

1. **Set SELF_HOSTED=true** in `api/.env`:
   ```env
   SELF_HOSTED=true
   ```

2. **Create invite tokens** (you'll need to implement this):

   Option A - Manual database insert:
   ```bash
   # SSH into your server
   docker compose exec api php artisan tinker

   # In tinker:
   $token = \Illuminate\Support\Str::random(32);
   $email = 'friend@example.com';
   \DB::table('workspace_invitations')->insert([
       'workspace_id' => 1,  // Your workspace ID
       'email' => $email,
       'token' => $token,
       'created_at' => now(),
       'updated_at' => now(),
   ]);
   echo "Invite URL: /register?email=$email&invite_token=$token";
   ```

   Option B - Create an admin command (requires custom code):
   ```bash
   # You'd create a custom artisan command
   php artisan invite:create friend@example.com
   ```

3. **Send invite links to friends**:
   ```
   https://your-domain.com/register?email=friend@example.com&invite_token=abc123xyz...
   ```

**Pros:**
- Most secure option
- Tokens are unique per user
- Tokens can be one-time use
- You control exactly who can register

**Cons:**
- Requires database access or custom admin tool
- More complex to set up
- You need to manually create invites for each friend
- Uses SELF_HOSTED=true (which may affect other features)

---

## Option 4: Email Domain Whitelist (Custom)

**What it does:** Only allows registration from specific email domains (e.g., only @yourcompany.com).

**Security Level:** Medium to High (depends on email domain)

**How to implement:**

This requires creating a custom validation rule. Create:
`custom-files/api/app/Rules/WhitelistedEmailDomain.php`:

```php
<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;

class WhitelistedEmailDomain implements Rule
{
    protected $allowedDomains = [
        'gmail.com',      // Add allowed domains
        'yourfriend.com',
        // Add more domains
    ];

    public function passes($attribute, $value)
    {
        $domain = substr(strrchr($value, "@"), 1);
        return in_array($domain, $this->allowedDomains);
    }

    public function message()
    {
        return 'Registration is only available for approved email domains.';
    }
}
```

Then modify the RegisterController to use this rule (requires more advanced customization).

**Pros:**
- Works well for specific communities
- Friends can register themselves if they have the right email

**Cons:**
- Only works if your friends share common email domains
- Requires PHP code modification
- More complex to maintain

---

## Recommendation

**For most cases, use Option 1 + Option 2 combined:**

1. **Hide the signup link** (Option 1) - Use custom `LoginForm.vue`
2. **Add access code** (Option 2) - Use `register-with-code.vue`
3. **Share both** with friends:
   - URL: `https://your-domain.com/register`
   - Code: `avalon2026` (or whatever you set)

This gives you:
- Two layers of obscurity (hidden link + access code)
- Easy to share with friends
- Simple to maintain
- No database changes needed

**For maximum security, use Option 3** (invite-only), but it requires more technical setup.

---

## Quick Setup for Option 1 + 2

```bash
cd opnform-custom-deploy/custom-files/client/pages

# Rename the files
mv register.vue register-original.vue
mv register-with-code.vue register.vue

# Edit the access code
nano register.vue
# Change line 95: const VALID_CODE = 'your-secret-here'

# Deploy
cd ../../../
./deploy.sh

# Share with friends:
# "Go to https://your-domain.com/register and enter code: your-secret-here"
```

---

## Changing the Access Code Later

If you need to change the code (e.g., if it leaks):

1. Edit `custom-files/client/pages/register.vue` line 95
2. Run `./deploy.sh` to rebuild
3. Notify friends of the new code

The rebuild takes 2-5 minutes (uses cache, faster than first build).

---

## Monitoring Registrations

Keep an eye on who registers:

```bash
# Check recent user registrations
docker compose exec db psql -U opnform_user opnform -c "SELECT id, name, email, created_at FROM users ORDER BY created_at DESC LIMIT 10;"

# Count total users
docker compose exec db psql -U opnform_user opnform -c "SELECT COUNT(*) FROM users;"
```

If you see unexpected registrations, change the access code immediately.
