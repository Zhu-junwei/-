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

| 命 令      | 描 述                                                           |
|----------|---------------------------------------------------------------|
| usermod  | 修改用户账户字段，还可以指定主要组（ primary group）以及辅助组（ secondary group）的所属关系 |
| passwd   | 修改已有用户的密码                                                     |
| chpasswd | 从文件中读取登录名及密码并更新密码                                             |
| chage    | 修改密码的过期                                                       |
| chfn     | 日期修改用户账户的备注信息                                                 |
| chsh     | 修改用户账户的默认登录 shell                                             |

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

​ 锁定用户账户，锁定后用户不能登录系统。

​ 示例：锁定/解锁 `user1` 账户。

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

## 系统版本(登录提示信息)

```bash
/etc/issue
uname -a
```

## 查看磁盘分区信息

```bash
cat /proc/partitions
lsblk
```

## 查看磁盘分区占用挂载情况

```bash
df -Th
```

# 文件系统

## 添加磁盘

系统添加磁盘之前的样子

```
zjw@debian:~$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   40G  0 disk 
├─sda1   8:1    0   39G  0 part /
├─sda2   8:2    0    1K  0 part 
└─sda5   8:5    0  975M  0 part [SWAP]
```

我这里使用的是虚拟机。找到`虚拟机设置` >` 添加硬盘` > `虚拟磁盘类型选择SCSI `> `创建新虚拟磁盘` >
`大小设置2G，将虚拟磁盘存储为单文件` > `完成`。

添加完磁盘后重启虚拟机，开机后使用root来完成后续的挂载操作。

## 分区

重启后发现系统已经识别到了磁盘，但是因为新添加的磁盘没有分区，需要先分区。

**分区**

可用于组织和管理分区的工具不止一种。这里使用的是fdisk，因为系统默认自带了。

 **fdisk**

> 传统上是用于管理 MBR (Master Boot Record) 分区表的工具，适用于老旧的磁盘分区方式。
> MBR最多支持4个主分区（或3个主分区和1个扩展分区），且每个分区最大支持2TB的容量。

 gdisk

> 是用于管理 GPT (GUID Partition Table) 分区表的工具。GPT是现代硬盘（特别是大于2TB的硬盘）
> 常用的分区表方式，支持最多128个主分区，并且没有2TB的限制，支持更大的硬盘和更多的分区。

 GNU parted

### fdisk分区

在 `fdisk` 命令行界面中，你可以按如下步骤操作：

- 输入 `n` 创建新分区。
- 按 `p` 选择主分区类型。
- 输入 `1` 创建第一个分区（如果是第一次使用此磁盘）。
- 默认选择起始和结束位置（直接按 Enter 键）。
- 输入 `w` 保存并退出。

```
zjw@debian:~$ sudo fdisk /dev/sda
[sudo] zjw 的密码：

Welcome to fdisk (util-linux 2.38.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS (MBR) disklabel with disk identifier 0x3a6516e0.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-4194303, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-4194303, default 4194303): 

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

zjw@debian:~$ 
```

再次查看磁盘，可以看到已经分区了。

```
zjw@debian:~$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0    2G  0 disk 
└─sda1   8:1    0    2G  0 part 
sdb      8:16   0   40G  0 disk 
├─sdb1   8:17   0   39G  0 part /
├─sdb2   8:18   0    1K  0 part 
└─sdb5   8:21   0  975M  0 part [SWAP]
```

