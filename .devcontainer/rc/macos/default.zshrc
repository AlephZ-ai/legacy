# shellcheck shell=bash
# shellcheck source=/dev/null
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# oh-my-zsh settings
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source "$(brew --prefix)/share/antigen/antigen.zsh"

# update
antigen update

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
# antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme powerlevel10k/powerlevel10k
antigen theme robbyrussell

# User configuration
# Local
export LC_ALL="C"
export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Example aliases
alias zshrc="code ~/.zshrc"
alias bashrc="code ~/.bashconfig"
alias ohmyzsh="code ~/.oh-my-zsh"
# Custom
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Tell Antigen that you're done.
antigen apply
