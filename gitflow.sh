#!/bin/bash

###### GIT ######

# Generating a new SSH key
# - press Enter thrice
ssh-keygen -t rsa -C "your_email@example.com"

# You can change the passphrase for an existing private key without regenerating the keypair by typing the following command:
ssh-keygen -p

# ignore file mode (chmod) changes (local repo config)
git config core.filemode false
# global git config
git config --global core.filemode false

git config user.name "Mona Lisa"
git config user.email johndoe@example.com


# remove a large committed file from your Git repository
git rm giant_file
# stage our giant file for removal, but leave it on disk
git rm --cached giant_file
git commit --amend --allow-empty
git rebase --continue


# добавить изменения в последний коммит
git add file
git commit --amend
git rebase --continue # если конфликты
git push -f


git clone https://github.com/paulmind/dev-tips.git ./dev-tips

git checkout -b feature-1 origin/feature-1

git reset --hard origin/feature-1

git add --force file

# find deleted code
git log -c -S'missingtext' /path/to/file

git diff feature-1..feature-2

# updating file permissions only in git
git update-index --chmod=+x script.sh
git commit -m 'change mode back'

# откат ветки из прода
git rebase -i -p --onto SHA^ SHA
git rebase --continue
git push -f

# откат ветки из прода (вариант 2)
# откат мердж коммита
git revert -n -m 1 SHA

# откат коммита
git revert -n SHA

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
# --first-parent instructs git log to log only the first parent of each commit

# git log has a tool you can use to visualize all of this merging, --graph. The output looks like this:

#  *   8aec370 0 seconds ago Merge branch 'branch3'
#  |\
#  | * f88c7ba 2 seconds ago branch 3
#  * |   b7b4b7c 1 second ago Merge branch 'branch1'
#  |\ \
#  | * | 974b6d7 5 seconds ago branch 1
#  | |/
#  * |   7b79ec5 3 seconds ago Merge branch 'branch2'
#  |\ \
#  | * | accf1ce 4 seconds ago branch 2
#  | |/
#  * | a26aed9 6 seconds ago commit directly on master
#  |/
#  * 2d56476 7 seconds ago initial

# here’s what we see when we git log --first-parent.

#  8aec370 0 seconds ago Merge branch 'branch3'
#  b7b4b7c 1 second ago Merge branch 'branch1'
#  7b79ec5 3 seconds ago Merge branch 'branch2'
#  a26aed9 6 seconds ago commit directly on master
#  2d56476 7 seconds ago initial

git log -n 5 --oneline --merges --first-parent

# that “pretty” argument says to show the commit hash, the relative timestamp, and the commit message, all on one line per commit;
git log -n 5 --pretty="format:%h %s %ar" --merges --first-parent

git log -n 5 --oneline --merges --graph


###### delete remote branch ######
git push origin --delete branch_name

git branch --merged # lists branches merged into HEAD (i.e. tip of current branch)

git branch --no-merged # lists branches that have not been merged

# рабочий вариант для local
git branch | grep feature | xargs git branch -d
git branch --merged | grep feature | xargs git branch -d

# рабочий вариант для origin
git branch -r --merged | grep -v '\*\|master\|dev' | sed 's/origin\///' | grep release | xargs -n 1 git push --delete origin

# удалить ветки, в которых последний коммит старше N дней (скрипт delete_branches.sh)

###### delete remote branch ######


git diff HEAD:full/path/to/foo branch2:full/path/to/bar

git diff branch1:./relative/path/to/foo.txt branch2:./relative/path/to/foo-another.txt
###### GIT ######