[TOC]
# 基础命令

## locale

```shell
# 查看语系
locale
# 查询支持的语系
locale -a

```

```shell
# 修改语系
LANG=en_US.utf8
# 设置所有语言环境 英文
export LC_ALL=en_US.utf8
# 设置所有语言环境 中文
export LC_ALL=zh_CN.utf8
```
> 系统永久生效可以修改`/etc/locale.conf`文件

## date 日期

```shell
date
# 年-月-日
date +%Y-%m-%d
date +%F
# 时:分:秒
date +%H:%M:%S
date +%T
# 年-月-日 时:分:秒
date "+%Y-%m-%d %H:%M:%S"
date +'%F %T'
```

## cal 日历

```
cal [month] [year]
cal 
cal 2020
cal 3 2020
```

## bc 计算器

```
bc
1+2+3
3-2
2*3
3/2
5%2
2^3
quit
#设置小数点
scale=3
```

`tab` 键提示

`Ctrl+C` 停止当前运行的程序

`Ctrl+D` 键盘输入结束,不会用

`Shift+↑/↓` 上下行翻动屏幕

`Shift+PagUp/PagDn` 上下页翻动屏幕

--help求助说明

```
date --help
```

## man page

```
man date
```

`空格` 向下翻页

`q` 离开

`/` 向下搜索关键词

`?` 向上搜索关键词

`n` :继续下一个搜索 ,`N` :继续上一个搜索

`Home` 第一页

`End` 最后一页

man page所在路径

```
/usr/share/man/
```

查看`man`指令有关的说明文件

```
#man -f man
#whatis man
man (1)              - an interface to the on-line reference manuals
man (1p)             - display system documentation
man (7)              - macros to format man pages
```

查看指定的说明文件

```
man 1 man
man 7 man
```

默认打开的说明文件顺序

```
/etc/man_db.conf
```

关键词查找

```shell
#查找含有man关键词的说明文件
man -k man

apropos man
```

`man -f man` = `whatis man`

`man -k man` = `apropos man`

使用上述两个命令的时候必须要建立whatis数据库

```shell
mandb
```



## info page

info指令的文件存放位置

```shell
/usr/share/info/
```

info gcc

`h` 帮助快捷键

`x` 退出帮助

`q` 退出info

`n` 下一个结点

`p` 前一个结点

`t` 头结点



## 正确关机

- 观察系统使用状态

`who` 谁在线

`netstat -a` 网络状态

`ps -aux` 查看背景执行的程序

- 通知在线使用者关机的时刻

- 关机

`sync` 将数据同步写入硬盘中的指令

`shutdown` 惯用的关机

`reboot` `halt` `poweroff` 重启,关机



## su 切换身份

```
#su -

#logout 或 exit
```



## shutdown

```
#shutdown [-krhc] [时间] [警告讯息]

-k 只是警告
-r 重启
-h 关机
-c 取消关机

#shutdown -h 10 '10分钟后关机'
#shutdown -h now
#shutdown -h 20:18
#shutdown -r now

重启
#sync;sync;sync;reboot
关机
#halt
#poweroff

#systemctl reboot
#systemctl poweroff
```

## 查看文件时间
```shell
#查看文件的时间
#mtime 默认文件内容修改时间 ll bashrc
#ctime 文件属性修改时间
#atime 文件最近访问时间
date;ll .bashrc ;ll --time=ctime .bashrc ;ll --time=atime .bashrc
```

```
zjw@debian:~$ date;ll .bashrc ;ll --time=ctime .bashrc ;ll --time=atime .bashrc 
2025年 01月 08日 星期三 11:25:55 CST
-rw-r--r-- 1 zjw zjw 3.5K 12月25日 12:34 .bashrc
-rw-r--r-- 1 zjw zjw 3.5K 12月25日 12:34 .bashrc
-rw-r--r-- 1 zjw zjw 3.5K  1月 7日 19:37 .bashrc
```

```shell
#stat 文件名 查看文件时间戳
stat bashrc
```

```
zjw@debian:~$ stat .bashrc
  文件：.bashrc
  大小：3526      	块：8          IO 块大小：4096   普通文件
设备：8,17	Inode: 392453      硬链接：1
权限：(0644/-rw-r--r--)  Uid: ( 1000/     zjw)   Gid: ( 1000/     zjw)
访问时间：2025-01-07 19:37:49.615999943 +0800
修改时间：2024-12-25 12:34:40.602643033 +0800
变更时间：2024-12-25 12:34:40.602643033 +0800
创建时间：2024-12-25 12:34:40.602643033 +0800
```

## touch

创建空文件
```shell
touch test
```

创建指定时间戳的文件
```shell
touch -t 202501081127.33 test
stat test
```

```
zjw@debian:~/shell$ touch -t 202501081127.33 test
zjw@debian:~/shell$ stat test 
  文件：test
  大小：0         	块：0          IO 块大小：4096   普通空文件
设备：8,17	Inode: 392463      硬链接：1
权限：(0644/-rw-r--r--)  Uid: ( 1000/     zjw)   Gid: ( 1000/     zjw)
访问时间：2025-01-08 11:27:33.000000000 +0800
修改时间：2025-01-08 11:27:33.000000000 +0800
变更时间：2025-01-08 11:28:01.176269207 +0800
创建时间：2025-01-08 11:28:01.176269207 +0800
```

