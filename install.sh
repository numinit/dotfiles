#!/bin/sh

SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
CWD="$(pwd)"

echo "[**] Performing prerequisite checks"
command -v git >/dev/null 2>&1 || { echo >&2 "[!!] Install git to continue."; exit 1; }
type git >/dev/null 2>&1 || { echo >&2 "[!!] Install git to continue."; exit 1; }
hash git >/dev/null 2>&1 || { echo >&2 "[!!] Install git to continue."; exit 1; }
GIT="$(which git)"
echo "[**] You have all prerequisites. Press ENTER to sync submodules."
read -t 30 || { echo >&2 "[!!] User abort."; exit 1; }

echo "[**] Initializing submodules"
$GIT reset --hard HEAD
$GIT submodule init
$GIT submodule update
cd .zprezto
$GIT submodule init
$GIT submodule update

cd "$DIR"
FILES=`git ls-tree --name-only HEAD | grep -ve '.git*' 2>/dev/null | grep -ve 'install.sh' 2>/dev/null`

echo "[**] About to perform the following commands:"
for i in $FILES; do
  SRC="$(realpath $i)"
  DEST=~/"$i"
  echo "[>>] rm -rf \"$SRC\""
  echo "[>>] ln -s \"$SRC\" \"$DEST\""
done
echo "[**] Press ENTER to continue or CTRL+C to abort."
read -t 30 || { echo >&2 "[!!] User abort."; exit 1; }

for i in $FILES; do
  SRC="$(realpath $i)"
  DEST=~/"$i"
  echo "[>>] $SRC => $DEST"
  rm -rf "$DEST" || { echo >&2 "[!!] Error removing $DEST"; exit 1; }
  ln -s "$SRC" "$DEST" || { echo >&2 "[!!] Error symlinking $SRC to $DEST"; exit 1; }
done
cd "$CWD"
echo "[**] Done, logout and login to activate the new settings"
exit 0
