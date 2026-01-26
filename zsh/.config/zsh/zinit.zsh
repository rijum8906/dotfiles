
# ---- completions ----
autoload -Uz compinit
compinit

zinit light zsh-users/zsh-completions

# ---- usability ----
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

# keybindings for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ---- visuals (MUST be last) ----
zinit light zsh-users/zsh-syntax-highlighting

