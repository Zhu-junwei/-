# Debain系统使用

# 安装

[官方手册](https://www.debian.org/releases/stable/amd64/)

使用vm进行安装，安装的时候选择ssh服务，便于远程连接。

# 系统配置

## 设置静态ip

检查ip

```
ip a
```

切换`root`用户编辑`/etc/network/interfaces`文件

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens33
# iface ens33 inet dhcp
iface ens33 inet static
    address 192.168.234.81
    netmask 255.255.255.0
    gateway 192.168.234.2
    dns-nameservers 8.8.8.8
```

重启网络服务

```
systemctl restart networking
```

> 注意：默认情况下debian是不支持root用户远程登录的。

## 开启root远程登录

为了安全考虑，并不建议这样做。

编辑`/etc/ssh/sshd_config`文件，找到`PermitRootLogin`选项，将其值设置为`yes`

```
PermitRootLogin yes
```

或者，你也可以选择使用 without-password 来允许仅通过 SSH 密钥进行登录，而不允许使用密码进行登录：

```
PermitRootLogin without-password
```

重启ssh服务

```
systemctl restart sshd
```

## sudo权限

默认情况下，普通用户没有sudo权限，无法执行sudo命令，需要先切换到root用户，安装sudo包，并配置sudoers文件。

安装sudo包:

```
su -
apt install sudo
```

添加普通用户到 sudo 用户组，以便该用户可以使用 sudo 命令：

```
usermod -aG sudo username
```

> 我这里是重启系统后生效的。

## 定义alias

编辑`~/.bash_aliases`文件，添加以下内容：

```
alias vi='vim'
alias ll='ls -lh'
alias grep='grep --color=auto'
```

使其生效：

```
source ~/.bash_aliases
```

# 软件系统更新

换源：
```
# 需要切换root用户
bash <(curl -sSL https://linuxmirrors.cn/main.sh)
```

查看使用的源：

```
cat /etc/apt/sources.list
```

可更新软件列表：

```
sudo apt list --upgradeable
```

更新所有软件：

```
sudo apt upgrade
```

更新指定的软件：

```
sudo apt install package_name
```

清理无用的软件：

```
sudo apt autoremove
```



# 挂载卸载

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

我这里使用的是虚拟机。找到`虚拟机设置` >` 添加硬盘` > `虚拟磁盘类型选择SCSI `> `创建新虚拟磁盘` > `大小设置2G，将虚拟磁盘存储为单文件` > `完成`。

添加完磁盘后重启虚拟机，开机后使用root来完成后续的挂载操作。

## 分区格式化

重启后发现系统已经识别到了磁盘，但是因为新添加的磁盘没有分区，需要先分区并格式化。

**分区**

可用于组织和管理分区的工具不止一种。这里使用的是fdisk，因为系统默认自带了。

 **fdisk**

> fdisk 是一款老而弥坚的工具，可以在任何存储设备上创建和管理分区。但是， fdisk 只能**处理最大 2 TB** 的硬盘。如果大于此容量，则只能使用 gdisk 或 GNU parted 代替。  

 gdisk

 GNU parted

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

**格式化分区**

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

## **挂载磁盘**

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

<file system> <mount point>   <type>  <options>       <dump>  <pass>

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

