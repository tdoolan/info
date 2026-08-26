# Proglab uv install check (Windows)
# Usage: irm https://www.proglab.nl/welkom/install/uv/check.ps1 | iex

$Esc = [char]27
$Reset = "$Esc[0m"
$Accent = "$Esc[36m"
$Ok = "$Esc[32m"; $NotOk = "$Esc[37m"; $Gray = "$Esc[90m"

# Look for a subfolder of $Base whose name case-insensitively matches one
# of the given names. Returns the full path of the first match, or $null
# (also when $Base does not exist).
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

# Report -Status <pass|fail|warn> -Headline <text> -Detail <sentences>
# Detail sentences are printed indented under the headline to explain
# what was checked and, if needed, what to do about it.
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
Write-Accent "  PROGLAB - CHECKING YOUR SETUP"
Write-Line
Write-Host ""

# 1. uv installed
$uvCmd = Get-Command uv -ErrorAction SilentlyContinue
if ($uvCmd) {
    $uvVersion = (& uv --version) 2>$null
    Report pass "uv is installed ($uvVersion)" @(
        "uv is the tool this course uses to install Python and manage the"
        "packages for each course, instead of doing that by hand."
    )
} else {
    Report fail "uv was not found" @(
        "This means the install command from 'Install uv now' did not finish,"
        "or you have not closed and reopened PowerShell since running it."
        "Go back to that step, run the install command again, then close this"
        "window, open a new one, and run this check again."
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
            Report pass "uv can start Python $pyVersion" @(
                "That is a recent enough version. This course needs at least Python 3.14."
            )
        } else {
            Report fail "uv started Python $pyVersion, which is too old" @(
                "This course needs at least Python 3.14. Run this command in your"
                "terminal to install a newer version, then run this check again:"
                "    uv python install 3.14"
            )
        }
    } else {
        Report fail "could not start Python through uv" @(
            "Run this command in your terminal to install Python, then run this"
            "check again:"
            "    uv python install 3.14"
        )
    }
} else {
    Report fail "skipped: this check needs uv, which was not found above" @(
        "Fix the uv problem above first, then run this check again."
    )
}

# 3. Programming folder exists at an acceptable location
#
# The tutorial tells students to use C:\programming. A folder directly in
# the home directory is fine too: OneDrive only takes over Desktop,
# Documents and Pictures, so $HOME\Programming is not synced either.
$systemDrive = if ($env:SystemDrive) { "$env:SystemDrive\" } else { "C:\" }
$programmingDir = Find-SubdirCI -Base $systemDrive -Names @('programming')
if (-not $programmingDir) {
    $programmingDir = Find-SubdirCI -Base $HOME -Names @('programming')
}
if ($programmingDir) {
    Report pass "found your programming folder: $programmingDir" @(
        "This is where you keep a subfolder for every course. It is a plain"
        "folder on your own computer, which is exactly what you want: no cloud"
        "service is going to move, lock or half-download your files."
    )
} else {
    Report fail "no programming folder found" @(
        "The tutorial has you create one folder that holds all your course"
        "folders. Create it with this command, then run this check again:"
        "    mkdir C:\programming"
    )
}

# 4. No Programming folder in a synced or otherwise unsuitable location
#
# Course work must not live in a folder that a cloud service syncs, or in
# Documents/Desktop/Downloads (which on many machines are synced without
# the student realising it).
$badBases = @(
    (Join-Path $HOME 'Documents')
    (Join-Path $HOME 'Desktop')
    (Join-Path $HOME 'Downloads')
)

# With OneDrive's Known Folder Move, $HOME\Documents is an empty decoy and
# the real Documents folder lives inside OneDrive. Ask Windows where it is.
try {
    $realDocs = [Environment]::GetFolderPath('MyDocuments')
    if ($realDocs) { $badBases += $realDocs }
} catch { }

# Cloud clients put their folder directly in the home directory. OneDrive
# for an organisation is named like "OneDrive - Universiteit van Amsterdam".
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
    Report pass "no course work in a synced folder" @(
        "Nothing was found in Documents, Desktop, Downloads, OneDrive or a"
        "similar folder. Keep it that way."
    )
} else {
    $detail = @(
        "Cloud services rewrite, lock and partially download files, which"
        "breaks virtual environments in ways that are hard to diagnose. Move"
        "the folder(s) below to C:\programming, then run this check again:"
    )
    foreach ($bad in $badDirs) { $detail += "    $bad" }
    Report fail "found course work in a folder you should not use" $detail
}

Write-Host ""
Write-Line
Write-Host ""
if ($failN -eq 0 -and $warnN -eq 0) {
    Write-Host "  $Ok" -NoNewline
    Write-Host "Everything checks out. You can continue with the tutorial.$Reset"
    Write-Host ""
    Write-Accent "  Next: go to your programming folder and create a folder for your course."
    Write-Host ""
    Write-Host "      $Gray" -NoNewline; Write-Host "cd $programmingDir$Reset"
    Write-Host "      $Gray" -NoNewline; Write-Host "mkdir my-course$Reset"
    Write-Host "      $Gray" -NoNewline; Write-Host "cd my-course$Reset"
} elseif ($failN -eq 0) {
    Write-Host "  $NotOk" -NoNewline
    Write-Host "Nothing is broken, but read the warning(s) above.$Reset"
} else {
    Write-Host "  $NotOk" -NoNewline
    Write-Host "$failN item(s) above need fixing. Fix them one at a time, then run this check again.$Reset"
}
Write-Host ""
