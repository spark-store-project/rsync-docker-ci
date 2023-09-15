# 使用官方Nginx镜像作为基础镜像
FROM nginx:latest

# 安装必要的软件包
RUN apt-get update && \
    apt-get install -y rsync sshpass python3 python3-pip cron pgrep ps nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 复制nginx配置文件和其他文件
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/logs
COPY crontab /etc/cron.d/rsync-cron
COPY status.py /status.py
COPY start.sh /start.sh
COPY rsync.sh /rsync.sh

# 添加执行权限
RUN chmod +x /start.sh
RUN chmod +x /rsync.sh

# 创建和设置cron计划任务
RUN chmod 0644 /etc/cron.d/rsync-cron
RUN crontab /etc/cron.d/rsync-cron

# 修改时区
ENV TZ Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 启动cron、Python脚本和其他任务
CMD ["/start.sh"]