## yum

`yum` 是用于在基于 RPM（Red Hat Package Manager）的 Linux 发行版上管理软件包的包管理器。以下是一些常用的 yum 命令：

安装软件包
```bash
yum install package_name
```

更新软件包
> 用于更新系统上已安装的所有软件包，包括操作系统的核心组件和其他已安装的软件包。
```bash
yum update
```

升级特定软件包
```bash
yum update package_name
```

查找软件包信息
```bash
yum info package_name
```

列出所有已安装的软件包
```bash
yum list installed
```

搜索可用软件包
```bash
yum search keyword
```

删除软件包
```bash
yum remove package_name
```

清理缓存
```bash
yum clean all
```

显示软件包组信息
```bash
yum grouplist
```

安装软件包组
```bash
yum groupinstall group_name
```

删除软件包组
```bash
yum groupremove group_name
```

检查可用更新
```bash
yum check-update
```

查看软件包提供哪些文件
```bash
yum provides file_path
```

## curl

显示html信息
```bash
curl www.baidu.com
```

显示请求返回的头部信息
```bash
curl -I www.baidu.com
```

请求的时候加上Referer头部信息
```bash
curl -e www.google.com -I www.baidu.com
```

# 权限管理

## 用户文件和密码文件

- `/etc/passwd`存放了系统中的所有用户信息
- `/etc/shadow`存放了系统用户相关的信息

## 用户管理

### 添加用户

**创建一个用户**

```shell
# 添加一个名叫test的用户，并且-m选项表示为test用户创建home目录
sudo useradd -m test
```

**检查用户是否存在**

```shell
# 查看是否创建
cat /etc/passwd
# 查看家目录是否存在
ls -l /home
```

### 删除用户
```shell
# 删除test用户，包括home目录和用户邮箱
sudo userdel -r test
```

### 修改用户

| 命 令    | 描 述                                                        |
| -------- | ------------------------------------------------------------ |
| usermod  | 修改用户账户字段，还可以指定主要组（ primary group）以及辅助组（ secondary group）的所属关系 |
| passwd   | 修改已有用户的密码                                           |
| chpasswd | 从文件中读取登录名及密码并更新密码                           |
| chage    | 修改密码的过期                                               |
| chfn     | 日期修改用户账户的备注信息                                   |
| chsh     | 修改用户账户的默认登录 shell                                 |

#### usermod

`usermod` 命令用于修改现有用户的账户设置。它可以修改多个用户属性，如用户名、用户ID（UID）、组ID（GID）、家目录、登录Shell、用户的附加组等。

`usermod` 命令的基本语法：

```bash
sudo usermod [选项] 用户名
```

- `-l`：修改用户名

  用于修改用户的用户名。

  示例：将用户名 `olduser` 修改为 `newuser`

```bash
sudo usermod -l newuser olduser
```

- `-aG`：将用户添加到附加组

  用于将用户添加到一个或多个附加组。使用时需要小心，因为如果没有指定 `-a` 选项，`usermod` 会将用户从其他组中移除。

  示例：将 `user1` 添加到 `group1` 和 `group2` 组中。

  ```
  sudo usermod -aG group1,group2 user1
  ```

- `-L`：锁定用户账户
- `-U`：解锁用户账户

​	锁定用户账户，锁定后用户不能登录系统。

​	示例：锁定/解锁 `user1` 账户。

```bash
sudo usermod -L user1
sudo usermod -U user1
```

#### passwd

修改用户密码，默认只能修改自己的密码，root用户可以修改所有人的密码。

```bash
# 修改user1用户的密码
passwd user1
```

## 组管理

### 查看组信息

```bash
# 查看系统中的组
cat /etc/group
# 查看用户的组信息
id 用户名
groups 用户名
```

### 添加一个组

```bash
# 添加一个名叫shared
sudo groupadd shared
```

### 将用户添加到某个组

```bash
# 使用usermod添加，将用户添加到shared组中
sudo usermod -aG shared test

# 使用gpasswd添加用户到shared组中
sudo gpasswd -a test shared
```

注意两者的参数顺序。

### 将用户从某个组中删除

```bash
# 将用户从shared组中删除
sudo gpasswd -d test shared
```





## 改变文件的所属用户

```shell
# 改变某个文件的所有者
chown 用户 文件名
# 改变某个文件的所有者和组
chown 用户:组 文件名
# 递归改变文件夹下所有文件的所属用户和组
chown -R 用户:组 目录名
```

# 系统相关

## 查看磁盘物理分区信息

```
cat /proc/partitions
```

## 查看磁盘分区占用情况

```
df -ah
```

## 系统版本(登录信息)

```
/etc/issue
```

## history

查看输入过的命令

```
history
```

清空内存中的命令

```
history -c
```

设置history的条数
```
#设置HISTSIZE的大小
vim /etc/profile
```

重新加载配置文件

```
source /etc/profile
```
