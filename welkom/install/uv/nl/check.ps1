# Proglab uv-installatiecontrole (Windows)
# Gebruik: irm https://www.proglab.nl/welkom/install/uv/nl/check.ps1 | iex

$Esc = [char]27
$Reset = "$Esc[0m"
$Accent = "$Esc[36m"
$Ok = "$Esc[32m"; $NotOk = "$Esc[37m"; $Gray = "$Esc[90m"

# Zoek een submap van $Base waarvan de naam hoofdletterongevoelig overeenkomt
# met een van de gegeven namen. Geeft het volledige pad van de eerste treffer
# terug, of $null (ook als $Base niet bestaat).
function Find-SubdirCI([string]$Base, [string[]]$Names) {
    Get-ChildItem -Path $Base -Directory -ErrorAction SilentlyContinue |
        Where-Object { $Names -contains $_.Name.ToLower() } |
        Select-Object -First 1 -ExpandProperty FullName
}

function Write-Accent([string]$Text) {
    Write-Host "$Accent$Text$Reset"
}

function Write-Line { Write-Accent ("-" * 44) }

$global:passN = 0
$global:warnN = 0
$global:failN = 0

# Report -Status <pass|fail|warn> -Headline <tekst> -Detail <zinnen>
# Detailzinnen worden ingesprongen onder de kop getoond en leggen uit wat er
# gecontroleerd is en, indien nodig, wat je eraan kunt doen.
function Report([string]$Status, [string]$Headline, [string[]]$Detail = @()) {
    switch ($Status) {
        'pass' { $tag = "[x]"; $color = $Ok; $global:passN++ }
        'fail' { $tag = "[ ]"; $color = $NotOk; $global:failN++ }
        'warn' { $tag = "[!]"; $color = $NotOk; $global:warnN++ }
    }
    Write-Host "  $color$tag$Reset $Headline"
    foreach ($line in $Detail) {
        Write-Host "      $Gray$line$Reset"
    }
}

Write-Host ""
Write-Accent "  PROGLAB - JE INSTALLATIE CONTROLEREN"
Write-Line
Write-Host ""

# 1. uv geïnstalleerd
$uvCmd = Get-Command uv -ErrorAction SilentlyContinue
if ($uvCmd) {
    $uvVersion = (& uv --version) 2>$null
    Report pass "uv is geïnstalleerd ($uvVersion)" @(
        "uv is het gereedschap waarmee dit vak Python installeert en de packages"
        "voor elk vak beheert, in plaats van dat je dat met de hand doet."
    )
} else {
    Report fail "uv is niet gevonden" @(
        "Dat betekent dat het installatiecommando uit 'Installeer uv nu' niet is"
        "afgerond, of dat je PowerShell sindsdien niet hebt gesloten en opnieuw"
        "geopend. Ga terug naar die stap, voer het installatiecommando opnieuw"
        "uit, sluit dit venster, open een nieuw venster en voer deze controle"
        "nog een keer uit."
    )
}

# 2. uv run python >= 3.14
if ($uvCmd) {
    $tmp = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $tmp | Out-Null
    Push-Location $tmp
    $pyVersion = (& uv run python -c "import sys; print('%d.%d.%d' % sys.version_info[:3])") 2>$null
    Pop-Location
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue

    if ($pyVersion) {
        $parts = $pyVersion -split '\.'
        $major = [int]$parts[0]; $minor = [int]$parts[1]
        if ($major -gt 3 -or ($major -eq 3 -and $minor -ge 14)) {
            Report pass "uv kan Python $pyVersion starten" @(
                "Dat is een recente genoeg versie. Dit vak heeft minimaal Python 3.14 nodig."
            )
        } else {
            Report fail "uv startte Python $pyVersion, en dat is te oud" @(
                "Dit vak heeft minimaal Python 3.14 nodig. Voer dit commando uit in je"
                "terminal om een nieuwere versie te installeren en voer deze controle"
                "daarna opnieuw uit:"
                "    uv python install 3.14"
            )
        }
    } else {
        Report fail "kon Python niet starten via uv" @(
            "Voer dit commando uit in je terminal om Python te installeren en voer"
            "deze controle daarna opnieuw uit:"
            "    uv python install 3.14"
        )
    }
} else {
    Report fail "overgeslagen: hiervoor is uv nodig, en dat is hierboven niet gevonden" @(
        "Los eerst het probleem met uv hierboven op en voer deze controle daarna opnieuw uit."
    )
}

