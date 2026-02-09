# ---- PATH ----
export PATH=$PATH:/home/rijum/.local/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(zoxide init zsh)"


# ------ Sources --------
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/zinit.zsh"
source "$HOME/.config/zsh/yazi.zsh"
source "$HOME/.config/zsh/sway.zsh"

# History
# ---- History Configuration ----
HISTFILE=~/.zsh_history     # The file where history is saved
HISTSIZE=10000              # How many lines to keep in active memory
SAVEHIST=10000              # How many lines to save in the file
setopt APPEND_HISTORY       # Append to the file rather than overwriting
