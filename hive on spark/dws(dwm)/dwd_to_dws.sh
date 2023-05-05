#!/bin/bash
APP=gmall

# 如果输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n "$2" ] ;then
    do_date=$2
else
    do_date=`date -d "-1 day" +%F`
fi


dws_trade_user_order_1d="
insert overwrite table ${APP}.dws_trade_user_order_1d partition(dt='$do_date')
select
    user_id,
    count(distinct(order_id)),
    sum(sku_num),
    sum(split_original_amount),
    sum(nvl(split_activity_amount,0)),
    sum(nvl(split_coupon_amount,0)),
    sum(split_total_amount)
from ${APP}.dwd_trade_order_detail_inc
#where dt='$do_date'
where  dt>=trunc(date_sub('$do_date',1),'MM') and dt<=date_sub('$do_date',1)
group by user_id;
"

case $1 in

    "dws_trade_user_order_1d" )
        hive -e "$dws_trade_user_order_1d"
    ;;

    "all" )
        hive -e "$dws_trade_user_order_1d"
    ;;
esac
