# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# install zinit
if [ ! -d $ZINIT_HOME ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice depth=1 wait lucid; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth=1 wait lucid; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1 wait lucid; zinit light Aloxaf/fzf-tab

# snippets
zinit ice wait lucid; zinit snippet OMZP::colored-man-pages
zinit ice wait lucid; zinit snippet OMZP::sudo

# load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# env variables
EDITOR="nvim"
VISUAL="nvim"
PAGER="less -R"

# aliases
alias eza="eza --icons --group-directories-first --color=always -a"
alias ls="eza -1"
alias la="eza -l --git"
alias lt="eza -T"

alias grep="grep --color"
alias rg="rg --colors match:fg:yellow --colors line:fg:magenta --colors path:fg:red"

alias df="duf --sort type"

alias khalendar="vdirsyncer sync && khal calendar"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias -g -- -h="-h 2>&1 | bat --language=help --style=plain --paging=never"
alias -g -- --help="--help 2>&1 | bat --language=help --style=plain --paging=never"

setopt autocd
alias -g "..."="../.."
alias -g "...."="../../.."
alias -g "....."="../../../.."
alias -g "......"="../../../../.."

# keybindings
bindkey -e
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'eza --icons --group-directories-first --color=always -a -T $realpath'
zstyle ":fzf-tab:complete:nvim:*" fzf-preview 'bat --color=always $realpath 2> /dev/null || eza --icons --group-directories-first --color=always -a -T $realpath'

# fzf
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}'"
export FZF_CTRL_R_OPTS="--reverse"

# integrations
eval "$(fzf --zsh)"
function yazi() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
