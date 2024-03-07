# 密码策略

查看默认的密码策略设置
```mysql
show variables like 'validate_password%';
```
```bash
+-------------------------------------------------+--------+
| Variable_name                                   | Value  |
+-------------------------------------------------+--------+
| validate_password.changed_characters_percentage | 0      |
| validate_password.check_user_name               | ON     |
| validate_password.dictionary_file               |        |
| validate_password.length                        | 8      |
| validate_password.mixed_case_count              | 1      |
| validate_password.number_count                  | 1      |
| validate_password.policy                        | MEDIUM |
| validate_password.special_char_count            | 1      |
+-------------------------------------------------+--------+
8 rows in set (0.00 sec)
```

默认：
- `length`密码的最小长度。在这里，它的值为 8。
- `mixed_case_count`表示密码中必须包含的不同大小写字母的数量。在这里，它的值为 1。
- `number_count`表示密码中必须包含的数字的数量。在这里，它的值为 1。
- `special_char_count`表示密码中必须包含的特殊字符的数量。在这里，它的值为 1。
- `policy`定义了密码强度的策略。在这里，它的值为 MEDIUM，表示中等强度的密码策略。

更改默认设置
```mysql
SET GLOBAL validate_password.length = 6;
SET GLOBAL validate_password.mixed_case_count = 0;
SET GLOBAL validate_password.number_count = 0;
SET GLOBAL validate_password.special_char_count = 0;
```
也可以设置密码的强度策略
```mysql
SET GLOBAL validate_password.length = 4;
SET GLOBAL validate_password.policy=LOW;
```

参考：

https://stackoverflow.com/questions/43094726/your-password-does-not-satisfy-the-current-policy-requirements