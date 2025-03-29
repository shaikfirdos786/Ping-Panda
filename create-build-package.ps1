# Create Build Package Script for Ping Panda
# This script creates a zip file with all the files needed for deployment

# Configuration
$packageName = "ping-panda-build"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputZip = "${packageName}-${timestamp}.zip"

# Create build first
Write-Host "Building application (skipping linting)..." -ForegroundColor Cyan
pnpm build-package

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed. Aborting package creation." -ForegroundColor Red
    exit 1
}

# Define files and directories to include
$filesToInclude = @(
    ".next",
    "public",
    "prisma",
    "package.json",
    "pnpm-lock.yaml",
    "next.config.mjs",
    "postcss.config.mjs",
    "tailwind.config.ts",
    "wrangler.toml",
    "ENVIRONMENT_VARIABLES.md",
    "README.md",
    # Add any other files needed for deployment
    # but exclude development and git files
    "deploy.sh",
    "deploy.ps1"
)

# Create a temporary directory for the build package
$tempDir = "build-package-temp"
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
Write-Host "Creating build package: $outputZip" -ForegroundColor Cyan
Compress-Archive -Path "$tempDir/*" -DestinationPath $outputZip

# Clean up
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Build package created successfully: $outputZip" -ForegroundColor Green
Write-Host "You can now deploy this package to your production environment." -ForegroundColor Green 