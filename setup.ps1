Clear-Host
Write-Host "=================================" -ForegroundColor Cyan
Write-Host "      Robin Setup Tool" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

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

foreach ($app in $apps.Keys) {
    $answer = Read-Host "Wil je $app installeren? (Y/N)"

    if ($answer -match "^[Yy]$") {
        Write-Host "Installeren van $app..." -ForegroundColor Yellow

        winget install --id $apps[$app] -e `
            --accept-package-agreements `
            --accept-source-agreements
    }
}

Write-Host ""
Write-Host "Alle geselecteerde programma's zijn geïnstalleerd!" -ForegroundColor Green
Pause
