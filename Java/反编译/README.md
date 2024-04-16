# 使用IDEA插件编译jar为源码

- 安装IDEA插件`Java Bytecode Decompiler`

> 执行编译命令

```java
java -cp "E:\IDEA安装位置\plugins\java-decompiler\lib\java-decompiler.jar"org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler -dgs=true E:\xxx.jar "E:\target"
```

执行命令后会在`E:\target`目录下生成`xxx.java`文件，里面是源码，使用IDEA打开即可。