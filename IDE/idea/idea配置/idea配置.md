[TOC]

# 配置jdk

![2020-07-19_231043](img/2020-07-19_231043.png)

![2020-07-19_231128](img/2020-07-19_231128.png)

![2020-07-19_231213](img/2020-07-19_231213.png)

# 配置tomcat

![2020-10-28_111308](img/2020-10-28_111308.png)

# 配置maven

![2020-07-19_231404](img/2020-07-19_231404.png)

![2020-07-19_231420](img/2020-07-19_231420.png)

![2021-12-23_092507](img/2021-12-23_092507.png)

# 配置控制台maven编码

取消`Delegate IDE build/run actions to Maven`(将 IDE 构建/运行操作委托给 Maven)，减少不必要的日志输出。

谨慎设置编码。

```
-Dfile.encoding=GBK
```

![20210621_000802](img/20210621_000802.png)



# 配置git

![2020-07-19_231513](img/2020-07-19_231513.png)



# 配置gitee

![20210823_223618](img/20210823_223618.png)

安装后重启IDEA

添加token添加gitee账号

![20210823_224205](img/20210823_224205.png)



# 配置提示忽略大小写

![2020-07-19_231641](img/2020-07-19_231641.png)

# 配置鼠标改变大小写

![2020-07-19_231705](img/2020-07-19_231705.png)

# 配置背景图片

![2020-07-19_231737](img/2020-07-19_231737.png)

![2020-07-19_231753](img/2020-07-19_231753.png)

# 配置编码字体

![](img/2020-07-20_223413.png)

# 配置SQL代码样式

![](img/20221102_221014.png)

# 配置新建Java文件模板

```java
/**
 * @author ${USER}
 * @date ${YEAR}/${MONTH}/${DAY} ${TIME}
 */
```

![20220102_214755](img/20220102_214755.png)

# 配置项目文件编码

![2020-07-20_223910](img/2020-07-20_223910.png)

# 显示工具条

![2020-07-20_232505](img/2020-07-20_232505.png)

# 取消中间显示的竖线

![2020-07-31_094418](img/2020-07-31_094418.png)

# 设置调用了标记为`@Deprecated`启用的API显示删除线

![20240113_134610.png](img/20240113_134610.png)

# 未使用过的方法和变量设置弱警告

![20240113_141216.png](img/20240113_141216.png)

# 修改jsp默认生成的样式

![2020-07-31_114336](img/2020-07-31_114336.png)

# 设置方法参数自动提示

![2020-08-03_162219](img/2020-08-03_162219.png)

# 动态删除无用导入的package

![2020-09-05_094640](img/2020-09-05_094640.png)

# 默认打开项目位置

![2020-10-27_142202](img/2020-10-27_142202.png)

# 渲染文档注释

![20220520_101205](img/20220520_101205.png)

# Debug不能进入jdk源码问题

> debug不能step into源码，而是要force step into。
>
> 可以修改如下配置，使用step into进入源码。

![2020-10-28_095357](img/2020-10-28_095357.png)

# debug时可修改jdk源码

> 由于默认的jdk源码是src.zip，不能修改。需要解压后使idea指向解压后的源码。

![2020-10-28_100349](img/2020-10-28_100349.png)

# 配置SSH
![](img/20220706_205445.png)

# 隐藏项目导航中的文件或目录

![20210726_003246](img/20210726_003246.png)

# 状态栏内存占用显示

双击Shift搜索`show memory indicator`

![2021-12-23_092846](img/2021-12-23_092846.png)

或者在下面状态栏选中`Memory Indicator`

![20240113_134921.png](img/20240113_134921.png)

# 取消嵌入提示

![](img/2022-09-28_155301.png)

# ~~修改idea配置文件所在目录~~

修改idea安装目录下的idea.properties文件，防止系统重装时配置文件在C盘被删除。

如修改 E:\idea\bin\idea.properties

```properties
idea.install.path=E:/idea
idea.config.path=${idea.install.path}/.IntelliJIdea/config
idea.system.path=${idea.install.path}/.IntelliJIdea/system
idea.plugins.path=${idea.config.path}/plugins
idea.log.path=${idea.system.path}/log
```

# 插件

## Show Comment

> 文件树中显示类的注释，前提在类的开头写好了javadoc注释

![20220608_095819.png](img/20220608_095819.png)

- 取消行末注释

![20220608_135754.png](img/20220608_135754.png)

## diagrams.net

> draw.io画图工具包

## Chinese Language Pack

> 将idea翻译为中文

## CMD Support

> CMD命令高亮支持

## Gitee

> 写过的代码要提交云端

## GsonFormatPlus

> json开发工具

## Key Promoter X

> 使用idea的快捷键提示

## Maven Helper

> Maven工具

## Translation

> 直接在idea里面翻译英文不香吗

## ignore

> 忽略文件

## 主题插件

- Xcode Dark theme
- Visual Studio Code "Dark Plus" theme

## Atom Material ICons

> 自定义文件和IDE图标，用于改进视觉绘制

## Rainbow Brackets Lite

> 彩虹括号，提高代码可读性

## MybatisPlus

> MybatisPlus插件从java到xml或从xml到java

## CodeGlance

> 代码缩略图

# 激活

https://wwqn.lanzoul.com/iT0Yr2i3cv4b
