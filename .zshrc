# Path to your oh-my-zsh installation.
export TERM="xterm-256color"

export ZSH=/home/omri/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="gallois"
#ZSH_THEME="muse"
#ZSH_THEME="mikolaj"
#ZSH_THEME="avit"
ZSH_THEME="crunch"
#ZSH_THEME="powerline"
#ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Configuring zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY="match_prev_cmd"
bindkey '^ ' autosuggest-accept

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux autopep8 common-aliases vi-mode jump github gitignore rand-quote virtualenvwrapper tmuxinator pipenv zsh-autosuggestions git-flow-completion aws)

# User configuration

  export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
  #export PATH="~/Dropbox/scripts:~/Downloads/hdf-java-2.10/usr/bin:$PATH"
  #export PATH="$HOME/bin:$PATH"
  #export PATH="$HOME/.local/bin:$PATH"
  #export PATH="$HOME/Dropbox/scripts:$PATH"
  #export PATH="$HOME/pandoc-crossref/.cabal-sandbox/bin:$PATH"
  export PATH="$PATH:$HOME/anaconda3/bin"
  export PATH="$PATH:$HOME/.local/bin"
  export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
  export PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Tell python to load stuff in this script on startup
#export PYTHONSTARTUP=~/.pythonrc
#export PYTHONPATH=$HOME/repos/public_repos/:$PYTHONPATH

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias i3config="(cd ~/.config/i3 && vim config)"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias wg="wget -O tempfile www.google.com && rm tempfile"
alias rm="rm"  # override rm -i requiring confirmation
alias pg="ps aux | grep -v grep | grep "
alias jn="jupyter notebook"
alias ap="~/anaconda3/bin/python"
alias apip="~/anaconda3/bin/pip"
alias mux="tmuxinator"
alias prp="pipenv run python"
alias pi="pipenv install"
alias pipython="pipenv run ipython"
alias mongokill="kill $(pg mongo | grep 'MongoDB Compass' | head -1 | awk '{print $2}')"

# Allow using Ctrl+S in vim in the terminal without freezing it
alias vim="stty -ixon -ixoff && vim"

# Simple dotfile management, a la:
#https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias conf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

apnotify() {
  ~/anaconda3/bin/python $1
  notify-send "Execution finished!"  "$1 finished running."
}

thesis() {
  jump thesis
  gvim 01-introduction.tex
  clear
}

export TERM="xterm-256color"
export TERMINAL="termite"

# For completions to work well for pandocmk
fpath=(~/.zsh/completion $fpath)

editmd() {
  gvim $@
  pandocmk $@
}

_editmd() {
  _path_files -g "*.md"
}

compdef _editmd editmd
compdef _editmd pandocmk

export PATH="$HOME/.yarn/bin:$PATH"

# Stuff for virtualenvwrapper to work
export WORKON_DIR=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/repos/projects
source /usr/bin/virtualenvwrapper.sh
source ~/.gem/ruby/2.4.0/gems/tmuxinator-0.10.1/completion/tmuxinator.zsh

# Add support for direnv
#eval "$(direnv hook zsh)"

#eval "$(_TMUXP_COMPLETE=source tmuxp)"
export VIRTUAL_ENV_DISABLE_PROMPT=
export PIPENV_MAX_DEPTH=5
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH:$HOME/opt/splunk/bin"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/omri/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/omri/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/omri/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /home/omri/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh
