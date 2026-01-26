# ---- PATH ----
export PATH=$PATH:/home/rijum/.local/bin

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/base.json)"
eval "$(zoxide init zsh)"


# ------ Sources --------
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/zinit.zsh"
source "$HOME/.config/zsh/yazi.zsh"

