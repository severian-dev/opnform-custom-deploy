# OpnForm Custom Deployment Package

This repository contains customization files and deployment scripts for running a privately branded OpnForm instance for your organization.

## 📋 Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [How It Works](#how-it-works)
- [Directory Structure](#directory-structure)
- [Customization Guide](#customization-guide)
- [Deployment](#deployment)
- [Progress Log](#progress-log)
- [Troubleshooting](#troubleshooting)

## 📖 Documentation

- **[DEPLOYMENT_SUMMARY.md](DEPLOYMENT_SUMMARY.md)** - ⭐ Start here! Explains the automated deployment approach
- **[QUICKSTART.md](QUICKSTART.md)** - Step-by-step deployment guide (10 minutes)
- **[BRANDING_CHECKLIST.md](BRANDING_CHECKLIST.md)** - Complete guide to preparing branding files, frameworks, and design specs
- **[CONFIG_FIELD_GUIDE.md](CONFIG_FIELD_GUIDE.md)** - Detailed explanation of every field in opnform.config.js
- **[COLOR_CONFIGURATION.md](COLOR_CONFIGURATION.md)** - How colors work and what values are supported
- **[LINKS_BEHAVIOR.md](LINKS_BEHAVIOR.md)** - How empty links are hidden
- **[V0_PROMPT.md](V0_PROMPT.md)** - Prompt for v0.dev to generate custom pages
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Quick reference for Tailwind CSS, Vue 3, and deployment commands

---

## Quick Start

**New to this?** The deployment is fully automated:

1. **Understand:** Read [DEPLOYMENT_SUMMARY.md](DEPLOYMENT_SUMMARY.md) - How automation works
2. **Prepare:** 4 files total (3 images + 1 config edit)
3. **Customize:** Edit landing page and login page templates
4. **Deploy:** Run `./deploy.sh` on your server - script does everything!

**What you customize (4 files):**
```bash
custom-files/client/
├── opnform.config.js           # Set app_name: "YourOrg Forms"
├── pages/
│   ├── index.vue               # Edit landing page content
│   └── login.vue               # Edit login page content
└── public/img/
    ├── logo.svg                # Your logo (24×24px display)
    ├── logo.png                # Fallback logo
    └── favicon.ico             # Browser icon
```

**What the script automates:**
- ✅ Replaces "OpnForm" with your app name everywhere
- ✅ Copies your files to correct locations
- ✅ Builds local Docker images with your branding
- ✅ Starts your customized instance

**One command deployment:**
```bash
./deploy.sh  # That's it!
```

---

## Overview

This deployment package allows you to:
- Customize OpnForm branding (logo, colors, app name)
- Replace homepage and login pages
- Build custom Docker images with your modifications
- Deploy to your server with a single command

**Important**: This approach builds Docker images locally from source, which means your customizations are baked into the images and persist across container restarts.

---

## How It Works

### Standard OpnForm Setup
By default, OpnForm uses prebuilt Docker images:
- `jhumanj/opnform-api:latest` (Backend)
- `jhumanj/opnform-client:latest` (Frontend)

### Custom Setup (This Package)
This package modifies the deployment to:
1. Build images locally from the OpnForm source code
2. Include your custom files in the build
3. Tag images as `opnform-api-custom:latest` and `opnform-client-custom:latest`

**Build Process:**
- **Client**: Nuxt.js build (compiles Vue components → production JavaScript)
- **API**: Laravel build (installs Composer dependencies)

---

## Directory Structure

```
opnform-custom-deploy/
├── README.md                           # This file
├── deploy.sh                           # Deployment script
├── docker-compose.override.yml         # Override to build locally
├── custom-files/                       # Your customization files
│   ├── client/                         # Frontend customizations
│   │   ├── public/
│   │   │   └── img/                    # Custom images/logos
│   │   │       ├── logo.svg            # Main logo (SVG)
│   │   │       ├── logo.png            # Fallback logo
│   │   │       └── favicon.ico         # Browser icon
│   │   ├── pages/                      # Custom pages (Vue files)
│   │   │   ├── index.vue               # Homepage (/)
│   │   │   └── login.vue               # Login page (/login)
│   │   ├── css/                        # Custom styles
│   │   │   └── app.css                 # Main stylesheet
│   │   ├── opnform.config.js           # App name & links config
│   │   └── app.config.ts               # Theme colors config
│   └── api/                            # Backend customizations (optional)
└── .gitignore                          # Git ignore file
```

---

## Customization Guide

### 1. Branding Files

#### Logo & Favicon
Place your custom logo files in `custom-files/client/public/img/`:

```bash
custom-files/client/public/img/
├── logo.svg        # Primary logo (SVG recommended for scaling)
├── logo.png        # PNG fallback
└── favicon.ico     # Browser tab icon
```

**Recommended dimensions:**
- Logo: SVG (scalable) or PNG 200x50px
- Favicon: 32x32px or 16x16px

#### App Name & Links
Edit `custom-files/client/opnform.config.js`:

```javascript
export default {
  app_name: "YourOrg Forms",  // Your organization name
  links: {
    github_url: "",            // Optional: Remove or update
    discord: "",               // Optional: Your support channel
    help_url: "https://yourorg.com/help",
  }
}
```

#### Color Scheme
Edit `custom-files/client/app.config.ts`:

```typescript
export default defineAppConfig({
  ui: {
    colors: {
      primary: 'blue',      // Main brand color
      secondary: 'blue',    // Secondary color
      // ... other colors
    }
  }
})
```

Or edit `custom-files/client/css/app.css` for custom CSS variables.

### 2. Custom Pages

#### Homepage (/)
Edit or create `custom-files/client/pages/index.vue`:

```vue
<template>
  <div>
    <h1>Welcome to {{ orgName }} Forms</h1>
    <p>Custom homepage content here</p>
  </div>
</template>

<script setup>
const orgName = "YourOrg"
</script>
```

#### Login Page (/login)
Edit or create `custom-files/client/pages/login.vue`:

```vue
<template>
  <div>
    <h1>Sign in to {{ orgName }}</h1>
    <!-- Custom login UI -->
  </div>
</template>
```

**Note**: These are Vue.js single-file components. They need to be compiled during the Docker build process.

### 3. CSS Customizations

Edit `custom-files/client/css/app.css` to customize:
- Colors (CSS variables)
- Fonts
- Global styles

---

## Deployment

### Prerequisites

On your server:
- Docker and Docker Compose installed
- OpnForm repository cloned
- This custom deployment package cloned/downloaded

### Deployment Steps

1. **Clone OpnForm on your server:**
   ```bash
   git clone https://github.com/OpnForm/OpnForm.git
   cd OpnForm
   ```

2. **Clone this customization package inside OpnForm:**
   ```bash
   git clone https://github.com/YourOrg/opnform-custom-deploy.git
   # Or download/extract the zip file
   ```

3. **Add your custom files** to the `custom-files/` directories

4. **Set up environment files:**
   ```bash
   # Copy and configure API environment
   cp api/.env.example api/.env
   nano api/.env  # Configure database, etc.

   # Copy and configure Client environment
   cp client/.env.example client/.env
   nano client/.env  # Configure API URLs
   ```

5. **Run the deployment script:**
   ```bash
   cd opnform-custom-deploy
   ./deploy.sh
   ```

   This script will:
   - Copy your custom files into the OpnForm directories
   - Set up Docker Compose override
   - Stop existing containers
   - Build custom images (this takes 5-10 minutes)
   - Start containers with your customizations

6. **Verify deployment:**
   ```bash
   docker-compose ps        # Check container status
   docker-compose logs -f   # View logs
   ```

   Access your instance at `http://your-server-ip`

### Updating Customizations

To update your customizations:

1. Modify files in `custom-files/`
2. Run `./deploy.sh` again
3. The script will rebuild images with your changes

---

## Progress Log

### ✅ Completed
- [x] Analyzed OpnForm Docker setup
- [x] Created deployment package structure
- [x] Created docker-compose.override.yml for local builds
- [x] Created deployment script (deploy.sh)
- [x] Created comprehensive README

### 🚧 In Progress
- [ ] Add example customization files
- [ ] Test deployment on remote server

### 📝 To Do
- [ ] Add opnform.config.js example
- [ ] Add app.config.ts example
- [ ] Add example custom homepage (index.vue)
- [ ] Add example custom login page (login.vue)
- [ ] Add .gitignore file
- [ ] Test full deployment flow
- [ ] Document environment variables
- [ ] Add rollback procedure
- [ ] Add update procedure documentation

### 🔮 Future Enhancements
- [ ] Add backup script
- [ ] Add health check script
- [ ] Support for custom middleware
- [ ] Support for custom API routes
- [ ] Pre-built image option (push custom images to private registry)

---

## Troubleshooting

### Build Fails

**Issue**: Docker build fails with memory errors

**Solution**: Increase Docker memory limit
```bash
# In Docker Desktop: Settings → Resources → Memory (set to 8GB+)
```

### Containers Won't Start

**Issue**: Containers exit immediately

**Solution**: Check logs
```bash
docker-compose logs api
docker-compose logs ui
```

Common causes:
- Missing `.env` files
- Database connection issues
- Port conflicts

### Changes Not Appearing

**Issue**: Customizations don't show up after rebuild

**Solution**: Force rebuild without cache
```bash
docker-compose build --no-cache
docker-compose up -d --force-recreate
```

### Port Already in Use

**Issue**: Error "port 80 already in use"

**Solution**: Change port in docker-compose.yml
```yaml
services:
  ingress:
    ports:
      - "8080:80"  # Use port 8080 instead
```

---

## Technical Details

### Build Times
- **Initial build**: 5-10 minutes
- **Subsequent builds**: 2-5 minutes (with cache)

### Image Sizes
- API image: ~500MB
- Client image: ~200MB

### System Requirements
- **RAM**: 4GB minimum, 8GB recommended
- **Disk**: 5GB for images + database storage
- **CPU**: 2+ cores recommended

---

## Support

For OpnForm-specific issues:
- [OpnForm GitHub](https://github.com/OpnForm/OpnForm)
- [OpnForm Discord](https://discord.gg/YTSjU2a9TS)

For customization issues specific to this package:
- Check the [Progress Log](#progress-log) for known issues
- Review [Troubleshooting](#troubleshooting)
- Contact your organization's DevOps team

---

## License

This customization package follows OpnForm's license. See the main OpnForm repository for details.

---

**Last Updated**: 2026-01-17
