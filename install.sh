#!/bin/sh

SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
CWD="$(pwd)"

prereq () {
  command -v "$1" >/dev/null 2>&1 || { echo >&2 "[!!] Install $1 to continue."; exit 1; }
  type "$1" >/dev/null 2>&1 || { echo >&2 "[!!] Install $1 to continue."; exit 1; }
  hash "$1" >/dev/null 2>&1 || { echo >&2 "[!!] Install $1 to continue."; exit 1; }
  echo `which "$1"`
}

# Get prereqs
echo "[**] Performing prerequisite checks"
GIT="$(prereq git)"
GREP="$(prereq grep)"
REALPATH="$(prereq realpath)"
RM="$(prereq rm)"
LN="$(prereq ln)"

echo "[**] You have all prerequisites. Press ENTER to continue."
echo "[>>] git=$GIT, grep=$GREP, realpath=$REALPATH, rm=$RM, ln=$LN"
read -t 30 || { echo >&2 "[!!] User abort."; exit 1; }

# Grab submodules
if [ -z "$NO_SUBMODULES" ]; then
  echo "[**] Initializing submodules"
  $GIT submodule update --init --recursive
  $GIT submodule foreach --recursive $GIT fetch
  $GIT submodule foreach $GIT pull --ff-only origin master
fi

# Find install files
cd "$DIR"
FILES=`$GIT ls-tree --name-only HEAD | $GREP -e '^\.' 2>/dev/null | $GREP -ve '.git*'`

# Let the user know which commands we're running
echo "[**] About to perform the following commands:"
for i in $FILES; do
  SRC="$(realpath $i)"
  DEST=~/"$i"
  echo "[>>] $RM -rf \"$DEST\""
  echo "[>>] $LN -s \"$SRC\" \"$DEST\""
done
echo "[**] Press ENTER to continue or CTRL+C to abort."
read -t 30 || { echo >&2 "[!!] User abort."; exit 1; }

# Do it
for i in $FILES; do
  SRC="$($REALPATH $i)"
  DEST=~/"$i"
  echo "[>>] $SRC => $DEST"
  $RM -rf "$DEST" || { echo >&2 "[!!] Error removing $DEST"; exit 1; }
  $LN -s "$SRC" "$DEST" || { echo >&2 "[!!] Error symlinking $SRC to $DEST"; exit 1; }
done
cd "$CWD"

# All done
echo "[**] Done, logout and login to activate the new settings"
exit 0
