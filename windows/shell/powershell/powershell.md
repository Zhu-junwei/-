# 教程

[PowerShell教程™ (yiibai.com)](https://www.yiibai.com/powershell)

# 创建并运行PowerShell脚本

## 修改执行策略

需要管理员身份运行。

```powershell
Set-ExecutionPolicy Unrestricted
```

运行hello world

```
echo "Hello world......"
```

# PowerShell注释

单行注释

> \# 这是单行注释

多行注释

> <# 这是多行注释 #>



```powershell
<# 打印1-10之间的偶数 #>

for ( $i = 1; $i -le 10; $i++ )
{
    $x = $i % 2
    if($x -eq 0)
    {
        echo $i
    }
}
```

