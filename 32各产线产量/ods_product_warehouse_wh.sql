-- 创建表
CREATE TABLE ODS_PRODUCT_WAREHOUSE_WH (
    rq DATE,
    jhq DATE,
    rkdw VARCHAR2(2000),
    rkbm VARCHAR2(2000),
    pz VARCHAR2(2000),
    gg VARCHAR2(2000),
    xs VARCHAR2(2000),
    zl NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ods_product_warehouse_wh IS '成品入库表统一入库威海';

-- 添加字段注释
COMMENT ON COLUMN ods_product_warehouse_wh.rq IS '日期';
COMMENT ON COLUMN ods_product_warehouse_wh.jhq IS '交货期';
COMMENT ON COLUMN ods_product_warehouse_wh.rkdw IS '入库单位';
COMMENT ON COLUMN ods_product_warehouse_wh.rkbm IS '入库编码';
COMMENT ON COLUMN ods_product_warehouse_wh.pz IS '品种';
COMMENT ON COLUMN ods_product_warehouse_wh.gg IS '规格';
COMMENT ON COLUMN ods_product_warehouse_wh.xs IS '形式';
COMMENT ON COLUMN ods_product_warehouse_wh.zl IS '重量';
COMMENT ON COLUMN ods_product_warehouse_wh.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ods_product_warehouse_wh.etl_upd_dt IS 'ETL更新时间';




