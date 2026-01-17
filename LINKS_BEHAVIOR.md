# Link Visibility Behavior

Quick reference for how links behave when left empty in `opnform.config.js`.

---

## ✅ Answer: Empty Links Are Hidden

**Yes, leaving link fields as empty strings (`""`) WILL hide those links.**

The deploy script automatically adds `v-if` conditions to components, so empty links don't appear in the UI.

---

## 🔧 How It Works

### In Your Config:

```javascript
// opnform.config.js
export default {
  links: {
    help_url: "",              // HIDDEN - won't appear
    discord: "https://...",    // VISIBLE - will appear
    feature_requests: "",      // HIDDEN - won't appear
  }
}
```

### What the Script Does:

The deploy script automatically modifies components to add conditional rendering:

**Before (default OpnForm):**
```vue
<a :href="opnformConfig.links.help_url">
  Help
</a>
```

**After (deploy script modification):**
```vue
<a v-if="opnformConfig.links.help_url" :href="opnformConfig.links.help_url">
  Help
</a>
```

**Result:** If `help_url` is empty (`""`), the link won't render at all.

---

## 📍 Where Links Appear

### Navbar (Top Navigation)
- `help_url` → "Help" button

### Footer (Bottom of Pages)
- `feature_requests` → "Feature Requests" link
- `roadmap` → "Roadmap" link
- `discord` → "Discord" link
- `tech_docs` → "Technical Docs" link

### Your Custom Pages
Landing page (`index.vue`) and login page (`login.vue`) are custom templates - they don't use these config links at all. You control what appears there by editing the templates directly.

---

## 🎯 Recommended Configuration for Private Org

Since you're using custom landing and login pages, you likely want to hide most external links:

```javascript
export default {
  app_name: "Avalon Forms",

  links: {
    // Useful internal links
    help_url: "",  // Or set to your internal help docs
    tech_docs: "",  // Or set to your internal documentation
    api_docs: "",   // Or set to your API docs (if developers need it)

    // Hide all external/marketing links
    github_url: "",
    github_forum_url: "",
    discord: "",
    twitter: "",
    zapier_integration: "",
    book_onboarding: "",
    feature_requests: "",
    changelog_url: "",
    roadmap: "",
  }
}
```

**Result:**
- Clean, minimal interface
- No external/marketing links
- Only shows links you explicitly set

---

## 🔍 What Gets Modified

The deploy script adds `v-if` conditions to these files:

1. **`/client/components/global/Navbar.vue`**
   - Adds `v-if="helpUrl"` to Help link

2. **`/client/components/pages/OpenFormFooter.vue`**
   - Adds `v-if="opnformConfig.links.feature_requests"` to Feature Requests link
   - Adds `v-if="opnformConfig.links.roadmap"` to Roadmap link
   - Adds `v-if="opnformConfig.links.discord"` to Discord link
   - Adds `v-if="opnformConfig.links.tech_docs"` to Technical Docs link

---

## ✅ Testing

After deploying, you can verify:

1. **Links you left empty** should not appear anywhere
2. **Links you set** should appear and work correctly
3. **Your custom pages** are unaffected by these config links

---

## 💡 Pro Tip

If you need a link to appear conditionally:

**Option 1: Use empty string to always hide**
```javascript
help_url: "",  // Never shows
```

**Option 2: Set URL to show**
```javascript
help_url: "https://yourorg.com/help",  // Always shows
```

**Option 3: Change config and redeploy**
```javascript
// Initially empty
help_url: "",

// Later, add a link
help_url: "https://yourorg.com/help",
// Run ./deploy.sh again to update
```

---

**Bottom line:** Empty (`""`) = Hidden. URL = Visible. Simple!
