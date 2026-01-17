# Quick Reference Card

Essential information for customizing OpnForm.

---

## 📦 Files You Need to Prepare

### Absolutely Required
```
custom-files/client/public/img/
├── logo.svg               24×24px display (SVG, transparent)
├── logo.png               48×48px (PNG, transparent, fallback)
└── favicon.ico            16×16, 32×32 (ICO format)

custom-files/client/
├── opnform.config.js      Change app_name + links
└── app.config.ts          Change primary color
```

### Optional
```
custom-files/client/pages/
├── index.vue              Custom homepage
└── login.vue              Custom login page

custom-files/client/css/
└── app.css                Custom CSS
```

---

## 🎨 Tech Stack Quick Guide

| What | Technology | Syntax |
|------|-----------|--------|
| Framework | Vue 3 | `<script setup>` |
| Meta-Framework | Nuxt.js 3 | Auto-imports, file routing |
| Styling | Tailwind CSS | `class="text-blue-500 px-4"` |
| Components | @nuxt/ui | `<UButton label="Click" />` |
| Icons | Heroicons | `i-heroicons-arrow-right` |

---

## 🎯 Tailwind CSS Cheat Sheet

### Common Classes

```css
/* Spacing */
p-4          padding: 1rem
px-4         padding left/right: 1rem
py-8         padding top/bottom: 2rem
m-4          margin: 1rem
mt-2         margin-top: 0.5rem
gap-4        gap: 1rem

/* Colors */
text-blue-500       text color
bg-white            background color
border-neutral-200  border color

/* Typography */
text-sm        font-size: 0.875rem (14px)
text-base      font-size: 1rem (16px)
text-lg        font-size: 1.125rem (18px)
text-xl        font-size: 1.25rem (20px)
text-2xl       font-size: 1.5rem (24px)
text-4xl       font-size: 2.25rem (36px)
font-bold      font-weight: 700
font-semibold  font-weight: 600

/* Layout */
flex                display: flex
items-center        align-items: center
justify-between     justify-content: space-between
grid                display: grid
grid-cols-2         grid-template-columns: repeat(2, 1fr)

/* Responsive */
md:w-1/2           width: 50% on medium+ screens
lg:block           display: block on large+ screens
hidden md:flex     hidden on mobile, flex on medium+

/* Sizing */
w-full             width: 100%
h-screen           height: 100vh
max-w-7xl          max-width: 80rem

/* Rounded corners */
rounded            border-radius: 0.25rem
rounded-md         border-radius: 0.375rem
rounded-full       border-radius: 9999px

/* Shadows */
shadow             box-shadow: default
shadow-md          box-shadow: medium
shadow-lg          box-shadow: large
```

### Responsive Breakpoints

```
sm:   640px  @media (min-width: 640px)
md:   768px  @media (min-width: 768px)
lg:   1024px @media (min-width: 1024px)
xl:   1280px @media (min-width: 1280px)
2xl:  1536px @media (min-width: 1536px)
```

---

## 🧩 Vue 3 Template Syntax

```vue
<template>
  <!-- Variables -->
  <p>{{ message }}</p>

  <!-- Attributes -->
  <a :href="url">Link</a>
  <img :src="imagePath" />

  <!-- Conditionals -->
  <div v-if="isVisible">Show this</div>
  <div v-else>Show that</div>

  <!-- Loops -->
  <div v-for="item in items" :key="item.id">
    {{ item.name }}
  </div>

  <!-- Events -->
  <button @click="handleClick">Click</button>
  <input @input="handleInput" />
  <form @submit.prevent="handleSubmit">

  <!-- Classes -->
  <div :class="{ 'active': isActive }">
  <div :class="[isActive ? 'bg-blue-500' : 'bg-gray-200']">
</template>

<script setup>
// Reactive data
const message = ref('Hello')
const count = ref(0)

// Computed
const doubled = computed(() => count.value * 2)

// Functions
const handleClick = () => {
  count.value++
}

// Composables (auto-imported)
const { data: user } = useAuth().user()
const authenticated = useIsAuthenticated()
</script>
```

---

## 📐 Exact Logo Dimensions

Based on code at `/client/components/global/Navbar.vue:13-17`:

```vue
<img
  src="/img/logo.svg"
  alt="logo"
  class="w-6 h-6"    ← 24px × 24px
>
```

**Recommendations:**
- **Design at:** 512×512px (or 1024×1024px)
- **Export SVG:** Any size (it scales)
- **Export PNG:** 48×48px (2× for retina)
- **Display size:** 24×24px (Tailwind w-6 h-6)

