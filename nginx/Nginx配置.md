# 多个域名绑定同一台主机指向不同的服务

`app1`和`app2`是在同一台服务器上，使用的端口也是一样的，只是使用的服务不一样（root指向了不同的首页）

> /etc/nginx/conf.d/app1.conf

```bash
server {
    listen       80;
    server_name  app1.com;

    location / {
        root   /data/app1/html;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

> /etc/nginx/conf.d/app2.conf

```bash
server {
    listen       80;
    server_name  app2.com;

    location / {
        root   /data/app2/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

这里我在windows的hosts文件中把`app1`,`app2`指向了同一台服务器，默认在互联网上的域名解析。
```bash
192.168.234.101 nginx app1.com app2.com
```

# server_name通配符

## 多个域名指向同一个服务

比如`hello1.com`和`hello2.com`想指向同一个服务，可以这样配置。

> /etc/nginx/conf.d/app1.conf

```bash
server {
    listen       80;
    server_name  hello1.com hello2.com;

    location / {
        root   /data/app1/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

这里我在windows的hosts文件中把`hello1.com`,`hello2.com`指向了同一台服务器，默认在互联网上的域名解析。
```bash
192.168.234.101 hello1.com hello2.com
```

## 多个域名指向同一个服务,*号通配符

如果想`a.hello.com`和`b.hello.com`以及其他`xxxx.hello.com`想指向同一个服务，可以这样配置。

> 前缀匹配行不通。。。

> /etc/nginx/conf.d/app1.conf

```bash
server {
    listen       80;
    server_name  *.hello.com;

    location / {
        root   /data/app1/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

如果想`hello.com`和`hello.org`以及其他`hello.xxx`想指向同一个服务，可以这样配置。

> /etc/nginx/conf.d/app1.conf

```bash
server {
    listen       80;
    server_name  hello.*;

    location / {
        root   /data/app1/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

# server_name正则匹配

```bash
server_name ~^[0-9]+\.hello\.com$;
```

# 反向代理到外网

> 通过访问hello.com达到访问baidu.com的效果。

```bash
[root@CentOS7 conf.d]# cat app1.conf 
server {
    listen       80;
    server_name   hello.com;

    location / {
        proxy_pass https://www.baidu.com;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

# 反向代理到本地其他主机

> 设置代理到192.168.234.102主机

```bash
server {
    listen       80;
    server_name   hello.com;

    location / {
       proxy_pass http://192.168.234.102:8080;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

# 负载均衡到多台主机

`/etc/nginx/nginx.conf`定义需要负载均衡的机器

```bash
    upstream backend {
        server 192.168.234.102:8080;
        server 192.168.234.103:8080;
        server 192.168.234.104:8080;
    }
```

<details>
  <summary>完整配置</summary>

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

    upstream backend {
        server 192.168.234.102:8080;
        server 192.168.234.103:8080;
        server 192.168.234.104:8080;
    }
}
```
</details>

`/etc/nginx/nginx.d`定义`proxy_pass`上游服务器组。

```bash
server {
    listen       80;
    server_name   hello.com;

    location / {
        proxy_pass http://backend;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}                                                                                                                          
```

这样即使其中的一个服务器挂机了，依然可以通过其他的代理服务器来在正常工作。

# 负载均衡权重weight

`/etc/nginx/nginx.conf`定义需要负载均衡机器的权重`weight`,没有配置权重的机器默认是1。

```bash
upstream backend {
        server 192.168.234.102:8080 weight=8;
        server 192.168.234.103:8080;
        server 192.168.234.104:8080;
    }
```

# 负载均衡down不参与负载均衡

`/etc/nginx/nginx.conf`定义不需要负载均衡机的器添加关键字`down`,该机器不会被访问，就和挂掉了一样。

```bash
upstream backend {
        server 192.168.234.102:8080 weight=8;
        server 192.168.234.103:8080;
        server 192.168.234.104:8080 down;
    }
```

> 只用102，103服务器可用

# 负载均衡backup设置备用服务器

`/etc/nginx/nginx.conf`定义备用机添加关键字`backup`,只用当其他负载机器不可用的时候才使用该备用机。

```bash
upstream backend {
        server 192.168.234.102:8080 weight=8;
        server 192.168.234.103:8080 backup;
        server 192.168.234.104:8080 down;
    }
```

> 上面的设置只会访问102，当103挂点的时候才会使用103。

# 其他几种不常用负债均衡配置

## ip_hash

> 根据客户端的ip地址转发同一台服务器，可以保持会话。（现实中客户ip会改变）

## least_conn

> 最少连接访问。给负载的机器连接较少的分配请求。

## url_hash

> 根据用户访问的url定向转发请求。


## fair

> 根据后端服务器的响应时间转发请求。

# 使用正则设置动静分离

`192.168.234.101`nginx服务器设置app1.conf文件。
```bash
server {
    listen       80;
    server_name   hello.com;

    location / {
       proxy_pass http://192.168.234.104:8080;
    }

    location ~*/(js|css|images|webfonts|favicon.ico) {
        root   /data/mi/static;
    }
}
```


在`192.168.234.104`服务器上可以将`js|css|images`全部删除，因为在nginx服务器上已经有缓存了。

> 我不清楚是为什么，`html`文件无法代理，虽然我在location里添加了html还是不可以。

# rewrite实现URL重写

rewrite是实现URL重写的关键指令，根据regex(正则表达式)部分内容，重定向到replacement,结尾是flag标记。

rewrite <regex> <replacement>   [flag];
关键字  正则     替代内容    flag标记

rewrite参数的标签段位置:
server,location,if

flag标记说明:
last    #本条规则匹配完成后，继续向下匹配新的location URI规则
break   #本条规则匹配完成即终止，不再匹配后面的任何规则
redirect #返回302临时重定向，浏览器地址会显示跳转后的URL地址
permanent #返回301永久重定向，浏览器地址栏会显示跳转后的URL地址

实例
```bash
location / {
   rewrite ^/([0-9]+).html$ /index.jsp?pageNum=$1 break;
   proxy_pass http://192.168.234.104:8080;
}
```
> 如果访问 http://xxx/2.html 会转发到后台的 http://xxx/index.jsp?pageNum=2

# 设置被代理服务器的防火墙

```bash
# 开启防火墙
systemctl start firewalld
# 设置被代理服务器的8080端口只能被101访问
firewall-cmd --permanent --add-rich-rule="rule family="ipv4" source address="192.168.234.101" port protocol="tcp" port="8080" accept"
# 生效防火墙规则
firewall-cmd --reload
# 删除规则
firewall-cmd --permanent --remove-rich-rule="rule family="ipv4" source address="192.168.234.101" port protocol="tcp" port="8080" accept"
# 关闭防火墙
systemctl stop firewalld
```        