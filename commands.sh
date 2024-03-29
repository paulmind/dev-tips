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


screen # create screen
screen -x # attach to a running session (enter this command into PuTTY/SSH->Category->Connection->SSH in Remote command field)
screen -x # see all session

# (Ctrl+a+?) HELP
# (Ctrl+a+n) change to next window in list
# (Ctrl+a+p) change to previous window in list
# (Ctrl+a+") see window list
# (Ctrl+a+d) close session


# VIM::


F8 '(удалить символ)' + Tab # - переключение кодировки файла
y # undo откат изменений
Ctrl-R # redo возврат изменений
ggVG # (g+g+Shift+v+Shift+g) выделить все
gg # в начало файла
G # (Shift+g) в конец файла
Shift+v # visual line mode
  3j # press 3j to go down 3 lines, or press j 3 times
  d # to delete select row
  y # to yank/copy
  x # to cut
  p # to paste after cursor
  P # to paste before cursor

:! # execute shell commands
/filepath +'номер строки'

:%s/foo/bar/gc
# change each 'foo' to 'bar', but ask for confirmation first.

:set paste # вставка без табов
:set nonumber # скрыть номера строк
:set nonu # скрыть номера строк
:set number
:set nu
:his # lists the command history
:his / # lists the search history
# In many situations, a better solution is the command-line window which you can open in two ways:
q: # for commands
q/ # for searches
# OR
: + Ctrl-f # Type : or / to start entering a command or search, then press the 'cedit' key (default is Ctrl-f)
/ + Ctrl-f

vim -o *dir_template*/header.php # находит по маске пути к файлам header.php в текущей директории, открывает их, разделяя экран горизонтально
# в таком режиме переключение между файлами (Ctrl+w+[стрелка вверх|стрелка вниз])
vim -O *dir_template*/header.php # с флагом -O экран разделяется вертикально
# в таком режиме переключение между файлами (Ctrl+w+[стрелка влево|стрелка вправо])
vim -p *dir_template*/header.php # с флагом -p vim открывает файлы во вкладках


# MYSQL::


mysql -u username -p
# enter password

mysql> show processlist;
mysql> show processlist\g
mysql> show processlist | grep -v ''
mysql> exit

# MySQL restore backup
# If the database you want to restore doesn't already exist, you need to create it first
mysql --verbose --user=XXXXXX --password DB_NAME < db_backup.dump
mysql --verbose --user=XXXXXX --password DB_NAME < /PATH/TO/DUMPFILE.SQL
mysql -v -u XXXXXX -p DB_NAME < /PATH/TO/DUMPFILE.SQL

# MySQL dump databases
# Dump ALL MySQL databases
mysqldump --user=XXXXXX --password=XXXXXX -A > /PATH/TO/DUMPFILE.SQL
# Dump individual or multiple MySQL databases
mysqldump --user=XXXXXX --password=XXXXXX --databases DB_NAME1 DB_NAME2 DB_NAME3 > /PATH/TO/DUMPFILE.SQL
# Dump only certain tables from a MySQL database
mysqldump --user=XXXXXX --password=XXXXXX --databases DB_NAME --tables TABLE_NAME > /PATH/TO/DUMPFILE.SQL


# MERCURIAL::


