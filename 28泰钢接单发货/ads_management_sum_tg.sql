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