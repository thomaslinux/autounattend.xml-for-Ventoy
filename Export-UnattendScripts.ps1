$unattendPath = Join-Path $PSScriptRoot 'autounattend.xml'
if (-not (Test-Path $unattendPath)) { $unattendPath = (Read-Host 'Chemin de autounattend.xml').Trim('"') }

$outputFolder = Join-Path $PSScriptRoot 'scripts'
$installedFolder = 'C:\Windows\Setup\Scripts'
$launchOrder = 'Specialize', 'DefaultUser', 'UserOnce', 'FirstLogon'
$namespace = @{ g = 'https://schneegans.de/windows/unattend-generator/' }
$document = [xml](Get-Content -LiteralPath $unattendPath -Raw -Encoding UTF8)
New-Item -ItemType Directory -Path $outputFolder -Force | Out-Null

function Get-Encoding($fileName) {
    if ($fileName -like '*.vbs') { [Text.UnicodeEncoding]::new($false, $true) }
    else { [Text.UTF8Encoding]::new($true) }
}

function Convert-ForCurrentUser($script) {
    $script = $script.Replace('HKU\DefaultUser', 'HKCU').Replace('HKU\.DEFAULT', 'HKCU')
    $script = $script -replace "'$([regex]::Escape($installedFolder))\\([^']*)'", '"$$PSScriptRoot\$1"'
    $script = $script.Replace($installedFolder, '$PSScriptRoot')
    $script.Replace('-Raw )', "-Raw ).Replace('$installedFolder', `$PSScriptRoot)")
}

Select-Xml $document -XPath '//g:File' -Namespace $namespace | ForEach-Object Node | ForEach-Object {
    $fileName = ($_.GetAttribute('path') -split '\\')[-1]
    $content = $_.InnerText.Trim()
    if ($fileName -like '*.ps1') { $content = Convert-ForCurrentUser $content }
    $encoding = Get-Encoding $fileName
    [IO.File]::WriteAllBytes((Join-Path $outputFolder $fileName), $encoding.GetPreamble() + $encoding.GetBytes($content))
    $fileName
}

@"
@echo off
net session >nul 2>&1 || (powershell -NoProfile -Command "Start-Process '%~f0' -Verb RunAs" & exit /b)
for %%S in ($launchOrder) do powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0%%S.ps1"
pause
"@ | Set-Content -LiteralPath (Join-Path $outputFolder 'LancerTout.bat') -Encoding ASCII