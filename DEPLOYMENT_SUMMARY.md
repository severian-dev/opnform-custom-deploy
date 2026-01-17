# Deployment Summary - Automated Approach

This document explains the fully automated deployment approach for your custom OpnForm instance.

---

## 🎯 Design Philosophy

**You customize. Script automates. Server deploys.**

1. **Edit templates** - Customize landing page, login page, logos
2. **Set config** - One file controls app name everywhere
3. **Run script** - Everything else is automated
4. **Deploy** - Just run `./deploy.sh` on your server

**No manual file editing on the server. No hardcoded values.**

---

## 📦 What You Customize

### Required Files (4 total)

```
custom-files/
├── client/
│   ├── opnform.config.js        [1] App name & links config
│   ├── pages/
│   │   ├── index.vue            [2] Landing page template
│   │   └── login.vue            [3] Login page template
│   └── public/img/
│       ├── logo.svg             [4a] Your logo (SVG)
│       ├── logo.png             [4b] Your logo (PNG fallback)
│       └── favicon.ico          [4c] Browser icon
```

**That's it!** Everything else is automated.

---

## 🤖 What the Script Automates

### deploy.sh automatically:

1. **✅ Copies your files** to the OpnForm directories
2. **✅ Fixes config typo** (app_ame → app_name)
3. **✅ Extracts app name** from config
4. **✅ Replaces "OpnForm"** throughout the codebase with your app name:
   - Navbar component
   - Footer component
   - Default login page (if you're not using custom)
   - API environment file
5. **✅ Builds Docker images** locally with your customizations baked in
6. **✅ Starts containers** with your branded instance

---

## 🔧 How App Name Replacement Works

### You set in config:

```javascript
// custom-files/client/opnform.config.js
export default {
  app_name: "Acme Corp Forms"
}
```

### Script automatically replaces in:

**File: `/client/components/global/Navbar.vue`**
```vue
<!-- Before -->
<span>OpnForm</span>

<!-- After (automatic) -->
<span>Acme Corp Forms</span>
```

**File: `/client/components/pages/OpenFormFooter.vue`**
```vue
<!-- Before -->
<span>OpnForm</span>

<!-- After (automatic) -->
<span>Acme Corp Forms</span>
```

**File: `/api/.env`**
```env
# Before
APP_NAME="OpnForm"

# After (automatic)
APP_NAME="Acme Corp Forms"
```

**Your custom templates** (`index.vue`, `login.vue`):
```vue
<!-- Dynamically uses config -->
<template>
  <h1>Welcome to {{ appName }}</h1>
</template>

<script setup>
const appName = computed(() => opnformConfig.app_name || 'OpnForm')
</script>
```

**Result:** "Acme Corp Forms" appears consistently everywhere!

---

## 📋 Deployment Workflow

### On Your Development Machine:

```bash
cd opnform-custom-deploy

# 1. Add your branding files
cp ~/Downloads/logo.svg custom-files/client/public/img/
cp ~/Downloads/logo.png custom-files/client/public/img/
cp ~/Downloads/favicon.ico custom-files/client/public/img/

# 2. Edit config
nano custom-files/client/opnform.config.js
# Set: app_name: "YourOrg Forms"

# 3. Customize pages (optional)
nano custom-files/client/pages/index.vue
nano custom-files/client/pages/login.vue

# 4. Commit to git
git add .
git commit -m "Add custom branding"
git push
```

### On Your Server:

```bash
# 1. Clone OpnForm
git clone https://github.com/OpnForm/OpnForm.git
cd OpnForm

# 2. Clone your custom repo
git clone https://github.com/YourOrg/opnform-custom-deploy.git

# 3. Set up environment files
cp api/.env.example api/.env
nano api/.env  # Configure database, etc.

cp client/.env.example client/.env
nano client/.env  # Configure URLs

# 4. Run deployment script
cd opnform-custom-deploy
./deploy.sh

# That's it! Script handles everything else.
```

---

## ✅ What Gets Built

### Local Docker Images:

- `opnform-api-custom:latest` - Backend with your app name
- `opnform-client-custom:latest` - Frontend with:
  - Your logos
  - Your app name everywhere
  - Your custom landing page
  - Your custom login page
  - Your color scheme

### Result:

A fully branded OpnForm instance with:
- ✅ Your organization name throughout
- ✅ Your logos in navbar/footer
- ✅ Your custom landing page
- ✅ Your custom login page
- ✅ All OpnForm features working
- ✅ No external links (if you removed them)

---

## 🔄 Updating Customizations

Need to change something?

```bash
# On your dev machine
cd opnform-custom-deploy
nano custom-files/client/pages/index.vue  # Edit content
git add .
git commit -m "Update homepage content"
git push

# On your server
cd OpnForm/opnform-custom-deploy
git pull
./deploy.sh  # Rebuilds with new changes
```

---

## 🎨 Customization Examples

### Example 1: Minimal Setup (5 minutes)

**Files needed:**
- 3 image files (logo.svg, logo.png, favicon.ico)
- 1 config edit (set app_name)

**Result:**
- Your logos appear
- Your app name everywhere
- Default templates with your branding

### Example 2: Full Customization (30 minutes)

**Files needed:**
- 3 image files
- 1 config edit (app_name + colors)
- Edit index.vue (custom homepage content)
- Edit login.vue (custom marketing text)

**Result:**
- Complete brand alignment
- Custom messaging
- Unique user experience

---

## 🚨 Important Notes

### About Links in Config

Since you're replacing landing page and login page, **links in config only matter for:**
- Navbar "Help" button
- Footer on dashboard pages
- User settings pages

**If you don't need these**, just leave links empty:
```javascript
links: {
  help_url: "",
  github_url: "",
  discord: "",
  // ... all empty
}
```

### About Template Modifications

**Safe to edit:**
- HTML content (text, headings, descriptions)
- Tailwind CSS classes (colors, spacing, sizes)
- Feature cards (add/remove/modify)
- Images and icons

**Don't edit (unless you know Vue):**
- `<script setup>` section (handles logic)
- `{{ appName }}` variable (dynamic app name)
- `<login-form />` component (handles authentication)
- Import statements

---

## 📊 Script Output Example

```
==================================
OpnForm Custom Deployment
==================================

Script directory: /home/user/OpnForm/opnform-custom-deploy
OpnForm directory: /home/user/OpnForm

[1/6] Copying custom client files...
Copying files from custom-files/client/public/img to client/public/img...
Copying files from custom-files/client/pages to client/pages...
Copying opnform.config.js...
  ✓ Fixed app_ame -> app_name typo
Copying app.config.ts...

[2/6] Replacing hardcoded app names...
Using app name: 'Acme Corp Forms'
  ✓ Updated app name in client/components/global/Navbar.vue
  ✓ Updated app name in client/components/pages/OpenFormFooter.vue
  ✓ Updated APP_NAME in api/.env

[3/6] Copying custom API files...

[4/6] Setting up Docker Compose override...
✓ docker-compose.override.yml copied

[5/6] Stopping existing containers...
Stopping opnform-client ... done
Stopping opnform-api    ... done

[6/6] Building custom images and starting containers...
This may take several minutes...
Building api...
Building ui...
Creating network "opnform_default" ...
Creating opnform-db    ... done
Creating opnform-redis ... done
Creating opnform-api   ... done
Creating opnform-client ... done

==================================
✓ Deployment Complete!
==================================

Your 'Acme Corp Forms' instance is now running.

Check status with: docker-compose ps
View logs with: docker-compose logs -f
```

---

## 🎯 Key Benefits

| Aspect | Traditional Approach | Automated Approach |
|--------|---------------------|-------------------|
| **Setup time** | Hours (manual editing) | Minutes (run script) |
| **Error risk** | High (manual mistakes) | Low (automated) |
| **Updates** | Re-edit all files | Re-run script |
| **Consistency** | Hard to maintain | Guaranteed by script |
| **Repeatability** | Manual process | One command |

---

## 🆘 Troubleshooting

### Script fails: "api/.env not found"

**Solution:** Create the file first:
```bash
cp api/.env.example api/.env
nano api/.env  # Configure
```

### App name not changing

**Solution:** Check config syntax:
```javascript
// Correct:
app_name: "YourOrg Forms",

// Wrong:
app_name = "YourOrg Forms"  // ❌ Uses = instead of :
app name: "YourOrg Forms"   // ❌ Space in key
```

### Build fails with memory error

**Solution:** Increase Docker memory to 8GB

### Changes not appearing

**Solution:** Rebuild without cache:
```bash
cd OpnForm
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

---

## 📚 Next Steps

1. **Read:** [BRANDING_CHECKLIST.md](BRANDING_CHECKLIST.md) - Understand file requirements
2. **Prepare:** Your 4 files (3 images + 1 config)
3. **Customize:** Edit page templates (optional)
4. **Deploy:** Follow [QUICKSTART.md](QUICKSTART.md)
5. **Verify:** Access your instance and check branding

---

**Questions?** See the main [README.md](README.md) for comprehensive documentation.
