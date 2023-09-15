#!/bin/bash

# 检查是否有正在运行的 rsync 进程
if pgrep -x "rsync" > /dev/null
then
    echo "rsync 已经在运行，跳过本次同步"
else
    echo "rsync 没有在运行，开始同步"
    rsync -rtlvH --perms --delete-after --delay-updates --safe-links --timeout 120 --progress sdu@zunyun01.store.deepinos.org.cn::spark-store /container-workdir
fi
