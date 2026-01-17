# Quick Start Guide

Get your custom OpnForm deployment up and running in 10 minutes.

## Prerequisites Checklist

- [ ] Server with Docker and Docker Compose installed
- [ ] Your organization's logo files (SVG/PNG)
- [ ] Decided on your app name
- [ ] Server has at least 4GB RAM and 10GB disk space

## Step-by-Step Deployment

### 1. Clone OpnForm on Your Server

```bash
# SSH into your server
ssh user@your-server.com

# Clone OpnForm
git clone https://github.com/OpnForm/OpnForm.git
cd OpnForm
```

### 2. Clone This Custom Deployment Package

```bash
# Inside the OpnForm directory
git clone https://github.com/YourOrg/opnform-custom-deploy.git

# Or download and extract if not on GitHub yet
# wget https://github.com/YourOrg/opnform-custom-deploy/archive/main.zip
# unzip main.zip
```

### 3. Add Your Custom Files

```bash
cd opnform-custom-deploy

# Add your logo files
cp /path/to/your/logo.svg custom-files/client/public/img/
cp /path/to/your/logo.png custom-files/client/public/img/
cp /path/to/your/favicon.ico custom-files/client/public/img/

# Edit configuration files
nano custom-files/client/opnform.config.js
# Change app_name to your organization name
# Update or remove social links

# Optional: Customize colors
nano custom-files/client/app.config.ts
# Change primary color to match your brand

# Optional: Customize homepage
# Rename and edit the example homepage
mv custom-files/client/pages/EXAMPLE_index.vue custom-files/client/pages/index.vue
nano custom-files/client/pages/index.vue
```

### 4. Set Up Environment Variables

```bash
# Go back to OpnForm root
cd ..

# Set up API environment
cp api/.env.example api/.env
nano api/.env
```

**Required changes in `api/.env`:**
```env
APP_NAME="YourOrg Forms"
APP_URL=http://your-server-ip-or-domain
APP_ENV=production
APP_DEBUG=false

# Database (default PostgreSQL settings work with docker-compose)
DB_CONNECTION=pgsql
DB_HOST=db
DB_DATABASE=opnform
DB_USERNAME=opnform_user
DB_PASSWORD=change_this_secure_password

# Set a secure app key (generate with: php artisan key:generate)
APP_KEY=base64:GENERATE_THIS_WITH_KEY_GENERATE_COMMAND

# Redis
REDIS_HOST=redis

# Mail settings (configure if you need email)
MAIL_MAILER=smtp
MAIL_HOST=your-smtp-server
MAIL_PORT=587
MAIL_USERNAME=your-email
MAIL_PASSWORD=your-password
MAIL_FROM_ADDRESS=noreply@yourorg.com
```

**Set up Client environment:**
```bash
cp client/.env.example client/.env
nano client/.env
```

**Required changes in `client/.env`:**
```env
NUXT_PUBLIC_APP_URL=http://your-server-ip-or-domain
NUXT_PUBLIC_API_BASE=http://your-server-ip-or-domain/api
NUXT_PUBLIC_ENV=production

# Optional: Analytics (leave empty if not using)
NUXT_PUBLIC_GOOGLE_ANALYTICS_CODE=
NUXT_PUBLIC_AMPLITUDE_CODE=
```

### 5. Update docker-compose.yml Database Credentials

```bash
nano docker-compose.yml
```

Find the `db:` service and update:
```yaml
db:
  environment:
    POSTGRES_DB: opnform
    POSTGRES_USER: opnform_user
    POSTGRES_PASSWORD: change_this_secure_password  # Same as in api/.env
```

### 6. Run Deployment

```bash
cd opnform-custom-deploy
./deploy.sh
```

This will:
- Copy your custom files
- Build Docker images (takes 5-10 minutes)
- Start all containers

**Watch the build process:**
```bash
# Monitor container logs
docker-compose logs -f
```

### 7. Initialize Database

```bash
# Run database migrations
docker-compose exec api php artisan migrate --force

# Optional: Seed with sample data
docker-compose exec api php artisan db:seed
```

### 8. Access Your Instance

Open your browser and go to:
```
http://your-server-ip
```

**Create your admin account:**
1. Click "Register" or go to `/register`
2. Create your account
3. Verify email (if mail is configured)

## Verification Checklist

- [ ] Website loads at your server IP/domain
- [ ] Custom logo appears in navigation
- [ ] App name shows your organization name
- [ ] Can register a new account
- [ ] Can log in successfully
- [ ] Can create a form
- [ ] Dashboard loads correctly

## Common Issues

### Build Fails with Memory Error

**Solution:** Increase Docker memory limit to 8GB in Docker settings

### Port 80 Already in Use

**Solution:** Change port in `docker-compose.yml`:
```yaml
ingress:
  ports:
    - "8080:80"  # Use port 8080 instead
```

### Containers Exit Immediately

**Solution:** Check logs:
```bash
docker-compose logs api
docker-compose logs ui
```

Common causes:
- Missing or invalid `.env` files
- Database credentials mismatch
- Missing APP_KEY in api/.env

### Changes Not Showing

**Solution:** Rebuild without cache:
```bash
cd opnform-custom-deploy
# Edit deploy.sh and make sure it uses --no-cache
./deploy.sh
```

Or manually:
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## Updating Customizations

To update branding or content after initial deployment:

1. Edit files in `opnform-custom-deploy/custom-files/`
2. Run `./deploy.sh` again
3. Wait for rebuild (faster after first time)

## Production Checklist

Before going live:

- [ ] Set up domain name (not just IP)
- [ ] Configure SSL/HTTPS (use Caddy or nginx reverse proxy)
- [ ] Configure email for password resets
- [ ] Set up backups for database volume
- [ ] Change all default passwords
- [ ] Set `APP_DEBUG=false` in api/.env
- [ ] Configure firewall (only allow 80/443)
- [ ] Test form submission end-to-end
- [ ] Set up monitoring/alerts

## Next Steps

1. **SSL Certificate**: Set up HTTPS with Let's Encrypt
2. **Backups**: Create backup script for database
3. **Monitoring**: Set up Uptime monitoring
4. **Documentation**: Create user guide for your team

## Getting Help

- Check the main [README.md](README.md) for detailed documentation
- Review [Troubleshooting](README.md#troubleshooting) section
- Check OpnForm documentation: https://docs.opnform.com
- OpnForm Discord: https://discord.gg/YTSjU2a9TS
