
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
# 查有没有该文件
ll /etc/yum.repos.d/nginx.repo

# 没有就创建
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
sudo yum install -y nginx
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

# 卸载nginx

停止Nginx服务：
```bash
systemctl stop nginx
```

禁用Nginx服务
```bash
systemctl disable nginx
```

卸载Nginx软件包
```bash
yum remove -y nginx
```

删除Nginx的配置文件和数据

配置文件通常位于 /etc/nginx 目录下，您可以删除这个目录：
```bash
rm -rf /etc/nginx
```

Nginx默认的网站文件（HTML、日志等）通常位于 /usr/share/nginx 或 /var/www 目录下，您可以删除这些目录：
```bash
rm -rf /usr/share/nginx
```

删除日志
```bash
rm -rf /var/log/nginx
```

清理Nginx相关的依赖包
```bash
yum autoremove -y
```

清理缓存
```bash
yum clean all
```

查找并删除残留的文件

检查是否有其他与Nginx相关的文件或目录，然后手动删除它们。您可以使用以下命令来查找可能残留的文件
```bash
find / -name '*nginx*'
```

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

## 常用其他命令
```bash
# 查看版本
nginx -v
# 查看nginx详细信息
nginx -V
# 查看nginx配置是否有问题
nginx -t
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

`user nginx;`: 指定Nginx进程的运行用户，通常为nginx用户。

`worker_processes auto;`: 指定Nginx启动的worker进程数量，auto表示根据CPU核心数自动选择。

`error_log /var/log/nginx/error.log notice;`: 指定错误日志的路径和日志级别。在这里，错误日志被写入到/var/log/nginx/error.log文件，并且只记录notice级别及以上的错误。

`pid /var/run/nginx.pid;`: 指定Nginx主进程的PID文件路径。

`events { ... }`: 配置Nginx事件模块，包括worker_connections参数，指定每个worker进程的最大连接数。

`http { ... }`: 主要的HTTP配置块。

 - `include /etc/nginx/mime.types;`: 包含定义MIME类型的文件。

 - `default_type application/octet-stream;`: 设置默认的MIME类型，如果无法从文件扩展名中确定类型，则使用application/octet-stream。

 - `log_format main '...';`: 定义日志格式，该配置中定义了一个名为main的日志格式，记录了访问日志的详细信息。

 - `access_log /var/log/nginx/access.log main;`: 指定访问日志的路径和使用的日志格式。

 - `sendfile on;`: 启用sendfile系统调用来传输文件，可以提高文件传输效率。

 - `keepalive_timeout 65;`: 定义客户端与服务器之间的空闲连接超时时间。

 - `include /etc/nginx/conf.d/*.conf;`: 包含其他配置文件，通常用于组织和分离不同的站点或应用程序配置。

default.conf默认配置

`/etc/nginx/conf.d/default.conf`

```bash
server {
    listen       80;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
```

`server { ... }`: 定义一个服务器块，用于配置特定的虚拟主机或应用程序。

`listen 80;`: 监听端口80，处理传入的HTTP请求。

`server_name localhost;`: 定义服务器名为localhost，表示该服务器将响应对应于该主机名的请求。

`location / { ... }`: 针对URI路径为/的请求进行配置。

`root /usr/share/nginx/html;`: 指定服务器文件系统中用于处理请求的根目录。

`index index.html index.htm;`: 定义当访问根路径时默认显示的文件。

`error_page 500 502 503 504 /50x.html;`: 配置服务器错误页面，当出现500、502、503、504错误时，将会重定向到/50x.html页面。

`location = /50x.html { ... }`: 配置处理50x错误页面的具体位置。

`root /usr/share/nginx/html;`: 指定50x.html文件的位置。