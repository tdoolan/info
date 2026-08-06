#!/usr/bin/env bash
# Proglab uv/Nextcloud install check (macOS/Linux)
# Usage: curl -LsSf https://www.proglab.nl/welkom/install/uv/check.sh | bash
set -u
shopt -s nullglob

# Look for a subfolder of $1 whose name case-insensitively matches one of
# the remaining arguments. Prints the matching path and returns 0, or
# returns 1 if nothing matched.
find_subdir_ci() {
  local base="$1" entry name lower want
  shift
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

# Most students have a folder named "Nextcloud" in their home directory, but
# some set their account up a while ago and still have it named "Surfdrive"
# or "ownCloud" (older names for the same kind of folder).
find_cloud_dir() { find_subdir_ci "$HOME" nextcloud surfdrive owncloud; }

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

# 3. Cloud-sync folder exists (Nextcloud, or an older Surfdrive/ownCloud setup)
cloud_dir=$(find_cloud_dir || true)
if [ -n "$cloud_dir" ]; then
  cloud_name="${cloud_dir##*/}"
  report pass "found your $cloud_name folder" \
    "This is the folder that gets backed up to the cloud automatically. Save" \
    "your course work somewhere inside it, for example in $cloud_name/Programming."
else
  report fail "no Nextcloud (or Surfdrive/ownCloud) folder in your home directory" \
    "This usually means Nextcloud has not been installed yet, or you have" \
    "not logged in with your UvA account. Go back to the \"Installing" \
    "Nextcloud\" step and finish it, then run this check again."
fi

# 4. .venv excluded from syncing
if [ -n "$cloud_dir" ]; then
  exclude_file="$cloud_dir/.sync-exclude.lst"
  if [ -f "$exclude_file" ] && grep -q '\.venv' "$exclude_file" 2>/dev/null; then
    report pass ".venv is excluded from syncing" \
      "Good. The .venv folder holds every package installed for a course. It" \
      "is large, and uv can always recreate it, so it does not need to be" \
      "backed up."
  else
    report warn "$cloud_name is probably still trying to sync .venv folders" \
      "The .venv folder holds every package installed for a course. It is" \
      "large, and uv can always recreate it, so it does not need to be backed" \
      "up. Go back to the \"Add .venv\" step in the tutorial and add .venv to" \
      "the ignored files, then run this check again."
  fi
else
  report warn "skipped: could not check the .venv exclusion" \
    "This is because no Nextcloud (or Surfdrive/ownCloud) folder was found" \
    "above. Fix that first, then run this check again."
fi

# 5. Programming folder exists inside the cloud folder
if [ -n "$cloud_dir" ]; then
  programming_dir=$(find_subdir_ci "$cloud_dir" programming || true)
  if [ -n "$programming_dir" ]; then
    programming_name="${programming_dir##*/}"
    report pass "found a $programming_name folder inside $cloud_name" \
      "This is where the tutorial has you keep a subfolder for every course."
  else
    report warn "no Programming folder inside $cloud_name yet" \
      "The tutorial has you create one to keep all your course folders" \
      "together. Create it with this command, then run this check again:" \
      "    mkdir -p ~/$cloud_name/Programming"
  fi
else
  report warn "skipped: could not check for a Programming folder" \
    "This is because no Nextcloud (or Surfdrive/ownCloud) folder was found" \
    "above. Fix that first, then run this check again."
fi

echo
line
echo
if [ "$fail_n" -eq 0 ] && [ "$warn_n" -eq 0 ]; then
  printf '  %s%s%s\n' "$OK" "Everything checks out. You can continue with the tutorial." "$RESET"
elif [ "$fail_n" -eq 0 ]; then
  printf '  %s%s%s\n' "$NOTOK" "Nothing is broken, but read the warning(s) above." "$RESET"
else
  printf '  %s%s item(s) above need fixing. Fix them one at a time, then run this check again.%s\n' "$NOTOK" "$fail_n" "$RESET"
fi
echo
