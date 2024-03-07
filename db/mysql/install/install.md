# 安装

本教程环境为CentOS7，安装MySQL8.0.23确保系统可以连接互联网。

首先确定系统的[mysql已经卸载干净](../uninstall/uninstall.md)。

1. 下载安装 MySQL Yum 仓库
```bash
wget https://repo.mysql.com/mysql80-community-release-el7-11.noarch.rpm
yum localinstall mysql80-community-release-el7-11.noarch.rpm
```

2. 安装 MySQL 8 社区服务器

```bash
yum install mysql-community-server -y
```

3. 启动 MySQL 服务
```bash
systemctl start mysqld
```
4. 显示 root 用户的默认密码

> 安装 MySQL 8.0 时，会自动为 root 用户生成一个临时密码，并记录在日志文件里。请使用以下命令查看 root 用户的临时密码：

```bash
grep "A temporary password" /var/log/mysqld.log
```
这是输出：

```bash
[Note] A temporary password is generated for root@localhost: Liaka*(Dka&^Kjs
```
请注意，您本地的临时密码是不同的。您要根据此密码来更改 root 用户的密码。

5. MySQL 安全配置

执行以下 `mysql_secure_installation` 命令来保护 MySQL 服务器：

```bash
mysql_secure_installation
```
它会提示您输入 root 帐户的当前密码：
```bash
Enter password for user root:
```
输入上面的临时密码，然后按下回车键。将显示以下消息：

```bash
The existing password for the user account root has expired. Please set a new password.

New password:
Re-enter new password:
```
请输入 root 用户的新密码和确认密码。

配置过程中它会提示配置一些安全选项，为了服务器的安全，应该选择 y。这些问题包括：

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y

删除匿名用户？（按 y|Y 表示是，任何其他键表示否）：y

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y

禁止远程 root 登录？（按 y|Y 表示是，任何其他键表示否）：y

Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y

删除测试数据库并访问它？（按 y|Y 表示是，任何其他键表示否）：y

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y

现在重新加载权限表？（按 y|Y 表示是，任何其他键表示否）：y

6. MySQL 服务控制命令

安装完成后，MySQL 服务就会自动启动。我们可以通过以下几个命令查看 MySQL 服务的状态，启动、停止、重启 MySQL 服务器：

CentOS 8 或 CentOS 7

查看 MySQL 服务器状态： `systemctl status mysqld`

启动 MySQL 服务器： `systemctl start mysqld`

停止 MySQL 服务器： `systemctl stop mysqld`

重启 MySQL 服务器： `systemctl restart mysqld`

配置 MySQL 服务器自启动： `systemctl enable mysqld`

7. 连接到 MySQL 服务器

请使用以下命令连接到 MySQL 服务器：

```bash
mysql -u root -p
```

然后根据提示输入 root 帐户的密码，并按 Enter 键。验证通过后，将显示以下输出代表进入了 MySQL 控制台：

```bash
mysql>
```

使用 `SHOW DATABASES` 显示当前服务器中的所有数据库：

```bash
mysql> show databases;
```

这是输出：

```bash
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.05 sec)
```
上面显示的数据库，是 MySQL 服务器自带数据库。

参考

https://dev.mysql.com/downloads/repo/yum/

https://stackoverflow.com/questions/50379839/connection-java-mysql-public-key-retrieval-is-not-allowed

https://www.sjkjc.com/mysql/install-on-centos/