# ��װ

**����ȷ��ϵͳ�Ѿ���װ��docker**

��ȡ����
```bash
docker pull redis
```

׼��Ŀ¼
```bash
# redis�ļ�����Ŀ¼
mkdir -p /data/redis/conf
# �־û��ļ����Ŀ¼
mkdir -p /data/redis/data
```

��д�����ļ�
```bash
# ��redis������ʹ�ø��ļ�

# Ĭ�϶˿�6379
# ��redis������ʹ�ø��ļ�

# Ĭ�϶˿�6379
port 6379

# ����,Ĭ��û������
requirepass redis@123

# ���ݳ־û�
appendonly yes

# ������־λ�ã�Ĭ�� /dev/null
# logfile /usr/local/log/redis.log
```

redis��������
```bash
#redisʹ���Զ��������ļ�����
docker run -v /data/redis/conf/redis.conf:/etc/redis/redis.conf \
-v /data/redis/data:/data \
-d --name redis \
-p 6379:6379 \
--restart=always \
redis:latest  redis-server /etc/redis/redis.conf
```
> ���������������ڼ�Ŀ¼����redis.txt�������´δ���������ʱ��ʹ�á�

������ɺ�鿴�������
```bash
docker ps -a
```
��Ϊ�������������˿�������`--restart=always`�������´ε�docker������ʱ��redisҲ���Զ�������

# ж��

��Ϊ����ʹ�õ���docker�����ģ�����ֻ��Ҫɾ�������ɾ��񼴿ɡ��ⲿ�ֿɲο�docker�������;���Ĺ��������

ֹͣɾ��redis����
```bash
docker stop redis
docker rm redis
```
ɾ��redis����
```bash
docker rmi redis
```

ɾ��redis�����ļ�����ѡ��
> ���ݾ������ѡ������������ļ�����ѡ��ɾ����
```bash
rm -rf /data/redis/
```