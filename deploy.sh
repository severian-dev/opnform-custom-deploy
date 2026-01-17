#!/bin/bash

# OpnForm Custom Deployment Script
# This script applies your custom branding and configuration to OpnForm

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPNFORM_DIR="$(dirname "$SCRIPT_DIR")"

echo "=================================="
echo "OpnForm Custom Deployment"
echo "=================================="
echo ""
echo "Script directory: $SCRIPT_DIR"
echo "OpnForm directory: $OPNFORM_DIR"
echo ""

# Function to copy files if they exist
copy_custom_files() {
    local src_dir="$1"
    local dest_dir="$2"

    if [ -d "$src_dir" ]; then
        echo "Copying files from $src_dir to $dest_dir..."
        cp -r "$src_dir"/* "$dest_dir/" 2>/dev/null || true
    fi
}

# Function to extract app_name from opnform.config.js
extract_app_name() {
    local config_file="$1"
    if [ -f "$config_file" ]; then
        # Extract app_name value (handles both app_name and app_ame typo)
        local app_name=$(grep -E '^\s*(app_name|app_ame):' "$config_file" | sed -E 's/.*:\s*"([^"]+)".*/\1/')
        echo "$app_name"
    else
        echo "OpnForm"  # Default fallback
    fi
}

# Function to replace app name in files
replace_app_name() {
    local file="$1"
    local new_name="$2"

    if [ -f "$file" ]; then
        # Escape special characters for sed
        local escaped_name=$(echo "$new_name" | sed 's/[&/\]/\\&/g')

        # Replace "OpnForm" with new app name
        sed -i "s/OpnForm/$escaped_name/g" "$file"
        echo "  ✓ Updated app name in $file"
    fi
}

# Function to add v-if conditions for empty links
add_link_conditionals() {
    echo "Adding conditional rendering for empty links..."

    # Navbar: Add v-if to Help link
    local navbar_file="$OPNFORM_DIR/client/components/global/Navbar.vue"
    if [ -f "$navbar_file" ]; then
        # Check if already has v-if (to avoid duplicate additions)
        if ! grep -q 'v-if="helpUrl"' "$navbar_file"; then
            # Add v-if to the NuxtLink containing Help
            sed -i '/<NuxtLink/,/Help/{ /:href="helpUrl"/{ s/<NuxtLink/<NuxtLink v-if="helpUrl"/; } }' "$navbar_file"
            echo "  ✓ Added conditional rendering to Help link in Navbar"
        fi
    fi

    # Footer: Add v-if to all external links
    local footer_file="$OPNFORM_DIR/client/components/pages/OpenFormFooter.vue"
    if [ -f "$footer_file" ]; then
        # Add v-if to feature_requests link
        if ! grep -q 'v-if="opnformConfig.links.feature_requests"' "$footer_file"; then
            sed -i '/opnformConfig.links.feature_requests/,/Feature Requests/{ /:href="opnformConfig.links.feature_requests"/{ s/<a/<a v-if="opnformConfig.links.feature_requests"/; } }' "$footer_file"
        fi

        # Add v-if to roadmap link
        if ! grep -q 'v-if="opnformConfig.links.roadmap"' "$footer_file"; then
            sed -i '/opnformConfig.links.roadmap/,/Roadmap/{ /:href="opnformConfig.links.roadmap"/{ s/<a/<a v-if="opnformConfig.links.roadmap"/; } }' "$footer_file"
        fi

        # Add v-if to discord link
        if ! grep -q 'v-if="opnformConfig.links.discord"' "$footer_file"; then
            sed -i '/opnformConfig.links.discord/,/Discord/{ /:href="opnformConfig.links.discord"/{ s/<a/<a v-if="opnformConfig.links.discord"/; } }' "$footer_file"
        fi

        # Add v-if to tech_docs link
        if ! grep -q 'v-if="opnformConfig.links.tech_docs"' "$footer_file"; then
            sed -i '/opnformConfig.links.tech_docs/,/Technical Docs/{ /:href="opnformConfig.links.tech_docs"/{ s/<a/<a v-if="opnformConfig.links.tech_docs"/; } }' "$footer_file"
        fi

        echo "  ✓ Added conditional rendering to Footer links"
    fi
}

# Step 1: Copy custom client files
echo "[1/7] Copying custom client files..."
copy_custom_files "$SCRIPT_DIR/custom-files/client/public/img" "$OPNFORM_DIR/client/public/img"
copy_custom_files "$SCRIPT_DIR/custom-files/client/pages" "$OPNFORM_DIR/client/pages"
copy_custom_files "$SCRIPT_DIR/custom-files/client/css" "$OPNFORM_DIR/client/css"
copy_custom_files "$SCRIPT_DIR/custom-files/client/components" "$OPNFORM_DIR/client/components"

# Copy config files
CONFIG_COPIED=false
if [ -f "$SCRIPT_DIR/custom-files/client/opnform.config.js" ]; then
    echo "Copying opnform.config.js..."

    # Fix typo: app_ame -> app_name
    sed 's/app_ame:/app_name:/' "$SCRIPT_DIR/custom-files/client/opnform.config.js" > "$OPNFORM_DIR/client/opnform.config.js"
    echo "  ✓ Fixed app_ame -> app_name typo"
    CONFIG_COPIED=true
fi

