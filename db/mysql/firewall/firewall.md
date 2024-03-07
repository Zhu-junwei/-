# 设置防火墙
检查防火墙状态：
```bash
sudo systemctl status firewalld
```
如果防火墙未运行，启动它：
```bash
sudo systemctl start firewalld
```
启用防火墙自启动：
```bash
sudo systemctl enable firewalld
```
添加允许 3306 端口的规则：
```bash
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
```
> 这会将 3306 端口添加到 public 区域，并且 --permanent 选项将规则永久保存，使其在系统重启后仍然有效。

重新加载防火墙规则：
```bash
sudo firewall-cmd --reload
```
查看开放的防火墙
```bash
firewall-cmd --list-ports
```