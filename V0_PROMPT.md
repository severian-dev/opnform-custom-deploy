# v0.dev Prompt for OpnForm Custom Pages

Copy and paste this prompt to v0.dev to generate custom landing and login pages.

---

## 📋 Prompt for v0.dev

```
Create two pages for a Vue 3 / Nuxt 3 application.

TECHNICAL STACK:
- Vue 3.5.13 - Composition API with <script setup> syntax
- Nuxt 3.17.1 - auto-imports, file-based routing
- Tailwind CSS 4.1.10 (@tailwindcss/postcss) - utility-first CSS framework
- @nuxt/ui 3.2.0 - component library (UButton, UCard, etc.)
- @iconify-json/heroicons 1.2.2 - icon library (format: i-heroicons-icon-name)
- Vue Router 4.4.5 - client-side routing

REQUIRED STRUCTURE FOR BOTH FILES:

<template>
  <!-- page content here -->
  <open-form-footer />
</template>

<script setup>
import opnformConfig from "~/opnform.config.js"

definePageMeta({
  layout: 'default'  // or middleware: "guest" for login page
})

const appName = computed(() => opnformConfig.app_name || 'OpnForm')

useOpnSeoMeta({
  title: "Title",
  description: "Description"
})
</script>

PAGE 1 - LANDING PAGE (index.vue):
Required imports:
- import { useIsAuthenticated } from '~/composables/useAuthFlow'

Required code:
- const { isAuthenticated: authenticated } = useIsAuthenticated()
- Use {{ appName }} variable to display the app name

Authentication-aware button:
  <UButton v-if="!authenticated" :to="{ name: 'login' }" label="Sign In" />
  <UButton v-else :to="{ name: 'home' }" label="Dashboard" />

Must end with: <open-form-footer />

PAGE 2 - LOGIN PAGE (login.vue):
Required imports:
- import LoginForm from "~/components/pages/auth/components/LoginForm.vue"

definePageMeta must have: middleware: "guest"

CRITICAL: Must include <login-form /> component which provides:
- Email input field
- Password input field
- "Remember me" checkbox
- "Forgot your password?" link
- "Log in to continue" submit button (handles form submission)
- Optional "Sign in with Google" button
- "Don't have an account? Sign Up" link
DO NOT recreate these form elements. The <login-form /> component is complete and handles all authentication logic including OAuth, two-factor auth, and password reset.

REQUIRED LOGIN PAGE STRUCTURE:
The <login-form /> component must be wrapped in this exact structure:

<div class="flex mt-6 mb-10">
  <div class="w-full md:max-w-6xl mx-auto px-4 flex md:flex-row-reverse flex-wrap">
    <!-- Form Section (right side on desktop) -->
    <div class="w-full md:w-1/2 md:p-6">
      <div class="border rounded-md p-6 shadow-md sticky top-4">
        <h2 class="font-semibold text-2xl">
          Login to {{ appName }}
        </h2>
        <p class="text-sm text-neutral-500">
          Welcome back! Please enter your details.
        </p>

        <login-form />
      </div>
    </div>

    <!-- Marketing Section (left side on desktop) -->
    <div class="w-full md:w-1/2 md:p-6 mt-8 md:mt-0">
      <!-- Your marketing content here -->
      <h1>...</h1>
      <p>...</p>
    </div>
  </div>
</div>

KEY STYLING NOTES:
- Form container: border rounded-md p-6 shadow-md sticky top-4
- Two-column layout: both md:w-1/2 (50/50 split on desktop)
- Layout reverses on desktop: md:flex-row-reverse (form shows on right)
- Max width container: md:max-w-6xl mx-auto
- Form heading must use {{ appName }} variable

Must end with: <open-form-footer />

TECHNICAL CONSTRAINTS:
- Valid Vue 3 SFC (Single File Component) format
- Must use <script setup> (NOT Options API)
- Do not recreate form inputs - use <login-form /> component as-is
- Use {{ appName }} for any app name references (not hardcoded text)
- Most composables are auto-imported in Nuxt, but useIsAuthenticated requires explicit import
- Routing uses Nuxt route names: { name: 'login' }, { name: 'home' }

AVAILABLE COMPONENTS:
- <UButton label="Text" :to="{ name: 'route' }" size="sm|md|lg" />
- <UCard class="...">content</UCard>
- <NuxtLink :to="{ name: 'route' }">text</NuxtLink>

Generate the code for both pages.
```

---

## 🎯 How to Use

1. Copy the prompt above (everything in the code block)
2. Paste into [v0.dev](https://v0.dev)
3. Copy generated code to:
   - `custom-files/client/pages/index.vue`
   - `custom-files/client/pages/login.vue`

---

## ✅ Verify Generated Code Has:

**index.vue:**
- [ ] `<script setup>` with opnformConfig import
- [ ] `import { useIsAuthenticated } from '~/composables/useAuthFlow'`
- [ ] `const appName = computed(...)`
- [ ] `const { isAuthenticated: authenticated } = useIsAuthenticated()`
- [ ] `{{ appName }}` in template
- [ ] `v-if="!authenticated"` and `v-else` for conditional buttons
- [ ] `<open-form-footer />` at end

**login.vue:**
- [ ] `<script setup>` with opnformConfig import
- [ ] `import LoginForm from "~/components/pages/auth/components/LoginForm.vue"`
- [ ] `const appName = computed(...)`
- [ ] `definePageMeta({ middleware: "guest" })`
- [ ] `<login-form />` component in template (NOT recreated form fields)
- [ ] `{{ appName }}` in template
- [ ] `<open-form-footer />` at end

---

## 🔧 Common Fixes Needed

If v0.dev generates incorrect code:

**Wrong API syntax:**
```vue
<!-- Wrong (Options API) -->
<script>
export default {
  data() { ... }
}
</script>

<!-- Correct (Composition API) -->
<script setup>
import { useIsAuthenticated } from '~/composables/useAuthFlow'
const appName = computed(...)
</script>
```

**Missing required imports:**
```vue
<script setup>
import LoginForm from "~/components/pages/auth/components/LoginForm.vue"
import opnformConfig from "~/opnform.config.js"
import { useIsAuthenticated } from '~/composables/useAuthFlow'
</script>
```

**Hardcoded app name:**
```vue
<!-- Wrong -->
<h1>Login to OpnForm</h1>

<!-- Correct -->
<h1>Login to {{ appName }}</h1>
```

**Recreated login form (WRONG):**
```vue
<!-- Wrong - v0 might try to recreate the entire form -->
<form @submit="handleLogin">
  <input type="email" v-model="email" />
  <input type="password" v-model="password" />
  <button type="submit">Login</button>
</form>

<!-- Correct - use the existing component -->
<login-form />
```

**The login-form component is self-contained and needs no props or event handlers from your page.**
