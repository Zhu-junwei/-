使用GraalVM构建本地镜像

参考官网：
https://docs.spring.io/spring-boot/docs/current/reference/html/native-image.html#native-image

# windows:

## 前期准备

在 Windows 上，按照以下说明安装 `GraalVM` 或 `Liberica Native Image Kit`（版本 22.3）、`Visual Studio` 构建工具和 `Windows SDK`。由于
Windows 相关的命令行最大长度，请确保使用 x64 Native Tools 命令提示符而不是常规 Windows 命令行来运行 Maven 或 Gradle 插件。

## Maven

需要确保使用 `spring-boot-starter-parent` 来继承 native 配置文件，并使用 `org.graalvm.buildtools:native-maven-plugin` 插件。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.4</version>
        <relativePath/>
    </parent>
    <groupId>com.example</groupId>
    <artifactId>MyApplication</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>MyApplication</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.graalvm.buildtools</groupId>
                <artifactId>native-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>

```

当 native 配置文件处于活动状态时，您可以调用 `native:compile` 目标来触发 `native-image` 编译：
```
mvn -Pnative native:compile
```

本机映像可执行文件可以在 target 目录中找到。