# Return if requirements are not found
if (( ! $+commands[fabric] )); then
  return 1
fi

# Load custom completions
local completions_dir="${0:h}/completions"

if [[ -d "$completions_dir" ]]; then
  fpath=("$completions_dir" $fpath)
fi

# Define any fabric-specific environment variables or settings here
# For example:
# export FABRIC_CONFIG_DIR="${HOME}/.config/fabric"

# Load any fabric-specific aliases or functions
# For example:
alias fab='fabric'
alias faby='fabric -y'

