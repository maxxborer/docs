export ZSH="/home/$USER/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git)

alias -g pro.="cd /home/$USER/PRO/"

alias -g czsh="code /home/$USER/.zshrc"

alias -g tarpkg="tar -xvf "

alias -g c="clear"
alias -g pressf="rm -rf "
alias -g killnode="killall -s KILL node"

alias -g ap.="sudo apt purge "
alias -g ai.="sudo apt install "
alias -g autoremove.="sudo apt autoremove"

alias -g clone.="git clone"
alias -g push.="git push"
alias -g pull.="git pull"
alias -g reset.="git reset HEAD~"
alias -g st.="git add ."

alias -g gfs.="git flow feature start"
alias -g gff.="git flow feature finish"

alias -g gfrs.="git flow release start "
alias -g gfrp.="git flow release publish "
alias -g gfrf.="git flow release finish "

alias -g cm="./node_modules/cz-customizable/standalone.js -S"
alias -g sc.="gadd; ./node_modules/cz-customizable/standalone.js -S"

alias -g n="npm"
alias -g i.="npm i"
alias -g start.="npm start"
alias -g boot.="npm run bootstrap"
alias -g dev.="npm run dev"
alias -g run.="boot.;dev."
alias -g watch.="npm run watch"
alias -g build.="npm run build"
alias -g locale.="npm run build-locales"
alias -g i18.="npm run i18"
alias -g release.="npm run release"
alias -g story.="npm run storybook"

alias -g ystart.="npm start"
alias -g yboot.="yarn bootstrap"
alias -g ydev.="yarn dev"
alias -g yrun.="yboot.;ydev."
alias -g ywatch.="yarn watch"
alias -g ybuild.="yarn build"
alias -g ylocale.="yarn build-locales"
alias -g yi18.="yarn i18"
alias -g yrelease.="yarn release"
alias -g ystory.="yarn storybook"

eval $(thefuck --alias)

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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

source $ZSH/oh-my-zsh.sh
clear
# echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
