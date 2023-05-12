ALTER   TABLE  gmall.ods_order_info_inc ARCHIVE PARTITION(dt='2023-05-03');

hadoop archive -archiveName data.har -p /warehouse/gmall/ods/ods_order_detail_inc/dt=2023-05-03 dir1 dir2 /warehouse/gmall/ods/ods_order_detail_inc/dt=2023-05-03/data.har


