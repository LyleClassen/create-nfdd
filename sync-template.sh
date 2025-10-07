#!/bin/bash

# Sync template from mono-repo-starter
# This script copies the mono-repo-starter and applies template variable substitutions

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="../mono-repo-starter"
TEMPLATE_DIR="$SCRIPT_DIR/templates/default"

echo "🔄 Syncing template from mono-repo-starter..."

# Clean existing template
rm -rf "$TEMPLATE_DIR"
mkdir -p "$TEMPLATE_DIR"

# Copy files excluding certain directories
echo "📦 Copying files..."
rsync -av \
  --exclude='node_modules' \
  --exclude='.next' \
  --exclude='dist' \
  --exclude='pnpm-lock.yaml' \
  --exclude='.git' \
  --exclude='.claude' \
  "$SOURCE_DIR/" "$TEMPLATE_DIR/"

echo "✏️  Applying template substitutions..."

# Substitute in root package.json
sed -i '' 's/"name": "mono-repo-starter"/"name": "{{name}}"/' "$TEMPLATE_DIR/package.json"
sed -i '' 's/"description": ""/"description": "{{description}}"/' "$TEMPLATE_DIR/package.json"
sed -i '' 's/"author": ""/"author": "{{author}}{{#if email}} <{{email}}>{{\/if}}"/' "$TEMPLATE_DIR/package.json"
sed -i '' 's/"license": "ISC"/"license": "{{license}}"/' "$TEMPLATE_DIR/package.json"

# Substitute in .env.dev
sed -i '' 's/WEB_CLIENT_PORT=3000/WEB_CLIENT_PORT={{webPort}}/' "$TEMPLATE_DIR/.env.dev"
sed -i '' 's/BACKEND_API_PORT=3001/BACKEND_API_PORT={{apiPort}}/' "$TEMPLATE_DIR/.env.dev"
sed -i '' 's|NEXT_PUBLIC_API_URL=http://localhost:3001|NEXT_PUBLIC_API_URL=http://localhost:{{apiPort}}|' "$TEMPLATE_DIR/.env.dev"
sed -i '' 's|CORS_ORIGIN=http://localhost:3000|CORS_ORIGIN=http://localhost:{{webPort}}|' "$TEMPLATE_DIR/.env.dev"
sed -i '' 's/POSTGRES_DB=app_db/POSTGRES_DB={{database}}/' "$TEMPLATE_DIR/.env.dev"
sed -i '' 's|DATABASE_URL=postgresql://postgres:postgres@database:5432/app_db|DATABASE_URL=postgresql://postgres:postgres@database:5432/{{database}}|' "$TEMPLATE_DIR/.env.dev"

# Substitute in .env.prod
sed -i '' 's/WEB_CLIENT_PORT=3000/WEB_CLIENT_PORT={{webPort}}/' "$TEMPLATE_DIR/.env.prod"
sed -i '' 's/BACKEND_API_PORT=3001/BACKEND_API_PORT={{apiPort}}/' "$TEMPLATE_DIR/.env.prod"
sed -i '' 's/POSTGRES_DB=app_db/POSTGRES_DB={{database}}/' "$TEMPLATE_DIR/.env.prod"
sed -i '' 's|DATABASE_URL=postgresql://postgres:change_me_in_production@database:5432/app_db|DATABASE_URL=postgresql://postgres:change_me_in_production@database:5432/{{database}}|' "$TEMPLATE_DIR/.env.prod"

# Substitute in web-client .env.local
sed -i '' 's|NEXT_PUBLIC_API_URL=http://localhost:3001|NEXT_PUBLIC_API_URL=http://localhost:{{apiPort}}|' "$TEMPLATE_DIR/apps/web-client/.env.local"

# Substitute in backend-api package.json
sed -i '' 's/"name": "@mono-repo-starter\/backend-api"/"name": "@{{name}}\/backend-api"/' "$TEMPLATE_DIR/apps/backend-api/package.json"

# Substitute in web-client package.json
sed -i '' 's/"name": "web-client"/"name": "{{name}}-web-client"/' "$TEMPLATE_DIR/apps/web-client/package.json"

echo "✅ Template sync complete!"
echo ""
echo "Template location: $TEMPLATE_DIR"
echo ""
echo "Next steps:"
echo "  1. Review the template files"
echo "  2. Run 'pnpm build' to rebuild the CLI"
echo "  3. Test with: node lib/cli.js test-app"
