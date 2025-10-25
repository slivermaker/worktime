
select 
WC_NAME
,SO_NO
,PLN_QTY
,COMPLETED_QTY
,STANDARD
,QUALIFIED_QUANTITY
,YIELD_RATE
,PRODUCTION_PROGRESS
,PLN_BEGIN
from mom_zg_sync_inf.production_summary_view


CREATE TABLE ods_production_summary_view (
    WC_NAME VARCHAR2(2000),
    SO_NO VARCHAR2(2000),
    PLN_QTY NUMBER,
    COMPLETED_QTY NUMBER,
    STANDARD VARCHAR2(2000),
    QUALIFIED_QUANTITY NUMBER,
    YIELD_RATE NUMBER,
    PRODUCTION_PROGRESS NUMBER,
    PLN_BEGIN DATE,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ods_production_summary_view IS '临沂铸管看板生产汇总视图表';

COMMENT ON COLUMN ods_production_summary_view.WC_NAME IS '资源名称';
COMMENT ON COLUMN ods_production_summary_view.SO_NO IS '销售订单号';
COMMENT ON COLUMN ods_production_summary_view.PLN_QTY IS '计划数量';
COMMENT ON COLUMN ods_production_summary_view.COMPLETED_QTY IS '完工数量';
COMMENT ON COLUMN ods_production_summary_view.STANDARD IS '规格';
COMMENT ON COLUMN ods_production_summary_view.QUALIFIED_QUANTITY IS '';
COMMENT ON COLUMN ods_production_summary_view.YIELD_RATE IS '';
COMMENT ON COLUMN ods_production_summary_view.PRODUCTION_PROGRESS IS '';
COMMENT ON COLUMN ods_production_summary_view.PLN_BEGIN IS '计划开始时间';
COMMENT ON COLUMN ods_production_summary_view.etl_crt_dt IS '';
COMMENT ON COLUMN ods_production_summary_view.etl_upd_dt IS '';