---

## 🎨 Available Tailwind Colors

For `app.config.ts` → `colors.primary`:

```
slate    gray     zinc     neutral  stone
red      orange   amber    yellow   lime
green    emerald  teal     cyan     sky
blue     indigo   violet   purple   fuchsia   pink   rose
```

Each has shades: 50, 100, 200, 300, 400, 500, 600, 700, 800, 900

---

## 🔧 Nuxt UI Components

Common components you'll use:

```vue
<!-- Button -->
<UButton
  label="Click Me"
  color="primary"
  size="sm|md|lg"
  variant="solid|outline|ghost"
  icon="i-heroicons-home"
  trailing-icon="i-heroicons-arrow-right"
  :loading="isLoading"
  block
/>

<!-- Card -->
<UCard class="shadow-md">
  <template #header>
    <h3>Card Title</h3>
  </template>

  <p>Card content</p>

  <template #footer>
    <UButton label="Action" />
  </template>
</UCard>

<!-- Link -->
<NuxtLink :to="{ name: 'home' }">
  Home
</NuxtLink>

<!-- External Link -->
<NuxtLink to="https://example.com" target="_blank">
  External
</NuxtLink>
```

---

## 🚀 Deployment Commands

```bash
# On your VPS
git clone https://github.com/OpnForm/OpnForm.git
cd OpnForm
git clone https://github.com/YourOrg/opnform-custom-deploy.git

# Configure
nano api/.env
nano client/.env

# Deploy (first time)
cd opnform-custom-deploy
./deploy.sh

# Check status
docker-compose ps
docker-compose logs -f

# Update customizations
# Edit files in custom-files/
./deploy.sh

# Rebuild from scratch
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

---

## 📁 Where Things Are

```
OpnForm/
├── client/                          Frontend (Nuxt.js)
│   ├── pages/                       Routes (file-based)
│   │   ├── index.vue               → /
│   │   ├── login.vue               → /login
│   │   └── home.vue                → /home
│   ├── components/
│   │   └── global/
│   │       └── Navbar.vue          Navigation bar
│   ├── public/
│   │   └── img/
│   │       ├── logo.svg            Your logo here
│   │       └── logo.png            Fallback logo
│   ├── opnform.config.js           App name & links
│   ├── app.config.ts               Theme colors
│   └── .env                        Frontend config
│
├── api/                             Backend (Laravel)
│   └── .env                        Backend config
│
├── docker-compose.yml              Docker setup
└── opnform-custom-deploy/          Your customizations
    ├── deploy.sh                   Deployment script
    ├── docker-compose.override.yml Build config
    └── custom-files/               Your files
        └── client/
            ├── public/img/         Logos
            ├── pages/              Custom pages
            ├── opnform.config.js   Config
            └── app.config.ts       Colors
```

---

## 🎯 Customization Levels

### Level 1: Minimal (5 minutes)
- ✅ Add logo files
- ✅ Change app name in `opnform.config.js`
- Result: Branded navbar + app name

### Level 2: Recommended (15 minutes)
- ✅ Level 1 +
- ✅ Set brand colors in `app.config.ts`
- ✅ Update/remove links in `opnform.config.js`
- Result: Full brand identity

### Level 3: Custom Pages (1-2 hours)
- ✅ Level 2 +
- ✅ Customize homepage (`index.vue`)
- ✅ Modify login page (`login.vue`)
- ✅ Add custom CSS
- Result: Unique user experience

---

## 🆘 Quick Troubleshooting

```bash
# Build fails
→ Increase Docker memory to 8GB

# Port 80 in use
→ Change port in docker-compose.yml to 8080:80

# Changes not showing
→ docker-compose down
→ docker-compose build --no-cache
→ docker-compose up -d

# Logo not showing
→ Hard refresh: Ctrl+Shift+R (or Cmd+Shift+R)
→ Check file names are exact (case-sensitive)

# Containers exit
→ docker-compose logs api
→ docker-compose logs ui
→ Check .env files exist
```

---

## 📚 Essential Links

- [Vue 3 Docs](https://vuejs.org)
- [Nuxt 3 Docs](https://nuxt.com)
- [Tailwind CSS](https://tailwindcss.com)
- [Nuxt UI](https://ui.nuxt.com)
- [Heroicons](https://heroicons.com)

---

**Need more details?** See [BRANDING_CHECKLIST.md](BRANDING_CHECKLIST.md) for comprehensive guide.
