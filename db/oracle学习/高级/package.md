# DBMS_NETWORK_ACL_ADMIN

https://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_networkacl_adm.htm#BABEHFAG

The DBMS_NETWORK_ACL_ADMIN package provides the interface to administer the network Access Control List (ACL).
> DBMS_NETWORK_ACL_ADMIN包提供了管理网络访问控制列表(ACL)的接口。

## Example1

Grant the connect and resolve privileges for host www.us.oracle.com to SCOTT.
> 将主机www.us.oracle.com的连接和解析权限授予SCOTT。

```oracle
BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'www.xml',
                                    description => 'WWW ACL',
                                    principal   => 'SCOTT',
                                    is_grant    => true,
                                    privilege   => 'connect');
 
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'www.xml',
                                       principal => 'SCOTT',
                                       is_grant  => true,
                                       privilege => 'resolve');
 
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'www.xml',
                                    host => 'www.us.oracle.com');
END;
/
COMMIT;
```
## Example 2

Grant the resolve privilege for www.us.oracle.com to ADAMS. Since an ACL for www.us.oracle.com exists already, just add the privilege for ADAMS.
> 将www.us.oracle.com的resolve权限授予ADAMS。因为已经存在www.us.oracle.com的ACL，所以只需为ADAMS添加特权即可。

```oracle
BEGIN
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'www.xml',
                                       principal => 'ADAMS',
                                       is_grant  => true,
                                       privilege => 'resolve');
END;
/
COMMIT;
```
## Example 3

Assign the ACL www.xml to www-proxy.us.oracle.com so that SCOTT and ADAMS can access www-proxy.us.oracle.com also.
> 为www-proxy.us.oracle.com分配ACL www.xml，这样SCOTT和ADAMS也可以访问www-proxy.us.oracle.com。

```oracle
BEGIN
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'www.xml',
                                    host => 'www-proxy.us.oracle.com');
END;
/
COMMIT;
```

## Example 4

Unassign the ACL from www.us.oracle.com so that no access to www.us.oracle.com is allowed.
> 取消对www.us.oracle.com的ACL分配，不允许访问www.us.oracle.com。

```oracle
BEGIN
  DBMS_NETWORK_ACL_ADMIN.UNASSIGN_ACL(host => 'www.us.oracle.com');
END;
/
COMMIT;
```

## Example 5

The DOMAINS Function in the DBMS_NETWORK_ACL_UTLILITY package returns all the domains a host belongs to. It can be used in conjunction with the CHECK_PRIVILEGE_ACLID Function in this package to determine the privilege assignments affecting a user's permission to access a network host. The function DOMAIN_LEVEL Function in the DBMS_NETWORK_ACL_UTILITY package returns the level of each domain and can be used to order the ACL assignments by their precedence.
> dbms_network_acl_utility包中的DOMAINS函数返回主机所属的所有域。它可以与此包中的CHECK_PRIVILEGE_ACLID函数一起使用，以确定影响用户访问网络主机权限的特权分配。DBMS_NETWORK_ACL_UTILITY包中的DOMAIN_LEVEL function函数返回每个域的级别，并可用于按优先级排序ACL分配。

For example, for SCOTT's permission to connect to www.us.oracle.com:
> 例如，对于SCOTT连接到www.us.oracle.com的权限:

```oracle
 SELECT host, lower_port, upper_port, acl,
     DECODE(
         DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid, 'SCOTT', 'connect'),
            1, 'GRANTED', 0, 'DENIED', null) privilege
     FROM dba_network_acls
    WHERE host IN
      (SELECT * FROM
         TABLE(DBMS_NETWORK_ACL_UTILITY.DOMAINS('www.us.oracle.com')))
   ORDER BY DBMS_NETWORK_ACL_UTLITITY.DOMAIN_LEVEL(host) desc, lower_port, 
                                               upper_port;


   HOST                 LOWER_PORT UPPER_PORT         ACL          PRIVILEGE
   -------------------- ---------- ---------- -------------------- ---------
   www.us.oracle.com            80         80 /sys/acls/www.xml    GRANTED
   www.us.oracle.com          3000       3999 /sys/acls/www.xml    GRANTED
   www.us.oracle.com                          /sys/acls/www.xml    GRANTED
   *.oracle.com                               /sys/acls/all.xml
   *                                          /sys/acls/all.xml
```

## Example 6

For example, for SCOTT's permission to do domain name resolution for www.us.oracle.com:

```oracle
SELECT host, acl,
     DECODE(
          DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid, 'SCOTT', 'resolve'),
            1, 'GRANTED', 0, 'DENIED', NULL) privilege
     FROM dba_network_acls
    WHERE host IN
      (SELECT * FROM
         TABLE(DBMS_NETWORK_ACL_UTILITY.DOMAINS('www.us.oracle.com'))) and
      lower_port IS NULL AND upper_port IS NULL
   ORDER BY DBMS_NETWORK_ACL_UTILITY.DOMAIN_LEVEL(host) desc;


   HOST                         ACL          PRIVILEGE
   -------------------- -------------------- ---------
   www.us.oracle.com    /sys/acls/www.xml    GRANTED
   *.oracle.com         /sys/acls/all.xml
   *                    /sys/acls/all.xml  
 
```

Note that the 'resolve' privilege takes effect only in ACLs assigned without any port range (when lower_port and upper_port are NULL). For this reason, we do not include lower_port and upper_port columns in the query.
> 请注意，'resolve'特权仅在没有任何端口范围的acl中生效(当lower_port和upper_port为NULL时)。因此，我们在查询中不包括lower_port和upper_port列。

