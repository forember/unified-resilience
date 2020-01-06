#!/bin/sh
askcommit () {
  read -p 'Commit and push these changes? [Y/n]' confirm
  case "$confirm" in
    y|Y|'')
      printf 'Committing and pushing.\n'
      ;;
    n|N)
      printf 'Done.\n'
      exit 0
      ;;
    *)
      printf 'Invalid response (valid: y or n). Done.\n'
      exit 1
      ;;
  esac
}
if [ "$#" = 0 ]
then
  printf 'Usage: %s <message> [options...]\n\n' "$0"
  printf '  Commit both the submodule and the root project.\n'
  exit 2
fi
message="$1"
shift 1
set -e
set -x
git add -A
git status
askcommit
git commit --message "$message" "$@"
git push
superproject="$(git rev-parse --show-superproject-working-tree)"
if ! [ "$superproject" ]
then
  printf 'The current repo has no superproject to commit. Done.\n'
  exit 0
fi
submodule="$(basename "$(git rev-parse --show-toplevel)")"
cd "$superproject"
git add -A
git status
askcommit
git commit --message "$submodule: $message" "$@"
git push
printf 'Done.\n'