# 3. Programmeermap bestaat op een acceptabele plek
#
# De tutorial zegt studenten C:\programming te gebruiken. Een map direct in de
# thuismap is ook prima: OneDrive neemt alleen Desktop, Documents en Pictures
# over, dus $HOME\Programming wordt ook niet gesynchroniseerd.
$systemDrive = if ($env:SystemDrive) { "$env:SystemDrive\" } else { "C:\" }
$programmingDir = Find-SubdirCI -Base $systemDrive -Names @('programming')
if (-not $programmingDir) {
    $programmingDir = Find-SubdirCI -Base $HOME -Names @('programming')
}
if ($programmingDir) {
    Report pass "je programmeermap is gevonden: $programmingDir" @(
        "Hierin houd je een submap bij voor elk vak. Het is een gewone map op je"
        "eigen computer, en dat is precies wat je wilt: geen clouddienst gaat je"
        "bestanden verplaatsen, vergrendelen of half downloaden."
    )
} else {
    Report fail "geen programmeermap gevonden" @(
        "In de tutorial maak je één map aan waarin al je vakmappen komen te staan."
        "Maak hem aan met dit commando en voer deze controle daarna opnieuw uit:"
        "    mkdir C:\programming"
    )
}

# 4. Geen Programming-map op een gesynchroniseerde of anderszins ongeschikte plek
#
# Vakwerk mag niet staan in een map die door een clouddienst wordt
# gesynchroniseerd, of in Documents/Desktop/Downloads (die op veel computers
# gesynchroniseerd worden zonder dat de student dat doorheeft).
$badBases = @(
    (Join-Path $HOME 'Documents')
    (Join-Path $HOME 'Desktop')
    (Join-Path $HOME 'Downloads')
)

# Met Known Folder Move van OneDrive is $HOME\Documents een lege lokmap en
# staat de echte map Documents in OneDrive. Vraag aan Windows waar hij staat.
try {
    $realDocs = [Environment]::GetFolderPath('MyDocuments')
    if ($realDocs) { $badBases += $realDocs }
} catch { }

# Cloudprogramma's zetten hun map direct in de thuismap. OneDrive voor een
# organisatie heet bijvoorbeeld "OneDrive - Universiteit van Amsterdam".
Get-ChildItem -Path $HOME -Directory -ErrorAction SilentlyContinue |
    Where-Object {
        $n = $_.Name.ToLower()
        $n -like 'onedrive*' -or $n -eq 'dropbox' -or $n -eq 'google drive' -or
        $n -eq 'nextcloud' -or $n -eq 'surfdrive' -or $n -eq 'owncloud'
    } |
    ForEach-Object { $badBases += $_.FullName }

$badDirs = @()
foreach ($base in ($badBases | Select-Object -Unique)) {
    $found = Find-SubdirCI -Base $base -Names @('programming')
    if ($found) { $badDirs += $found }
}
$badDirs = @($badDirs | Select-Object -Unique)

if ($badDirs.Count -eq 0) {
    Report pass "geen vakwerk in een gesynchroniseerde map" @(
        "Er is niets gevonden in Documents, Desktop, Downloads, OneDrive of een"
        "vergelijkbare map. Houd dat zo."
    )
} else {
    $detail = @(
        "Clouddiensten herschrijven, vergrendelen en downloaden bestanden"
        "gedeeltelijk, en dat maakt virtuele omgevingen kapot op een manier die"
        "moeilijk te achterhalen is. Verplaats de map(pen) hieronder naar"
        "C:\programming en voer deze controle daarna opnieuw uit:"
    )
    foreach ($bad in $badDirs) { $detail += "    $bad" }
    Report fail "vakwerk gevonden in een map die je niet moet gebruiken" $detail
}

Write-Host ""
Write-Line
Write-Host ""
if ($failN -eq 0 -and $warnN -eq 0) {
    Write-Host "  $Ok" -NoNewline
    Write-Host "Alles is in orde. Je kunt verder met de tutorial.$Reset"
    Write-Host ""
    Write-Accent "  Hierna: ga naar je programmeermap en maak een map voor je vak."
    Write-Host ""
    Write-Host "      $Gray" -NoNewline; Write-Host "cd $programmingDir$Reset"
    Write-Host "      $Gray" -NoNewline; Write-Host "mkdir mijn-vak$Reset"
    Write-Host "      $Gray" -NoNewline; Write-Host "cd mijn-vak$Reset"
} elseif ($failN -eq 0) {
    Write-Host "  $NotOk" -NoNewline
    Write-Host "Er is niets kapot, maar lees de waarschuwing(en) hierboven.$Reset"
} else {
    Write-Host "  $NotOk" -NoNewline
    Write-Host "$failN punt(en) hierboven moeten worden opgelost. Los ze een voor een op en voer deze controle daarna opnieuw uit.$Reset"
}
Write-Host ""
