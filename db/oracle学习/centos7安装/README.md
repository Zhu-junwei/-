# centos7安装oracle21c

https://www.bilibili.com/video/BV1pN4y1F7LK

## 系统环境

- 数据库版本：oracle21c
- 操作系统：centos7.6
- 硬盘：60G
- 内存：2G

## 前置准备

### 修改Linux内核

> vim /etc/sysctl.conf

```bazaar
kernel.sem = 250 32000 100 128
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
fs.file-max = 6815744
```

立即生效

> sysctl -p

`kernel.sem`
这个参数用于设置 Linux 内核中的 System V IPC 机制的信号量（semaphore）参数。
具体的值分别表示：信号量数组的大小、每个信号量集的大小、系统中的最大信号量集数、每个信号量的最大值。

`net.core.rmem_default`
这个参数设置了套接字接收缓冲区的默认大小（以字节为单位）。

`net.core.rmem_max`
这个参数设置了套接字接收缓冲区的最大大小（以字节为单位）。

`net.core.wmem_default`
这个参数设置了套接字发送缓冲区的默认大小（以字节为单位）。

`net.core.wmem_max`
这个参数设置了套接字发送缓冲区的最大大小（以字节为单位）。

`fs.file-max`
这个参数设置了系统中文件句柄的最大数量。文件句柄用于标识系统中的文件和套接字等资源。

### 安装依赖

```bash
yum install -y glibc-devel ksh xauth libXrender libXtst xorg-x11-utils
```

## 下载安装包

https://www.oracle.com/database/technologies/oracle-database-software-downloads.html

LINUX.X64_213000_db_home.zip

## 上传

创建用户名和用户组

```bash
groupadd oinstall
useradd -g oinstall oracle
```

创建目录

```bash
mkdir /usr/local/oracle
chown -R oracle:oinstall /usr/local/oracle
mkdir /usr/local/oracle/home
chown -R oracle:oinstall /usr/local/oracle/home
```

上传安装包`LINUX.X64_213000_db_home.zip`到/usr/local/oracle/home

指定用户名和用户组

```bash
chown -R oracle:oinstall /usr/local/oracle/home
```

## 环境变量

切换oracle用户

```bash
su - oracle
```

创建目录

```bash
mkdir /usr/local/oracle/base
mkdir /usr/local/oracle/oraInventory
```

编辑~/.bashrc文件

```bash
vim ~/.bashrc
```

添加以下内容

```bash
export DISPLAY=192.168.234.1:0.0
export ORACLE_BASE=/usr/local/oracle/base
export ORACLE_HOME=/usr/local/oracle/home
export INVENTORY_LOCATION=/usr/local/oracle/oraInventory
export TNS_ADMIN=$ORACLE_HOME/network/admin
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"
export PATH=$ORACLE_HOME/bin:$PATH
```

立即生效

```bash
source ~/.bashrc
```

查看PATH环境变量

```bash
echo $PATH
```

## 安装

解压安装包

```bash
cd $ORACLE_HOME
unzip LINUX.X64_213000_db_home.zip
rm -f LINUX.X64_213000_db_home.zip
./runInstaller
```

## 数据库配置助手

dbca (Database Configuration Assistant)命令是Oracle数据库的配置工具,
它可以用来创建和配置数据库实例、数据库、数据库用户、数据库角色、数据库表空间、
数据库控制文件、数据库参数文件、数据库网络配置、数据库备份、数据库恢复、
数据库连接、数据库监控、数据库审计、数据库加密等。

启动DBCA，安装数据库实例

```
su - oracle
dbca
```
orclpbd

## 网络配置助手

```
su - oracle
netca
```
配置监听
