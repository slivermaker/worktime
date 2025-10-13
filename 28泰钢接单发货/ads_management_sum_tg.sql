CREATE TABLE ads_management_sum_tg (
    period DATE,
    management_type VARCHAR2(2000),
    weight_T NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ads_management_sum_tg IS '泰钢接单发货管理汇总表';

COMMENT ON COLUMN ads_management_sum_tg.period IS '日期';
COMMENT ON COLUMN ads_management_sum_tg.management_type IS '项目类型';
COMMENT ON COLUMN ads_management_sum_tg.weight_T IS '重量';
COMMENT ON COLUMN ads_management_sum_tg.etl_crt_dt IS 'ETL创建日期';
COMMENT ON COLUMN ads_management_sum_tg.etl_upd_dt IS 'ETL更新日期';






INSERT INTO MDADS.ads_management_sum_tg(
PERIOD,
WEIGHT_t,
MANAGEMENT_TYPE
)
with rk as (
     select period,
            sum(WAREHOUSING_WEIGHT_T) AS WEIGHT_T,
            '入库' as type
            from mdads.ads_package_warehouse_sum_tg group by period
),fh as(
select period,
       SUM(weight_t)AS WEIGHT_T,
       '发货' as type
       from MDADS.ADS_SHIPMENT_SUM_TG
       group by period
), jd as(
   select period ,
          SUM(ORDER_WGT_T) AS WEIGHT_T,
          '接单' AS TYPE
          FROM MDADS.ADS_ORDER_RECEIVE_SUMMARY_TG
          GROUP BY PERIOD
)
select 
          PERIOD,
          WEIGHT_T,
          TYPE
      FROM RK
UNION ALL
      select 
          PERIOD,
          WEIGHT_T,
          TYPE
      FROM JD
 UNION ALL
 select 
          PERIOD,
          WEIGHT_T,
          TYPE
      FROM FH   