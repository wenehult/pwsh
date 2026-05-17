# strukturverktyg.ps1
# Detta skript skapar en mappstruktur med logs, scripts och temp.
# Det skapar även en loggfil med dagens datum.

function SkapaStruktur {
    param (
        [string]$Namn
    )

    try {
        # Kontrollera om användaren skrev något
        if ([string]::IsNullOrWhiteSpace($Namn)) {
            throw "Du måste skriva ett namn."
        }

        # Sökväg till huvudmappen
        $huvudmapp = ".\$Namn"

        # Kontrollera om huvudmappen redan finns
        if (Test-Path $huvudmapp) {
            throw "Det kan du glömma den mappen finns redan."
        }

        # Skapa huvudmappen
        New-Item -Path $huvudmapp -ItemType Directory | Out-Null

        # Skapa undermappar
        New-Item -Path "$huvudmapp\logs" -ItemType Directory | Out-Null
        New-Item -Path "$huvudmapp\scripts" -ItemType Directory | Out-Null
        New-Item -Path "$huvudmapp\temp" -ItemType Directory | Out-Null

        # Skapa datum för loggfilens namn
        $datum = Get-Date -Format "yyyy-MM-dd"

        # Skapa datum och tid för loggens innehåll
        $datumTid = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        # Sökväg till loggfilen
        $loggfil = "$huvudmapp\logs\log-$datum.txt"

        # Skriv text till loggfilen
        "Struktur skapad: $datumTid" | Out-File -FilePath $loggfil -Encoding UTF8

        Write-Host "Strukturen skapades utan problem." -ForegroundColor Green
        Write-Host "Huvudmapp: $huvudmapp"
        Write-Host "Loggfil: $loggfil"
    }
    catch {
        # Visa felmeddelande om något går fel
        Write-Host "Ett fel uppstod: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Fråga användaren efter ett namn
$namn = Read-Host "Skriv namn på kundsystem eller miljö"

# Kör funktionen
SkapaStruktur -Namn $namn