hg init /dir1/dir2 # создает репозиторий
hg st
hg stat
hg status # отображает список измененных файлов, добавляя значок в начале каждой строки. Этот значок сообщает о том, что же произошло.
# «R» означаете «Removed» — файл был удален.
# «M» означаете «Modified» — файл был изменен.
# "!" означает отсутствие — файл должен быть здесь, но куда-то делся.
# "?" означает что, состояние не определено — Mercurial ничего не знает про этот файл.
hg st -m
hg st -a
hg st -r
# shows only modify,add,remove files
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
hg add folder1/folder2/* # добавит все новые файлы и подпапки (folder2) в репозиторий
hg ci -m 'comment' folder1/folder2 # закоммитит добавленные файлы в папке (folder2) в репозиторий
hg ci -m 'comment' folder1/folder2/* # закоммитит все файлы и подпапки в folder2 в репозиторий
hg mv # перемещает/переименовывает файл
hg remove # помечает файлы как запланированные для удаления из репозитория. Файлы на диске не будут удалены до тех пор, пока вы не зафиксируете изменения.
hg heads # текущая ветка

hg up -C # выкладывает текущую (после hg pull) ревизию, при этом откатив все измененные файлы
hg up -C -r 888 # позволяет перемещаться вперед и назад ко времени создания любой ревизии, при этом откатив все измененные файлы

hg log filename.java --limit 3 # отображает последние 3 коммита файла
hg log filename.java -l 3

hg cat -r REV /filepath1 > /filepath1
# команда восстанавливает изменения файла из коммита


# ARCH::

:<<Arch_apps
Window manager [wm]         -> awesome [dynamic wm], bspwm [tiling wm]
Virtual terminal            -> urxvt terminal
System info                 -> htop
Shadows done with           -> compton
Like rainmeter              -> conky
Music Player Daemon         -> mpd
Mpd client                  -> ncmpcpp
weechat
More info about sys         -> inxi
Mail client                 -> mutt

dfc, screenfetch
Arch_apps

:<<fonts
tamsyn
Anorexia
artwiz lime
artwiz Edges
fonts

# настройка шрифтов

# установим шрифт tamsyn
sudo pacman -S tamsyn-font
# обновим кэш шрифтов
sudo fc-cache
# убедимся, что шрифт добавился в систему
fc-list | grep Tamsyn
# чтобы изменить стандартный шрифт иксов на tamsyn, необходимо создать файл ~/.fonts.conf
# с содержимым из примера Liberation Font configuration (изменив Liberation на Tamsyn):
# https://wiki.archlinux.org/index.php/Font_configuration/fontconfig_examples
# также в файл ~/.fonts.conf необходимо добавить размеры шрифтов
#<match target="font">
#<test name="size" compare="less_eq"><double>8</double></test>
#</match>
#<match target="font">
#<test name="size" compare="more_eq"><double>14</double></test>
#</match>
#<match target="font">
#<test name="size" compare="eq"><double>6</double></test>
#</match>


# BASH::


sudo bash
# режим супер пользователя (root); выход из режима exit

passwd
# смена пароля
# Enter old password:
# Enter new password:
# Re-enter new password:
# Password updated successfully.

# show server date info with timezone
timedatectl

bunzip2 backup.tar.bz2
# распаковка bz2

tar -xf backup.tar
# распаковка tar

tar -xvzf backup.tar.gz
# распаковка tar gz

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


# To change all the directories to 755 (drwxr-xr-x):
find /opt/lampp/htdocs -type d -exec chmod 755 {} \;

# To change all the files to 644 (-rw-r--r--):
find /opt/lampp/htdocs -type f -exec chmod 644 {} \;


ls -l
#  -l (list) содержимое директории
#  -lh (h) размер файла/директории
#  -lt сортировка по времени

du -d 1 -h ~/tmp/
# (Disk Usage)
# Using '-h' option with 'du' command provides results in 'Human Readable Format'. Means you can see sizes in Bytes, Kilobytes, Megabytes, Gigabytes etc.
# показывает папки вложенные
du -sh *
du -sh temp/*
# size of directory

# List Disk
fdisk -l
# List Disk with size
df -h

# mount <path USB storage> <mount dir>
mount /dev/sda1 /mnt/USB
umount /mnt/USB

# grep логов apache
ls /var/log/apache2/
grep '30/Sep/2013' /var/log/apache2/access.log | wc
grep '30/Sep/2013:14:10' access.log | wc
grep '30/Sep/2013:14:10' access.log>~test/tmp/apache.log

grep 'Jan 12 ' /var/log/apache2/errors.log | grep 'Warning' | awk -F '  ' '{print $2}' | cut -c -50 | sort | uniq -c | sort -rn
# выводит кол-во варнингов из error-лога апача
#  58388 strpos() expects parameter 1 to be string, array g
#  12324 var_export does not handle circular references in
#  10166 Missing argument 1 for Core_File_File::getFilePath
#   ...  ...
#    936 apc_store(): GC cache entry

# list
sudo crontab -l
# edit
sudo crontab -e
sudo crontab -u www-data -l

ps uax | grep keyword
# выводит список процессов(ps) | перенаправление вывода и поиск по 'keyword'
ps -ef --forest | grep 'keyword'
# выводит список процессов(ps) в виде дерева | перенаправление потока вывода и поиск по 'keyword'

kill pid
# убить процесс
pkill -f my_pattern # убить процессы по маске 'my_pattern'

less /filepath
#  Shift+G - перейти в конец
#  Shift+F - режим слежения лога аналог (tail -f)
#  ? - поиск назад
#  / - поиск вперед
#  N - перейти к след.
#  n - перейти к пред.

find . -name '*.js' -exec hg revert -C {} \;
# -exec для найденных файлов выполнить команду
# возврат файлов из репозитория
find -type f -name 'header.php' -exec sed -i -r 's/nocache=20140303/nocache=20140320/g' {} \;
# рекурсивный поиск и замена текста в файлах
find . -mindepth 2 -maxdepth 2 -type d -ctime +10 -exec rm -rf {} \;
# script to delete directories older than n (10) days

ionice -c 3 find . -name '*.php'
# низкий приоритет выполнения команд (если диск загружен не использует его, только когда диск свободен)

grep -rn --exclude-dir=dir 'pattern' .
# recent versions of GNU Grep (>= 2.5.2) provide:
# exclude directories matching the pattern dir from recursive directory searches.
grep -rn '' . | less
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
# -h HELP, prints the help section which includes a summary of all the command line options.
# -c количество имитируемых пользователей
# -t время, за которое должно пройти тестирование
# -r, --reps=NUM REPS, number of times to run the test.

cp -r /var/www/common /var/www/common-20140101
cp -r common common-20140101
# копирует директорию dir в dir2
cp -r dir dir2
# копирует содержимое директории dir в dir2
cp -r dir/. dir2

# откуда / куда
# скопировать файл по SSH в директорию
scp testuser@example.com:/var/www/common/filename.java /var/www/common/testdir

# сжать файл и скопировать по SSH в директорию
ssh bob@some-sever.example.com "cat my-app.sql | gzip -c" | pv | gunzip > tmp/my-app.sql

# copy the directory "foo" from the local host to a remote host's directory "bar"
scp -r foo testuser@example.com:/some/remote/directory/bar

# synchronize folders
# -v verbose
# -n dry-run
rsync -azcvn -O --stats --delete vendor/ vendor/

# use the --no- options to rsync to NOT copy the ownership or permissions of the files you're sync'ing.
rsync -azcvn --no-perms --no-owner --no-group -O --stats --delete vendor/ vendor/

time wget -O 'test' 'http://www.example.com/'
# загрузить содержимое страницы в файл test
wget --force-html -i /home/user/urls.html -P /home/user/tmp/ -o /home/user/tmp/logs
#                             |                     |                  |
#                      files with urls      downloaded files        log file
# конвейер загрузки сайтов, ссылки на которые указаны в html файле

mkdir -m 664 /var/tmp/xdebug
mkdir -p /backup/{2008,2009,2010}/{01,02,03,04,05,06,07,08,09,10,11,12}/
# create multiple directory in one mkdir command


# FAIL2BAN::
sudo apt-get install fail2ban
sudo fail2ban-client status
sudo fail2ban-client restart
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
cd /etc/fail2ban/filter.d
sudo nano nginx-limit-req.conf

# filter config
[nginx-limit-req]
enabled = true
filter = nginx-limit-req
action = iptables-allports[blocktype=DROP, protocol=all]
#port = http,https
logpath = %(nginx_error_log)s
findtime = 600
bantime = 300
maxretry = 50

fail2ban-client -V
sudo fail2ban-client status sshd
sudo fail2ban-client status nginx-limit-req
sudo fail2ban-client set nginx-limit-req unbanip XXX.XXX.XXX.XXX
sudo fail2ban-client stop nginx-limit-req # убирает записи раздела f2b-nginx-limit-req из iptable

sudo systemctl restart fail2ban
sudo systemctl status fail2ban
sudo systemctl stop fail2ban

fail2ban-regex '185.183.107.142 - - [28/Dec/2020:13:08:28 +0100] "GET / HTTP/1.1" 502 182 "-" "-"' '^<HOST> -.*(GET|POST) .*/.*" \d+ \d+ "-" .*'
fail2ban-regex /var/log/auth.log /etc/fail2ban/filter.d/sshd.conf
sudo fail2ban-regex /var/log/nginx/error.log /etc/fail2ban/filter.d/nginx-limit-req.conf


