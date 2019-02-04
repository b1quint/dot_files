
# My .bashrc
# by Bruno C. Quint
# last update: 2018.Nov
#

# If you get the error message:
#   bash: __git_ps1: command not found
# Use the following command to fix:
# curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
# And decomment the following line
source ~/.bash_git


## Colors

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
     PURPLE="\[\033[0;35m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

 # Changing colors of the terminal prompt
 export PS1="\[\e[00;37m\]\u@\h [\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;37m\]] \n\\$\[\e[0m\] "


## Print nickname for git/hg/bzr/svn version control in CWD
## Optional $1 of format string for printf, default "(%s) "
function be_get_branch {
  local dir="$PWD"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git) __git_ps1 "${1:-(%s) }"; return;;
          hg) nick=$(hg branch 2>/dev/null);;
          svn) nick=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && nick=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$nick" ]] && [[ -f "$conf" ]] && nick="$(basename "$(< $conf)")"
            [[ -z "$nick" ]] && nick="$(basename "$(readlink -f "$dir")")";;
        esac
        [[ -n "$nick" ]] && printf "${1:-(%s) }" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}

## Add branch to PS1 (based on $PS1 or $1), formatted as $2
export GIT_PS1_SHOWDIRTYSTATE=yes
export PS1="\$(be_get_branch "$2")${PS1}";
export iraf="/iraf/iraf/"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.iraf/bin:$PATH"
export PATH="$PATH:/opt/montage/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PGPLOT_DIR="/opt/qfitsview/"

## For OSX 
## Make sure you run "$ brew install coreutils" first
#alias ls='ls --color -h --group-directories-first'

## For GNU/Linux
alias ls='gls --color -h --group-directories-first'

# AstroConda
source activate astroconda
