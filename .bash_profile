# make vim default for terminal
set -o vi

# remap up and down keys to search history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

forDirectoryWithName() {
	for file in *$1*
	do 
		echo $file;
		cd $file;
		$2;
		cd ..;
	done
}

git_delete() {
	git branch -D $1;
	git push origin :$1;
}

alias startredis='redis-server /usr/local/etc/redis.conf'
alias git_setUpstream='git branch --set-upstream-to=origin/$(git rev-parse --abbrev-ref HEAD) $(git rev-parse --abbrev-ref HEAD)'

# call submodules_deleteAndCheckoutDevelop afterward 
# otherwise when pulling from develop, branches might throw upstream error
alias submodules_mergeAndRecut="git submodule update --init --recursive && git submodule foreach '\
git checkout release && \
git pull && \
git checkout master && \
git pull && \
git merge release --no-ff -m \"merge release to master\" && \
git push origin HEAD && \
git push origin :develop && \
git branch -D develop; \
git checkout master -b develop && \
git push origin develop'"

alias submodules_deleteAndCheckoutDevelop="git submodule foreach '\
git checkout master && \
git pull && \
git branch -D develop; \
git checkout develop'"

alias submodules_recut="git submodule foreach '\
git checkout master && \
git pull --all && \
git push origin :develop && \
git branch -D develop; \
git checkout master -b develop && \
git push origin develop'"

alias recutDevelop='git checkout master && git pull && git push origin :develop && git branch -D develop && git checkout master -b develop && git push origin develop;'

# unmaintained aliases
alias mergeReleaseMaster='git pull --all; git checkout master; git merge release --no-ff -m "merge release to master"; git push origin HEAD;'
alias sbdevelop="git submodule foreach 'git checkout develop && git pull'"
