# ��װ

���̳̻���ΪCentOS7����װMySQL8.0.23ȷ��ϵͳ�������ӻ�������

����ȷ��ϵͳ��[mysql�Ѿ�ж�ظɾ�](../uninstall/uninstall.md)��

1. ���ذ�װ MySQL Yum �ֿ�
```bash
wget https://repo.mysql.com/mysql80-community-release-el7-11.noarch.rpm
yum localinstall mysql80-community-release-el7-11.noarch.rpm
```

2. ��װ MySQL 8 ����������

```bash
yum install mysql-community-server -y
```

3. ���� MySQL ����
```bash
systemctl start mysqld
```
4. ��ʾ root �û���Ĭ������

> ��װ MySQL 8.0 ʱ�����Զ�Ϊ root �û�����һ����ʱ���룬����¼����־�ļ����ʹ����������鿴 root �û�����ʱ���룺

```bash
grep "A temporary password" /var/log/mysqld.log
```
���������

```bash
[Note] A temporary password is generated for root@localhost: Liaka*(Dka&^Kjs
```
��ע�⣬�����ص���ʱ�����ǲ�ͬ�ġ���Ҫ���ݴ����������� root �û������롣

5. MySQL ��ȫ����

ִ������ `mysql_secure_installation` ���������� MySQL ��������

```bash
mysql_secure_installation
```
������ʾ������ root �ʻ��ĵ�ǰ���룺
```bash
Enter password for user root:
```
�����������ʱ���룬Ȼ���»س���������ʾ������Ϣ��

```bash
The existing password for the user account root has expired. Please set a new password.

New password:
Re-enter new password:
```
������ root �û����������ȷ�����롣

���ù�����������ʾ����һЩ��ȫѡ�Ϊ�˷������İ�ȫ��Ӧ��ѡ�� y����Щ���������

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y

ɾ�������û������� y|Y ��ʾ�ǣ��κ���������ʾ�񣩣�y

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y

��ֹԶ�� root ��¼������ y|Y ��ʾ�ǣ��κ���������ʾ�񣩣�y

Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y

ɾ���������ݿⲢ������������ y|Y ��ʾ�ǣ��κ���������ʾ�񣩣�y

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y

�������¼���Ȩ�ޱ����� y|Y ��ʾ�ǣ��κ���������ʾ�񣩣�y

6. MySQL �����������

��װ��ɺ�MySQL ����ͻ��Զ����������ǿ���ͨ�����¼�������鿴 MySQL �����״̬��������ֹͣ������ MySQL ��������

CentOS 8 �� CentOS 7

�鿴 MySQL ������״̬�� `systemctl status mysqld`

���� MySQL �������� `systemctl start mysqld`

ֹͣ MySQL �������� `systemctl stop mysqld`

���� MySQL �������� `systemctl restart mysqld`

���� MySQL �������������� `systemctl enable mysqld`

7. ���ӵ� MySQL ������

��ʹ�������������ӵ� MySQL ��������

```bash
mysql -u root -p
```

Ȼ�������ʾ���� root �ʻ������룬���� Enter ������֤ͨ���󣬽���ʾ���������������� MySQL ����̨��

```bash
mysql>
```

ʹ�� `SHOW DATABASES` ��ʾ��ǰ�������е��������ݿ⣺

```bash
mysql> show databases;
```

���������

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
������ʾ�����ݿ⣬�� MySQL �������Դ����ݿ⡣

�ο�

https://dev.mysql.com/downloads/repo/yum/

https://stackoverflow.com/questions/50379839/connection-java-mysql-public-key-retrieval-is-not-allowed

https://www.sjkjc.com/mysql/install-on-centos/