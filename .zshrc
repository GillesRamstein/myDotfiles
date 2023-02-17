# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# ZSH_CUSTOM=/usr/share/oh-my-zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-autocomplete
)

# # Config AutoSuggestions: 
# bindkey '<tab>' complete-word # Tab=History
# bindkey '^[[Z' autosuggest-accept # Shift+Tab=Suggestions
# ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

# User configuration

# disable ctrl-d to exit
setopt IGNORE_EOF

# bash-like IGNORE_EOF for zsh
bash-ctrl-d() {
  if [[ $CURSOR == 0 && -z $BUFFER ]]
  then
    [[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit
    if [[ $HISTNO == $__histno ]]
    then
      (( --__BASH_IGNORE_EOF == 0 )) && exit
      echo "Use 'exit' to leave the shell. ($__BASH_IGNORE_EOF)"
    else
      __histno=$HISTNO
      __BASH_IGNORE_EOF=$IGNOREEOF
      echo "Use 'exit' to leave the shell. ($__BASH_IGNORE_EOF)"
    fi
    zle send-break
  else
    zle delete-char-or-list
  fi
}
zle -N bash-ctrl-d
bindkey '^D' bash-ctrl-d

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='helix'
  export VISUAL='helix'
else
  export EDITOR='helix'
  export VISUAL='helix'
fi

# aliases
alias zconf="helix $HOME/.zshrc"
alias tconf="helix $HOME/.tmux.conf"
alias nvconf="helix $HOME/.config/nvim/init.lua"
alias nv=nvim
alias hxconf="helix $HOME/.config/helix/config.toml"
alias hxlconf="helix $HOME/.config/helix/languages.toml"
alias hx=helix
alias tmux="tmux -u"
alias tm="tmux attach -t gilles || tmux new -s gilles"
alias dc="docker-compose"
alias lg="lazygit"
alias git="LANG=en_US git" # change git cli language to english
alias dots="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# alias ssh="kitty +kitten ssh"

pyfmt() {
 flake8 $1
 isort $1
 black $1
}

PATH=$PATH:~/.local/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]
then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]
then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# direnv
eval "$(direnv hook zsh)"

# nim package manager
export PATH=$PATH:~/.nimble/bin
