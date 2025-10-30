-- 创建表
CREATE TABLE ods_mkfm_by_recordlist_custom (
    id VARCHAR2(2000),
    czcbh VARCHAR2(2000),
    csbmc VARCHAR2(2000),
    cggxh VARCHAR2(2000),
    cdw VARCHAR2(2000),
    cstandard VARCHAR2(2000),
    izq VARCHAR2(2000),
    czqlx VARCHAR2(2000),
    cpartcode VARCHAR2(2000),
    cpartname VARCHAR2(2000),
    iquantity VARCHAR2(2000),
    cunit VARCHAR2(2000),
    isfinished VARCHAR2(2000),
    cmaker VARCHAR2(2000),
    ddate DATE,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ods_mkfm_by_recordlist_custom IS '备件记录清单表';

-- 添加字段注释
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.id IS 'ID';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.czcbh IS '资产编号';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.csbmc IS '设备名称';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cggxh IS '规格型号';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cdw IS '单位';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cstandard IS '保养内容';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.izq IS '周期';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.czqlx IS '周期类型';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cpartcode IS '物料代码';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cpartname IS '物料名称';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.iquantity IS '数量';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cunit IS '单位';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.isfinished IS '是否完成';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.cmaker IS '制单人';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.ddate IS '日期';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ods_mkfm_by_recordlist_custom.etl_upd_dt IS 'ETL更新时间';














-------------------------------