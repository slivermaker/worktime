CREATE TABLE dwd_transfer_all (
    period                 DATE,
    production_line        VARCHAR2(2000),
    factory                VARCHAR2(2000),
    PRODUCT_VARIETY        VARCHAR2(2000),
    PRODUCT_SPECIFICATION  VARCHAR2(2000),
    PRODUCT_FORM           VARCHAR2(2000),
    PRODUCT_TEXTURE        VARCHAR2(2000),
    SURFACE_TREATMENT      VARCHAR2(2000),
    transfer_PCS           NUMBER,
    WEIGHT_kg              NUMBER,
    unit_weight            number,
    OUTWARE_id             VARCHAR2(2000),
    OUTWARE_ORG            VARCHAR2(2000),
    GETWARE_ORG            VARCHAR2(2000),
    GETWARE_id             VARCHAR2(2000),
    etl_crt_dt             DATE DEFAULT SYSDATE,
    etl_upd_dt             DATE DEFAULT SYSDATE
);

COMMENT ON TABLE dwd_transfer_all IS 'dwd_transfer_all';

COMMENT ON COLUMN dwd_transfer_all.period IS 'period';
COMMENT ON COLUMN dwd_transfer_all.production_line IS 'production_line';
COMMENT ON COLUMN dwd_transfer_all.factory IS 'factory';
COMMENT ON COLUMN dwd_transfer_all.PRODUCT_VARIETY IS 'PRODUCT_VARIETY';
COMMENT ON COLUMN dwd_transfer_all.PRODUCT_SPECIFICATION IS 'PRODUCT_SPECIFICATION';
COMMENT ON COLUMN dwd_transfer_all.PRODUCT_FORM IS 'PRODUCT_FORM';
COMMENT ON COLUMN dwd_transfer_all.PRODUCT_TEXTURE IS 'PRODUCT_TEXTURE';
COMMENT ON COLUMN dwd_transfer_all.SURFACE_TREATMENT IS 'SURFACE_TREATMENT';
COMMENT ON COLUMN dwd_transfer_all.transfer_PCS IS 'transfer_PCS';
COMMENT ON COLUMN dwd_transfer_all.WEIGHT_kg IS 'WEIGHT_kg';
COMMENT ON COLUMN dwd_transfer_all.unit_weight IS 'unit_weight';
COMMENT ON COLUMN dwd_transfer_all.OUTWARE_id IS 'OUTWARE_id';
COMMENT ON COLUMN dwd_transfer_all.OUTWARE_ORG IS 'OUTWARE_ORG';
COMMENT ON COLUMN dwd_transfer_all.GETWARE_ORG IS 'GETWARE_ORG';
COMMENT ON COLUMN dwd_transfer_all.GETWARE_id IS 'GETWARE_id';
COMMENT ON COLUMN dwd_transfer_all.etl_crt_dt IS 'etl_crt_dt';
COMMENT ON COLUMN dwd_transfer_all.etl_upd_dt IS 'etl_upd_dt';




 
