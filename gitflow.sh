#!/bin/bash

###### GIT ######

git clone https://github.com/paulmind/dev-tips.git ./dev-tips

git checkout -b feature-1 origin/feature-1

git reset --hard origin/feature-1

git add --force file

#find deleted code
git log -c -S'missingtext' /path/to/file

git diff feature-1..feature-2

#updating file permissions only in git
git update-index --chmod=+x script.sh
git commit -m 'change mode back'

# откат ветки из прода
git rebase -i -p --onto SHA^ SHA
git rebase --continue
git push -f

# удалить коммит из истории (для линейной истории)
git rebase -i SHA
git rebase --continue
git push -f

# удалить последний коммит из origin
git reset --hard HEAD~1
# или конкретный коммит
git reset --hard SHA
git push -f

# показать 5 последних мерджей
git log --merges --pretty=oneline --abbrev-commit -n 5
git log --pretty=oneline --abbrev-commit -n 5

#delete remote branch
git push origin --delete branch_name

git branch --merged #lists branches merged into HEAD (i.e. tip of current branch)

git branch --no-merged #lists branches that have not been merged

for branch in `git branch --merged | grep feature`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r

# рабочий вариант для local
git branch | grep feature | xargs git branch -d
git branch --merged | grep feature | xargs git branch -d

# рабочий вариант для origin
git branch -r --merged | grep -v '\*\|master\|dev' | sed 's/origin\///' | grep release | xargs -n 1 git push --delete origin

###### GIT ######