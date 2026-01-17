# Custom Pages

This directory contains custom page templates for your OpnForm instance.

## 📄 Included Templates

### ✅ index.vue (Landing Page)

**What it does:**
- Custom homepage that replaces the default OpnForm landing page
- Dynamically uses `app_name` from `opnform.config.js`
- Clean, minimal design focused on internal organization use

**Features:**
- Hero section with your app name
- Three feature cards (customizable)
- Sign In / Dashboard button (based on auth state)
- Footer with org branding

**Customization:**
- Edit the headline text
- Modify the description
- Change or remove feature cards
- Adjust colors and styling

### ✅ login.vue (Login Page)

**What it does:**
- Custom login page that replaces the default
- Uses the actual OpnForm `<login-form />` component (all auth features work)
- Dynamically uses `app_name` from config

**Features:**
- Login form with email/password
- OAuth integration (if enabled)
- Two-factor authentication support
- Password reset functionality
- Marketing copy that references your org name

**Customization:**
- Edit the marketing text on the left side
- Modify feature list
- Keep the `<login-form />` component unchanged

---

## 🎨 How to Customize

### 1. Edit Content

**index.vue:**
```vue
<!-- Change this section -->
<h1>
  Welcome to
  <span>{{ appName }}</span>  <!-- Auto-populated from config -->
</h1>

<p>
  Create and manage forms...  <!-- Change this text -->
</p>

<!-- Modify feature cards -->
<div>
  <h3>Easy to Use</h3>  <!-- Change feature name -->
  <p>Create forms...</p>  <!-- Change description -->
</div>
```

**login.vue:**
```vue
<!-- Change this section -->
<h1>
  Create beautiful forms for your organization  <!-- Customize this -->
</h1>

<p>
  Secure, fast, and easy to use...  <!-- Customize this -->
</p>
```

### 2. Keep These Parts

**DON'T change these:**

```vue
<!-- In login.vue - KEEP THIS -->
<login-form />  <!-- This handles all authentication -->

<!-- In both files - KEEP THESE -->
<script setup>
import opnformConfig from "~/opnform.config.js"
const appName = computed(() => opnformConfig.app_name || 'OpnForm')
</script>
```

---

## 🚀 Deployment

These templates are **ready to use**. The deploy script will:

1. ✅ Copy `index.vue` to replace the landing page
2. ✅ Copy `login.vue` to replace the login page
3. ✅ Automatically use your `app_name` from config
4. ✅ Build everything into the Docker image

**No additional steps needed!**

---

## 🎯 Design Philosophy

These templates are intentionally:

- **Simple** - Easy to understand and customize
- **Clean** - Minimal design for professional appearance
- **Functional** - All OpnForm features still work
- **Dynamic** - Uses config values, not hardcoded text

**For internal org use:**
- Removed marketing fluff
- Focused on functionality
- Clear calls to action
- Professional appearance

---

## 📝 Customization Examples

### Change Colors

```vue
<!-- From blue gradient to green -->
<span class="bg-clip-text text-transparent bg-gradient-to-r from-green-600 to-green-400">
  {{ appName }}
</span>
```

### Add More Features

```vue
<!-- Add a 4th feature card -->
<div class="text-center p-6">
  <div class="text-blue-600 text-5xl mb-4">🎯</div>
  <h3 class="text-xl font-semibold mb-2">Accurate</h3>
  <p class="text-neutral-600">Collect precise data</p>
</div>
```

### Remove Features Section

```vue
<!-- Delete or comment out the entire section -->
<!--
<section class="py-16 bg-white">
  ... entire features section ...
</section>
-->
```

### Add Custom Logo to Login Page

```vue
<!-- Add before the h2 in login.vue -->
<div class="flex justify-center mb-4">
  <img src="/img/logo.svg" alt="Logo" class="h-16 w-16" />
</div>
<h2 class="font-semibold text-2xl">
  Login to {{ appName }}
</h2>
```

---

## 🔧 Advanced Customization

### Using Your Own Components

You can import and use any Vue components:

```vue
<script setup>
import MyCustomComponent from "~/components/custom/MyCustomComponent.vue"
</script>

<template>
  <MyCustomComponent />
</template>
```

### Adding Custom Styles

```vue
<style scoped>
.custom-gradient {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.feature-card:hover {
  transform: translateY(-4px);
  transition: transform 0.3s ease;
}
</style>
```

### Conditional Content Based on Feature Flags

```vue
<script setup>
const isSelfHosted = computed(() => useFeatureFlag('self_hosted'))
</script>

<template>
  <div v-if="!isSelfHosted">
    <!-- Only show for non-self-hosted -->
  </div>
</template>
```

---

## 🎨 Tailwind CSS Reference

Quick reference for styling (see QUICK_REFERENCE.md for complete guide):

```
Spacing:      p-4, px-6, py-8, mt-4, mb-2, gap-4
Colors:       text-blue-600, bg-white, border-neutral-200
Typography:   text-xl, font-bold, leading-9
Layout:       flex, grid, items-center, justify-center
Responsive:   md:w-1/2, lg:text-6xl, hidden sm:block
```

---

## ✅ Pre-Deployment Checklist

Before deploying:

- [ ] Edited content in `index.vue` to match your org
- [ ] Edited marketing text in `login.vue` to match your org
- [ ] Kept `<login-form />` component unchanged
- [ ] Tested that `{{ appName }}` will be replaced correctly
- [ ] Set `app_name` in `opnform.config.js`
- [ ] Reviewed both pages for any placeholder text

---

## 🔄 How the App Name Works

**In your config** (`opnform.config.js`):
```javascript
app_name: "Acme Corp Forms"
```

**In your templates:**
```vue
<script setup>
const appName = computed(() => opnformConfig.app_name || 'OpnForm')
</script>

<template>
  <h1>Welcome to {{ appName }}</h1>  <!-- Shows: Welcome to Acme Corp Forms -->
</template>
```

**The deploy script also:**
- Replaces "OpnForm" in Navbar → "Acme Corp Forms"
- Replaces "OpnForm" in Footer → "Acme Corp Forms"
- Updates `APP_NAME` in `/api/.env` → "Acme Corp Forms"

**Result:** Your org name appears consistently throughout the entire application!

---

**Need help?** See the main [README.md](../../README.md) or [BRANDING_CHECKLIST.md](../../BRANDING_CHECKLIST.md)
