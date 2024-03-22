[TOC]

# SC

```
描述:
        SC 是用来与服务控制管理器和服务进行通信
        的命令行程序。
用法:
        sc <server> [command] [service name] <option1> <option2>...


        <server> 选项的格式为 "\\ServerName"
        可通过键入以下命令获取有关命令的更多帮助: "sc [command]"
        命令:
          query-----------查询服务的状态，
                          或枚举服务类型的状态。
          queryex---------查询服务的扩展状态，
                          或枚举服务类型的状态。
          start-----------启动服务。
          pause-----------向服务发送 PAUSE 控制请求。
          interrogate-----向服务发送 INTERROGATE 控制请求。
          continue--------向服务发送 CONTINUE 控制请求。
          stop------------向服务发送 STOP 请求。
          config----------更改服务的配置(永久)。
          description-----更改服务的描述。
          failure---------更改失败时服务执行的操作。
          failureflag-----更改服务的失败操作标志。
          sidtype---------更改服务的服务 SID 类型。
          privs-----------更改服务的所需特权。
          managedaccount--更改服务以将服务帐户密码
                          标记为由 LSA 管理。
          qc--------------查询服务的配置信息。
          qdescription----查询服务的描述。
          qfailure--------查询失败时服务执行的操作。
          qfailureflag----查询服务的失败操作标志。
          qsidtype--------查询服务的服务 SID 类型。
          qprivs----------查询服务的所需特权。
          qtriggerinfo----查询服务的触发器参数。
          qpreferrednode--查询服务的首选 NUMA 节点。
          qmanagedaccount-查询服务是否将帐户
                          与 LSA 管理的密码结合使用。
          qprotection-----查询服务的进程保护级别。
          quserservice----查询用户服务模板的本地实例。
          delete ----------(从注册表中)删除服务。
          create----------创建服务(并将其添加到注册表中)。
          control---------向服务发送控制。
          sdshow----------显示服务的安全描述符。
          sdset-----------设置服务的安全描述符。
          showsid---------显示与任意名称对应的服务 SID 字符串。
          triggerinfo-----配置服务的触发器参数。
          preferrednode---设置服务的首选 NUMA 节点。
          GetDisplayName--获取服务的 DisplayName。
          GetKeyName------获取服务的 ServiceKeyName。
          EnumDepend------枚举服务依赖关系。
        
        以下命令不需要服务名称:
        sc <server> <command> <option>
          boot------------(ok | bad)指示是否应将上一次启动另存为
                          最近一次已知的正确启动配置
          Lock------------锁定服务数据库
          QueryLock-------查询 SCManager 数据库的 LockStatus
示例:
        sc start MyService


QUERY 和 QUERYEX 选项:
        如果查询命令带服务名称，将返回
        该服务的状态。其他选项不适合这种
        情况。如果查询命令不带参数或
        带下列选项之一，将枚举此服务。
    type=    要枚举的服务的类型(driver, service, userservice, all)
             (默认 = service)
    state=   要枚举的服务的状态 (inactive, all)
             (默认 = active)
    bufsize= 枚举缓冲区的大小(以字节计)
             (默认 = 4096)
    ri=      开始枚举的恢复索引号
             (默认 = 0)
    group=   要枚举的服务组
             (默认 = all groups)

语法示例
sc query                - 枚举活动服务和驱动程序的状态
sc query eventlog       - 显示 eventlog 服务的状态
sc queryex eventlog     - 显示 eventlog 服务的扩展状态
sc query type= driver   - 仅枚举活动驱动程序
sc query type= service  - 仅枚举 Win32 服务
sc query state= all     - 枚举所有服务和驱动程序
sc query bufsize= 50    - 枚举缓冲区为 50 字节
sc query ri= 14         - 枚举时恢复索引 = 14
sc queryex group= ""    - 枚举不在组内的活动服务
sc query type= interact - 枚举所有不活动服务
sc query type= driver group= NDIS     - 枚举所有 NDIS 驱动程序
```

## 启动服务

```shell
//启动mysql服务
sc start mysql
//启动clouddriveservice
sc start clouddriveservice
```

## 停止服务

```powershell
//停止mysql服务
sc stop mysql
//停止clouddriveservice
sc stop clouddriveservice
```

## 设置服务启动类型

> sc <server> config [服务名称] <option1> <option2>...

```powershell
//设置为手动启动
sc config mysql start=demand
//设置为禁用
sc config mysql start=disabled
//设置为自动
sc config mysql start=auto
//设置为自动（延迟启动）
sc config mysql start=delayed-auto
```

## 创建服务

> sc create
>
> 描述:
> 在注册表和服务数据库中创建服务项。
> 用法:
> sc <server> create [service name] [binPath= ] <option1> <option2>...


```powershell
sc create clouddrive binPath=D:\CloudDrive\CloudDriveService.exe start=auto
```

## 设置服务的描述

> sc description
> 描述:
> 设置服务的描述字符串。
> 用法:
> sc <server> description [service name] [description]


```powershell
sc description clouddrive "这是我创建的第一个服务"
```

## 卸载服务

> sc delete
> 描述:
> 从注册表删除服务项。
> 如果服务正在运行，或另一进程已经打开
> 到此服务的句柄，服务将简单地标记为
> 删除。
> 用法:
> sc <server> delete [service name]


```powershell
sc delete clouddrive
```

## 参考资料

[SC命令详解 - 森大科技 - 博客园](https://www.cnblogs.com/cnsend/p/12907229.html)


# 查看端口占用

```bash
netstat -ano | findstr <端口号>
```

# 杀死进程

```bash
# 使用 taskkill 命令加上进程ID来终止进程。
taskkill /PID <进程ID>
# 如果需要强制终止进程，可以添加 /F 参数
taskkill /F /PID <进程ID>
```
