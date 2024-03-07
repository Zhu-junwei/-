# 设置远程访问

登录到 MySQL 控制台
```bash
mysql -u root -p
```

查看是否存在远程登录的用户
```mysql
SELECT user,host FROM mysql.user;
```
> `localhost`为本地登录，`%`为任意主机登录。

修改或创建远程登录用户的密码

```mysql
-- 创建远程 root 用户，替换 'password' 为你希望设置的密码
CREATE USER 'root'@'%' IDENTIFIED BY 'password';

-- 修改远程 root 用户，替换 'password' 为你希望设置的密码
ALTER USER 'root'@'%' IDENTIFIED BY 'password';
```
MySQL 8 中的默认[密码策略](../password/password.md)规则：

- 密码长度： 密码必须至少有 8 个字符。
- 包含数字、大小写字母和特殊字符： 密码必须包含数字、大写字母、小写字母和特殊字符。

为远程登录用户授权
```mysql
-- 授予 root 用户所有权限，替换 'password' 为你希望设置的密码
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```

```mysql
-- 刷新权限
FLUSH PRIVILEGES;

-- 退出 MySQL 控制台
EXIT;
```
> 修改完密码或权限后更新后退出


退出登录后重启mysql服务
```bash
systemctl restart mysqld
```