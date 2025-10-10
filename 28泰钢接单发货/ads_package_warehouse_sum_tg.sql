

period  日期
warehoursing_type--入库材质
group_name--入库单位
warehoursing_weight_t入库重量
fine_packaging_cnt精装件数
fine_packaging_wgt_T精装吨位


CREATE TABLE ads_package_warehouse_sum_tg (
    period DATE,
    warehousing_type VARCHAR2(2000),
    group_name VARCHAR2(2000),
    warehousing_weight_t NUMBER,
    fine_packaging_cnt NUMBER,
    fine_packaging_wgt_T NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ads_package_warehouse_sum_tg IS '包装入库汇总表';

COMMENT ON COLUMN ads_package_warehouse_sum_tg.period IS '日期';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.warehousing_type IS '入库材质';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.group_name IS '入库单位';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.warehousing_weight_t IS '入库重量';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.fine_packaging_cnt IS '精装件数';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.fine_packaging_wgt_T IS '精装吨位';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.etl_crt_dt IS 'ETL创建日期';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.etl_upd_dt IS 'ETL更新日期';