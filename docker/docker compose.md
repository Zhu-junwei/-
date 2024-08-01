# 概述

> [Docker Compose][] 是一个用于定义和运行多容器应用程序的工具。它是解锁精简高效的开发和部署体验的关键。
>
> Compose 简化了对整个应用程序堆栈的控制，使您可以在单个易于理解的 YAML 配置文件中轻松管理服务、网络和卷。然后，使用单个命令，您可以从配置文件创建并启动所有服务。
>
> Compose 适用于所有环境；生产、登台、开发、测试以及 CI 工作流程。它还具有用于管理应用程序整个生命周期的命令：
> - 启动、停止和重建服务
> - 查看正在运行的服务的状态
> - 流式传输正在运行的服务的日志输出
> - 在服务上运行一次性命令

[Docker Compose]: https://docs.docker.com/compose/

# 命令

要启动`compose.yaml`文件中定义的所有服务：
```docker
docker compose up
```

要停止并删除正在运行的服务：
```docker
docker compose down 
```

运行服务：
```docker
docker compose start 
```

要停止正在运行的服务：
```docker
docker compose stop 
```

列出所有服务及其当前状态：
```docker
docker compose ps
```

如果您想监视正在运行的容器的输出并调试问题，可以使用以下命令查看日志：
```docker
docker compose logs
```

查看其他可用命令。
```docker
docker compose --help
```
