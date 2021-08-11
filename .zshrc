if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/***REMOVED***/.oh-my-zsh"
source $ZSH/oh-my-zsh.shf
source ~/.zsh_plugins.sh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

# plugins=(git)

alias code='code-insiders'
alias c="clear"
alias killnode.="killall -s KILL node"

alias clone.="git clone"
alias push.="git push"
alias pull.="git pull"
alias reset.="git reset HEAD~"
alias st.="git add ."

alias gfs.="git flow feature start"
alias gff.="git flow feature finish"

alias gfrs.="git flow release start "
alias gfrp.="git flow release publish "
alias gfrf.="git flow release finish "

alias i.="yarn"
alias start.="yarn start"
alias dev.="yarn dev"
alias watch.="yarn watch"
alias build.="yarn build"
alias release.="yarn release"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

clear
