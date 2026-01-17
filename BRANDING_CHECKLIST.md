# Branding Checklist

Complete guide to preparing all files needed for your custom OpnForm deployment.

---

## 📋 Required Files Checklist

### 1. Logo Files ✅

**Location:** `custom-files/client/public/img/`

| File | Format | Dimensions | Usage | Priority |
|------|--------|------------|-------|----------|
| **logo.svg** | SVG | 24×24px display size | Navbar logo (scales perfectly) | **REQUIRED** |
| **logo.png** | PNG | 48×48px (2x for retina) | Fallback if SVG unavailable | Recommended |
| **favicon.ico** | ICO | 16×16, 32×32, 48×48 | Browser tab icon | **REQUIRED** |
| social-preview.jpg | JPG | 1200×630px | Social media sharing | Optional |

**Logo Design Notes:**
- **Navbar Display**: Logo shows at `24×24px` (Tailwind class: `w-6 h-6`)
- **Format Priority**: SVG is best (scales to any size, small file)
- **Background**: Must have transparent background
- **Orientation**: Square or slightly wide works best
- **Simplicity**: Should be recognizable at small size (24px)
- **Color**: Should work on white backgrounds

**How logo is used in code** (`/client/components/global/Navbar.vue:13-20`):
```vue
<img
  src="/img/logo.svg"
  alt="your logo"
  class="w-6 h-6"
>
<span class="ml-2 text-md">OpnForm</span>
```

---

### 2. Configuration Files ✅

**Location:** `custom-files/client/`

#### A. opnform.config.js

**What to customize:**

```javascript
export default {
  // CHANGE THIS: Your organization name
  app_name: "YourOrg Forms",

  links: {
    // CHANGE THESE: Your organization's URLs
    help_url: "https://yourorg.com/help",

    // REMOVE THESE: Set to empty string "" to hide
    github_url: "",
    discord: "",
    twitter: "",
    // ... etc
  }
}
```

**Example:**
```javascript
export default {
  app_name: "Acme Corp Forms",
  locale: "en",
  locales: { en: "EN" },
  githubAuth: null,
  notion: { worker: "https://notion-forms-worker.notionforms.workers.dev/v1" },
  links: {
    help_url: "https://acme.com/support",
    github_url: "",  // Hidden
    discord: "",     // Hidden
    twitter: "",     // Hidden
    tech_docs: "https://docs.acme.com",
    api_docs: "https://docs.acme.com/api",
  },
}
```

#### B. app.config.ts

**What to customize:**

```typescript
export default defineAppConfig({
  ui: {
    colors: {
      primary: 'blue',    // CHANGE: Your brand color
      secondary: 'blue',  // CHANGE: Secondary color
      // ... rest stay the same
    }
  }
})
```

**Available Tailwind colors:**
- `blue`, `green`, `red`, `purple`, `pink`, `indigo`, `cyan`, `teal`, `emerald`, `lime`, `amber`, `orange`, `yellow`, `rose`, `fuchsia`, `violet`, `sky`, `neutral`, `gray`, `slate`, `zinc`, `stone`

**Example:**
```typescript
export default defineAppConfig({
  ui: {
    colors: {
      primary: 'emerald',    // Acme's brand green
      secondary: 'teal',
      success: 'green',
      error: 'red',
      warning: 'amber',
      info: 'blue',
      neutral: 'neutral',
      form: 'form'
    }
  }
})
```

---

### 3. Custom Pages (Optional) 📄

**Location:** `custom-files/client/pages/`

#### A. Homepage (index.vue)

**Priority:** Optional (can use default)

**Template provided:** `custom-files/client/pages/EXAMPLE_index.vue`

**To use:**
1. Rename `EXAMPLE_index.vue` → `index.vue`
2. Customize content
3. Deploy

#### B. Login Page (login.vue)

**Priority:** Optional (recommended to use default)

**Default login page includes:**
- Email/password authentication
- "Remember me" checkbox
- "Forgot password" link
- Google Sign-In (if enabled)
- OAuth integration
- Two-factor authentication

**Your branding applies automatically:**
- Logo in navbar
- App name in heading
- Brand colors

**Only customize if you need to:**
- Change marketing copy on the left side
- Add organization-specific disclaimer
- Modify layout structure

