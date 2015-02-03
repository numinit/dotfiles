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
read -t 10 || { echo >&2 "[!!] User abort."; exit 1; }

echo "[**] Initializing submodules"
$GIT submodule init
$GIT submodule update
cd .zprezto
$GIT submodule init
$GIT submodule update

FILES=`git ls-tree --name-only HEAD | grep -ve '.git*' 2>/dev/null | grep -ve 'install.sh' 2>/dev/null`

echo "[**] About to remove and reinstall the following files:"
for i in $FILES; do
  echo ">> "~/"$i"
done
echo "[**] Press ENTER to continue or CTRL+C to abort."
read -t 10 || { echo >&2 "[!!] User abort."; exit 1; }

cd "$DIR"
for i in $FILES do
  echo "[>>] symlink $i -> "~/"$i"
  rm -rf ~/"$i" || { echo >&2 "Error removing "~/"%$i"; exit 1; }
  ln -s "$(realpath $i)" ~/"$i" || { echo >&2 "Error symlinking $(realpath $i) to "~/"$i"; exit 1; }
done
cd "$CWD"
echo "[**] Done, logout and login"
exit 0
