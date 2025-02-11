# 魅蓝metal

### 刷机

下载刷机包：[metal刷机包](https://www.flyme.cn/firmwarelist-24.html)

- 将`update.zip`刷机包放在手机的根目录下面。

关机状态下，按手机`开机键`+`音量-` ，进行系统升级。

# MTK强制退出账号

参考：https://www.bilibili.com/video/BV17b411q7CF/

1. 先刷回原厂系统

2. 拨号界面输入如下命令进入工程模式
```
*#*#3646633#*#*
```
3. 修改IMEI序列号

因为现在的手机flyme账号已经IMEI绑定了，所以需要修改IMEI。

在`Connectivity> CDS Information > Phone 1 > Radio Information` 里面进行如下设置
```
AT +EMGR=1,7"869515023784025"
```

> 我这里修改成了我的另一个魅族手机的IMEI。

修改完成后重启手机，就可以登录flyme账号了。

4. 刷最新的系统

由于上面我们回退到了出厂的系统，所以现在我们需要再刷到最新的系统，这里建议刷到`体验版`，方便后续root。

**刷最近系统的时候不要清除数据，否则IMEI会被重置为手机的默认值，导致无法登录flyme。**



