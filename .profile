export EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -G'
alias vi='nvim'
alias f='find . -name '
alias gs='git status'
alias npm=yarn
alias pie='racket -l pie -i'
alias codaport='lsof -i:3085'
alias ev='esy nvim'
alias dotfiles='/usr/bin/git --git-dir=/Users/avery/.dotfiles/ --work-tree=/Users/avery'

fl () {
  fd $1 --no-ignore-vcs | tail -n1
}

source ~/.git-prompt.sh
#export PS1='mbp:\W \u\$ '
export PS1="\[\e[0;90m\]\D{%T} \[\033[01;32m\]\u@mbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 ' (%s)') \$([ \$? == 0 ] && echo '\[\e[0;32m\]\$' || echo '\[\e[0;31m\]\$') \[\033[00m\]"
# '\`" make
# complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

export PATH=$PATH:~/bin

# opam configuration
# test -r /Users/avery/.opam/opam-init/init.sh && . /Users/avery/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
if [ -e /Users/avery/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/avery/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


if [ -f ~/.git-completion.bash ]; then . ~/.git-completion.bash; fi

# GNU "sed" has been installed as "gsed".
# If you need to use it as "sed", you can add a "gnubin" directory
# to your PATH from your bashrc like:

#     PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="/Applications/Racket v7.4/bin":"$HOME/.cargo/bin:/Users/avery/Library/Python/3.7/bin/":$PATH

activate () {
 source "$1/bin/activate"
}

export PATH="$HOME/.elan/bin:$PATH"
