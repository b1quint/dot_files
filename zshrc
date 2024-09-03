# My .bashrc
# by Bruno C. Quint
# last update: 2018.Nov
#

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b) '

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
#PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '

# Changing colors of the terminal prompt
# See https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion for por details
PROMPT='${vcs_info_msg_0_}%F{green}%n@%m%f [%F{green}%~%f] 
$ '

# Adding extra paths
export GIT_PS1_SHOWDIRTYSTATE=yes
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"

## For OSX 
## Make sure you run "$ brew install coreutils" first
#alias ls='ls --color -h --group-directories-first'

## For GNU/Linux
# alias ls='gls --color -h --group-directories-first'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/brunoquint/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/brunoquint/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/brunoquint/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/brunoquint/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> Start Zephyr Interface <<<
source ~/.ts_planning_tool

# >> Prepara for Docker <<
# Run docker contained named "dev"
alias run_dev_container="docker run -it --rm --name dev -v ~/GitHub/:/home/saluser/develop lsstts/develop-env:develop"

# Stop "dev" container
alias stop_dev_container="docker stop dev"

# Pull corresponding dev image: lsstts/develop-env:develop
alias pull_dev_image="docker pull lsstts/develop-env:develop"
