# CentOS9安装后配置

## 安装一些必要的工具
```bash
# 网络管理工具
dnf install net-tools git vim yum-utils -y
```

## 设置静态IP

> CentOS9的默认网络设置地址为`/etc/NetworkManager/system-connections/<filename>`

编辑文件

```ini
[ipv4]
method=manual
address1=192.168.234.8/24,192.168.234.2  # IP地址/子网掩码,网关
dns=8.8.8.8;8.8.4.4;  # DNS服务器地址，用分号分隔
```

重新加载 NetworkManager 的配置
```bash
nmcli connection reload
```

重启网络接口以应用更改
```bash
nmcli connection down ens160
nmcli connection up ens160
```

## 设置语系
```bash
# 先查看有没有已安装的语系
locale -a
# 如果没有就下载语系，这里下载的是英文
dnf install langpacks-en -y

# 修改语系
LANG=en_US.utf8
# 设置所有语言环境
export LC_ALL=en_US.utf8
```
> 系统永久生效可以修改`/etc/locale.conf`文件
> 不知道为什么了我设置了英文，时间都不对了，最后我还是设为了`zh_CN.utf8`

## 更新系统及软件

### 更新
```bash
dnf update -y
```

### 清理缓存
```bash
dnf clean all
```

### 清理多余内核
```bash
dnf remove --oldinstallonly --setopt installonly_limit=2 kernel
```

