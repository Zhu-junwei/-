# 通过SDKMAN安装JDK

> [SDKMAN](https://github.com/sdkman/sdkman-cli)是一个用于在任何基于Unix的系统上管理多个软件开发工具包的并行版本的工具。它为安装、切换、删除和列出候选程序提供了方便的命令行界面。

官网：https://sdkman.io/

## 安装SDKMAN

1. 安装

二选一
```bash
# 默认安装到 ~/.sdkman
curl -s "https://get.sdkman.io" | bash

# 安装到指定目录（后面初始化环境的时候记得改路径）
export SDKMAN_DIR="/usr/local/sdkman" && curl -s "https://get.sdkman.io" | bash
```

2. 初始化环境

```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

3. 确认安装是否成功

```bash
sdk version
```

## 安装JDK

```bash
# 查看可用的版本
sdk list java

# 安装 可以输入完大版本号后按tab进行提示
sdk install java 21.0.2-open

# 安装后会默认切换为已安装的版本
# 也可以收到指定使用的版本
sdk use java 21.0.2-open

## 查看当前使用的版本
sdk current java
java -version
```

## 卸载JDK

```bash
sdk uninstall java 22-open
```

## 卸载SDKMAN

```bash
rm -rf ~/.sdkman
rm -rf ~/.zshrc
```
编辑并删除 `.bashrc` 、 `.bash_profile` 和/或 `.profile` 文件中的初始化代码段。如果您使用 ZSH，请将其从 `.zshrc`
文件中删除。要删除的代码片段如下所示： 删除后，您已成功卸载 SDKMAN！

重新加载当前用户的 Bash shell 配置文件 `.bashrc`
```bash
source ~/.bashrc
```



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