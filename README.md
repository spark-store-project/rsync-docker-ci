# rsync-docker-ci

这个Docker镜像集成了Nginx, rsync, 和一个Python上报软件，用于自动同步星火文件并提供文件服务器功能。

## 功能

1. 每天早上2点使用rsync同步远程目录到`/container-workdir`。
2. 使用Nginx建立文件服务器，工作目录设置为`/container-workdir`。
3. 在容器启动后自动运行名为`status.py`的Python上报软件。

## 工作目录

容器内工作目录为`/container-workdir`。

## 端口转发

容器内Nginx服务运行在`80`端口。

## 环境变量

以下环境变量需要在运行容器时设置：

- `SPARKUSER`: 用户名，用于信息上报认证。
- `SPARKPASSWORD`: 密码，用于信息认证。

示例：请注意修改端口转发和同步目录，例子里是：/home/dir

```bash
docker run -d --restart=always --name=spark-server -e SPARKUSER=sparkuser -e SPARKPASSWORD=sparkpassword -p 80:80 -v  /home/dir:/container-workdir  uniartisan/spark-software-server:latest

```

在容器内，这些环境变量通过Python获取，如下：

```python
USER = os.environ.get("SPARKUSER")
PASSWORD = os.environ.get("SPARKPASSWORD")
```

## 如何使用

1. **构建Docker镜像**

在项目根目录下运行：

```bash
docker build -t spark-software-server .
```

2. **运行容器**

```bash
docker run -e SPARKUSER=sparkuser -e SPARKPASSWORD=sparkpassword -p 80:80 spark-software-server
```

3. **推送到DockerHub**

```bash
docker push uniartisan/spark-software-server:latest
```

## 注意事项

- 确保你的`nginx.conf`、`crontab`和`status.py`等配置文件都在与`Dockerfile`相同的目录下。
- 如果你使用GitHub Actions进行CI/CD，请确保你在GitHub Secrets里已经设置了DockerHub的用户名和密码。
