-- 创建表
CREATE TABLE ods_tpc_bzrkb_wh (
    id NUMBER,
    rq VARCHAR2(2000),
    rkbm VARCHAR2(2000),
    rkdw VARCHAR2(2000),
    ddh VARCHAR2(2000),
    jhq VARCHAR2(2000),
    khm VARCHAR2(2000),
    lh VARCHAR2(2000),
    lch VARCHAR2(2000),
    pz VARCHAR2(2000),
    gg VARCHAR2(2000),
    xs VARCHAR2(2000),
    zl NUMBER,
    zcbm VARCHAR2(2000),
    zcdw VARCHAR2(2000),
    ckbm VARCHAR2(2000),
    ckmc VARCHAR2(2000),
    lqhwh VARCHAR2(2000),
    djlsh VARCHAR2(2000),
    sjly VARCHAR2(2000),
    lry VARCHAR2(2000),
    gxsj DATE,
    ch VARCHAR2(2000),
    cdbs NUMBER,
    lrfsyy VARCHAR2(2000),
    tl NUMBER,
    wg NUMBER,
    tsgh VARCHAR2(2000),
    ztjh VARCHAR2(2000),
    bc VARCHAR2(2000),
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ods_tpc_bzrkb_wh IS '玫德威海成品包装入库表';

-- 添加字段注释
COMMENT ON COLUMN ods_tpc_bzrkb_wh.id IS 'ID';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.rq IS '日期';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.rkdw IS '入库单位';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.ddh IS '订单号';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.jhq IS '交货期';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.khm IS '客户名';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.lh IS '炉号';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.lch IS '炉次号';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.pz IS '品种';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.gg IS '规格';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.xs IS '销售';
COMMENT ON COLUMN ods_tpc_bzrkb_wh.zl IS '重量';
