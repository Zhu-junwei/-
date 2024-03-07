DATE数据转为VATCHAR2类型

```plsql
declare 
--接收数据库中的日期类型
v_hiredate emp.hiredate%TYPE;
--接收转换后的数据类型
v_show VARCHAR2(20);
BEGIN
   SELECT hiredate INTO v_hiredate
   FROM emp WHERE ename='SMITH';
   DBMS_OUTPUT.put_line(v_hiredate);
   v_show := TO_CHAR(v_hiredate);
   DBMS_OUTPUT.put_line(v_hiredate);
END;
```

