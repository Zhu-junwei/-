# ���÷���ǽ
������ǽ״̬��
```bash
sudo systemctl status firewalld
```
�������ǽδ���У���������
```bash
sudo systemctl start firewalld
```
���÷���ǽ��������
```bash
sudo systemctl enable firewalld
```
������� 3306 �˿ڵĹ���
```bash
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
```
> ��Ὣ 3306 �˿���ӵ� public ���򣬲��� --permanent ѡ��������ñ��棬ʹ����ϵͳ��������Ȼ��Ч��

���¼��ط���ǽ����
```bash
sudo firewall-cmd --reload
```
�鿴���ŵķ���ǽ
```bash
firewall-cmd --list-ports
```