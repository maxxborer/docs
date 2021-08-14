export EDITOR='code-insiders'
export VISUAL='code-insiders'
export ZSH="/Users/***REMOVED***/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
source $ZSH/oh-my-zsh.sh
source ~/.zsh_plugins.sh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

alias code='code-insiders'
alias c="clear"
alias knode.="killall -s KILL node"
alias clone.="git clone"
alias push.="git push"
alias pull.="git pull"
alias res.="git reset HEAD~"
alias st.="git add ."
alias gfs.="git flow feature start"
alias gff.="git flow feature finish"
# alias grs.="git flow release start "
# alias grp.="git flow release publish "
# alias grf.="git flow release finish "
alias i.="yarn"
alias s.="yarn start"
alias d.="yarn dev"
alias w.="yarn watch"
alias b.="yarn build"
alias r.="yarn release"
