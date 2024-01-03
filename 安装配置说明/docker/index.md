# Docker ж��

ֹͣ��ɾ�����������е�����
```bash
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
```

ɾ�����о���
```bash
sudo docker rmi $(sudo docker images -q)
```

����docker�Ŀ�������

> ��������˿�������
```bash
sudo systemctl disable docker
```
> ����ͨ��`systemctl status docker`����鿴�Ƿ�����docker�������������loaded��enabled�����ǿ�������������û�����ÿ���������

ֹͣDocker����
```bash
# �ر�docker.socket
sudo systemctl stop docker.socket
# �ر�docker
sudo systemctl stop docker
```

ж��Docker�����
```bash
sudo yum remove docker-ce docker-ce-cli containerd.io -y
```

ɾ��Docker���ݺ�����
```bash
sudo rm -rf /var/lib/docker
```

ɾ��Docker�洢��
```bash
sudo yum remove docker-ce docker-ce-cli containerd.io \
                    docker-buildx-plugin.x86_64 \
                    docker-compose-plugin.x86_64 -y
```

����yum����
```bash
sudo yum clean all
```

��鲢ɾ�����ܴ��ڵ�����Docker���
```bash
sudo yum list installed | grep docker
```
����еĻ�ʹ�������������ɾ��
```bash
sudo yum remove xxx
```


# Docker��װ

��װ������
```bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

���Docker�洢��

> ��ѡһ
```bash
# docker����
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# ������
sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

��װDocker����
```bash
sudo yum install docker-ce docker-ce-cli containerd.io -y
```

����Docker����
```bash
sudo systemctl start docker
```

����Docker������ϵͳ����
```bash
sudo systemctl enable docker
```

��֤��װ
```bash
sudo docker --version
```

��ʾ���
```
[root@Redis ~]# sudo docker --version
Docker version 24.0.7, build afdd53b
```

����ѡ�����û���ӵ�docker�飨����ʹ��sudo��
```bash
sudo usermod -aG docker your_username
```
�뽫your_username�滻Ϊ���ʵ���û�����Ȼ��ע�������µ�¼��Ӧ�ø��ġ�
