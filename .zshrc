export ZSH="/Users/***REMOVED***/.oh-my-zsh"
ZSH_THEME="hyper-oh-my-zsh"

export EDITOR="code -w"

plugins=(git)

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

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/

export PATH=/usr/local/bin:$PATH

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
# This load plugins
source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $ZSH/oh-my-zsh.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

clear
export ZSH="/Users/***REMOVED***/.oh-my-zsh"
ZSH_THEME="hyper-oh-my-zsh"

export EDITOR="code -w"

plugins=(git)

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

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/

export PATH=/usr/local/bin:$PATH

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
# This load plugins
source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $ZSH/oh-my-zsh.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

clear
