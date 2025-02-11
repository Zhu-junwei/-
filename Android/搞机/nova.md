
# fastboot

手机关机，插上电脑，同时按住`电源`和`音量-`进入fastboot。

# 刷recevory

fast模式下执行如下的命令
```
fastboot flash recovery D:\xxx\twrp-xx.img(第三方recovery路径)
```

# recovery

手机关机，同时按住`电源`和`音量+`进入recovery

# 安装三方系统

adb sideload "J:\system\mobile\huawei\nova\huawei nova aosp-a8.1\类原生（安卓8.1）\lineage-15.1-20181115-UNOFFICIAL-hwcan.zip"

# 安装软件

```
adb install H:\手机应用\实用工具\magisk\Magisk_27.0.apk
adb install H:\手机应用\实用工具\爱玩机工具箱\爱玩机工具箱_S-22.0.9.3.apk
adb install H:\手机应用\实用工具\一个木函\一个木函_7.17.11-normal.apk
adb install H:\手机应用\文件管理\文件闪传\文件闪传_4.2.2.apk
adb install H:\手机应用\文件管理\ES文件浏览器\ES文件浏览器_4.2.4.apk
adb install H:\手机应用\输入法\讯飞输入法小米版_8.0.5932_080004.apk
adb install H:\手机应用\浏览器\Via\Via_5.8.1.APK

```