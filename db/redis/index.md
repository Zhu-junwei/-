# 安装

**首先确保系统已经安装了docker**

拉取镜像
```bash
docker pull redis
```

准备目录
```bash
# redis文件配置目录
mkdir -p /data/redis/conf
# 持久化文件存放目录
mkdir -p /data/redis/data
```

编写配置文件
```bash
# 在redis容器中使用该文件

# 默认端口6379
# 在redis容器中使用该文件

# 默认端口6379
port 6379

# 密码,默认没有密码
requirepass redis@123

# 数据持久化
appendonly yes

# 设置日志位置，默认 /dev/null
# logfile /usr/local/log/redis.log
```

redis启动命令
```bash
#redis使用自定义配置文件启动
docker run -v /data/redis/conf/redis.conf:/etc/redis/redis.conf \
-v /data/redis/data:/data \
-d --name redis \
-p 6379:6379 \
--restart=always \
redis:latest  redis-server /etc/redis/redis.conf
```
> 可以在这个命令保存在家目录下面redis.txt，方面下次创建容器的时候使用。

启动完成后查看运行情况
```bash
docker ps -a
```
因为启动命令设置了开机自启`--restart=always`，所以下次当docker重启的时候，redis也会自动启动。

# 卸载

因为我们使用的是docker创建的，所以只需要删除容器可镜像即可。这部分可参考docker对容器和镜像的管理命令处理。

停止删除redis容器
```bash
docker stop redis
docker rm redis
```
删除redis镜像
```bash
docker rmi redis
```

删除redis配置文件（可选）
> 根据具体情况选择，如果有配置文件可以选择删除。
```bash
rm -rf /data/redis/
```