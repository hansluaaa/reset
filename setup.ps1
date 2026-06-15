Clear-Host
Write-Host "=================================" -ForegroundColor Cyan
Write-Host "       Hans Setup Tool"
Write-Host "================================="
Write-Host ""
Write-Host "1. Installeer alles"
Write-Host "2. Kies zelf"
Write-Host ""

$choice = Read-Host "Maak een keuze (1/2)"

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

if ($choice -eq "1") {
    foreach ($app in $apps.Values) {
        winget install --id $app -e `
            --accept-package-agreements `
            --accept-source-agreements
    }
}
elseif ($choice -eq "2") {
    foreach ($app in $apps.Keys) {
        $answer = Read-Host "Wil je $app installeren? (Y/N)"

        if ($answer -match "^[Yy]$") {
            winget install --id $apps[$app] -e `
                --accept-package-agreements `
                --accept-source-agreements
        }
    }
}
else {
    Write-Host "Ongeldige keuze."
}

Write-Host ""
Write-Host "Klaar!" -ForegroundColor Green
Pause
