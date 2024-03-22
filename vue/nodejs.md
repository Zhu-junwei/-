
# npm

> npm: Node Package Manager, 是Node.js的包管理工具

## 配置npm的全局安装路径

使用管理员身份运行命令行，在命令行中，执行如下指令：

```
npm config set prefix "E:\nodejs"
```

## 设置安装包的源

查看默认的源：
```
npm config get registry
```
> 默认的为：https://registry.npmmirror.com ，npm官方源


~~修改为淘宝的源（实现了，还是用官方的吧）：~~
```
npm config set registry http://registry.npm.taobao.org/
```