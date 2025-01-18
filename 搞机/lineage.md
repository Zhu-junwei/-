## GSI下载

https://sourceforge.net/projects/andyyan-gsi/files/

## 版本对照

| Lineage | Android | 代号 |
|---------|---------|----|
| 22.1    | 15      |    |
| 21      | 14      |    |
| 20      | 13      |    |
| 19.1    | 12.1    |    |
| 18.1    | 11      |    |
| 17.1    | 10      |    |
| 16      | 9.0.0   |    |
| 15.1    | 8.1.0   |    |
| 14.1    | 7.1.2   |    |
| 13      | 6.0.1   |    |

## CPU架构、系统架构与GSI版本关系

| CPU架构（位）         | 系统架构（位）     | 该选的GSI版本 |
|------------------|-------------|----------|
| ARMv8A/ARM64(64) | aarch64(64) | arm64    |
| ARMv8A/ARM64(64) | armv7l(32)  | a64      |
| ARMv7/ARM32(32)  | armv7l(32)  | arm      |

可以通过`uname -m`命令查看系统架构。

## 刷机步骤

### A only

A only分区机型无super动态分区,直接在fastboot模式下刷system

### AB分区

AB分区(动态分区)机型

system，vendor等小分区被合并进super大分区刷super大分区可在fastboot模式下进行刷system，vendor等小分区需在fastbootd模式进行,而非fastboot模式

开机状态重启命令
```
# 进入fastboot模式
adb reboot bootloader
# 进入fastbootd模式
adb reboot fastboot
```

fastboot状态重启命令
```
# 进入fastbootd模式 
fastboot reboot fastboot
```

### 刷入GSI

```
fastboot flash system lineage-xxx.img
```

进入recovery模式
```
fastboot reboot recovery
```

清理数据

### root

1. 提取镜像

```
C:\Users\jw>adb root
restarting adbd as root

C:\Users\jw>adb devices
List of devices attached
ceb7dc81        device


C:\Users\jw>adb shell
lineage_gsi_arm64:/ # cd /d
d                data/            data_mirror/     debug_ramdisk/   dev/             dsp
lineage_gsi_arm64:/ # cd /dev/block/by-name/
lineage_gsi_arm64:/dev/block/by-name # ls -l boo
boot_a  boot_b
lineage_gsi_arm64:/dev/block/by-name # ls -l boot_a
lrwxrwxrwx 1 root root 16 1970-09-17 12:54 boot_a -> /dev/block/sde12
lineage_gsi_arm64:/dev/block/by-name # dd if=/dev/block/sde12 of=/sdcaard/a.img
```

2. 安装magisk

修补刚才提取的a.img镜像文件

3. 刷回修补后的boot镜像

```
dd if=/sdcard/Download/magisk_patched-xxxxx.img of=/dev/block/sde12
# 重启手机后即可获取root
reboot
```

## 优化设置

### 网络验证
```
adb shell settings put global captive_portal_https_url https://connect.rom.miui.com/generate_204
adb shell settings put global captive_portal_http_url http://connect.rom.miui.com/generate_204
```

### 时间同步

```
adb shell settings put global ntp_server ntp.aliyun.com
```
