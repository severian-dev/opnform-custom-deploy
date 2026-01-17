# opnform.config.js Field Reference

Complete guide showing what each field in `opnform.config.js` controls and where it appears.

---

## 📝 File Structure

```javascript
export default {
  app_name: "OpnForm",           // ⚠️ Note: Typo in original (app_ame)
  locale: "en",
  locales: { en: "EN" },
  githubAuth: null,
  notion: { worker: "..." },
  links: {
    help_url: "...",
    github_url: "...",
    github_forum_url: "...",
    discord: "...",
    twitter: "...",
    zapier_integration: "...",
    book_onboarding: "...",
    feature_requests: "...",
    changelog_url: "...",
    roadmap: "...",
    tech_docs: "...",
    api_docs: "...",
  }
}
```

---

## 🔧 Field by Field Breakdown

### 1. `app_name` ⚠️ IMPORTANT NOTE

**Current issue:** The file has a typo - it says `app_ame` instead of `app_name` (line 2 of opnform.config.js)

**What it should control:** Application name throughout the UI

**Current reality:**
- ❌ This field is **NOT USED** in the client code
- ✅ App name is **hardcoded** in multiple places:
  - `/client/components/global/Navbar.vue:20` - Shows "OpnForm"
  - `/client/components/pages/OpenFormFooter.vue:22` - Shows "OpnForm"
  - `/client/pages/login.vue:10` - Shows "Login to OpnForm"

**How to change app name:**

You need to edit the **backend API** environment file:

**File:** `/api/.env`
```env
APP_NAME="YourOrg Forms"
MAIL_FROM_NAME="${APP_NAME}"
```

This controls:
- Email sender name (password resets, notifications, etc.)
- API responses with app name
- SEO meta tags (in some places)

**To also change in UI, you must edit:**
1. `/client/components/global/Navbar.vue:20` - Navbar text
2. `/client/components/pages/OpenFormFooter.vue:22` - Footer text
3. `/client/pages/login.vue:10` - Login page heading

**Recommendation:** Fix the typo and modify the Navbar/Footer components to use the config value.

---

### 2. `locale` & `locales`

**What it controls:** Default language settings

```javascript
locale: "en",              // Default locale
locales: { en: "EN" }     // Available locales
```

**Where it's used:**
- Language selection (if multi-language support is enabled)
- Default translations

**For single-language org use:**
- Leave as `"en"` unless you want a different default language

---

### 3. `githubAuth`

**What it controls:** GitHub OAuth authentication configuration

```javascript
githubAuth: null
```

**Where it's used:**
- OAuth authentication flow
- "Sign in with GitHub" feature

**For private org use:**
- Leave as `null` (disables GitHub OAuth)

---

### 4. `notion`

**What it controls:** Notion integration worker endpoint

```javascript
notion: {
  worker: "https://notion-forms-worker.notionforms.workers.dev/v1"
}
```

**Where it's used:**
- Notion CMS integration features
- Used in `/client/stores/notion_cms.js`

