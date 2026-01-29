# ---- Zinit Setup ----
# Load zinit if you haven't already (assuming it's installed)
# source "$HOME/.local/share/zinit/zinit.zsh"

# ---- Plugins: Functionality ----
zinit light zsh-users/zsh-completions
zinit light hlissner/zsh-autopair
# zinit light z-shell/zsh-z              # "z" for jumping to frequent directories

# ---- Plugins: History & Search ----
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

# FZF: Interactive Fuzzy Finding (History, Files, Processes)
# This loads the fzf binary and the zsh integration
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# ---- Plugins: Visuals (Must be last) ----
zinit light zdharma-continuum/fast-syntax-highlighting

# ---- Config & Completion ----
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit && compinit

# ---- Keybindings ----
# History Substring Search (Arrows)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# FZF Keybindings (If fzf is installed on system via brew/apt/zinit)
# CTRL-R: Search command history
# CTRL-T: Search files in current folder
# ALT-C:  cd into subdirectories
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---- Options ----
setopt HIST_IGNORE_ALL_DUPS  # Clean up history
setopt HIST_REDUCE_BLANKS    # Remove wasted space
setopt SHARE_HISTORY         # Share history across all terminals


export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
