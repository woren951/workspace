#! /bin/bash

###########################################################################
# BASH HISTORY FILES
###########################################################################

if [[ ! -e .bash-history/.bash_history ]]; then
    mkdir -p .bash-history
    touch .bash-history/.bash_history
fi

if [[ ! -e .bash-history/.zsh_history ]]; then
    mkdir -p .bash-history
    touch .bash-history/.zsh_history
fi
