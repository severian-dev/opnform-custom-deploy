# Color Configuration Guide

Complete guide to how colors work in OpnForm and what values you can use.

---

## 🎨 How Colors Work

OpnForm uses **@nuxt/ui 3.2.0** which integrates with Tailwind CSS to provide a color system.

### Two-Layer System:

1. **Color Keys** (defined in `nuxt.config.ts`)
   - These are the semantic names: `primary`, `secondary`, `success`, etc.

2. **Color Values** (assigned in `app.config.ts`)
   - These map keys to actual Tailwind color names

---

## 📝 Available Color Keys

From `/client/nuxt.config.ts`:

```typescript
ui: {
  theme: {
    colors: [
      'primary',      // Your main brand color
      'secondary',    // Secondary brand color
      'success',      // Success states (usually green)
      'error',        // Error states (usually red)
      'warning',      // Warning states (usually amber/yellow)
      'info',         // Info states (usually blue)
      'neutral',      // Neutral UI elements
      'form'          // Form-specific color
    ]
  }
}
```

**You cannot add new keys** without modifying `nuxt.config.ts`. These are the only available semantic color names.

---

## 🌈 Available Color Values

### Standard Tailwind Colors

In `app.config.ts`, you can use these **Tailwind color names**:

```typescript
export default defineAppConfig({
  ui: {
    colors: {
      primary: 'blue',     // Base color name only (no shade numbers)
      secondary: 'slate',
      // ... etc
    }
  }
})
```

**Available Tailwind Color Names:**

From `/client/css/app.css` safelist and Tailwind CSS v4 defaults:

```
slate     gray      zinc      neutral   stone
red       orange    amber     yellow    lime
green     emerald   teal      cyan      sky
blue      indigo    violet    purple    fuchsia   pink    rose
```

### Color Shades (Auto-Generated)

When you set a base color like `primary: 'blue'`, the system automatically generates all shade variants:

**Shades available:** `50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`

**How they're used in code:**

Setting `primary: 'blue'` generates these utility classes:
- `text-primary` → uses primary color (typically 500 shade)
- `bg-primary-50` → very light blue background
- `bg-primary-100` → light blue background
- `bg-primary-500` → main blue color
- `bg-primary-600` → darker blue (hover states)
- `text-primary-700` → darker blue text
- `border-primary-200` → light blue border
- etc.

**You CANNOT specify shades in app.config.ts:**

```typescript
// ❌ WRONG - Don't include shade numbers
colors: {
  primary: 'blue-600',  // Won't work
  secondary: 'emerald-500',  // Won't work
}

// ✅ CORRECT - Base color name only
colors: {
  primary: 'blue',      // Auto-generates blue-50 through blue-950
  secondary: 'emerald',  // Auto-generates emerald-50 through emerald-950
}
```

### How Components Use Shades

Nuxt UI components automatically select appropriate shades:
- `shade-50` - Very light backgrounds, subtle highlights
- `shade-100` - Light backgrounds, hover states for neutral elements
- `shade-200` - Borders, dividers
- `shade-300` - Disabled states, muted elements
- `shade-400` - Placeholder text
- `shade-500` - Main/default color (buttons, links, primary elements)
- `shade-600` - Hover states for primary elements
- `shade-700` - Active/pressed states
- `shade-800` - Dark mode primary elements
- `shade-900` - Very dark elements, emphasis
- `shade-950` - Darkest shade

---

## ❌ Hex Codes Are NOT Directly Supported

**You CANNOT use hex codes directly in `app.config.ts`:**

```typescript
// ❌ THIS WILL NOT WORK
colors: {
  primary: '#3b82f6',  // Won't work
  secondary: 'rgb(59, 130, 246)',  // Won't work
}
```

**Why?** @nuxt/ui expects Tailwind color names that have a full palette (50-950 shades), not single hex values.

---

## ✅ Using Custom Hex Colors (Advanced)

If you need custom hex colors, you must define them in Tailwind's theme configuration.

### Method 1: Add to `app.css` (Recommended)

Edit `/client/css/app.css`:

```css
@theme {
  /* Your custom brand color */
  --color-brand-50: #eff6ff;
  --color-brand-100: #dbeafe;
  --color-brand-200: #bfdbfe;
  --color-brand-300: #93c5fd;
  --color-brand-400: #60a5fa;
  --color-brand-500: #3b82f6;  /* Main color */
  --color-brand-600: #2563eb;
  --color-brand-700: #1d4ed8;
  --color-brand-800: #1e40af;
  --color-brand-900: #1e3a8a;
  --color-brand-950: #172554;
}
```

Then in `app.config.ts`:

```typescript
colors: {
  primary: 'brand',  // Uses your custom brand-* colors
}
```

### Method 2: Use Existing Color with Override

