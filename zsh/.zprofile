echo "Loading ~/.zprofile"

echo "\tLoading homebrew..."
eval "$(/opt/homebrew/bin/brew shellenv)"

# tools installed with `go install` (e.g. gopls) land in $(go env GOPATH)/bin
echo "\tAdding go bins to \$PATH..."
export PATH="$PATH:$HOME/go/bin"

echo "Done loading ~/.zprofile"
