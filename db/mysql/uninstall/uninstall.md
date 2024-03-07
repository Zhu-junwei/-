# 卸载
彻底卸载 MySQL 包括删除软件包、清理配置文件、删除数据目录等步骤。以下是在 CentOS 7 上彻底卸载 MySQL 的步骤：

停止 MySQL 服务：
```bash
sudo systemctl stop mysqld
```
移除 MySQL 软件包：

使用 yum 移除 MySQL 软件包：
```bash
sudo yum remove mysql-community-server -y
```
删除 MySQL 相关的数据目录：
```bash
sudo rm -rf /var/lib/mysql
```
删除 MySQL 配置文件：
```bash
sudo rm -rf /etc/my.cnf
```

确认是否有剩余文件：
```bash
ls /etc/ | grep mysql
```
如果还有残留的 MySQL 配置文件，请手动删除。

删除 MySQL 的日志文件：
```bash
sudo rm -rf /var/log/mysqld.log
```
卸载 MySQL 依赖的包（可选）：
```bash
sudo yum autoremove -y
```
清理系统缓存：
```bash
sudo yum clean all
```
更新系统缓存：
```bash
sudo yum makecache
```
重启系统：
```bash
sudo reboot
```