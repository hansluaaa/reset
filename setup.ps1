Clear-Host

$downloadPath = "C:\Setup"

$apps = @{
    "Discord"           = "Discord.Discord"
    "Epic Games"        = "EpicGames.EpicGamesLauncher"
    "Steam"             = "Valve.Steam"
    "Spotify"           = "Spotify.Spotify"
    "NVIDIA App"        = "Nvidia.NVIDIAApp"
    "Brave"             = "Brave.Brave"
    "Rockstar Launcher" = "RockstarGames.RockstarGamesLauncher"
    "FiveM"             = "Cfx.re.FiveM"
    "ReShade"           = "Reshade.Setup"
}

Write-Host "=================================" -ForegroundColor Cyan
Write-Host "       El Patron Hans Tool" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Alles installeren"
Write-Host "2. Zelf kiezen"
Write-Host "3. Alles downloaden naar C:\Setup"
Write-Host ""

$choice = Read-Host "Maak een keuze"

switch ($choice) {

    "1" {
        foreach ($app in $apps.Values) {
            winget install --id $app -e `
                --accept-package-agreements `
                --accept-source-agreements
        }
    }

    "2" {
        foreach ($app in $apps.Keys) {
            $answer = Read-Host "Wil je $app installeren? (Y/N)"

            if ($answer -match "^[Yy]$") {
                winget install --id $apps[$app] -e `
                    --accept-package-agreements `
                    --accept-source-agreements
            }
        }
    }

    "3" {
        if (!(Test-Path $downloadPath)) {
            New-Item -ItemType Directory -Path $downloadPath | Out-Null
        }

        foreach ($app in $apps.Values) {
            winget download --id $app -e `
                --download-directory $downloadPath
        }

        Write-Host ""
        Write-Host "Alle installers zijn gedownload naar:" -ForegroundColor Green
        Write-Host $downloadPath -ForegroundColor Yellow
    }

    Default {
        Write-Host "Ongeldige keuze." -ForegroundColor Red
    }
}

Pause
