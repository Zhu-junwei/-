[toc]

# nvm是什么

> Windows电脑node.js管理器。可以方便node.js的安装与切换。

最新版本`1.1.11` [coreybutler/nvm-windows](https://github.com/coreybutler/nvm-windows)

有一个更高star的nvm是[nvm-sh/nvm](https://github.com/nvm-sh/nvm)，没仔细研究。

# 安装

非常简单，下载Releases下的安装包，一步步安装即可，选好安装的位置即可。

**最先下卸载本机安装好的node.js**

# 简单命令

- 帮助命令:

```shell
nvm --help
```

> 有什么不懂的或者记不住的可以使用这个命令。


- 查看版本:

```shell
nvm version
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113202748804-640652161.png)

- 查看Node.js可用的版本列表，可执行如下命令：
```shell
nvm ls available
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113203009732-1435279354.png)

- 安装版本号为21.0.0的Node.js，可执行如下命令：
```shell
nvm install 21.0.0
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113204148008-1450862984.png)


- 查看已经安装的版本
```shell
nvm list
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113203345934-367987020.png)


- 切换版本
```shell
nvm use 21.1.0
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113203417321-1514991684.png)


- 卸载某个版本
```shell
nvm uninstall 16.15.0
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113203436291-460595843.png)

- 查看node版本
```shell
node -v
```
![](https://img2023.cnblogs.com/blog/1745057/202311/1745057-20231113203903538-1649164578.png)
