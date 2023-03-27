# samba����������

> ��ʾ����CentOS 7

> Samba��һ�ֿ���Դ���������������Linux��UNIX����Unix����ϵͳ֮�乲���ļ�����ӡ��������������Դ��������Linux��UNIX��������ΪWindows�ͻ��˵��ļ��ʹ�ӡ�����������Լ�Microsoft Windows��������ΪLinux��UNIX�ͻ��˵��ļ��ʹ�ӡ����������

## 1. ��װsamba

### �鿴��װ���
```shell
rpm -qa|grep samba
```
![](./img/20230327_213706.png)

### ���û�а�װ��Ҫ�ֶ���װ
```shell
sudo yum install samba -y
```

### �鿴samba�汾
```shell
# ����һ
smbd --version
# ������
rpm -qi samba
```
![](./img/20230327_214327.png)

## ��������Ŀ¼

���ն˲��� root �û���ݵ�¼��
����һ���µ�Ŀ¼������Ȩ�ޣ�
```shell
mkdir /srv/share && chmod 777 /srv/share
```

## ����ʹ��samba���û�

```shell
useradd -M  -s /sbin/nologin user1
```
`-s`��ʾָ���û����õ�shell���˴�Ϊ`/sbin/nologin`����ʾ�û��������¼ϵͳ��

`-M`��ʾ�������û���Ŀ¼��

## ��ϵͳ�û���ӵ�samba�û��У����������

```shell
smbpasswd -a user1
```
����ѡ������
```
options:
  -a                   add user
  -d                   disable user
  -e                   enable user
  -n                   set no password
  -x                   delete user
```

## ����smb.conf�ļ�
������Ŀ¼��ӵ� Samba �������ļ��У��Ա�������������Է����������Ա༭ /etc/samba/smb.conf �ļ��������ļ��ײ�����������ݣ�
```shell
[global]
    workgroup = WORKGROUP
    server string = Samba Server Version %v
    security = user
    netbios name = MYSERVER
    smb ports = 445 22222

[MyShareName]
    comment = Shared directory
    path = /srv/share
    valid users = user1
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 0777
    directory mask = 0777
```

`security = user`��ʾʹ�û����û��İ�ȫģ�ͽ��������֤�������Ϳ���Ϊ��ͬ���û����ò�ͬ�ķ���Ȩ�ޡ�

`[MyShareName]`���������Ĺ������ƣ�Ҳ��Windows����ʾ�����ơ�

`comment`�����ǹ��ڹ������ݵ�������

`path`��������Ҫ�����Ŀ¼������·����

`valid users`����ʾ������ʸù���Ŀ¼���û�������ʹ�ÿո�ָ�����û���

`browseable`������Ϊ yes �󣬿�������Դ���������������

`guest ok`������Ϊ yes ���κ��û������Է��ʹ���

`read only`������Ϊ yes ���û�ֻ�ܶ�ȡ�ļ�������д���ɾ���ļ���

`create mask`����ѡ��ָ�����ļ���Ĭ��Ȩ�ޡ��ڴ�ʾ���У����������ļ������������ߺ����дִ��Ȩ�ޣ������˽����ж�ִ��Ȩ�ޡ�

`directory mask`����ѡ��ָ����Ŀ¼��Ĭ��Ȩ�ޡ��ڴ�ʾ���У���������Ŀ¼�����������ߺ����дִ��Ȩ�ޣ������˽����ж�ִ��Ȩ�ޡ�


## ������ֹͣ����������

�鿴samba����״̬
```shell
systemctl status smb.service
```
> ��������������У�����������Active: active (running)����״̬��

```shell
# ����samba����
systemctl start smb.service
# ֹͣsamba����
systemctl stop smb.service
# ����samba����
systemctl restart smb.service
```

# linux���ء�ж��

����
```shell
mount -t cifs //192.168.234.128/MyShareName /root/128 -o defaults,username=user1,password=user1,port=22222
```
![](./img/20230328_001018.png)

ж��
```shell
umount -f /root/128
```

# windows�������ӳ��

```shell
# ��Ӷ˿�ת��
netsh interface portproxy add v4tov4 listenport=445 listenaddress=127.0.0.1 connectport=22222 connectaddress=192.168.234.128
# �鿴ȫ���˿�ת��
netsh interface portproxy show all
# ɾ���˿�ת��
netsh interface portproxy delete v4tov4 listenaddress=127.0.0.1 listenport=445
```