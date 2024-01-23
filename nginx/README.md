
# nginx文档

# 安装nginx

## Red Hat Enterprise Linux

[官网安装手册](https://nginx.org/en/linux_packages.html)

> 红帽及其衍生系统，CentOS, Oracle Linux, Rocky Linux, AlmaLinux.

安装必备组件：

```bash
sudo yum install yum-utils
```

要设置 yum 存储库，请创建以以下内容命名的文件: `/etc/yum.repos.d/nginx.repo`

```bash
touch /etc/yum.repos.d/nginx.repo
```

```
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
````

默认情况下，使用稳定版nginx包的存储库。如果你想使用主线nginx包，运行以下命令:
```bash
sudo yum-config-manager --enable nginx-mainline
```

安装nginx的命令如下:
```bash
sudo yum install nginx
```

使用`nginx`命令启动nginx

> 启动后访问[http://yourip]()

## 关闭防火墙及自启动

> 可选，但是80端口要开通

```bash
systemctl stop firewalld
systemctl disable firewalld
```

## 自启动管理
```bash
# 设置nginx开机自启
systemctl enable nginx
# 关闭nginx开机自启
systemctl disable nginx
```

> 暂时不要设置，还有问题

## 目录说明

- `/etc/nginx/` nginx安装目录

- `/etc/nginx/nginx.conf` 配置文件

- `/usr/share/nginx/html` html页面

- `/var/log/nginx` 日志文件路径

- `/var/run/nginx.pid` nginx进程id，`systemctl`命令会用到

# 新手指南

## 官方提供的启动，停止，以及重新加载配置

要启动nginx，运行可执行文件`nginx`。一旦nginx启动，它可以通过调用可执行文件的参数来控制。使用如下语法:`-s`

> nginx -s _signal_

其中标志可能是以下其中一种:

- `stop` — fast shutdown

- `quit` — graceful shutdown

- `reload` — reloading the configuration file

- `reopen` — reopening the log files

例如，要停止nginx进程，等待工作进程完成当前请求，可以执行以下命令:

```bash
nginx -s quit
```

> 该命令应该以启动nginx的同一用户执行。

在配置文件中所做的更改将不会被应用，直到重新加载配置的命令被发送给nginx或它被重新启动。要重新加载配置，执行:

```bash
nginx -s reload
```

要获取所有正在运行的nginx进程的列表，可以使用该实用程序，例如，如下所示:
```bash
ps -ax | grep nginx
```

## nginx.conf配置文件

通过yum安装的在`/etc/nginx/nginx.conf`路径下。

```bash

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```

