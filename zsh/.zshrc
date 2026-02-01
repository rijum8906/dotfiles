# --- Zinit Bootstrapping ---
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    print -P "%F{33}Installing Zinit...%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# --- Proper Plugin Selection (The Essentials) ---

# 1. Syntax Highlighting & Autosuggestions (Loaded with Turbo Mode)
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]='-i; prio'" \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    blockf zsh-users/zsh-completions

# 2. Key Bindings & Utility
zinit ice wait lucid
zinit load jeffreytse/zsh-vi-mode

# 3. Proper Git support (Oh My Zsh library snippets are often "proper" enough)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git

# --- Theme & Environment ---

# Powerlevel10k (Load once, properly)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Your custom configs
source "$HOME/.config/zsh/init.zsh"
