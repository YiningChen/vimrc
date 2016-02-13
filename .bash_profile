# make macVim replace vim
alias vim='mvim -v'

# make vim default for terminal
set -o vi

# remap up and down keys to search history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

alias mergeReleaseMaster='git checkout release; git pull; git checkout master; git pull; git merge release --no-ff -m "merge release to master"; git push origin HEAD;'
alias recutDevelop='git checkout master; git pull; git push origin :develop; git branch -D develop; git checkout master -b develop; git push origin develop;'

