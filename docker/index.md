# Docker安装与卸载

## Docker 卸载

停止并删除所有运行中的容器
```bash
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
```

删除所有镜像
```bash
sudo docker rmi $(sudo docker images -q)
```

禁用docker的开机自启

> 如果设置了开机自启
```bash
sudo systemctl disable docker
```
> 可以通过`systemctl status docker`命令查看是否开启了docker的自启动。如果loaded是enabled代表是开机自启，否则没有设置开启自启。

停止Docker服务
```bash
# 关闭docker.socket
sudo systemctl stop docker.socket
# 关闭docker
sudo systemctl stop docker
```

卸载Docker软件包
```bash
sudo yum remove docker-ce docker-ce-cli containerd.io -y
```

删除Docker数据和配置
```bash
sudo rm -rf /var/lib/docker
```

删除Docker存储库
```bash
sudo yum remove docker-ce docker-ce-cli containerd.io \
                    docker-buildx-plugin.x86_64 \
                    docker-compose-plugin.x86_64 -y
```

清理yum缓存
```bash
sudo yum clean all
```

检查并删除可能存在的其他Docker组件
```bash
sudo yum list installed | grep docker
```
如果有的话使用如下命令进行删除
```bash
sudo yum remove xxx
```


## Docker安装

安装依赖包
```bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

添加Docker存储库

> 二选一
```bash
# docker官网
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 阿里云
sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

安装Docker引擎
```bash
sudo yum install docker-ce docker-ce-cli containerd.io -y
```

启动Docker服务
```bash
sudo systemctl start docker
```

设置Docker服务随系统启动
```bash
sudo systemctl enable docker
```

验证安装
```bash
sudo docker --version
```

显示结果
```
[root@Redis ~]# sudo docker --version
Docker version 24.0.7, build afdd53b
```

（可选）将用户添加到docker组（避免使用sudo）
```bash
sudo usermod -aG docker your_username
```
请将your_username替换为你的实际用户名。然后，注销并重新登录以应用更改。
