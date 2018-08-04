
if [ "`id -u`" -ne 0 ]; then
    export PS1='\[\033[32;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '
else
    export PS1='\[\033[32;32m\]\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`"
	alias ls='ls -a --color=auto'
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -Al'

alias b1='bitcoin-cli -datadir=1 '
alias b2='bitcoin-cli -datadir=2 '
