# Make Shell Scripts Executable
# This PowerShell script sets the executable flag on shell scripts when running on WSL or Git Bash

$shellScripts = @(
    "deploy.sh",
    "create-build-package.sh",
    "create-source-package.sh"
)

foreach ($script in $shellScripts) {
    if (Test-Path $script) {
        Write-Host "Making $script executable..." -ForegroundColor Cyan
        try {
            # First try with git update-index (Git Bash)
            git update-index --chmod=+x $script 2>$null
            # Try with chmod command (WSL or Git Bash)
            bash -c "chmod +x '$script'" 2>$null
            Write-Host "Successfully made $script executable" -ForegroundColor Green
        } catch {
            Write-Host "Could not make $script executable. You may need to run 'chmod +x $script' manually on Linux/Mac." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Warning: $script not found" -ForegroundColor Yellow
    }
}

Write-Host "Done. Shell scripts should now be executable on Linux/Mac systems." -ForegroundColor Green
Write-Host "Note: If deploying to Linux/Mac, you may still need to run 'chmod +x *.sh' after extraction." -ForegroundColor Cyan 