if [ -f "$SCRIPT_DIR/custom-files/client/app.config.ts" ]; then
    echo "Copying app.config.ts..."
    cp "$SCRIPT_DIR/custom-files/client/app.config.ts" "$OPNFORM_DIR/client/app.config.ts"
fi

# Step 2: Replace hardcoded app names
echo "[2/7] Replacing hardcoded app names..."

# Extract app name from config
if [ "$CONFIG_COPIED" = true ]; then
    APP_NAME=$(extract_app_name "$OPNFORM_DIR/client/opnform.config.js")

    if [ -n "$APP_NAME" ] && [ "$APP_NAME" != "OpnForm" ]; then
        echo "Using app name: '$APP_NAME'"

        # Replace in Navbar
        replace_app_name "$OPNFORM_DIR/client/components/global/Navbar.vue" "$APP_NAME"

        # Replace in Footer
        replace_app_name "$OPNFORM_DIR/client/components/pages/OpenFormFooter.vue" "$APP_NAME"

        # Replace in Login page (only if not using custom login page)
        if [ ! -f "$SCRIPT_DIR/custom-files/client/pages/login.vue" ]; then
            replace_app_name "$OPNFORM_DIR/client/pages/login.vue" "$APP_NAME"
        fi

        # Update API .env if it exists
        if [ -f "$OPNFORM_DIR/api/.env" ]; then
            # Check if APP_NAME line exists
            if grep -q "^APP_NAME=" "$OPNFORM_DIR/api/.env"; then
                # Replace existing APP_NAME
                sed -i "s/^APP_NAME=.*/APP_NAME=\"$APP_NAME\"/" "$OPNFORM_DIR/api/.env"
                echo "  ✓ Updated APP_NAME in api/.env"
            else
                # Add APP_NAME if not exists
                echo "APP_NAME=\"$APP_NAME\"" >> "$OPNFORM_DIR/api/.env"
                echo "  ✓ Added APP_NAME to api/.env"
            fi
        else
            echo "  ⚠ Warning: api/.env not found, skipping API app name update"
        fi
    else
        echo "Using default app name 'OpnForm'"
    fi
else
    echo "No custom config provided, skipping app name replacement"
fi

# Step 3: Add conditional rendering for empty links
echo "[3/7] Configuring link visibility..."
add_link_conditionals

# Step 4: Copy custom API files (if any)
echo "[4/7] Copying custom API files..."
copy_custom_files "$SCRIPT_DIR/custom-files/api" "$OPNFORM_DIR/api"

# Step 5: Backup and modify docker-compose.yml for local builds
echo "[5/7] Modifying docker-compose.yml for local builds..."

# Backup original if not already backed up
if [ ! -f "$OPNFORM_DIR/docker-compose.yml.original" ]; then
    cp "$OPNFORM_DIR/docker-compose.yml" "$OPNFORM_DIR/docker-compose.yml.original"
    echo "✓ Original docker-compose.yml backed up"
fi

# Restore from backup to start fresh
cp "$OPNFORM_DIR/docker-compose.yml.original" "$OPNFORM_DIR/docker-compose.yml"

# Modify the docker-compose.yml to add build directives
# Replace image: jhumanj/opnform-api:latest with build config
sed -i '/api: &api-environment/,/image: jhumanj\/opnform-api:latest/{
    s|image: jhumanj/opnform-api:latest|build:\n      context: '"$OPNFORM_DIR"'\n      dockerfile: '"$OPNFORM_DIR"'/docker/Dockerfile.api\n    image: opnform-api-custom:latest|
}' "$OPNFORM_DIR/docker-compose.yml"

# Replace image: jhumanj/opnform-client:latest with build config
sed -i '/ui:/,/image: jhumanj\/opnform-client:latest/{
    s|image: jhumanj/opnform-client:latest|build:\n      context: '"$OPNFORM_DIR"'\n      dockerfile: '"$OPNFORM_DIR"'/docker/Dockerfile.client\n    image: opnform-client-custom:latest|
}' "$OPNFORM_DIR/docker-compose.yml"

echo "✓ docker-compose.yml modified for local builds"

# Step 6: Stop existing containers
echo "[6/7] Stopping existing containers..."
cd "$OPNFORM_DIR"
echo "Current directory: $(pwd)"
echo "Checking for docker-compose files:"
ls -la docker-compose*.yml
echo ""
docker compose down || true

# Step 7: Build images directly with podman (bypass podman-compose)
echo "[7/7] Building custom images..."
echo "Current directory: $(pwd)"
echo "This may take several minutes..."

# Build API image
echo "Building API image..."
podman build --no-cache -t opnform-api-custom:latest -f "$OPNFORM_DIR/docker/Dockerfile.api" "$OPNFORM_DIR"

# Build Client image
echo "Building Client image..."
podman build --no-cache -t opnform-client-custom:latest -f "$OPNFORM_DIR/docker/Dockerfile.client" "$OPNFORM_DIR"

echo "✓ Images built successfully"

# Start containers with docker compose
echo "Starting containers..."
docker compose up -d

echo ""
echo "=================================="
echo "✓ Deployment Complete!"
echo "=================================="
echo ""
if [ -n "$APP_NAME" ] && [ "$APP_NAME" != "OpnForm" ]; then
    echo "Your '$APP_NAME' instance is now running."
else
    echo "Your customized OpnForm is now running."
fi
echo ""
echo "Check status with: docker compose ps"
echo "View logs with: docker compose logs -f"
echo ""