#=== commands to check for ssh hacking under root ===
last
sudo cat /var/log/auth.log | grep -v "CRON" | grep "session opened for user root"


# APACHE::


apache2ctl restart
# Restarts the Apache httpd daemon. If the daemon is not running, it is started.
apache2ctl graceful
# Gracefully restarts the Apache httpd daemon.
# If the daemon is not running, it is started.
# This differs from a normal restart in that currently open connections are not aborted.


# COMPOSER::


# Install
# install composer one command
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Note: If the above fails due to permissions, run the mv line again with sudo.
# Then, just run composer in order to run Composer instead of php composer.phar.
#   ______
#  / ____/___  ____ ___  ____  ____  ________  _____
# / /   / __ \/ __ `__ \/ __ \/ __ \/ ___/ _ \/ ___/
#/ /___/ /_/ / / / / / / /_/ / /_/ (__  )  __/ /
#\____/\____/_/ /_/ /_/ .___/\____/____/\___/_/
#                    /_/
composer install --no-dev


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


# SSL::
# ca_bundle (Contains Root and Intermediate Certificate)
cat certificate.crt ca_bundle.crt > chained.crt
# check SSL
openssl s_client -connect www.godaddy.com:443


# PostgreSQL::

# Stopping the server safely and quickly

# Режим «Smart» запрещает новые подключения, а затем ожидает отключения всех существующих клиентов и завершения всех текущих процессов резервного копирования.
# Если сервер работает в режиме горячего резерва, восстановление и потоковая репликация будут прерваны, как только отключатся все клиенты.
# Режим «Fast» (выбираемый по умолчанию) не ожидает отключения клиентов и завершает все текущие процессы резервного копирования. Все активные транзакции откатываются, а клиенты принудительно отключаются, после чего сервер останавливается.

