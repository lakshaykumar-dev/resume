param(
    [string]$Message = "Update resume"
)

$ErrorActionPreference = "Stop"

git add resume_v1.pdf
git commit -m $Message
git push

Write-Host "Resume PDF pushed successfully." -ForegroundColor Green
