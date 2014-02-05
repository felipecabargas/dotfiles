#------------------------------------------------------------------------------
# Returncode.
#------------------------------------------------------------------------------
# function returncode
# {
#  returncode=$?
#  if [ $returncode != 0 ]; then
#    echo "[$returncode]"
#  else
#    echo ""
#  fi
# }

#------------------------------------------------------------------------------
# Git options.
#------------------------------------------------------------------------------
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "[UNCOMMITED]"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]$(parse_git_dirty)/"
}

#------------------------------------------------------------------------------
# Prompt.
#------------------------------------------------------------------------------
if [ "$BASH" ]; then
  if [ "`id -u`" -eq 0 ]; then
    # The root prompt is red.
    PS1='${debian_chroot:+($debian_chroot)}\[\000[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    # PS1='\u@\h:\w > '
    PS1='felipe@macbook-air\[\033[0;35m\] $ \[\033[0;35m\]\w\[\033[0;27m\]$(parse_git_branch) > '
  fi
else
  if [ "`id -u`" -eq 0 ]; then
    PS1='# '
  else
    PS1='$ '
  fi
fi

export PS1

# Whenever displaying the prompt, write the previous line to .bash_history.
PROMPT_COMMAND='history -a'


#------------------------------------------------------------------------------
# Bash options.
#------------------------------------------------------------------------------
set -o notify

#------------------------------------------------------------------------------
# Bash shopts.
#------------------------------------------------------------------------------
shopt -s extglob
shopt -s progcomp
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s cmdhist
shopt -s lithist
# shopt -s cdspell
shopt -s no_empty_cmd_completion
shopt -s checkhash
shopt -s hostcomplete


#------------------------------------------------------------------------------
# Completion.
#------------------------------------------------------------------------------
complete -A alias         alias unalias
complete -A command       which
complete -A export        export printenv
complete -A hostname      ssh telnet ftp ncftp ping dig nmap
complete -A helptopic     help
complete -A job -P '%'    fg jobs
complete -A setopt        set
complete -A shopt         shopt
complete -A signal        kill killall
complete -A user          su userdel passwd
complete -A group         groupdel groupmod newgrp
complete -A directory     cd rmdir

#------------------------------------------------------------------------------
# Git options.
#------------------------------------------------------------------------------
#function parse_git_dirty {
#  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
#}
#function parse_git_branch {
#  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
#}

#------------------------------------------------------------------------------
# Colorized ls.
#------------------------------------------------------------------------------
# eval `dircolors ~/.dir_colors`
# export LS_OPTIONS='--color=auto'
# alias ls='ls $LS_OPTIONS'


#------------------------------------------------------------------------------
# Security.
#------------------------------------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'


#------------------------------------------------------------------------------
# Typos.
#------------------------------------------------------------------------------
alias scsl=clear
alias qcls=clear
alias clls=clear
alias csl=clear
alias cll=clear
alias slc=clear
alias lcs=clear
alias lsc=clear
alias sls=clear
alias scl=clear
alias cs=clear
alias c=clear
alias cl=clear
alias ssl=clear
alias csll=clear
alias clsl=clear
alias chmdo=chmod
alias sl=ls
alias sll=ls
alias lsl=ls
alias s=ls
alias psa='ps a'
alias tarx='tar x'
alias maek=make
alias act=cat
alias cart=cat
alias grpe=grep
alias gpre=grep
alias whcih=which
alias icfonfig=ifconfig
alias ifocnfig=ifconfig
alias iv=vi
alias lvi=vi
alias vf=cd
alias vp=cp
alias nmv=mv
alias mann=man
alias nman=man
alias nmann=man
alias mb=mv

#------------------------------------------------------------------------------
# Miscellaneous.
#------------------------------------------------------------------------------
# mesg n                     # Disable messages.
# setterm -blength 0         # Disable annoying beep.
#ulimit -c unlimited        # No limits.
#eval `lesspipe`            # Allow less to view *.gz etc. files.


#------------------------------------------------------------------------------
# Environment Variables.
#------------------------------------------------------------------------------
export EDITOR=nano
export NNTPSERVER=localhost
export HISTSIZE=2000
export HISTFILESIZE=100000
export HISTIGNORE=
export MESA_GLX_FX=fullscreen
export CVS_RSH=ssh
export PAGER=less
export LESS=i


#------------------------------------------------------------------------------
# Terminal settings.
#------------------------------------------------------------------------------
if ! [ $TERM ] ; then
  eval `tset -s -Q`
  case $TERM in
    con*|vt100|linux|xterm)
      tset -Q -e ^?
    ;;
  esac
fi


#------------------------------------------------------------------------------
# Useful aliases to save some typing.
#------------------------------------------------------------------------------
alias cls='clear'
alias l='ls -lA'
alias lsr='ls -lSr'
alias md='mkdir'
alias rd='rmdir'
alias p='ping www.google.com'
alias nt='netstat -a -e -e -p -A inet'
alias n='nano'

alias my='mysql5 -u root -p'
alias ru='ruby setup.rb all'
alias HEX="ruby -e 'printf(\"0x%X\n\", ARGV[0])'"
alias DEC="ruby -e 'printf(\"%d\n\", ARGV[0])'"
alias BIN="ruby -e 'printf(\"%bb\n\", ARGV[0])'"
alias WORD="ruby -e 'printf(\"0x%04X\n\", ARGV[0])'"

alias commit='git add . && git commit -a -m '
alias backup='heroku pgbackups:capture --expire'
alias irb='irb --simple-prompt'

alias archivos='cd /archivos'

alias stash='git stash'
alias destash='git stash pop'

alias redis='redis-server /opt/local/etc/redis.conf'

alias gemset='rvm gemset'

alias test_app='bundle exec rake test_app && cd spec/dummy'

#------------------------------------------------------------------------------
# Import local/private settings.
#------------------------------------------------------------------------------
if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi


#------------------------------------------------------------------------------
# User-dependent Settings.
#------------------------------------------------------------------------------
#if [ "`id -u`" -eq 0 ]; then
#  umask 022
#else
#  umask 077

  # # Print TODO file.
  # if test -f ~/.todo; then
  #   cat ~/.todo
  # fi

  # # Print fortune cookies.
  # if [ "`which fortune`" != "" ]; then
  #   echo
  #   fortune
  # fi
#fi

#------------------------------------------------------------------------------
# RVM.
#------------------------------------------------------------------------------

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