# Команда stop останавливает сервер, при этом systemd использует режим «Fast»
sudo systemctl stop postgresql
# или
pg_lsclusters
sudo pg_ctlcluster 10 main stop -m fast

# reinstall postgresql
sudo apt-get update && sudo apt-get upgrade
sudo apt-get --purge remove postgresql\*
sudo rm -r /etc/postgresql/
sudo rm -r /etc/postgresql-common/
sudo rm -r /var/lib/postgresql/
sudo userdel -r postgres
sudo groupdel postgres
sudo apt-get install postgresql
sudo -u postgres psql postgres
\password postgres


# Backup and Restore using compression
sudo su - postgres
pg_dump -d db_name -Fp -v -b -Z 5 --exclude-table-data=exclude_table --file=db_backup.gz
psql postgres
# CREATE DATABASE new_db OWNER user_owner;
gunzip -c db_backup.gz | psql new_db


# Backup and be able to restore individual tables
pg_dump -d db_name -t table_name -f /tmp/table_name.dump -Fc -v

pg_dump -h localhost -U postgres -d db_name -Fc -v -b -Ox -a --table=table_name --file=table_name.dump

psql -h localhost -U postgres -d db_name -c '\x' -c 'TRUNCATE table_name RESTART IDENTITY;'

pg_restore -h localhost -U postgres -v -a -d db_name table_name.dump
# but even if all you've got is a full dump of the source database, you can still restore that single table by simply extracting it out of the large dump first:
pg_restore -h localhost -U postgres -v --data-only --table=table_name fulldump.dump > table_name.dump

