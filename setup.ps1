Clear-Host

$downloadPath = "C:\Setup"

$apps = @{
    "Discord"           = "Discord.Discord"
    "Epic Games"        = "EpicGames.EpicGamesLauncher"
    "Steam"             = "Valve.Steam"
    "Spotify"           = "Spotify.Spotify"
    "Brave"             = "Brave.Brave"
    "Rockstar Launcher" = "RockstarGames.Launcher"
    "FiveM"             = "Cfx.re.FiveM"
    "ReShade"           = "Reshade.Setup"
}

Write-Host "=================================" -ForegroundColor Cyan
Write-Host "       Hans Reset Tool" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Alles installeren"
Write-Host "2. Zelf kiezen"
Write-Host "3. Alles downloaden naar C:\Setup"
Write-Host ""

$choice = Read-Host "Maak een keuze"

switch ($choice) {

    "1" {
        foreach ($app in $apps.Keys) {
            Write-Host "Installeren van $app..." -ForegroundColor Yellow

            winget install --id $apps[$app] -e `
                --accept-package-agreements `
                --accept-source-agreements
        }

        Write-Host "Installeren van NVIDIA App..." -ForegroundColor Yellow

        $tempFile = "$env:TEMP\NVIDIA_App_Setup.exe"

        Invoke-WebRequest `
            -Uri "https://us.download.nvidia.com/nvapp/client/11.0.7.247/NVIDIA_app_v11.0.7.247.exe" `
            -OutFile $tempFile

        Start-Process $tempFile -Wait

        Write-Host ""
        Write-Host "Alle programma's zijn geïnstalleerd!" -ForegroundColor Green
    }

    "2" {
        foreach ($app in $apps.Keys) {
            $answer = Read-Host "Wil je $app installeren? (Y/N)"

            if ($answer -match "^[Yy]$") {
                Write-Host "Installeren van $app..." -ForegroundColor Yellow

                winget install --id $apps[$app] -e `
                    --accept-package-agreements `
                    --accept-source-agreements
            }
        }

        $answer = Read-Host "Wil je NVIDIA App installeren? (Y/N)"

        if ($answer -match "^[Yy]$") {
            Write-Host "Installeren van NVIDIA App..." -ForegroundColor Yellow

            $tempFile = "$env:TEMP\NVIDIA_App_Setup.exe"

            Invoke-WebRequest `
                -Uri "https://us.download.nvidia.com/nvapp/client/11.0.7.247/NVIDIA_app_v11.0.7.247.exe" `
                -OutFile $tempFile

            Start-Process $tempFile -Wait
        }

        Write-Host ""
        Write-Host "Klaar!" -ForegroundColor Green
    }

    "3" {
        if (!(Test-Path $downloadPath)) {
            New-Item -ItemType Directory -Path $downloadPath | Out-Null
        }

        foreach ($app in $apps.Values) {
            Write-Host "Downloaden..." -ForegroundColor Yellow

            winget download --id $app -e `
                --download-directory $downloadPath
        }

        Write-Host "Downloaden van NVIDIA App..." -ForegroundColor Yellow

        Invoke-WebRequest `
            -Uri "https://us.download.nvidia.com/nvapp/client/11.0.7.247/NVIDIA_app_v11.0.7.247.exe" `
            -OutFile "$downloadPath\NVIDIA_App_Setup.exe"

        $renameMap = @{
            "Discord*.exe"             = "Discord_Setup.exe"
            "Epic Games Launcher*.msi" = "Epic_Games_Launcher_Setup.msi"
            "Steam*.exe"               = "Steam_Setup.exe"
            "Spotify*.exe"             = "Spotify_Setup.exe"
            "Brave*.exe"               = "Brave_Setup.exe"
            "FiveM*.exe"               = "FiveM_Setup.exe"
            "ReShade*.exe"             = "ReShade_Setup.exe"
            "Rockstar*.exe"            = "Rockstar_Launcher_Setup.exe"
        }

        foreach ($pattern in $renameMap.Keys) {
            Get-ChildItem $downloadPath -Filter $pattern -ErrorAction SilentlyContinue | ForEach-Object {
                Rename-Item $_.FullName -NewName $renameMap[$pattern] -Force
            }
        }

        Remove-Item "$downloadPath\*.yaml" -Force -ErrorAction SilentlyContinue

        Write-Host ""
        Write-Host "Alle installers zijn opgeslagen in:" -ForegroundColor Green
        Write-Host $downloadPath -ForegroundColor Cyan
    }

    Default {
        Write-Host "Ongeldige keuze." -ForegroundColor Red
    }
}

Pause
