#!/bin/bash

# Create Build Package Script for Ping Panda
# This script creates a zip file with all the files needed for deployment

# Configuration
packageName="ping-panda-build"
timestamp=$(date +"%Y%m%d-%H%M%S")
outputZip="${packageName}-${timestamp}.zip"

# Colors for terminal output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create build first
echo -e "${CYAN}Building application (skipping linting)...${NC}"
pnpm build-package

if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed. Aborting package creation.${NC}"
    exit 1
fi

# Define files and directories to include
filesToInclude=(
    ".next"
    "public"
    "prisma"
    "package.json"
    "pnpm-lock.yaml"
    "next.config.mjs"
    "postcss.config.mjs"
    "tailwind.config.ts"
    "wrangler.toml"
    "ENVIRONMENT_VARIABLES.md"
    "README.md"
    # Add any other files needed for deployment
    # but exclude development and git files
    "deploy.sh"
    "deploy.ps1"
)

# Create a temporary directory for the build package
tempDir="build-package-temp"
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
echo -e "${CYAN}Creating build package: $outputZip${NC}"
cd "$tempDir" && zip -r "../$outputZip" . >/dev/null && cd ..

# Clean up
rm -rf "$tempDir"

echo -e "${GREEN}Build package created successfully: $outputZip${NC}"
echo -e "${GREEN}You can now deploy this package to your production environment.${NC}" 