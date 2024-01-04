# ����Զ�̷���

��¼�� MySQL ����̨
```bash
mysql -u root -p
```

�鿴�Ƿ����Զ�̵�¼���û�
```mysql
SELECT user,host FROM mysql.user;
```
> `localhost`Ϊ���ص�¼��`%`Ϊ����������¼��

�޸Ļ򴴽�Զ�̵�¼�û�������

```mysql
-- ����Զ�� root �û����滻 'password' Ϊ��ϣ�����õ�����
CREATE USER 'root'@'%' IDENTIFIED BY 'password';

-- �޸�Զ�� root �û����滻 'password' Ϊ��ϣ�����õ�����
ALTER USER 'root'@'%' IDENTIFIED BY 'password';
```
MySQL 8 �е�Ĭ��[�������](../password/password.md)����

- ���볤�ȣ� ������������� 8 ���ַ���
- �������֡���Сд��ĸ�������ַ��� �������������֡���д��ĸ��Сд��ĸ�������ַ���

ΪԶ�̵�¼�û���Ȩ
```mysql
-- ���� root �û�����Ȩ�ޣ��滻 'password' Ϊ��ϣ�����õ�����
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```

```mysql
-- ˢ��Ȩ��
FLUSH PRIVILEGES;

-- �˳� MySQL ����̨
EXIT;
```
> �޸��������Ȩ�޺���º��˳�


�˳���¼������mysql����
```bash
systemctl restart mysqld
```