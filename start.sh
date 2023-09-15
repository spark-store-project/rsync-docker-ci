#!/bin/bash


# 启动Nginx服务
nginx -g 'daemon off;'


# 立即执行rsync
mkdir -p ~/.ssh/
ssh-keyscan -H zunyun01.store.deepinos.org.cn >> ~/.ssh/known_hosts

rsync -rtlvH --perms --delete-after --delay-updates --safe-links --timeout 120 --progress sdu@zunyun01.store.deepinos.org.cn::spark-store /container-workdir

# 启动cron服务
cron