经过分区后的磁盘可以进行[格式化](#格式化)挂载了，但是可以通过LVM逻辑卷管理来实现动态扩容。

### gdisk分区

如果没有gdisk，可以安装一下。

```
sudo apt-get install gdisk
```

gdisk菜单选项：

```
Command (? for help): ?
b	back up GPT data to a file
c	change a partition's name
d	delete a partition
i	show detailed information on a partition
l	list known partition types
n	add a new partition
o	create a new empty GUID partition table (GPT)
p	print the partition table
q	quit without saving changes
r	recovery and transformation options (experts only)
s	sort partitions
t	change a partition's type code
v	verify disk
w	write table to disk and exit
x	extra functionality (experts only)
?	print this menu
```

在 `gdisk` 命令行界面中，你可以按如下步骤操作分区：

- 输入 `n` 创建新分区。
- 输入分区号，默认是1。
- 选择了默认的起始和结束扇区。
- 选择分区类型，默认8300是Linux文件系统。
- 输入 `w` 写入分区表并退出。
- 输入`Y`选择继续

```
zjw@debian:~$ sudo gdisk /dev/sda
GPT fdisk (gdisk) version 1.0.9

Partition table scan:
  MBR: not present
  BSD: not present
  APM: not present
  GPT: not present

Creating new GPT entries in memory.

Command (? for help): n
Partition number (1-128, default 1): 
First sector (34-20971486, default = 2048) or {+-}size{KMGTP}: 
Last sector (2048-20971486, default = 20969471) or {+-}size{KMGTP}: 
Current type is 8300 (Linux filesystem)
Hex code or GUID (L to show codes, Enter = 8300): 
Changed type of partition to 'Linux filesystem'

Command (? for help): w

Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): Y
OK; writing new GUID partition table (GPT) to /dev/sda.
The operation has completed successfully.
zjw@debian:~$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   10G  0 disk 
└─sda1   8:1    0   10G  0 part 
sdb      8:16   0   20G  0 disk 
sdc      8:32   0   40G  0 disk 
├─sdc1   8:33   0   39G  0 part /
├─sdc2   8:34   0    1K  0 part 
└─sdc5   8:37   0  975M  0 part [SWAP]
```

### 查看磁盘的分区类型

```
zjw@debian:~$ sudo gdisk -l /dev/sdc
GPT fdisk (gdisk) version 1.0.9

Partition table scan:
MBR: MBR only
BSD: not present
APM: not present
GPT: not present
```

## LVM逻辑卷管理

### LVM 的基本概念

> Linux 逻辑卷管理器（ logical volume manager， LVM）可以通过将另一块硬盘上的分区加入已有的文件系统来动态地添加存储空间。
> 它可以让你在无须重建整个 文件系统的情况下，轻松地管理磁盘空间。

LVM 将存储设备（磁盘或磁盘分区）抽象为三个主要的组件：

- 物理卷（Physical Volume，PV）：

> 物理卷是 LVM 中的基本存储单元，通常是磁盘或磁盘分区。一个物理卷可以是整个磁盘、磁盘的一部分或者多个磁盘的组合。
> 物理卷是 LVM 系统中的底层存储资源。

- 卷组（Volume Group，VG）：

> 卷组由一个或多个物理卷组成，是管理物理卷的逻辑容器。卷组提供了一个统一的存储池，供逻辑卷使用。
> 每个卷组可以跨多个磁盘，因此它扩展性更强，能够动态地增加存储容量。

- 逻辑卷（Logical Volume，LV）：

> 逻辑卷是 LVM 中实际使用的存储单位。它是通过从卷组中分配空间创建的，并且可以用作普通的文件系统挂载点。
> 逻辑卷可以动态调整大小，这意味着可以在需要时增加或减少磁盘空间。

### 创建逻辑卷步骤

首次设置逻辑卷的步骤如下:

(1) 创建物理卷。

(2) 创建卷组。

(3) 创建逻辑卷。

(4) 格式化逻辑卷。

(5) 挂载逻辑卷。

这里采用gdisk来进行分区，因为他可以创建大于2TB的分区。

### 物理卷PV

创建物理卷使用`pvcreate`命令。

将磁盘分区`/dev/sda1`，`/dev/sdb1`作为物理卷PV:

```
sudo pvcreate /dev/sda1 /dev/sdb1
```

```
zjw@debian:~$ sudo pvcreate /dev/sda1 /dev/sdb1
WARNING: gpt signature detected on /dev/sdb1 at offset 512. Wipe it? [y/n]: y
  Wiping gpt signature on /dev/sdb1.
WARNING: gpt signature detected on /dev/sdb1 at offset 21472738816. Wipe it? [y/n]: y
  Wiping gpt signature on /dev/sdb1.
WARNING: PMBR signature detected on /dev/sdb1 at offset 510. Wipe it? [y/n]: y
  Wiping PMBR signature on /dev/sdb1.
  Physical volume "/dev/sda1" successfully created.
  Physical volume "/dev/sdb1" successfully created.
```

> 中间提示存在分区别签名，需要确认是否擦除，选择y。

查看创建的物理卷：

```
sudo pvs
# 或者
sudo pvdisplay
```

```
zjw@debian:~$ sudo pvs
  PV         VG Fmt  Attr PSize   PFree  
  /dev/sda1     lvm2 ---  <10.00g <10.00g
  /dev/sdb1     lvm2 ---  <20.00g <20.00g
zjw@debian:~$ sudo pvdisplay
  "/dev/sda1" is a new physical volume of "<10.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sda1
  VG Name               
  PV Size               <10.00 GiB
  Allocatable           NO
  PE Size               0   
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               sPnUyG-Shs6-Qkxf-toOq-gZfk-5MFF-zKW1cl
   
  "/dev/sdb1" is a new physical volume of "<20.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb1
  VG Name               
  PV Size               <20.00 GiB
  Allocatable           NO
  PE Size               0   
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               iqphie-n0ul-TE8D-TrYh-Q5Ky-KDYq-WbF2uH
```

### 卷组VG

#### 创建卷组

创建卷组使用`vgcreate`命令。

将物理卷`/dev/sda1`和`/dev/sdb1`作为卷组`vg1`:

```
sudo vgcreate vg1 /dev/sda1 /dev/sdb1
```

<details>
  <summary>展开创建过程</summary>
  <pre><code>
zjw@debian:~$ sudo vgcreate vg1 /dev/sda1 /dev/sdb1
  Volume group "vg1" successfully created
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize  VFree 
  vg1   2   0   0 wz--n- 29.99g 29.99g
zjw@debian:~$ sudo pvs
  PV         VG  Fmt  Attr PSize   PFree  
  /dev/sda1  vg1 lvm2 a--  <10.00g <10.00g
  /dev/sdb1  vg1 lvm2 a--  <20.00g <20.00g
zjw@debian:~$ sudo vgdisplay
  --- Volume group ---
  VG Name               vg1
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               29.99 GiB
  PE Size               4.00 MiB
  Total PE              7678
  Alloc PE / Size       0 / 0   
  Free  PE / Size       7678 / 29.99 GiB
  VG UUID               YHxJUu-64Kr-0tiT-gcn8-9UPQ-Sj5d-Jj23Bc
  </code></pre>
</details>

#### 删除卷组中的物理卷

如果需要删除卷组中的物理卷，可以使用`vgreduce`命令。

将物理卷`/dev/sda1`从卷组`vg1`中删除：

```
zjw@debian:~$ sudo vgreduce vg1 /dev/sda1
  Removed "/dev/sda1" from volume group "vg1"
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize   VFree  
  vg1   1   0   0 wz--n- <20.00g <20.00g
zjw@debian:~$ sudo pvs
  PV         VG  Fmt  Attr PSize   PFree  
  /dev/sda1      lvm2 ---  <10.00g <10.00g
  /dev/sdb1  vg1 lvm2 a--  <20.00g <20.00g
```

#### 扩容卷组

如果需要扩容卷组，可以使用`vgextend`命令。

将物理卷`/dev/sda1`扩容到卷组`vg1`中：

```
zjw@debian:~$ sudo vgextend vg1 /dev/sda1
  Volume group "vg1" successfully extended
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize  VFree 
  vg1   2   0   0 wz--n- 29.99g 29.99g
zjw@debian:~$ sudo pvs
  PV         VG  Fmt  Attr PSize   PFree  
  /dev/sda1  vg1 lvm2 a--  <10.00g <10.00g
  /dev/sdb1  vg1 lvm2 a--  <20.00g <20.00g
```

### 逻辑卷LV

#### 创建逻辑卷

可以使用 `lvcreate` 命令创建 LV。 LV 的大小由-L 选项设置，使用的空间取自指定的 VG 存储池：

```
# 创建一个逻辑卷，大小为 10G，属于卷组 vg1
sudo lvcreate -L 10G vg1
# 也可以使用-n来指定逻辑卷的名字
sudo lvcreate -L 10G -n lv1 vg1
```

```
zjw@debian:~$ sudo pvs
  PV         VG  Fmt  Attr PSize   PFree  
  /dev/sda1  vg1 lvm2 a--  <10.00g <10.00g
  /dev/sdb1  vg1 lvm2 a--  <20.00g <20.00g
zjw@debian:~$ sudo lvcreate -L 10G -n lv1 vg1
  Logical volume "lv1" created.
zjw@debian:~$ sudo lvs
  LV   VG  Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv1  vg1 -wi-a----- 10.00g                                                    
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize  VFree 
  vg1   2   1   0 wz--n- 29.99g 19.99g
zjw@debian:~$ 
```

#### 扩容逻辑卷

可以使用 `lvextend` 命令扩容 LV。 扩容后的大小由-L 选项设置：

```
# 为逻辑卷 lv1 从卷组 vg1 中扩容 10G
sudo lvextend -L +10G /dev/vg1/lv1
# 为逻辑卷 lv1 从卷组 vg1 中扩容 100%的可用空间
sudo lvextend -l +100%FREE /dev/vg1/lv1
```

```
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize  VFree 
  vg1   2   1   0 wz--n- 29.99g 19.99g
zjw@debian:~$ sudo lvs
  LV   VG  Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv1  vg1 -wi-a----- 10.00g    

zjw@debian:~$ sudo lvextend -L +10G /dev/vg1/lv1
Size of logical volume vg1/lv1 changed from 10.00 GiB (2560 extents) to 20.00 GiB (5120 extents).
Logical volume vg1/lv1 successfully resized.
zjw@debian:~$ sudo lvs
LV   VG  Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
lv1  vg1 -wi-a----- 20.00g                                                    
zjw@debian:~$ sudo vgs
VG  #PV #LV #SN Attr   VSize  VFree
vg1   2   1   0 wz--n- 29.99g 9.99g

zjw@debian:~$ sudo lvextend -l +100%FREE /dev/vg1/lv1
Size of logical volume vg1/lv1 changed from 20.00 GiB (5120 extents) to 29.99 GiB (7678 extents).
Logical volume vg1/lv1 successfully resized.
zjw@debian:~$ sudo lvs
LV   VG  Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
lv1  vg1 -wi-a----- 29.99g                                                    
zjw@debian:~$ sudo vgs
VG  #PV #LV #SN Attr   VSize  VFree
vg1   2   1   0 wz--n- 29.99g    0
```

如果逻辑卷已经挂载了，可以通过`resize2fs`命令来调整文件系统的大小：
```
sudo resize2fs /dev/vg1/lv1
```


#### 缩容逻辑卷
 ⚠️ `lvreduce` 命令用于 减少逻辑卷（LV） 的大小。这个命令可以用于释放磁盘空间，但必须小心使用，
因为减少逻辑卷的大小可能会导致数据丢失。如果你没有正确备份数据或没有提前调整文件系统大小，
可能会出现不可恢复的数据丢失。

```
# 为逻辑卷 lv1 从卷组 vg1 中缩容 10G
sudo lvreduce -L -10G /dev/vg1/lv1
```
```
zjw@debian:~$ 
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize  VFree
  vg1   2   1   0 wz--n- 29.99g    0 
zjw@debian:~$ sudo lvreduce -L -10G /dev/vg1/lv1
  WARNING: Reducing active logical volume to 19.99 GiB.
  THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce vg1/lv1? [y/n]: y
  Size of logical volume vg1/lv1 changed from 29.99 GiB (7678 extents) to 19.99 GiB (5118 extents).
  Logical volume vg1/lv1 successfully resized.
zjw@debian:~$ sudo vgs
  VG  #PV #LV #SN Attr   VSize  VFree 
  vg1   2   1   0 wz--n- 29.99g 10.00g
```

## 格式化

接下来，格式化刚刚创建的分区为 `ext4` 文件系统。使用以下命令格式化：

```
sudo mkfs.ext4 /dev/sda1
```

```
zjw@debian:~$ sudo mkfs.ext4 /dev/sda1
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 524032 4k blocks and 131072 inodes
Filesystem UUID: af9d4fe0-b4aa-4dbc-a0a6-1d52458654b1
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done 
```

## 挂载磁盘

**创建挂载点**

创建一个目录作为挂载点。例如，我们可以将新磁盘挂载到 `/mnt/data`：

```
sudo mkdir /mnt/data
```

**挂载**

现在，将新分区使用`mount`命令挂载到刚刚创建的目录 `/mnt/data`：

```
sudo mount /dev/sda1 /mnt/data
```

**检查挂载情况**

使用以下命令确认磁盘是否成功挂载：

```
df -h
```

可以看到已经被成功挂载到了/mnt/data

```
zjw@debian:~$ sudo mkdir /mnt/data
zjw@debian:~$ sudo mount /dev/sda1 /mnt/data
zjw@debian:~$ df -h
文件系统        大小  已用  可用 已用% 挂载点
udev            944M     0  944M    0% /dev
tmpfs           194M  748K  193M    1% /run
/dev/sdb1        39G  1.4G   35G    4% /
tmpfs           967M     0  967M    0% /dev/shm
tmpfs           5.0M     0  5.0M    0% /run/lock
tmpfs           194M     0  194M    0% /run/user/1000
/dev/sda1       2.0G   24K  1.9G    1% /mnt/data
```

**设置自动挂载（可选）**

查询新挂载磁盘`sda1`的`UUID`。

```
zjw@debian:/mnt$ sudo blkid
/dev/sdb5: UUID="63caacd2-f9b6-4199-b214-ba4cac16ed3d" TYPE="swap" PARTUUID="8d932b58-05"
/dev/sdb1: UUID="ca3d7186-33c9-46f3-8445-2814fd0d0654" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="8d932b58-01"
/dev/sda1: UUID="af9d4fe0-b4aa-4dbc-a0a6-1d52458654b1" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="3a6516e0-01"
```

这里可以看到`sda1`的`UUDI`是`af9d4fe0-b4aa-4dbc-a0a6-1d52458654b1`。

如果希望在每次系统重启时，磁盘能够自动挂载，你需要编辑 `/etc/fstab` 文件：

```
sudo vim /etc/fstab
```

在文件末尾添加以下内容：

```
UUID=af9d4fe0-b4aa-4dbc-a0a6-1d52458654b1    /mnt/data    ext4    defaults    0    2
```

参数分别代表：

```
<file system> <mount point>   <type>  <options>       <dump>  <pass>
```

**使用UUID是为了防止重启系统后磁盘名称发生变化。**

为了测试自动挂载是否有效，可以重新启动虚拟机，然后检查是否能自动挂载。

## 卸载磁盘

**取消自动挂载（如果有设置）**

参考上文**设置自动挂载**部分。

**卸载**

使用`lsblk`或`df -h`检查当前挂载点

```
zjw@debian:/mnt$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0    2G  0 disk 
└─sda1   8:1    0    2G  0 part /mnt/data
sdb      8:16   0   40G  0 disk 
├─sdb1   8:17   0   39G  0 part /
├─sdb2   8:18   0    1K  0 part 
└─sdb5   8:21   0  975M  0 part [SWAP]
zjw@debian:/mnt$ df -h
文件系统        大小  已用  可用 已用% 挂载点
udev            944M     0  944M    0% /dev
tmpfs           194M  752K  193M    1% /run
/dev/sdb1        39G  1.4G   35G    4% /
tmpfs           967M     0  967M    0% /dev/shm
tmpfs           5.0M     0  5.0M    0% /run/lock
tmpfs           194M     0  194M    0% /run/user/1000
/dev/sda1       2.0G   24K  1.9G    1% /mnt/data
```

可以看到**sda1**挂载到了`/mnt/data`，下面使用`umount`进行卸载：

```
sudo umount /mnt/data
```

`lsblk`检查是否已经卸载：

```
zjw@debian:/mnt$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0    2G  0 disk 
└─sda1   8:1    0    2G  0 part 
sdb      8:16   0   40G  0 disk 
├─sdb1   8:17   0   39G  0 part /
├─sdb2   8:18   0    1K  0 part 
└─sdb5   8:21   0  975M  0 part [SWAP]
```

