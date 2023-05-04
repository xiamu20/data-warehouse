#!/bin/bash

APP=gmall

if [ -n "$2" ] ;then
   do_date=$2
else
   do_date=`date -d '-1 day' +%F`
fi

load_data(){
    sql=""
    for i in $*; do
        #判断路径是否存在
        hadoop fs -test -e /origin_data/$APP/db/${i:4}/$do_date
        #路径存在方可装载数据
        if [[ $? = 0 ]]; then
            sql=$sql"load data inpath '/origin_data/$APP/db/${i:4}/$do_date' OVERWRITE into table ${APP}.$i partition(dt='$do_date');"
        fi
    done
    hive -e "$sql"
}

case $1 in

    "ods_order_info_inc")
        load_data "ods_order_info_inc"
    ;;
    "ods_user_info_inc")
        load_data "ods_user_info_inc"
    ;;
        "ods_order_detail_inc")
        load_data "ods_order_detail_inc"
    ;;
    "all")
        load_data "ods_order_info_inc" "ods_user_info_inc" "ods_order_detail_inc"
    ;;
esac
