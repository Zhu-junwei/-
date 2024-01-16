
# OpenJDK8

## 安装
```bash
yum install -y java-1.8.0-openjdk-devel
```

验证
```bash
java -version
```

## 卸载
```bash
yum remove -y java-1.8.0-openjdk-devel
```

检查其他依赖
```bash
yum list installed | grep java
```
如果有的话，通过`yum remove xxx`进行删除。

# OpenJDK11

## 安装
```bash
yum install -y java-11-openjdk-devel
```

验证
```bash
java -version
```

## 卸载
```bash
yum remove -y java-11-openjdk java-11-openjdk-headless
```

# OpenJDK17

> 我通过yum没有搜索到jdk17的安装包，只能手动下载了。

## 安装

下载 

进入官网 [下载地址](https://jdk.java.net/archive/)

选择linux版本复制链接
```bash
wget https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz
```
> 链接可能会变，以实际为准

解压
```bash
tar -xzvf openjdk-17_linux-x64_bin.tar.gz -C /opt/
ll /opt/jdk-17/
```

配置环境变量
```bash
sudo echo 'export JAVA_HOME=/opt/jdk-17' >> /etc/profile
sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
source /etc/profile
```

验证
```bash
java -version
```

删除包装包
```bash
rm -rf openjdk-17_linux-x64_bin.tar.gz
```

## 卸载

删除环境变量

> 请确保你在做什么，如果不清楚，请手动到文件内部进行删除。
```bash
sed -i '/JAVA_HOME/d' /etc/profile
source /etc/profile
```

删除jdk
```bash
rm -rf /opt/jdk-17
```