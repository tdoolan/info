# Proglab uv/Nextcloud install check (Windows)
# Usage: irm https://www.proglab.nl/welkom/install/uv/check.ps1 | iex

$Esc = [char]27
$Reset = "$Esc[0m"
$Accent = "$Esc[36m"
$Ok = "$Esc[32m"; $NotOk = "$Esc[37m"; $Gray = "$Esc[90m"

# Look for a subfolder of $Base whose name case-insensitively matches one
# of the given names. Returns the full path of the first match, or $null.
function Find-SubdirCI([string]$Base, [string[]]$Names) {
    Get-ChildItem -Path $Base -Directory -ErrorAction SilentlyContinue |
        Where-Object { $Names -contains $_.Name.ToLower() } |
        Select-Object -First 1 -ExpandProperty FullName
}

# Most students have a folder named "Nextcloud" in their home directory, but
# some set their account up a while ago and still have it named "Surfdrive"
# or "ownCloud" (older names for the same kind of folder).
function Find-CloudDir {
    Find-SubdirCI -Base $HOME -Names @('nextcloud', 'surfdrive', 'owncloud')
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

# 3. Cloud-sync folder exists (Nextcloud, or an older Surfdrive/ownCloud setup)
$cloudDir = Find-CloudDir
if ($cloudDir) {
    $cloudName = Split-Path $cloudDir -Leaf
    Report pass "found your $cloudName folder" @(
        "This is the folder that gets backed up to the cloud automatically. Save"
        "your course work somewhere inside it, for example in $cloudName\Programming."
    )
} else {
    Report fail "no Nextcloud (or Surfdrive/ownCloud) folder in your home directory" @(
        "This usually means Nextcloud has not been installed yet, or you have"
        "not logged in with your UvA account. Go back to the 'Installing"
        "Nextcloud' step and finish it, then run this check again."
    )
}

# 4. .venv excluded from syncing
if ($cloudDir) {
    $excludeFile = Join-Path $cloudDir ".sync-exclude.lst"
    $venvExcluded = (Test-Path $excludeFile -PathType Leaf) -and (Select-String -Path $excludeFile -Pattern '\.venv' -Quiet)
    if ($venvExcluded) {
        Report pass ".venv is excluded from syncing" @(
            "Good. The .venv folder holds every package installed for a course. It"
            "is large, and uv can always recreate it, so it does not need to be"
            "backed up."
        )
    } else {
        Report warn "$cloudName is probably still trying to sync .venv folders" @(
            "The .venv folder holds every package installed for a course. It is"
            "large, and uv can always recreate it, so it does not need to be backed"
            "up. Go back to the 'Add .venv' step in the tutorial and add .venv to"
            "the ignored files, then run this check again."
        )
    }
} else {
    Report warn "skipped: could not check the .venv exclusion" @(
        "This is because no Nextcloud (or Surfdrive/ownCloud) folder was found"
        "above. Fix that first, then run this check again."
    )
}

# 5. Programming folder exists inside the cloud folder
if ($cloudDir) {
    $programmingDir = Find-SubdirCI -Base $cloudDir -Names @('programming')
    if ($programmingDir) {
        $programmingName = Split-Path $programmingDir -Leaf
        Report pass "found a $programmingName folder inside $cloudName" @(
            "This is where the tutorial has you keep a subfolder for every course."
        )
    } else {
        Report warn "no Programming folder inside $cloudName yet" @(
            "The tutorial has you create one to keep all your course folders"
            "together. Create it with this command, then run this check again:"
            "    mkdir `$HOME\$cloudName\Programming"
        )
    }
} else {
    Report warn "skipped: could not check for a Programming folder" @(
        "This is because no Nextcloud (or Surfdrive/ownCloud) folder was found"
        "above. Fix that first, then run this check again."
    )
}

Write-Host ""
Write-Line
Write-Host ""
if ($failN -eq 0 -and $warnN -eq 0) {
    Write-Host "  $Ok" -NoNewline
    Write-Host "Everything checks out. You can continue with the tutorial.$Reset"
} elseif ($failN -eq 0) {
    Write-Host "  $NotOk" -NoNewline
    Write-Host "Nothing is broken, but read the warning(s) above.$Reset"
} else {
    Write-Host "  $NotOk" -NoNewline
    Write-Host "$failN item(s) above need fixing. Fix them one at a time, then run this check again.$Reset"
}
Write-Host ""
