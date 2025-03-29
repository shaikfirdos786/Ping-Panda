#!/bin/bash

# Ping Panda Deployment Script

echo "Starting deployment for Ping Panda..."

# Check if .env file exists
if [ ! -f .env ]; then
  echo "Error: .env file not found. Please create it from .env.example"
  exit 1
fi

# Install dependencies
echo "Installing dependencies..."
pnpm install

# Generate Prisma client
echo "Generating Prisma client..."
npx prisma generate

# Build the application
echo "Building application..."
pnpm build

# Deploy to Cloudflare Workers
echo "Deploying to Cloudflare Workers..."
pnpm deploy

echo "Deployment completed successfully!" 