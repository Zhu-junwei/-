# 在命令行中直接直接sql语句
```sql
sqlplus / as sysdba <<EOF
-- 注释的地方写需要执行的sql语句
EXIT;
EOF
    
```

# 系统配置

查看系统的密码规则
```sql
SELECT * FROM DBA_PROFILES WHERE RESOURCE_NAME = 'PASSWORD_VERIFY_FUNCTION';
```

查询用户使用的密码规则
```sql
SELECT PROFILE,USERNAME FROM DBA_USERS WHERE username='用户名';
```

修改用户的PROFILE
```sql
ALTER USER 用户名 PROFILE DEFAULT;
```

查看系统版本
```sql
SELECT * FROM v$version;
```

# 表空间

查表空间的大小和空闲空间
```sql
SELECT "SPACE".TABLESPACE_NAME, GB, "FREE(GB)" FROM
    (SELECT TABLESPACE_NAME, ROUND(SUM(NVL(BYTES,0))/(1024*1024*1024), 2) AS GB FROM DBA_DATA_FILES GROUP BY TABLESPACE_NAME) "SPACE",
    (SELECT TABLESPACE_NAME, ROUND(SUM(NVL(BYTES/1024/1024/1024, 0)), 2) AS "FREE(GB)" FROM DBA_FREE_SPACE GROUP BY TABLESPACE_NAME) FREE
WHERE "SPACE".TABLESPACE_NAME = FREE.TABLESPACE_NAME
ORDER BY 1;
```

查看表空间位置
```sql
col file_name for a60;
set linesize 160;
select file_name,tablespace_name,bytes from dba_data_files;
```
> 1、dbf文件与tablespase的关系：一个tablespase由多个dbf文件组成，一个dbf文件只能属于一个tablespase
> 
> 2、dbf文件如果占满了就无法写入新数据，无法自动扩展，相关的应用就会报错

增加表空间大小
```sql
-- 用于向Oracle数据库中的 SYSAUX 表空间添加一个数据文件，并设置其初始大小为 5G，自动扩展，下一个扩展为 1G，最大为 10G。
ALTER TABLESPACE SYSAUX ADD DATAFILE
'/ora12cdata/dbf/sysaux02.dbf' SIZE 5G
AUTOEXTEND ON NEXT 1G MAXSIZE 10G;
```

# 备份与恢复

备份某张表，如`QUOTE_VALUE`表

```sql
expdp SYSTEM/calypso DIRECTORY=DB_DUMP DUMPFILE=${MAIN_SCHEMA}_QUOTE_VALUE_`(date +%Y%m%d%H%M%S)`.dmp SCHEMAS=${MAIN_SCHEMA} INCLUDE=TABLE:"IN('QUOTE_VALUE')" LOGFILE=${MAIN_SCHEMA}_QUOTE_VALUE_`(date +%Y%m%d%H%M%S)`_export.log LOGTIME=ALL
```

