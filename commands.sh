#!/bin/bash
echo Hello World

: <<'END'
bla bla
END

#ctrl+->(стрелка)
# переход к след пробелу
#ctrl+shift->(стрелка)
# выделить и перейти к след пробелу


# SCREEN::


screen -x # create screen
# (Ctrl+a+?) HELP
# (Ctrl+a+n) change to next window in list
# (Ctrl+a+p) change to previous window in list
# (Ctrl+a+") see window list


# VIM::


F8 '(удалить символы)' + Tab # - переключение кодировки файла
y # undo откат изменений
Ctrl-R # redo возврат изменений
ggVG # (g+g+Shift+v+Shift+g) выделить все
gg # в начало файла
G # (Shift+g) в конец файла


:! # shell commands
/filepath +'номер строки'

:%s/foo/bar/gc
# change each 'foo' to 'bar', but ask for confirmation first.

:set paste # вставка без табов
:set nonumber # скрыть номера строк
:set number


# MYSQL::


mysql -u username -p userpass
mysql> show processlist;
mysql> show processlist\g
mysql> show processlist | grep -v ''
mysql> exit


# MERCURIAL::


hg init /dir1/dir2 # создает репозиторий
hg st
hg stat
hg status # отображает список измененных файлов, добавляя значок в начале каждой строки. Этот значок сообщает о том, что же произошло.
# «R» означаете «Removed» — файл был удален.
# «M» означаете «Modified» — файл был изменен.
# "!" означает отсутствие — файл должен быть здесь, но куда-то делся.
# "?" означает что, состояние не определено — Mercurial ничего не знает про этот файл.
hg serve # запускает веб-сервер и делает текущий репозиторий доступным в сети
hg serve -p 8001 #
hg diff /filepath # показывает изменения в файле
hg diff --rev REV1 : REV2 /filepath # показывает изменения файла между коммитами
hg diff --change REV /filepath # compare against first parent
hg revert /filepath1 /filepath2 # восстанавливает файл из репозитория
hg revert -C filename.java # восстанавливает файл из репозитория не создавая копию filename.java.orig (you can also use the flag --no-backup)
hg rollback # откатить последний коммит

hg pull 'http://www.example.com:8001/'
hg clone test/ test.copy/
hg parent -r REV

hg add folder1/folder2 # добавит все новые файлы в папке (folder2) в репозиторий
hg ci -m 'comment' folder1/folder2 # закоммитит добавленные файлы в папке (folder2) в репозиторий
hg mv # перемещает/переименовывает файл
hg remove # помечает файлы как запланированные для удаления из репозитория. Файлы на диске не будут удалены до тех пор, пока вы не зафиксируете изменения.
hg heads # текущая ветка

hg up -C # выкладывает текущую (после hg pull) ревизию, при этом откатив все измененные файлы
hg up -C -r 888 # позволяет перемещаться вперед и назад ко времени создания любой ревизии, при этом откатив все измененные файлы

hg log filename.java --limit 3 # отображает последние 3 коммита файла
hg log filename.java -l 3


# BASH::


sudo bash
# режим супер пользователя (root); выход из режима exit

passwd
# смена пароля
# Enter old password:
# Enter new password:
# Re-enter new password:
# Password updated successfully.

bunzip2 backup.tar.bz2
# распаковка bz2
tar -xf backup.tar
# распаковка tar
bunzip2 backup.tar.bz2; tar -xf backup.tar

> my_file
# how to empty a file

sudo chgrp -R devs .;sudo chmod -R g+w .
# chmod изменяет права доступа
# chgrp(change group) изменяет группу
# -R рекурсивно
#
# битовая маска
#  _____ чтение/read
# |  ___ запись/write
# | |  _ исполнение/executable
# | | |
# r w x
# 4 2 1 - биты
#
# d[rwx][rwx][rwx]
# d[user(u)][group(g)][other(o)]
#
# -[rwx][rwx][rwx]
# -[user(u)][group(g)][other(o)]
#
# example 664 rw-(4+2) rw-(4+2) r--(4)
# example 253 -w-(2) r-x(4+1) -wx(2+1)

ls -l
#	-l (list) содержимое директории
#	-lh (h) размер файла/директории
#	-lt сортировка по времени

du -d 1 -h ~/tmp/
# (Disk Usage)
# Using '-h' option with 'du' command provides results in 'Human Readable Format'. Means you can see sizes in Bytes, Kilobytes, Megabytes, Gigabytes etc.
# показывает папки вложенные

# grep логов apache
ls /var/log/apache2/
grep '30/Sep/2013' /var/log/apache2/access.log|wc
grep '30/Sep/2013:14:10' access.log|wc
grep '30/Sep/2013:14:10' access.log>~test/tmp/apache.log

