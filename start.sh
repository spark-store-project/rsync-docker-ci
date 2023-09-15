#!/bin/bash

# 启动 cron 服务
cron

# 运行 Python 脚本
python3 /status.py > /dev/null 2>&1 &

# 立即执行rsync
mkdir -p ~/.ssh/
ssh-keyscan -H zunyun01.store.deepinos.org.cn >> ~/.ssh/known_hosts

nohup rsync -rtlvH --perms --delete-after --delay-updates --safe-links --timeout 120 --progress sdu@zunyun01.store.deepinos.org.cn::spark-store /container-workdir > /dev/null 2>&1 &



# 启动Nginx服务
nginx -g 'daemon off;'