pg_dump -h localhost -U postgres -d db_name -Fc --data-only -v -b --table=table_name --file=table_name.dump
pg_restore -h localhost -U postgres --disable-triggers -v -a -d db_name table_name.dump


### SSL ON POSTGRES ###
### fix error Can't load /user/.rnd into RNG
openssl rand -writerand .rnd

### Certificate Authority
openssl req -new -nodes -text -out root.csr -keyout root.key -subj "/CN=root.yourdomain.com"
openssl x509 -req -in root.csr -text -days 3650 -extfile /etc/ssl/openssl.cnf -extensions v3_ca -signkey root.key -out root.crt

### Server Certificate
openssl req -new -nodes -text -out server.csr -keyout server.key -subj "/CN=dbhost.yourdomain.com"
openssl x509 -req -in server.csr -text -days 365 -CA root.crt -CAkey root.key -CAcreateserial -out server.crt

### Client Certificate
openssl req -new -nodes -text -out client1.csr -keyout client1.key -subj "/CN=John Doe"
openssl x509 -req -in client1.csr -text -days 365 -CA root.crt -CAkey root.key -CAcreateserial -out client1.crt

### !!! It is VERY important that the CN (Common Name) is different for all certificates !!!

### Verify all
openssl verify -CAfile root.crt root.crt
openssl verify -CAfile root.crt server.crt
openssl verify -CAfile root.crt client1.crt

### In config
ssl = on
ssl_ca_file = '/var/lib/postgresql/<version>/main/ssl_cert/root.crt'
ssl_cert_file = '/var/lib/postgresql/<version>/main/ssl_cert/server.crt'
#ssl_crl_file = ''
ssl_key_file = '/var/lib/postgresql/<version>/main/ssl_cert/server.key'

### Check connection
## sslmode=verify-full
## sslmode=verify-ca
## sslmode=require
## sslmode=disable
psql "host=example.com port=5432 dbname=test user=user1 sslmode=verify-full sslcert=./client1.crt sslkey=./client1.key sslrootcert=./root.crt"

### Get info about ssl connection
openssl s_client -starttls postgres -connect example.com:5432
### SSL ON POSTGRES ###


### SSL ON POSTGRES ALGO V2 ###
### Certificate Authority
openssl ecparam -name prime256v1 -genkey -noout -out ca.key
openssl req -new -x509 -sha256 -key ca.key -out ca.crt
### Fields on Certificate Authority
# Country Name (2 letter code) [AU]:DE
# State or Province Name (full name) [Some-State]:.
# Locality Name (eg, city) []:.
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:Company Name Ltd
# Organizational Unit Name (eg, section) []:.
# Common Name (e.g. server FQDN or YOUR name) []:root.example.com
# Email Address []:security@example.com

### Server Certificate
openssl ecparam -name prime256v1 -genkey -noout -out server.key
openssl req -new -sha256 -key server.key -out server.csr
### Fields on Server Certificate
# Country Name (2 letter code) [AU]:DE
# State or Province Name (full name) [Some-State]:.
# Locality Name (eg, city) []:.
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:Company Name Ltd
# Organizational Unit Name (eg, section) []:.
# Common Name (e.g. server FQDN or YOUR name) []:example.com
# Email Address []:security@example.com
# <passphrase>
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 1000 -sha256

### Client Certificate
openssl ecparam -name prime256v1 -genkey -noout -out client1.key
openssl req -new -sha256 -key client1.key -out client1.csr
### Fields on Client Certificate
# Country Name (2 letter code) [AU]:DE
# State or Province Name (full name) [Some-State]:.
# Locality Name (eg, city) []:.
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:Company Name Ltd
# Organizational Unit Name (eg, section) []:.
# Common Name (e.g. server FQDN or YOUR name) []:John Doe
# Email Address []:JohnDoe@example.com
# <passphrase>
openssl x509 -req -in client1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client1.crt -days 1000 -sha256
### SSL ON POSTGRES ALGO V2 ###
