# 简介

> [MinIO][] 是AI数据基础设施的对象存储。

# 安装

> 前往[MinIO官网][]下载适用于Linux的MinIO服务器。你也可以使用以下命令直接下载最新版本：

```bash
wget https://dl.min.io/server/minio/release/linux-amd64/minio
```

下载完成后，将其安装到/usr/local/bin目录，并确保它是可执行的：

```bash
sudo mv minio /usr/local/bin
sudo chmod +x /usr/local/bin/minio
```

# 配置

## 创建数据存储目录

MinIO需要一个数据目录来存储对象。你可以在适当的位置创建一个目录，例如：
```bash
sudo mkdir /data
```
## 配置环境变量

MinIO可以通过环境变量进行配置。创建一个MinIO环境文件，例如/etc/default/minio：

```bash
sudo vi /etc/default/minio
```

添加以下内容来配置MinIO服务：

```bash
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin
MINIO_VOLUMES=/data
MINIO_OPTS="--console-address :9001"
```

注意

- `MINIO_ROOT_USER`和`MINIO_ROOT_PASSWORD`为用于访问MinIO的用户名和密码，密码长度至少8位。
- `MINIO_VOLUMES`用于指定数据存储路径，需确保指定的路径是存在的，可执行以下命令创建该路径。
- `MINIO_OPTS`中的console-address,用于指定管理页面的地址。

## 配置MinIO为系统服务

创建一个systemd服务文件，例如/etc/systemd/system/minio.service：
```bash
sudo vi /etc/systemd/system/minio.service
```
添加以下内容：
```bash
[Unit]
Description=MinIO
Documentation=https://min.io/docs/minio/linux/index.html
Wants=network-online.target
After=network-online.target
AssertFileIsExecutable=/usr/local/bin/minio

[Service]
WorkingDirectory=/usr/local
ProtectProc=invisible
EnvironmentFile=-/etc/default/minio
ExecStartPre=/bin/bash -c "if [ -z \"${MINIO_VOLUMES}\" ]; then echo \"Variable MINIO_VOLUMES not set in /etc/default/minio\"; exit 1; fi"
ExecStart=/usr/local/bin/minio server $MINIO_OPTS $MINIO_VOLUMES
Restart=on
LimitNOFILE=65536
TasksMax=infinity
TimeoutStopSec=infinity
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
```

重点关注上述文件中的以下内容即可

- `EnvironmentFile`，该文件中可配置MinIO服务所需的各项参数
- `ExecStart`，该参数用于配置MinIO服务的启动命令，其中$MINIO_OPTS、$MINIO_VOLUMES，均引用于EnvironmentFile中的变量。
- `MINIO_OPTS`用于配置MinIO服务的启动选项，可省略不配置。
- `MINIO_VOLUMES`用于配置MinIO服务的数据存储路径。
- `Restart`，表示自动重启

# 启动与停止

```bash
# 查看状态
systemctl status minio
# 开启
systemctl start minio
# 停止
systemctl stop minio
# 开机自启
systemctl enable minio
```

# 卸载

> **删除前请仔细检查**

```bash
systemctl stop minio
yum remove minio
rm -rf /usr/local/bin/minio
rm -rf /etc/default/minio
rm -rf /etc/systemd/system/minio.service
rm -rf /data/minio
```

[MinIO]: https://min.io/

[MinIO官网]: https://min.io/download?license=agpl&platform=linux