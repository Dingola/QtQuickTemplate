[CmdletBinding()]
param(
    [Parameter()]
    [string]$TemplateSource = "gh:Dingola/QtQuickTemplate",

    [Parameter()]
    [string]$ProjectName = (Split-Path -Leaf (Get-Location)),

    [Parameter()]
    [string]$VcsRef
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Assert-CommandAvailable {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$InstallationHint
    )

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found. $InstallationHint"
    }
}

function Assert-BootstrapRepository {
    if (-not (Test-Path -LiteralPath ".git" -PathType Container)) {
        throw "Run this script from the root of the repository created with GitHub's 'Use this template' button."
    }

    if (-not (Test-Path -LiteralPath "copier.yml" -PathType Leaf) -or
        -not (Test-Path -LiteralPath "template" -PathType Container)) {
        throw "The Copier bootstrap files are missing or this project has already been initialized."
    }

    if (Test-Path -LiteralPath ".copier-answers.yml" -PathType Leaf) {
        throw "This repository already contains .copier-answers.yml. Use 'copier update' instead."
    }

    if ($ProjectName -notmatch "^[A-Za-z][A-Za-z0-9_]*$") {
        throw "ProjectName must start with a letter and contain only letters, numbers, and underscores."
    }

    $pendingChanges = git status --porcelain
    if ($LASTEXITCODE -ne 0) {
        throw "Unable to inspect the Git working tree."
    }
    if ($pendingChanges) {
        throw "The Git working tree must be clean before initialization. Commit or discard pending changes first."
    }
}

Assert-CommandAvailable `
    -Name "git" `
    -InstallationHint "Install Git and make it available through PATH."
Assert-CommandAvailable `
    -Name "copier" `
    -InstallationHint "Install Copier with a stable Python version through pipx, run 'pipx ensurepath', and restart the terminal. See README.md for the Windows commands."
Assert-BootstrapRepository

$copyArguments = @(
    "copy",
    "--overwrite",
    "--data",
    "project_name=$ProjectName"
)

if ($VcsRef) {
    $copyArguments += @("--vcs-ref", $VcsRef)
}

$copyArguments += @($TemplateSource, ".")

Write-Host "Generating project '$ProjectName' from '$TemplateSource'..."
& copier @copyArguments
if ($LASTEXITCODE -ne 0) {
    throw "Copier failed. The bootstrap files were kept so initialization can be retried."
}

if (-not (Test-Path -LiteralPath ".copier-answers.yml" -PathType Leaf)) {
    throw "Copier completed without creating .copier-answers.yml. Bootstrap files were kept."
}

$bootstrapTemplatePath = (Resolve-Path -LiteralPath "template").Path
$repositoryPath = (Resolve-Path -LiteralPath ".").Path
if (-not $bootstrapTemplatePath.StartsWith(
        $repositoryPath + [System.IO.Path]::DirectorySeparatorChar,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to remove a template directory outside the repository."
}

Remove-Item -LiteralPath $bootstrapTemplatePath -Recurse -Force
Remove-Item -LiteralPath "copier.yml" -Force
$bootstrapWorkflow = ".github/workflows/validate_template.yml"
if (Test-Path -LiteralPath $bootstrapWorkflow -PathType Leaf) {
    Remove-Item -LiteralPath $bootstrapWorkflow -Force
}

Write-Host ""
Write-Host "Project generation completed successfully."
Write-Host "Review and commit the generated files:"
Write-Host ""
Write-Host "  git status"
Write-Host "  git diff"
Write-Host "  git add ."
Write-Host '  git commit -m "Initialize project from QtQuickTemplate"'
Write-Host "  git push"
Write-Host ""
Write-Host "Future template updates can be applied from a clean working tree with:"
Write-Host ""
Write-Host "  copier update"

Remove-Item -LiteralPath $PSCommandPath -Force
