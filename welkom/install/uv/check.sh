#!/usr/bin/env bash
# Proglab uv install check (macOS/Linux)
# Usage: curl -LsSf https://www.proglab.nl/welkom/install/uv/check.sh | bash
set -u
shopt -s nullglob

# Look for a subfolder of $1 whose name case-insensitively matches one of
# the remaining arguments. Prints the matching path and returns 0, or
# returns 1 if nothing matched (including when $1 does not exist).
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

# report <pass|fail|warn> <headline> [detail line]...
# Detail lines are extra sentences printed under the headline to explain
# what was checked and, if needed, what to do about it.
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
accent "  PROGLAB - CHECKING YOUR SETUP"
line
echo

# 1. uv installed
if command -v uv >/dev/null 2>&1; then
  uv_version=$(uv --version 2>/dev/null | head -n1)
  report pass "uv is installed ($uv_version)" \
    "uv is the tool this course uses to install Python and manage the" \
    "packages for each course, instead of doing that by hand."
else
  report fail "uv was not found" \
    "This means the install command from \"Install uv now\" did not finish," \
    "or you have not closed and reopened your terminal since running it." \
    "Go back to that step, run the install command again, then close this" \
    "terminal window, open a new one, and run this check again."
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
      report pass "uv can start Python $py_version" \
        "That is a recent enough version. This course needs at least Python 3.14."
    else
      report fail "uv started Python $py_version, which is too old" \
        "This course needs at least Python 3.14. Run this command in your" \
        "terminal to install a newer version, then run this check again:" \
        "    uv python install 3.14"
    fi
  else
    report fail "could not start Python through uv" \
      "Run this command in your terminal to install Python, then run this" \
      "check again:" \
      "    uv python install 3.14"
  fi
else
  report fail "skipped: this check needs uv, which was not found above" \
    "Fix the uv problem above first, then run this check again."
fi

# 3. Programming folder exists in the home directory
programming_dir=$(find_subdir_ci "$HOME" programming || true)
if [ -n "$programming_dir" ]; then
  report pass "found your programming folder: ${programming_dir/#$HOME/~}" \
    "This is where you keep a subfolder for every course. It is a plain" \
    "folder on your own computer, which is exactly what you want: no cloud" \
    "service is going to move, lock or half-download your files."
else
  report fail "no Programming folder in your home directory" \
    "The tutorial has you create one folder that holds all your course" \
    "folders. Create it with this command, then run this check again:" \
    "    mkdir -p ~/Programming"
fi

# 4. No Programming folder in a synced or otherwise unsuitable location
#
# Course work must not live in a folder that a cloud service syncs, or in
# Documents/Desktop/Downloads (which on many machines are synced without
# the student realising it).
bad_dirs=()
for base in "$HOME/Documents" "$HOME/Desktop" "$HOME/Downloads" \
            "$HOME/Library/Mobile Documents/com~apple~CloudDocs"; do
  found=$(find_subdir_ci "$base" programming || true)
  [ -n "$found" ] && bad_dirs+=("$found")
done
# Cloud clients put their folder directly in the home directory. OneDrive
# for an organisation is named like "OneDrive - Universiteit van Amsterdam".
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
  report pass "no course work in a synced folder" \
    "Nothing was found in Documents, Desktop, Downloads, OneDrive, iCloud" \
    "Drive or a similar folder. Keep it that way."
else
  details=(
    "Cloud services rewrite, lock and partially download files, which"
    "breaks virtual environments in ways that are hard to diagnose. Move"
    "the folder(s) below to ~/Programming, then run this check again:"
  )
  for bad in "${bad_dirs[@]}"; do
    details+=("    $bad")
  done
  report fail "found course work in a folder you should not use" "${details[@]}"
fi

echo
line
echo
if [ "$fail_n" -eq 0 ] && [ "$warn_n" -eq 0 ]; then
  printf '  %s%s%s\n' "$OK" "Everything checks out. You can continue with the tutorial." "$RESET"
  echo
  printf '  %s%s%s\n' "$ACCENT" "Next: go to your programming folder and create a folder for your course." "$RESET"
  echo
  printf '      %s%s%s\n' "$GRAY" "cd ${programming_dir/#$HOME/~}" "$RESET"
  printf '      %s%s%s\n' "$GRAY" "mkdir my-course" "$RESET"
  printf '      %s%s%s\n' "$GRAY" "cd my-course" "$RESET"
elif [ "$fail_n" -eq 0 ]; then
  printf '  %s%s%s\n' "$NOTOK" "Nothing is broken, but read the warning(s) above." "$RESET"
else
  printf '  %s%s item(s) above need fixing. Fix them one at a time, then run this check again.%s\n' "$NOTOK" "$fail_n" "$RESET"
fi
echo
