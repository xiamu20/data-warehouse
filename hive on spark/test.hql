ALTER   TABLE  gmall.test2 ARCHIVE PARTITION(dt=1);
alter table test3  PARTITION(dt=3) concatenate;
INSERT  INTO table test partition (dt=1)
select
t1.a
from (select * from test ) as t1  join (select * from test ) as t2 on 1=1;


CREATE EXTERNAL TABLE test4
(
 a int
) COMMENT '用户表'
PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/warehouse/gmall/ods/test3/';


hadoop fs -getmerge  /warehouse/gmall/ods/test3/dt=3/* /warehouse/gmall/ods/test3/dt=3