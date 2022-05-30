# Prompt and prompt colors
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  # export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[33m\]$(__git_ps1)\[\033[00m\]>'
  # export PS1="\n$BLACKBOLD[\t]$GREENBOLD \u@\h\[\033[00m\]:$BLUEBOLD\w\[\033[00m\] \\$ "
  # export PS1="$BLACKBOLD[\t]$GREEN\u@\h\[\033[00m\]:$BLUEBOLD\w$(__git_ps1 " (%s)")]\> "
  # PS1="\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\]\$ "
  unamestr=`uname`
  if [[ "$unamestr" == 'Darwin' ]]; then
    #PS1="\[$BLACKBOLD\][\t]\[$GREEN\]\u@\h:\[$PURPLE\]\w\[\033[m\]\[$YELLOW\]\$(__git_ps1)\[$BLUE\]\n>\[\033[m\] "
    PS1="$BLACKBOLD[\d-\t]$GREEN\u@\h:\[$PURPLE\]\w\[\033[m\]$YELLOW\$(__git_ps1)$BLUE\n>\[\033[m\] "
  else
    PS1="\[$BLACKBOLD\][\d-\t]\[$RED\]\u@\h:\[$PURPLE\]\w\[\033[m\]\[$YELLOW\]\$(__git_ps1)\[$BLUE\]\n>\[\033[m\] "
    #PS1="$BLACKBOLD[\t]$RED\u@\h:\[$PURPLE\]\w\[\033[m\]$YELLOW\$(__git_ps1)$BLUE\n>\[\033[m\] "
  fi

}
prompt
# Modify command line to show working directory and git branch
GIT_PS1_SHOWDIRTYSTATE=true

export CLICOLOR=1
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  LS_COLORS="ow=01;90:di=01;90"
  export LS_COLORS
else
  export LSCOLORS=ExFxCxDxBxegedabagacad
fi

export PROMPT_COMMAND=`history -a; history -r`
if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

export HISTFILESIZE= HISTSIZE= #HISTFILE=~/.bash4_history

# Erase duplicates in bash history
HISTCONTROL=ignoredups:ignorespace

# Resize console as window resizes
shopt -s checkwinsize

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# export aliases
source ~/.alias

###########################################################################################
## Development environment

# Set git autocompletion
# Git and bash-completion: brew install git bash-completion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi
# http://code-worrier.com/blog/autocomplete-git/
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# ssh hostname autocompletion
complete -W "$(echo $(cat ~/.ssh/known_hosts | \
    cut -f 1 -d ' ' | sed -e s/,.*//g | \
    sort -u | grep -v "\["))" ssh

# ssh key forwarding
ssh-add

# MYSQL
# brew install mysql
# mysql_install_db --basedir=/usr/local/Cellar/mysql/5.6.22
# mysql.server start/stop
# mysql_install_db
# mysql_secure_installation
#
# After dmg installation
# export PATH=~/bin:/usr/local/bin:/usr/local/mysql/bin:$PATH
# export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# rbenv
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Python  'brew install python'
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages"

# brew install scala
# brew install sbt
SCALA_HOME=/usr/local/opt/scala/idea

export PATH="$PATH:$HOME/bin"

# added for bazel
export ARCHFLAGS="-arch x86_64"
export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/libffi/lib -L/usr/local/opt/mysql@5.7/lib ${LDFLAGS}"
export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/libffi/include -I/usr/local/opt/mysql@5.7/include ${CPPFLAGS}"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# PHP
# export PATH="/usr/local/bin:$PATH:~/bin"
# export PATH="$PATH:/usr/lib/php/pear/bin"
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
export PATH="/usr/local/sbin:$PATH"

export PATH="/usr/local/opt/freetds@0.91/bin:$PATH"
export PATH="/usr/local/opt/scala@2.11/bin:$PATH"
export PATH="/Users/skheang/Library/Python/2.7/bin:$PATH"
export PATH=$PATH:/usr/local/bin/spark/bin
export JAVA_HOME=`/usr/libexec/java_home`
export RAMS_SRC="src/main/java/com/roku/ads/rams"
export RAMS_UT="src/test/java/com/roku/ads/rams"
export PATH=/opt/apache-maven/bin:$PATH

ssh_rams_west() {
  export host="rams-xr-prod-us-west-2-${1}.bdp.roku.com"

  echo "connecting to $host" 
  ssh skheang37608@${host}
}

ssh_as_west() {
  export host=aerospike-rams-xr-prod-us-west-2-${1}.bdp.roku.com
  echo "connecting to $host ...."

  ssh skheang37608@${host}
}
