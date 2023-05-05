DROP TABLE IF EXISTS dws_trade_user_order_1d;
CREATE EXTERNAL TABLE dws_trade_user_order_1d
(
    `user_id`                   STRING COMMENT '用户id',
    `order_count_1d`            BIGINT COMMENT '最近1m下单次数',
    `order_num_1d`              BIGINT COMMENT '最近1m下单商品件数',
    `order_original_amount_1m`  DECIMAL(16, 2) COMMENT '最近1m最近1m下单原始金额',
    `activity_reduce_amount_1m` DECIMAL(16, 2) COMMENT '最近1m下单活动优惠金额',
    `coupon_reduce_amount_1m`   DECIMAL(16, 2) COMMENT '下单优惠券优惠金额',
    `order_total_amount_1m`     DECIMAL(16, 2) COMMENT '最近1m下单最终金额'
) COMMENT '交易域用户粒度订单最近1m汇总事实表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_trade_user_order_1d'
    TBLPROPERTIES ('orc.compress' = 'snappy');
