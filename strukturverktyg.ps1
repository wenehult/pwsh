# Detta är strukturverktyg.ps1 som är ett PowerShell-skript för inlämninig 1
# Detta skript skapar en mappstruktur med logs, scripts och temp.
# Det skapar även en loggfil med dagens datum.

function SkapaStruktur {
    param (
        [ValidateNotNullOrEmpty()]
        [string]$Namn
    )
    try {
        

        # Sökväg till huvudmappen
        $huvudmapp = ".\$Namn"

        # Kontrollera om huvudmappen redan finns
        if (Test-Path $huvudmapp) {
            throw "Det kan du glömma! Mappen '$Namn' finns redan."
        }

        # Skapar huvudmappen
        New-Item -Path $huvudmapp -ItemType Directory

        # Skapar undermapparna
        New-Item -Path "$huvudmapp\logs" -ItemType Directory
        New-Item -Path "$huvudmapp\scripts" -ItemType Directory
        New-Item -Path "$huvudmapp\temp" -ItemType Directory 

        #  Kollar datum för loggfilens namn
        $datum = Get-Date -Format "yyyy-MM-dd"

        # Tittar på datum och tid för loggens innehåll
        $datumTid = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        # Sökväg till loggfilen
        $loggfil = "$huvudmapp\logs\log-$datum.txt"

        # Skriv text till loggfilen
        "Struktur skapad: $datumTid" | Out-File -FilePath $loggfil -Encoding UTF8

        Write-Host "Strukturen skapades utan problem." -ForegroundColor Blue
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
