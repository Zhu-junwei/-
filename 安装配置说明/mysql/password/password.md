# �������

�鿴Ĭ�ϵ������������
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

Ĭ�ϣ�
- `length`�������С���ȡ����������ֵΪ 8��
- `mixed_case_count`��ʾ�����б�������Ĳ�ͬ��Сд��ĸ�����������������ֵΪ 1��
- `number_count`��ʾ�����б�����������ֵ����������������ֵΪ 1��
- `special_char_count`��ʾ�����б�������������ַ������������������ֵΪ 1��
- `policy`����������ǿ�ȵĲ��ԡ����������ֵΪ MEDIUM����ʾ�е�ǿ�ȵ�������ԡ�

����Ĭ������
```mysql
SET GLOBAL validate_password.length = 6;
SET GLOBAL validate_password.mixed_case_count = 0;
SET GLOBAL validate_password.number_count = 0;
SET GLOBAL validate_password.special_char_count = 0;
```
Ҳ�������������ǿ�Ȳ���
```mysql
SET GLOBAL validate_password.length = 4;
SET GLOBAL validate_password.policy=LOW;
```

�ο���

https://stackoverflow.com/questions/43094726/your-password-does-not-satisfy-the-current-policy-requirements