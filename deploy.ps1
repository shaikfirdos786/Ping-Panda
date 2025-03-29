# Ping Panda Deployment Script - PowerShell version

Write-Host "Starting deployment for Ping Panda..." -ForegroundColor Green

# Check if .env file exists
if (-not (Test-Path -Path ".env")) {
    Write-Host "Error: .env file not found. Please create it from .env.example" -ForegroundColor Red
    exit 1
}

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Cyan
pnpm install

# Generate Prisma client
Write-Host "Generating Prisma client..." -ForegroundColor Cyan
npx prisma generate

# Build the application
Write-Host "Building application..." -ForegroundColor Cyan
pnpm build

# Deploy to Cloudflare Workers
Write-Host "Deploying to Cloudflare Workers..." -ForegroundColor Cyan
pnpm deploy

Write-Host "Deployment completed successfully!" -ForegroundColor Green 