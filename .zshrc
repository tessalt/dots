# Path to your oh-my-zsh installation.
export ZSH=/Users/tessathornton/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tessa"
DEFAULT_USER="tessathornton"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

function _chbrochure_resolve() {
  host $1 | grep 'has address' | awk '{ print $4 }'
}

function _chbrochure_host() {
  case $1 in
  app4)
    echo 'brochure-app4.ec2.shopify.com'
    ;;
  production)
    echo 'origin.www.shopify.com'
    ;;
  staging)
    echo 'brochure-app1.staging.ec2.shopify.com'
    ;;
  *)
    echo $1
    ;;
  esac
}

function _chbrochure_set() {
  local _temphosts=`mktemp -t chbrochure.hosts`

  cat /etc/hosts | sed -e "/brochure2-hosts-start/,/brochure2-hosts-end/d" >$_temphosts

  if [ "$1" != "production" ]
  then
    local _host=`_chbrochure_host $1`
    local _ip=`_chbrochure_resolve $_host | head -n1`

    shift

    echo "## brochure2-hosts-start" >>$_temphosts

    for host in es.shopify.com fr.shopify.ca fr.shopify.com pt.shopify.com ru.shopify.com wholesale.shopify.com www.shopify.ca www.shopify.co.id www.shopify.co.ng www.shopify.com
    do
    echo "$_ip $host" >>$_temphosts
    done

    echo "## brochure2-hosts-end" >>$_temphosts
  fi

  sudo cp $_temphosts /etc/hosts
  rm -f $_temphosts
}

function _chbrochure_which() {
  local _ip=`_chbrochure_resolve www.shopify.com | head -n1`

  for _env in app4 production staging
  do
    _chbrochure_resolve `_chbrochure_host $_env` | grep -q $_ip
    echo "`echo $? | tr '01' '* '` $_env"
  done
}

function chbrochure() {
  if [ $# -eq 0 ]
  then
    _chbrochure_which
  else
    _chbrochure_set $*
  fi
}

 # git commands
alias co='git checkout'
alias gs='git status'
alias gd='git diff'
alias gmt='git mergetool'
alias grc='git rebase --continue'
alias pull='git pull origin $(current_branch)'
alias push='git push origin $(current_branch)'
alias fpush='git push origin +$(current_branch)'
alias pbranch='echo "$(current_branch)" | pbcopy'

# misc
alias be='bundle exec'
alias sourceme='source ~/.zshrc'

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
