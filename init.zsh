# Return if requirements are not found
if (( ! $+commands[fabric-ai] )) && (( ! $+commands[fabric] )); then
  return 1
fi

# Determine which command is available
if (( $+commands[fabric-ai] )); then
  FABRIC_CMD="fabric-ai"
elif (( $+commands[fabric] )); then
  FABRIC_CMD="fabric"
fi

# Load custom completions
local completions_dir="${0:h}/completions"

if [[ -d "$completions_dir" ]]; then
  fpath=("$completions_dir" $fpath)
fi

# Define fabric-specific environment variables
export FABRIC_CONFIG_DIR="${FABRIC_CONFIG_DIR:-${HOME}/.config/fabric}"
export FABRIC_PATTERNS_DIR="${FABRIC_PATTERNS_DIR:-${FABRIC_CONFIG_DIR}/patterns}"
export FABRIC_CONTEXTS_DIR="${FABRIC_CONTEXTS_DIR:-${FABRIC_CONFIG_DIR}/contexts}"
export FABRIC_SESSIONS_DIR="${FABRIC_SESSIONS_DIR:-${FABRIC_CONFIG_DIR}/sessions}"

# Cache settings
export FABRIC_CACHE_DIR="${TMPDIR:-/tmp}/fabric-zsh-cache"
export FABRIC_CACHE_TTL="${FABRIC_CACHE_TTL:-3600}"  # 1 hour default
mkdir -p "$FABRIC_CACHE_DIR"

# Helper function to pipe content to fabric-ai
fab() {
  if [[ -p /dev/stdin ]]; then
    # If there's piped input, use it
    cat | $FABRIC_CMD "$@"
  else
    # Otherwise just run the command
    $FABRIC_CMD "$@"
  fi
}

# Quick pattern execution
fabp() {
  if [[ -z "$1" ]]; then
    echo "Usage: fabp <pattern> [options]"
    return 1
  fi
  local pattern="$1"
  shift
  fab --pattern "$pattern" "$@"
}

# Stream mode shortcut
fabs() {
  fab --stream "$@"
}

# YouTube transcript processing
faby() {
  if [[ -z "$1" ]]; then
    echo "Usage: faby <youtube-url> [pattern] [options]"
    return 1
  fi
  local url="$1"
  shift
  fab --youtube "$url" "$@"
}

# URL scraping shortcut
fabu() {
  if [[ -z "$1" ]]; then
    echo "Usage: fabu <url> [pattern] [options]"
    return 1
  fi
  local url="$1"
  shift
  fab --scrape_url "$url" "$@"
}

# Copy output to clipboard
fabc() {
  fab --copy "$@"
}

# List patterns with optional filtering
fabls() {
  if [[ -n "$1" ]]; then
    $FABRIC_CMD --listpatterns --shell-complete-list 2>/dev/null | grep -i "$1"
  else
    $FABRIC_CMD --listpatterns
  fi
}

# List models with optional filtering
fablm() {
  if [[ -n "$1" ]]; then
    $FABRIC_CMD --listmodels --shell-complete-list 2>/dev/null | grep -i "$1"
  else
    $FABRIC_CMD --listmodels
  fi
}

# List contexts
fablc() {
  if [[ -n "$1" ]]; then
    $FABRIC_CMD --listcontexts --shell-complete-list 2>/dev/null | grep -i "$1"
  else
    $FABRIC_CMD --listcontexts
  fi
}

# List sessions
fabls-session() {
  if [[ -n "$1" ]]; then
    $FABRIC_CMD --listsessions --shell-complete-list 2>/dev/null | grep -i "$1"
  else
    $FABRIC_CMD --listsessions
  fi
}

# Pattern preview/info
fabinfo() {
  if [[ -z "$1" ]]; then
    echo "Usage: fabinfo <pattern>"
    return 1
  fi
  local pattern_file="${FABRIC_PATTERNS_DIR}/$1/system.md"
  if [[ -f "$pattern_file" ]]; then
    if (( $+commands[bat] )); then
      bat "$pattern_file"
    elif (( $+commands[less] )); then
      less "$pattern_file"
    else
      cat "$pattern_file"
    fi
  else
    echo "Pattern '$1' not found in ${FABRIC_PATTERNS_DIR}"
    return 1
  fi
}

# Update patterns
fabupdate() {
  echo "Updating fabric patterns..."
  $FABRIC_CMD --updatepatterns
}

# Quick context switch
fabctx() {
  if [[ -z "$1" ]]; then
    echo "Available contexts:"
    $FABRIC_CMD --listcontexts
    return 0
  fi
  fab --context "$1" "${@:2}"
}

# Session management
fabsession() {
  if [[ -z "$1" ]]; then
    echo "Available sessions:"
    $FABRIC_CMD --listsessions
    return 0
  fi
  fab --session "$1" "${@:2}"
}

# Clear cache
fabclearcache() {
  echo "Clearing fabric-zsh cache..."
  rm -rf "$FABRIC_CACHE_DIR"/*
  echo "Cache cleared!"
}

# Interactive pattern selector (requires fzf)
fabfzf() {
  if (( ! $+commands[fzf] )); then
    echo "Error: fzf is required for interactive selection"
    return 1
  fi

  local pattern
  pattern=$($FABRIC_CMD --listpatterns --shell-complete-list 2>/dev/null | fzf --preview "bat ${FABRIC_PATTERNS_DIR}/{}/system.md 2>/dev/null || cat ${FABRIC_PATTERNS_DIR}/{}/system.md 2>/dev/null || echo 'No preview available'" --preview-window=right:60%:wrap)

  if [[ -n "$pattern" ]]; then
    fab --pattern "$pattern" "$@"
  fi
}

# Aliases for common operations
alias fabhelp='$FABRIC_CMD --help'
alias fabsetup='$FABRIC_CMD --setup'
alias fabversion='$FABRIC_CMD --version'

# Backward compatibility - if fabric-ai exists, alias fabric to it
if [[ "$FABRIC_CMD" == "fabric-ai" ]] && (( ! $+commands[fabric] )); then
  alias fabric='fabric-ai'
fi