**For private org use:**
- Leave as-is (won't affect your deployment if not using Notion features)

---

## 🔗 Links Configuration

All links are in the `links` object. Here's what each one controls:

### `help_url`

**Used in:**
- `/client/components/global/Navbar.vue:209` - "Help" link in navigation bar
- `/client/composables/components/useSharedNavigation.js:122` - Help menu item

**Appears as:**
- Navigation bar → "Help" button

**Example:**
```javascript
help_url: "https://yourorg.com/support"
```

**Recommendation:**
- ✅ Change to your org's help/support page
- Or set to `""` to hide the Help link

---

### `github_url`

**Used in:**
- `/client/pages/index.vue:265` - Footer social links
- Social media section on homepage

**Appears as:**
- Homepage footer → GitHub icon link
- "Star us on GitHub" banner (if not self-hosted)

**Example:**
```javascript
github_url: ""  // Set to empty string to hide
```

**Recommendation:**
- ✅ Set to `""` to hide GitHub links for private org

---

### `github_forum_url`

**Used in:**
- Community/forum links (if enabled)

**Appears as:**
- Forum/discussion links

**Recommendation:**
- ✅ Set to `""` to hide

---

### `discord`

**Used in:**
- `/client/pages/index.vue:244` - Footer social links
- `/client/components/pages/OpenFormFooter.vue:42` - Footer "Discord" link

**Appears as:**
- Homepage footer → Discord icon link
- Footer → "Discord" text link

**Example:**
```javascript
discord: "https://discord.gg/your-org-server"
```

**Recommendation:**
- ✅ Change to your org's Discord/chat server
- Or set to `""` to hide Discord links

---

### `twitter`

**Used in:**
- `/client/pages/index.vue:227` - Footer social links

**Appears as:**
- Homepage footer → Twitter/X icon link

**Example:**
```javascript
twitter: ""  // Set to empty to hide
```

**Recommendation:**
- ✅ Set to `""` to hide for private org
- Or change to your org's social media

---

### `zapier_integration`

**Used in:**
- Zapier integration documentation/setup links

**Appears as:**
- Links to Zapier app integration page (if using Zapier)

**Recommendation:**
- ✅ Set to `""` if not using Zapier

---

### `book_onboarding`

**Used in:**
- Onboarding/scheduling features

**Appears as:**
- "Book a call" or onboarding links

**Recommendation:**
- ✅ Set to `""` for private org

---

### `feature_requests`

**Used in:**
- `/client/components/pages/OpenFormFooter.vue:28` - Footer "Feature Requests" link
- `/client/composables/components/useSharedNavigation.js:110` - Navigation menu

**Appears as:**
- Footer → "Feature Requests" text link
- User menu dropdown (when logged in)

**Example:**
```javascript
feature_requests: "https://yourorg.com/feedback"
```

**Recommendation:**
- ✅ Change to your org's feedback/feature request page
- Or set to `""` to hide

---

### `changelog_url`

**Used in:**
- `/client/components/global/Navbar.vue:71` - "What's new?" link

**Appears as:**
- Navigation bar → "What's new?" button (shows changelog/updates)

**Example:**
```javascript
changelog_url: "https://yourorg.com/changelog"
```

**Recommendation:**
- ✅ Set to `""` to hide "What's new?" button
- Or change to your org's changelog page

---

### `roadmap`

**Used in:**
- `/client/components/pages/OpenFormFooter.vue:35` - Footer "Roadmap" link
- `/client/composables/components/useSharedNavigation.js:92` - Navigation menu

**Appears as:**
- Footer → "Roadmap" text link
- User menu dropdown

**Example:**
```javascript
roadmap: "https://yourorg.com/roadmap"
```

**Recommendation:**
- ✅ Set to `""` to hide roadmap links
- Or change to your org's roadmap page

---

### `tech_docs`

**Used in:**
- `/client/components/pages/OpenFormFooter.vue:49` - Footer "Technical Docs" link

**Appears as:**
- Footer → "Technical Docs" text link

**Example:**
```javascript
tech_docs: "https://docs.yourorg.com"
```

**Recommendation:**
- ✅ Change to your org's documentation
- Or set to `""` to hide

---

### `api_docs`

**Used in:**
- `/client/components/users/settings/AccessTokens.vue:18` - API documentation link
- `/client/composables/components/useSharedNavigation.js:128` - Navigation menu

**Appears as:**
- User Settings → Access Tokens page → "API Documentation" link
- Developer menu items

**Example:**
```javascript
api_docs: "https://docs.yourorg.com/api"
```

**Recommendation:**
- ✅ Change to your org's API docs
- Or set to `""` to hide

---

## 📋 Quick Setup Guide for Private Org

### Minimal Configuration (Hide All External Links)

```javascript
export default {
  app_name: "YourOrg Forms",  // Fix typo: app_ame → app_name
  locale: "en",
  locales: { en: "EN" },
  githubAuth: null,
  notion: { worker: "https://notion-forms-worker.notionforms.workers.dev/v1" },
  links: {
    help_url: "",                    // Hide or set to your support page
    github_url: "",                  // Hide GitHub
    github_forum_url: "",            // Hide forum
    discord: "",                     // Hide Discord
    twitter: "",                     // Hide Twitter
    zapier_integration: "",          // Hide Zapier
    book_onboarding: "",             // Hide onboarding
    feature_requests: "",            // Hide or set to your feedback page
    changelog_url: "",               // Hide changelog
    roadmap: "",                     // Hide roadmap
    tech_docs: "",                   // Hide or set to your docs
    api_docs: "",                    // Hide or set to your API docs
  },
}
```

### Recommended Configuration (Keep Useful Links)

```javascript
export default {
  app_name: "YourOrg Forms",
  locale: "en",
  locales: { en: "EN" },
  githubAuth: null,
  notion: { worker: "https://notion-forms-worker.notionforms.workers.dev/v1" },
  links: {
    help_url: "https://yourorg.com/help",        // ✅ Keep - internal support
    github_url: "",                               // ❌ Hide
    github_forum_url: "",                         // ❌ Hide
    discord: "https://chat.yourorg.com",          // ✅ Keep - internal chat
    twitter: "",                                  // ❌ Hide
    zapier_integration: "",                       // ❌ Hide
    book_onboarding: "",                          // ❌ Hide
    feature_requests: "https://yourorg.com/feedback", // ✅ Keep - internal feedback
    changelog_url: "",                            // ❌ Hide (or keep if you publish updates)
    roadmap: "",                                  // ❌ Hide
    tech_docs: "https://docs.yourorg.com",        // ✅ Keep - internal docs
    api_docs: "https://docs.yourorg.com/api",     // ✅ Keep - for developers
  },
}
```

---

## ⚠️ Additional Changes Required

**The config file alone is NOT enough!** You also need to:

### 1. Fix App Name Display

**Edit:** `/client/components/global/Navbar.vue`
```vue
<!-- Line 20 - Change from: -->
<span class="ml-2 text-md hidden sm:inline text-black dark:text-white">
  OpnForm
</span>

<!-- To: -->
<span class="ml-2 text-md hidden sm:inline text-black dark:text-white">
  YourOrg Forms
</span>
```

**Edit:** `/client/components/pages/OpenFormFooter.vue`
```vue
<!-- Line 22 - Change from: -->
<span class="ml-2 text-xl text-black dark:text-white">OpnForm</span>

<!-- To: -->
<span class="ml-2 text-xl text-black dark:text-white">YourOrg Forms</span>
```

**Edit:** `/client/pages/login.vue`
```vue
<!-- Line 10 - Change from: -->
<h2 class="font-semibold text-2xl">
  Login to OpnForm
</h2>

<!-- To: -->
<h2 class="font-semibold text-2xl">
  Login to YourOrg Forms
</h2>
```

### 2. Configure Backend (.env)

**Edit:** `/api/.env`
```env
APP_NAME="YourOrg Forms"
APP_URL=http://your-server-ip-or-domain
```

---

## 🎯 Summary

**What opnform.config.js DOES control:**
- ✅ All external links (help, docs, social media, etc.)
- ✅ Notion integration endpoint
- ✅ OAuth settings

**What it DOESN'T control (needs manual editing):**
- ❌ App name in UI (hardcoded in components)
- ❌ Logo (controlled by /img/logo.svg)
- ❌ Colors (controlled by app.config.ts)
- ❌ Backend app name (controlled by /api/.env)

**Action Items:**
1. ✅ Edit `opnform.config.js` - Set all links
2. ✅ Edit `Navbar.vue` - Change app name text
3. ✅ Edit `OpenFormFooter.vue` - Change app name text
4. ✅ Edit `login.vue` - Change heading
5. ✅ Edit `/api/.env` - Set APP_NAME

---

**Need help?** See [BRANDING_CHECKLIST.md](BRANDING_CHECKLIST.md) for complete customization guide.
