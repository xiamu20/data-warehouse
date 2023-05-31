#order_info
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
set @partition_filed:=0;
set @row_num:=0;

select
@row_num:=if(@partition_filed=t.uid,@row_num+1,1) as row_num,
@partition_filed:=t.uid as uid,
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
