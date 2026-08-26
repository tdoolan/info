#!/usr/bin/env bash
# Proglab uv-installatiecontrole (macOS/Linux)
# Gebruik: curl -LsSf https://www.proglab.nl/welkom/install/uv/nl/check.sh | bash
set -u
shopt -s nullglob

# Zoek een submap van $1 waarvan de naam hoofdletterongevoelig overeenkomt
# met een van de overige argumenten. Print het gevonden pad en geeft 0 terug,
# of geeft 1 terug als er niets overeenkwam (ook als $1 niet bestaat).
find_subdir_ci() {
  local base="$1" entry name lower want
  shift
  [ -d "$base" ] || return 1
  for entry in "$base"/*/; do
    name="${entry%/}"
    name="${name##*/}"
    lower=$(printf '%s' "$name" | tr '[:upper:]' '[:lower:]')
    for want in "$@"; do
      if [ "$lower" = "$want" ]; then
        printf '%s\n' "${entry%/}"
        return 0
      fi
    done
  done
  return 1
}

if [ -t 1 ]; then
  RESET=$'\033[0m'
  ACCENT=$'\033[36m'
  OK=$'\033[32m'
  NOTOK=$'\033[37m'
  GRAY=$'\033[90m'
else
  RESET=""; ACCENT=""; OK=""; NOTOK=""; GRAY=""
fi

accent() { printf '%s%s%s\n' "$ACCENT" "$1" "$RESET"; }

line() { accent "$(printf -- '-%.0s' $(seq 1 44))"; }

pass_n=0; warn_n=0; fail_n=0

# report <pass|fail|warn> <kop> [detailregel]...
# Detailregels zijn extra zinnen onder de kop die uitleggen wat er
# gecontroleerd is en, indien nodig, wat je eraan kunt doen.
report() {
  local status="$1" headline="$2" tag color detail
  shift 2
  case "$status" in
    pass) tag="[x]"; color="$OK"; pass_n=$((pass_n+1)) ;;
    fail) tag="[ ]"; color="$NOTOK"; fail_n=$((fail_n+1)) ;;
    warn) tag="[!]"; color="$NOTOK"; warn_n=$((warn_n+1)) ;;
  esac
  printf '  %s%s%s %s\n' "$color" "$tag" "$RESET" "$headline"
  for detail in "$@"; do
    printf '      %s%s%s\n' "$GRAY" "$detail" "$RESET"
  done
}

echo
accent "  PROGLAB - JE INSTALLATIE CONTROLEREN"
line
echo

# 1. uv geïnstalleerd
if command -v uv >/dev/null 2>&1; then
  uv_version=$(uv --version 2>/dev/null | head -n1)
  report pass "uv is geïnstalleerd ($uv_version)" \
    "uv is het gereedschap waarmee dit vak Python installeert en de packages" \
    "voor elk vak beheert, in plaats van dat je dat met de hand doet."
else
  report fail "uv is niet gevonden" \
    "Dat betekent dat het installatiecommando uit \"Installeer uv nu\" niet is" \
    "afgerond, of dat je je terminal sindsdien niet hebt gesloten en opnieuw" \
    "geopend. Ga terug naar die stap, voer het installatiecommando opnieuw uit," \
    "sluit dit terminalvenster, open een nieuw venster en voer deze controle" \
    "nog een keer uit."
fi

# 2. uv run python >= 3.14
if command -v uv >/dev/null 2>&1; then
  tmpdir=$(mktemp -d)
  py_version=$(cd "$tmpdir" && uv run python -c "import sys; print('%d.%d.%d' % sys.version_info[:3])" 2>/dev/null)
  rm -rf "$tmpdir"
  if [ -n "$py_version" ]; then
    py_major=$(echo "$py_version" | cut -d. -f1)
    py_minor=$(echo "$py_version" | cut -d. -f2)
    if [ "$py_major" -gt 3 ] || { [ "$py_major" -eq 3 ] && [ "$py_minor" -ge 14 ]; }; then
      report pass "uv kan Python $py_version starten" \
        "Dat is een recente genoeg versie. Dit vak heeft minimaal Python 3.14 nodig."
    else
      report fail "uv startte Python $py_version, en dat is te oud" \
        "Dit vak heeft minimaal Python 3.14 nodig. Voer dit commando uit in je" \
        "terminal om een nieuwere versie te installeren en voer deze controle" \
        "daarna opnieuw uit:" \
        "    uv python install 3.14"
    fi
  else
    report fail "kon Python niet starten via uv" \
      "Voer dit commando uit in je terminal om Python te installeren en voer" \
      "deze controle daarna opnieuw uit:" \
      "    uv python install 3.14"
  fi
