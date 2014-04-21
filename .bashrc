# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ $TERM = dumb ]; then
  PS1="[\w]$ "
else 
#  PS1="\[\e[35;1m\]\u \t [\w]\n\\$ \[\e[0m\]"
  PS1="\[\033[1;35m\][\w]$\[\033[0m\] "
#  PS1="[\w]$ "
fi

HISTSIZE=50000
HISTFILESIZE=50000

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ll='ls -l'
alias la='ls -aF'
alias root='sudo -s -H -u root'

alias pmver="perl -le '\$m = shift; eval qq(require \$m)
             or die qq(module \"\$m\" is not installed\\n); print \$m->VERSION'"
#alias ls='ls -aF'

alias clean='rm -f "#"* *~ .*~ core'

export TZ=Japan
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

export PATH=/usr/local/bin:$PATH:/opt/local/bin:$JAVA_HOME/bin

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
eval "$(rbenv init -)"