**Current login page text** (`/client/pages/login.vue:9-14`):
```vue
<h2 class="font-semibold text-2xl">
  Login to OpnForm
</h2>
<p class="text-sm text-neutral-500">
  Welcome back! Please enter your details.
</p>
```

To customize, copy `/client/pages/login.vue` and change these lines.

---

## 🎨 Frameworks & Technologies Used

### Frontend Stack

| Technology | Purpose | What You Need to Know |
|-----------|---------|----------------------|
| **Vue 3** | JavaScript framework | Use `<script setup>` syntax |
| **Nuxt.js 3** | Vue meta-framework | File-based routing, auto-imports |
| **Tailwind CSS** | Styling | Utility classes like `bg-blue-500`, `text-xl`, `px-4` |
| **@nuxt/ui** | Component library | Pre-built components: `UButton`, `UCard`, `UInput` |
| **Heroicons** | Icon library | Icons like `i-heroicons-arrow-right` |

### Styling System

**Tailwind CSS Utility Classes**

Common patterns you'll see:

```vue
<!-- Spacing -->
<div class="px-4 py-8">        <!-- padding: horizontal 1rem, vertical 2rem -->
<div class="mt-4 mb-2">        <!-- margin-top: 1rem, margin-bottom: 0.5rem -->

<!-- Colors -->
<p class="text-blue-600">      <!-- text color: blue 600 shade -->
<div class="bg-white">         <!-- background: white -->

<!-- Typography -->
<h1 class="text-4xl font-bold">  <!-- font size: 2.25rem, font weight: bold -->
<p class="text-sm text-neutral-500">  <!-- small text, gray color -->

<!-- Layout -->
<div class="flex items-center gap-4">  <!-- flexbox: centered items, 1rem gap -->
<div class="grid md:grid-cols-2">      <!-- grid: 2 columns on medium+ screens -->

<!-- Responsive -->
<div class="w-full md:w-1/2">  <!-- width: 100% mobile, 50% on medium+ -->
```

**Nuxt UI Components**

Available components from `@nuxt/ui`:

```vue
<!-- Button -->
<UButton
  label="Click Me"
  color="primary"
  size="lg"
  trailing-icon="i-heroicons-arrow-right"
/>

<!-- Card -->
<UCard class="shadow-md">
  <p>Card content</p>
</UCard>

<!-- Input (custom wrapper) -->
<text-input
  name="email"
  label="Email"
  placeholder="Your email"
/>
```

### Vue 3 Composition API

**Template Syntax:**

```vue
<template>
  <div>
    <!-- Data binding -->
    <p>{{ variableName }}</p>

    <!-- Conditional rendering -->
    <div v-if="isLoggedIn">Welcome!</div>
    <div v-else>Please log in</div>

    <!-- Loop -->
    <div v-for="item in items" :key="item.id">
      {{ item.name }}
    </div>

    <!-- Event handling -->
    <button @click="handleClick">Click</button>

    <!-- Dynamic attributes -->
    <a :href="dynamicUrl">Link</a>
  </div>
</template>

<script setup>
// Reactive variables
const variableName = ref('Hello')
const isLoggedIn = computed(() => user.value !== null)

// Functions
const handleClick = () => {
  console.log('Clicked!')
}

// Composables (auto-imported in Nuxt)
const { data: user } = useAuth().user()
</script>
```

---

## 📝 File Preparation Workflow

### Step 1: Logo Files

