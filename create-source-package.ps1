# Create Source Package Script for Ping Panda
# This script creates a zip file with all the source code for manual deployment

# Configuration
$packageName = "ping-panda-source"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputZip = "${packageName}-${timestamp}.zip"

# Define files and directories to include
$filesToInclude = @(
    "src",
    "public",
    "prisma",
    "package.json",
    "pnpm-lock.yaml",
    "next.config.mjs",
    "postcss.config.mjs",
    "tailwind.config.ts",
    "wrangler.toml",
    "tsconfig.json",
    "ENVIRONMENT_VARIABLES.md",
    "README.md",
    "deploy.sh",
    "deploy.ps1"
)

# Create a temporary directory for the build package
$tempDir = "source-package-temp"
if (Test-Path $tempDir) {
    Remove-Item -Path $tempDir -Recurse -Force
}
New-Item -Path $tempDir -ItemType Directory | Out-Null

# Copy files to the temporary directory
foreach ($item in $filesToInclude) {
    if (Test-Path $item) {
        Write-Host "Including: $item" -ForegroundColor Green
        Copy-Item -Path $item -Destination $tempDir -Recurse
    } else {
        Write-Host "Warning: $item not found, skipping" -ForegroundColor Yellow
    }
}

# Create example .env file from .env.example if it exists
if (Test-Path ".env.example") {
    Copy-Item -Path ".env.example" -Destination "$tempDir/.env.example"
}

# Create the zip file
Write-Host "Creating source package: $outputZip" -ForegroundColor Cyan
Compress-Archive -Path "$tempDir/*" -DestinationPath $outputZip

# Clean up
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Source package created successfully: $outputZip" -ForegroundColor Green
Write-Host "This package contains the source code for manual deployment." -ForegroundColor Green
Write-Host "To deploy:" -ForegroundColor Cyan
Write-Host "1. Extract the package on your deployment server" -ForegroundColor Cyan
Write-Host "2. Create a .env file with all required environment variables" -ForegroundColor Cyan
Write-Host "3. Run 'pnpm install' to install dependencies" -ForegroundColor Cyan
Write-Host "4. Fix any TypeScript errors in the source code" -ForegroundColor Cyan
Write-Host "5. Run 'pnpm build' to build the application" -ForegroundColor Cyan
Write-Host "6. Run 'pnpm deploy' to deploy to Cloudflare Workers or 'pnpm start' to start the server" -ForegroundColor Cyan 