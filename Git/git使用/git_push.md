# 解决git提交github超时问题

前情回顾
> 我在使用idea往github进行代码提交的时候总是出现`Failed to connect to github.com port 443 after 21110 ms: Couldn't connect to server`的报错。经过查询资料发现可以使用clash的代理进行代码的提交，具体设置如下。

确保clash的端口是固定的
> 默认的是7890

使用下面的两条命令设置git的http及https的代理
```git
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy https://127.0.0.1:7890
```

如果想取消代理，可以使用下面的两条命令
```git
git config --global --unset http.proxy
git config --global --unset https.proxy
```

查看git正在使用的代理
```git
git config --global --get http.proxy
git config --global --get https.proxy
```

吐槽
> 真的很恶心~~~~~~~~~~~~~~~~