Replace the `--form-color` variable in `app.css`:

```css
@theme {
  /* Change the form color to your custom hex */
  --form-color: #your-hex-code;
}
```

Then use:

```typescript
colors: {
  primary: 'form',
}
```

**Note:** This only gives you ONE color value, not a full palette. Components may not look right without shades.

---

## 🎯 Recommended Approach for Custom Colors

### If Your Brand Color Matches a Tailwind Color:

**Best option:** Just use the Tailwind color name.

```typescript
// app.config.ts
colors: {
  primary: 'emerald',  // If your brand is green-ish
  secondary: 'slate',
}
```

### If Your Brand Color is Unique:

**Option A: Find the Closest Tailwind Color** (Easiest)

Compare your hex to Tailwind colors and pick the closest:
- Blue brands: `blue`, `sky`, `indigo`
- Green brands: `green`, `emerald`, `teal`
- Red brands: `red`, `rose`, `pink`
- Purple brands: `purple`, `violet`, `fuchsia`
- Orange brands: `orange`, `amber`

**Option B: Generate a Custom Palette** (Advanced)

Use a tool to generate shades from your hex:
- https://uicolors.app/create
- Input your hex color
- Get CSS variables for all shades (50-950)
- Add to `app.css` under `@theme {}`
- Use in `app.config.ts`

---

## 📊 Default Configuration

The default OpnForm colors are:

```typescript
colors: {
  primary: 'blue',      // Blue throughout the app
  secondary: 'blue',    // Also blue
  success: 'green',     // Success messages/states
  error: 'red',         // Error messages/states
  warning: 'amber',     // Warning messages
  info: 'blue',         // Info messages
  neutral: 'neutral',   // Neutral gray UI elements
  form: 'form'          // Special form color (maps to blue-500)
}
```

---

## 🔧 Example Customizations

### Example 1: Green Brand

```typescript
// app.config.ts
export default defineAppConfig({
  ui: {
    colors: {
      primary: 'emerald',
      secondary: 'teal',
      success: 'green',
      error: 'red',
      warning: 'amber',
      info: 'sky',
      neutral: 'neutral',
      form: 'emerald'
    }
  }
})
```

### Example 2: Purple Brand

```typescript
colors: {
  primary: 'purple',
  secondary: 'violet',
  success: 'green',
  error: 'red',
  warning: 'amber',
  info: 'blue',
  neutral: 'neutral',
  form: 'purple'
}
```

### Example 3: Monochrome/Neutral

```typescript
colors: {
  primary: 'slate',
  secondary: 'gray',
  success: 'green',
  error: 'red',
  warning: 'amber',
  info: 'slate',
  neutral: 'neutral',
  form: 'slate'
}
```

---

## 🧪 Testing Your Colors

After changing colors:

1. Edit `app.config.ts`
2. Run `./deploy.sh`
3. Check these areas:
   - Buttons (primary/secondary colors)
   - Form fields (form color)
   - Success/error messages
   - Links and interactive elements
   - Navbar and footer

---

## 🚨 Important Notes

1. **Stick to Tailwind color names** in `app.config.ts`
2. **Don't use hex codes** directly unless you add them to Tailwind theme
3. **Test thoroughly** - color changes affect the entire UI
4. **Keep accessibility in mind** - ensure sufficient contrast

---

## 📚 References

- Tailwind CSS v4 Colors: https://tailwindcss.com/docs/customizing-colors
- Nuxt UI Colors: https://ui.nuxt.com/getting-started/theme
- Color Palette Generator: https://uicolors.app/create
- Contrast Checker: https://webaim.org/resources/contrastchecker/

---

**Quick Answer:**
- ✅ Use Tailwind color names: `'blue'`, `'emerald'`, `'purple'`, etc.
- ✅ Shades auto-generate: Setting `'blue'` gives you `blue-50` through `blue-950`
- ❌ Don't use shade numbers in config: `'blue-600'` won't work
- ❌ Don't use hex codes directly: `'#3b82f6'` won't work
- ⚙️ For custom colors: Add to Tailwind theme in `app.css` first

---

## 🎯 Using Specific Shades in Templates

While you can't specify shades in `app.config.ts`, you CAN use specific shades directly in your Vue templates:

```vue
<template>
  <!-- Using semantic color (auto-selects appropriate shade) -->
  <UButton color="primary" />  <!-- Uses primary-500 by default -->

  <!-- Using specific shades directly in Tailwind classes -->
  <div class="bg-primary-100 text-primary-700">
    Light background, dark text
  </div>

  <!-- Or use Tailwind colors directly -->
  <div class="bg-blue-50 text-blue-900">
    Specific blue shades
  </div>
</template>
```

This is useful when you need precise control over specific elements.
