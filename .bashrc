start_tmux () {
  # set shell to start up tmux by default
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
  fi
}

if [ "$(uname)" = "Darwin" ]; then
    start_tmux
    alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    start_tmux
    alias ls='ls --color=auto'
    # elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
    # elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi

update_system () {
  if [ "$(uname)" = "Darwin" ]; then
    brew update
    brew upgrade
  elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
  fi
}

################################################
############# function definitions #############
################################################

prettify_json() {
    if [ $# -gt 0 ];
        then
        for arg in $@
        do
            if [ -f $arg ];
                then
                python -m json.tool "$arg"
            else
                echo "$arg" | python -m json.tool | vim -
            fi
        done
    fi
}

# git bash function
gbf() {
  git checkout feature/PEN-$1
}

gbb() {
  git checkout bugfix/PEN-$1
}

gnb() {
  git checkout -b bugfix/PEN-$1 #checking out a new branch
}

gnf() {
  git checkout -b feature/PEN-$1 #checking out a new branch
}

gbr() {
  git checkout release/$1
}

gnr() {
  git checkout release/$1
}

gap() {
  branch_name=$(git symbolic-ref -q HEAD);
  git add .;
  git commit -m "$*";
  git push -u origin $branch_name;
}

gcp() {
  branch_name=$(git symbolic-ref -q HEAD);
  git commit -m "$*";
  git push -u origin $branch_name;
}

gcmm() {
  git commit -m "$*";
}

gcap() {
  branch_name=$(git symbolic-ref -q HEAD);
  git add .;
  git commit --amend --no-edit;
  git push -u -f origin $branch_name;
}

gpu() {
  branch_name=$(git symbolic-ref -q HEAD);
  git push --set-upstream origin $branch_name;
}

af() {
  alias | grep $1
}

#----- Fuzzy finder function -------
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}


#-----Internal Command aliases-------
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias clr='clear'

#-----External Command aliases-------
alias dk='docker'
alias g='git'
alias x='exit'
alias ni='npm install'
alias ns='npm start'
alias nt='npm test'
alias v='vim'


#-------Git aliases-------
alias ga='git add'
alias gb='git branch'
alias gbD='git branch -D'
alias gbd='git branch -d'
alias gc='git clean -f' #remove untracked dirs and files
alias gca='git commit --amend'
alias gck='git checkout'
alias gckb='git checkout -b'
alias gckd='git checkout develop'
alias gckm='git checkout master'
alias gcl='git clone'
alias gcm='git commit'
alias gcrp='git cherry-pick'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gdp='git checkout develop && git pull'
alias gf='git fetch --prune'
alias gi='git init'
alias gl='git checkout -'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmt='git mergetool'
alias gp='git pull'
alias gpf='git push -f'
alias gps='git push'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbod='git rebase origin/develop'
alias grbod='git rebase origin/develop'
alias grbom='git rebase origin/master'
alias grh='git reset --hard'
alias grhom='grh origin/master'
alias grs='git reset --soft'
alias gs='git status'
alias gsa='git stash apply'
alias gsc='git stash clear' #clear all the stashes
alias gsd='git stash drop'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gst='git stash'


#-------Delete all branches except master--------
alias gbda='git branch | egrep -v "(master|\*)" | xargs git branch -D'

# AWS CLI path
export PATH=~/.local/bin:$PATH
