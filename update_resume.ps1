param(
    [string]$Message = "Update resume"
)

$ErrorActionPreference = "Stop"

git add index.html resume_v1.pdf
git commit -m $Message
git push

Write-Host "index.html and resume_v1.pdf pushed successfully." -ForegroundColor Green
