#!/bin/bash

# Create Source Package Script for Ping Panda
# This script creates a zip file with all the source code for manual deployment

# Configuration
packageName="ping-panda-source"
timestamp=$(date +"%Y%m%d-%H%M%S")
outputZip="${packageName}-${timestamp}.zip"

# Colors for terminal output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define files and directories to include
filesToInclude=(
    "src"
    "public"
    "prisma"
    "package.json"
    "pnpm-lock.yaml"
    "next.config.mjs"
    "postcss.config.mjs"
    "tailwind.config.ts"
    "wrangler.toml"
    "tsconfig.json"
    "ENVIRONMENT_VARIABLES.md"
    "README.md"
    "deploy.sh"
    "deploy.ps1"
)

# Create a temporary directory for the source package
tempDir="source-package-temp"
if [ -d "$tempDir" ]; then
    rm -rf "$tempDir"
fi
mkdir -p "$tempDir"

# Copy files to the temporary directory
for item in "${filesToInclude[@]}"; do
    if [ -e "$item" ]; then
        echo -e "${GREEN}Including: $item${NC}"
        cp -r "$item" "$tempDir/"
    else
        echo -e "${YELLOW}Warning: $item not found, skipping${NC}"
    fi
done

# Create example .env file from .env.example if it exists
if [ -f ".env.example" ]; then
    cp ".env.example" "$tempDir/.env.example"
fi

# Create the zip file
echo -e "${CYAN}Creating source package: $outputZip${NC}"
cd "$tempDir" && zip -r "../$outputZip" . >/dev/null && cd ..

# Clean up
rm -rf "$tempDir"

echo -e "${GREEN}Source package created successfully: $outputZip${NC}"
echo -e "${GREEN}This package contains the source code for manual deployment.${NC}"
echo -e "${CYAN}To deploy:${NC}"
echo -e "${CYAN}1. Extract the package on your deployment server${NC}"
echo -e "${CYAN}2. Create a .env file with all required environment variables${NC}"
echo -e "${CYAN}3. Run 'pnpm install' to install dependencies${NC}"
echo -e "${CYAN}4. Fix any TypeScript errors in the source code${NC}"
echo -e "${CYAN}5. Run 'pnpm build' to build the application${NC}"
echo -e "${CYAN}6. Run 'pnpm deploy' to deploy to Cloudflare Workers or 'pnpm start' to start the server${NC}" 