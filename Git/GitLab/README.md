# GitLab

## 使用Docker安装

[参考官方文档](https://docs.gitlab.cn/jh/install/docker.html)

### 先决条件

已经安装了Docker。

### 设置卷位置

在设置其他所有内容之前，请配置一个新的环境变量 `$GITLAB_HOME`，指向配置、日志和数据文件所在的目录。 确保该目录存在并且已授予适当的权限。

对于 `Linux` 用户，将路径设置为 `/srv/gitlab`：

`GITLAB_HOME` 环境变量应该附加到您的 shell 的配置文件中，以便它应用于所有未来的终端会话：

Bash：~/.bashrc。在文件的末尾加上下面这行

```bash
export GITLAB_HOME=/srv/gitlab
```

重新生效配置文件

```bash
source ~/.bashrc
```

验证是否生效

```bash
echo $GITLAB_HOME
```
其他路径说明：

| 本地位置                   | 容器位置              | 使用 |
|------------------------|-------------------|----|
| `$GITLAB_HOME/data`    | `/var/opt/gitlab` |  用于存储应用程序数据。  |
| `$GITLAB_HOME/logs`    | `/var/log/gitlab` |  用于存储日志。  |
| `$GITLAB_HOME/config`  | `/etc/gitlab`     | 用于存储极狐GitLab 配置文件。   |

### 开通防火墙

```bash
# 开通80端口
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
# 开通2222端口
sudo firewall-cmd --zone=public --add-port=2222/tcp --permanent
# 开通443端口
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
# 重新加载防火墙规则
sudo firewall-cmd --reload
```

### 运行镜像

您可以微调这些目录以满足您的要求。 一旦设置了 GITLAB_HOME 变量，您就可以运行镜像：

```bash
sudo docker run --detach \
  --hostname gitlab.zjw.com \
  --publish 443:443 --publish 80:80 --publish 2222:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  registry.gitlab.cn/omnibus/gitlab-jh:latest
```

这将下载并启动极狐GitLab 容器，并发布访问 `SSH`、`HTTP` 和 `HTTPS` 所需的端口。

所有极狐GitLab 数据将存储在 `$GITLAB_HOME` 的子目录中。系统重启后，容器将自动 `restart`。

初始化过程可能需要很长时间。 您可以通过以下方式跟踪此过程：

```bash
sudo docker logs -f gitlabX
```
访问极狐GitLab URL，并使用用户名 root 和来自以下命令的密码登录：
```bash
sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

> 密码文件将在 24 小时后的第一次重新配置运行中自动删除。可以在首次登录页面后进行修改。