else
  report fail "overgeslagen: hiervoor is uv nodig, en dat is hierboven niet gevonden" \
    "Los eerst het probleem met uv hierboven op en voer deze controle daarna opnieuw uit."
fi

# 3. Programming-map bestaat in de thuismap
programming_dir=$(find_subdir_ci "$HOME" programming || true)
if [ -n "$programming_dir" ]; then
  report pass "je programmeermap is gevonden: ${programming_dir/#$HOME/~}" \
    "Hierin houd je een submap bij voor elk vak. Het is een gewone map op je" \
    "eigen computer, en dat is precies wat je wilt: geen clouddienst gaat je" \
    "bestanden verplaatsen, vergrendelen of half downloaden."
else
  report fail "geen Programming-map in je thuismap" \
    "In de tutorial maak je één map aan waarin al je vakmappen komen te staan." \
    "Maak hem aan met dit commando en voer deze controle daarna opnieuw uit:" \
    "    mkdir -p ~/Programming"
fi

# 4. Geen Programming-map op een gesynchroniseerde of anderszins ongeschikte plek
#
# Vakwerk mag niet staan in een map die door een clouddienst wordt
# gesynchroniseerd, of in Documents/Desktop/Downloads (die op veel computers
# gesynchroniseerd worden zonder dat de student dat doorheeft).
bad_dirs=()
for base in "$HOME/Documents" "$HOME/Desktop" "$HOME/Downloads" \
            "$HOME/Library/Mobile Documents/com~apple~CloudDocs"; do
  found=$(find_subdir_ci "$base" programming || true)
  [ -n "$found" ] && bad_dirs+=("$found")
done
# Cloudprogramma's zetten hun map direct in de thuismap. OneDrive voor een
# organisatie heet bijvoorbeeld "OneDrive - Universiteit van Amsterdam".
for entry in "$HOME"/*/; do
  name="${entry%/}"; name="${name##*/}"
  lower=$(printf '%s' "$name" | tr '[:upper:]' '[:lower:]')
  case "$lower" in
    onedrive|onedrive\ -\ *|dropbox|google\ drive|nextcloud|surfdrive|owncloud)
      found=$(find_subdir_ci "${entry%/}" programming || true)
      [ -n "$found" ] && bad_dirs+=("$found")
      ;;
  esac
done

if [ "${#bad_dirs[@]}" -eq 0 ]; then
  report pass "geen vakwerk in een gesynchroniseerde map" \
    "Er is niets gevonden in Documents, Desktop, Downloads, OneDrive, iCloud" \
    "Drive of een vergelijkbare map. Houd dat zo."
else
  details=(
    "Clouddiensten herschrijven, vergrendelen en downloaden bestanden"
    "gedeeltelijk, en dat maakt virtuele omgevingen kapot op een manier die"
    "moeilijk te achterhalen is. Verplaats de map(pen) hieronder naar"
    "~/Programming en voer deze controle daarna opnieuw uit:"
  )
  for bad in "${bad_dirs[@]}"; do
    details+=("    $bad")
  done
  report fail "vakwerk gevonden in een map die je niet moet gebruiken" "${details[@]}"
fi

echo
line
echo
if [ "$fail_n" -eq 0 ] && [ "$warn_n" -eq 0 ]; then
  printf '  %s%s%s\n' "$OK" "Alles is in orde. Je kunt verder met de tutorial." "$RESET"
  echo
  printf '  %s%s%s\n' "$ACCENT" "Hierna: ga naar je programmeermap en maak een map voor je vak." "$RESET"
  echo
  printf '      %s%s%s\n' "$GRAY" "cd ${programming_dir/#$HOME/~}" "$RESET"
  printf '      %s%s%s\n' "$GRAY" "mkdir mijn-vak" "$RESET"
  printf '      %s%s%s\n' "$GRAY" "cd mijn-vak" "$RESET"
elif [ "$fail_n" -eq 0 ]; then
  printf '  %s%s%s\n' "$NOTOK" "Er is niets kapot, maar lees de waarschuwing(en) hierboven." "$RESET"
else
  printf '  %s%s punt(en) hierboven moeten worden opgelost. Los ze een voor een op en voer deze controle daarna opnieuw uit.%s\n' "$NOTOK" "$fail_n" "$RESET"
fi
echo