**Tools you can use:**
- [Figma](https://figma.com) - Design logos
- [SVGOMG](https://jakearchibald.github.io/svgomg/) - Optimize SVG files
- [Favicon.io](https://favicon.io) - Generate favicons

**Workflow:**

1. **Design logo** (square or horizontal)
   - Design at larger size (e.g., 512×512px)
   - Keep it simple and recognizable

2. **Export SVG**
   - Export as SVG
   - Optimize with SVGOMG
   - Save as `logo.svg`

3. **Export PNG**
   - Export at 48×48px (2x size for retina)
   - Transparent background
   - Save as `logo.png`

4. **Create favicon**
   - Go to [Favicon.io](https://favicon.io)
   - Upload your logo PNG
   - Download `favicon.ico`

5. **Place files:**
   ```bash
   custom-files/client/public/img/
   ├── logo.svg
   ├── logo.png
   └── favicon.ico
   ```

### Step 2: Configuration Files

**Edit with any text editor:**

1. **Open** `custom-files/client/opnform.config.js`
2. **Change** `app_name` to your organization
3. **Update** links (or set to `""` to hide)
4. **Save**

5. **Open** `custom-files/client/app.config.ts`
6. **Change** `primary` color to your brand color
7. **Save**

### Step 3: Custom Pages (Optional)

**If customizing homepage:**

1. **Rename:**
   ```bash
   mv custom-files/client/pages/EXAMPLE_index.vue custom-files/client/pages/index.vue
   ```

2. **Edit** `index.vue`:
   - Change headline text
   - Update description
   - Modify features section
   - Update SEO meta tags

3. **Save**

**If customizing login page:**

1. **Copy original:**
   ```bash
   cp /path/to/OpnForm/client/pages/login.vue custom-files/client/pages/login.vue
   ```

2. **Edit** the marketing copy (left side)
3. **Keep** the `<login-form />` component unchanged
4. **Save**

---

## ✅ Pre-Deployment Checklist

Before running `./deploy.sh`:

- [ ] Logo files created and placed in `custom-files/client/public/img/`
  - [ ] logo.svg (24×24px display, SVG format)
  - [ ] logo.png (48×48px, transparent background)
  - [ ] favicon.ico (16×16, 32×32 sizes)

- [ ] Configuration files edited
  - [ ] `opnform.config.js` - app_name updated
  - [ ] `opnform.config.js` - links updated or removed
  - [ ] `app.config.ts` - brand colors set

- [ ] Custom pages (if applicable)
  - [ ] Homepage customized (or using default)
  - [ ] Login page customized (or using default)

- [ ] Environment files ready
  - [ ] `api/.env` configured
  - [ ] `client/.env` configured

- [ ] Server requirements met
  - [ ] Docker installed
  - [ ] Docker Compose installed
  - [ ] 4GB+ RAM available
  - [ ] 10GB+ disk space available

---

## 🎨 Branding Examples

### Minimal Customization (Recommended to Start)

**Files needed:**
1. `logo.svg` - Your logo
2. `logo.png` - Fallback logo
3. `favicon.ico` - Browser icon
4. `opnform.config.js` - Change app name

**Result:**
- Your logo in navbar
- Your org name throughout the app
- Default pages with your branding
- Takes 5 minutes to prepare

### Full Customization

**Additional files:**
1. `app.config.ts` - Brand colors
2. `pages/index.vue` - Custom homepage
3. `pages/login.vue` - Custom login page (optional)
4. `css/app.css` - Custom CSS (optional)

**Result:**
- Complete brand alignment
- Custom homepage
- Modified login experience
- Takes 1-2 hours to prepare

---

## 🔍 Testing Your Branding Locally (Optional)

Before deploying to server, you can test locally:

1. **Copy files to OpnForm:**
   ```bash
   cp custom-files/client/public/img/* /path/to/OpnForm/client/public/img/
   cp custom-files/client/opnform.config.js /path/to/OpnForm/client/
   cp custom-files/client/app.config.ts /path/to/OpnForm/client/
   ```

2. **Run dev server:**
   ```bash
   cd /path/to/OpnForm/client
   npm install
   npm run dev
   ```

3. **Preview at:** `http://localhost:3000`

4. **Check:**
   - Logo appears in navbar
   - App name shows correctly
   - Colors match your brand
   - Pages look correct

---

## 📚 Resources

### Design Tools
- [Figma](https://figma.com) - Logo design
- [Canva](https://canva.com) - Simple logo creation
- [SVGOMG](https://jakearchibald.github.io/svgomg/) - SVG optimizer
- [Favicon.io](https://favicon.io) - Favicon generator

### Documentation
- [Vue 3 Docs](https://vuejs.org/guide/introduction.html)
- [Nuxt 3 Docs](https://nuxt.com/docs)
- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [Nuxt UI Docs](https://ui.nuxt.com)
- [Heroicons](https://heroicons.com)

### Tailwind References
- [Color Palette](https://tailwindcss.com/docs/customizing-colors)
- [Spacing Scale](https://tailwindcss.com/docs/customizing-spacing)
- [Typography](https://tailwindcss.com/docs/font-size)
- [Flexbox](https://tailwindcss.com/docs/flex)
- [Grid](https://tailwindcss.com/docs/grid-template-columns)

---

**Questions?** See the main [README.md](README.md) for detailed documentation and troubleshooting.
