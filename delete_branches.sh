#!/bin/bash
# удалить ветки, в которых последний коммит старше N дней
NOW=$(date -d "now - 1 days" +"%Y-%m-%d")

# local
#git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:short)'\
# | awk '$2 < "'$NOW'" {print $1}' | sed 's/origin\///'\
# | xargs -n 1 git push --delete origin

# remote
# --merged/--no-merged parameter is specified
git for-each-ref --count=30 --sort=-committerdate refs/remotes/ --format='%(refname:short) %(committerdate:short)'\
 | awk '$2 < "'$NOW'" {print $1}' | sed 's/origin\///'
