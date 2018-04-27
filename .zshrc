# Path to your zsh config directory
export ZSH=~/.zsh
export ZSH_CACHE_DIR="$ZSH/cache"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Load all of the config files in ~/.zsh/lib that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Extend Autocomplete Search Path
fpath=($HOME/.zsh/lib/completions $fpath)

# Use modern completion system
autoload -Uz compinit
compinit
