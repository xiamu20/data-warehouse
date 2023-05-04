#!/bin/bash

APP=gmall

if [ -n "$2" ] ;then
   do_date=$2
else
   echo "请传入日期参数"
   exit
fi

dim_user_zip="



insert overwrite table ${APP}.dim_user_zip partition (dt='9999-12-31')
select
    data.id,
    data.login_name,
    data.nick_name,
    md5(data.name),
    md5(data.phone_num),
    md5(data.email),
    data.user_level,
    data.birthday,
    data.gender,
    data.create_time,
    data.operate_time,
    '$do_date' start_date,
    '9999-12-31' end_date
from ${APP}.ods_user_info_inc
where dt='$do_date'
and type='bootstrap-insert';
"



case $1 in
"dim_user_zip")
    hive -e "$dim_user_zip"
;;
"all")
    hive -e "$dim_user_zip"
;;
esac
