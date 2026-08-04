#!/usr/bin/env bash
#
# Preview the site locally at http://localhost:4000
# Rebuilds automatically whenever you save a file.
#
#   ./preview.sh
#
set -euo pipefail
cd "$(dirname "$0")"

# macOS system Ruby is too old for Jekyll 4; prefer the Homebrew one.
if [ -x /opt/homebrew/opt/ruby/bin/ruby ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
elif [ -x /usr/local/opt/ruby/bin/ruby ]; then
  export PATH="/usr/local/opt/ruby/bin:$PATH"
fi

if ! command -v bundle >/dev/null 2>&1; then
  echo "Bundler not found. Install Ruby first:  brew install ruby" >&2
  exit 1
fi

export BUNDLE_GEMFILE="$PWD/Gemfile.dev"

if ! bundle check >/dev/null 2>&1; then
  echo "Installing preview dependencies (first run only)..."
  bundle install
fi

exec bundle exec jekyll serve --livereload "$@"
