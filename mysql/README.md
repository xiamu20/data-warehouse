
##order_info
create table test.order_info
(uid int,oid int,dt int);
insert into test.order_info
values
(1,1,20220101),
(1,2,20220101),
(1,3,20220102),
(2,1,20220103),
(2,2,20220103),
(2,3,20220104);

##取用户最新的oid
#变量赋值初始化

set @partition_field:=0;
set @row_num:=0;

select
@row_num:=if(@partition_field=t.uid,@row_num+1,1) as row_num,
@partition_field:=t.uid as uid,
t.oid,
t.dt
from
(
select
uid,
oid,
dt
from
test.order_info
order by uid,dt desc
)t;

result_t
+------+------+----------+
| uid  | oid  | dt       |
+------+------+----------+
|    1 |    3 | 20220102 |
|    1 |    1 | 20220101 |
|    1 |    2 | 20220101 |
|    2 |    3 | 20220104 |
|    2 |    1 | 20220103 |
|    2 |    2 | 20220103 |
+------+------+----------+

result:
+---------+------+------+----------+
| row_num | uid  | oid  | dt       |
+---------+------+------+----------+
|       1 |    1 |    3 | 20220102 |
|       2 |    1 |    1 | 20220101 |
|       3 |    1 |    2 | 20220101 |
|       1 |    2 |    3 | 20220104 |
|       2 |    2 |    1 | 20220103 |
|       3 |    2 |    2 | 20220103 |
+---------+------+------+----------+

where row_num=1