sudo crontab -l
sudo crontab -e

ps uax | grep keyword
# выводит список процессов(ps) | пернаправление выввода и поиск по 'listspo'
ps -ef --forest | grep 'keyword'
# выводит список процессов(ps) в виде дерева | пернаправление потока выввода и поиск по 'keyword'

kill pid
# убить процесс

less /filepath
#	Shift+G - перейти в конец
#	Shift+F - режим слежения лога аналог (tail -f)
#	? - поиск назад
#	/ - поиск вперед
#	N - перейти к след.
#	n - перейти к пред.

find . -name '*.js' -exec hg revert -C {} \;
# -exec для найденных файлов выполнить команду
# возврат файлов из репозитория
find -type f -name 'header.php' -exec sed -i -r 's/nocache=20140303/nocache=20140320/g' {} \;
# рекурсивный поиск и замена текста в файлах

ionice -c 3 find . -name '*.php'
#низкий приоритет выполнения команд (если диск загружен не использует его, только когда диск свободен)

grep -rn '' . |less
# grab log
grep 'ERROR' /var/log/test.log | grep '2014.01.01' | wc
grep 'ERROR' /var/log/test.log | grep '2014.01.01' | less
grep -A1 'TOTAL_TIME' /var/log/test.log | grep -B1 '2014.01.01' | wc
# -A1 (After) включить в вывод одну строку до вхождения
# -B1 (Before) включить в вывод одну строку после вхождения
grep -A1 'TOTAL_TIME' /var/log/test.log | grep -B1 '2014.01.01' | grep -oP "(?<=TOTAL_TIME \()\d{1,3}\.\d{1,2}"
grep -A1 'TOTAL_TIME' /var/log/test.log | grep -B1 '2014.01.01' | grep -oP "(?<=TOTAL_TIME \()\d{1,3}\.\d{1,2}" | sort -n | sed -n '1p;$p'
grep -A1 'TOTAL_TIME' /var/log/test.log | grep -B1 '2014.01.01' | grep -oP "(?<=TOTAL_TIME \()\d{1,3}\.\d{1,2}" | awk '{sum+=$1} END { print "Average =",sum/NR}'
grep 'Empty' /var/log/test.log | grep '2014.01.01' | grep -oP "(?<=\#)\d{4,6}\s" | sort -u | wc
grep 'Empty' /var/log/test.log | grep '2014.01.01' | grep -oP "(?<=\#)\d{4,6}\s" | sort -u | less

tail -f /var/log/test.log
# вывод логов в реальном времени, начиная с последней записи

tail -n 50 /var/log/test.log
# последние 50 записей лога

siege -b -i -c 5 -r 1 -t10M --log[=FILE] --file=FILE
siege -b -i -c 5 -r 1 --log[=FILE] --file=FILE
siege -c2 -t60M -i -f /var/tmp/urls.txt
# -c количество имитируемых пользователей
# -t время, за которое должно пройти тестирование


# APACHE::


mv common common-tmp; mv common-20140101 common; apache2ctl restart
# откатить проект
apache2ctl restart
# Restarts the Apache httpd daemon. If the daemon is not running, it is started.
apache2ctl graceful
# Gracefully restarts the Apache httpd daemon.
# If the daemon is not running, it is started.
# This differs from a normal restart in that currently open connections are not aborted.

cp -r /var/www/common /var/www/common-20140101
cp -r common common-20140101

scp testuser@example.com:/var/www/common/filename.java /var/www/common/testdir
# откуда / куда
#	скопировать файл по SSH в директорию

time wget -O 'test' 'http://www.example.com/'
# загрузить содержимое страницы в файл test
wget --force-html -i /home/user/urls.html -P /home/user/tmp/ -o /home/user/tmp/logs
#							|						|					|
#					files with urls			downloaded files		log file
# конвейер загрузки сайтов, ссылки на которые указаны в html файле

mkdir -m 664 /var/tmp/xdebug
mkdir -p /backup/{2008,2009,2010}/{01,02,03,04,05,06,07,08,09,10,11,12}/
# create multiple directory in one mkdir command


# PHP::


php -i | grep 'Configuration File'
# | перенаправление stdout
php -i | grep 'xdebug'
php -d xdebug.profiler_enable=On script.php
php -d xdebug.default_enable=On -d xdebug.profiler_enable=On /test/script.php
php shell/test.php
# запуск php скрипта
php -r ''
# выполнение php кода в консоли
php --ini
# путь к файлу php.ini
# Dude, where's my php.ini?
