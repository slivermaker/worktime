CREATE TABLE MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL (
    qsdw VARCHAR2(2000),        -- 欠数单位
    order_id VARCHAR2(2000),         -- 订单号
    PRODUCT_VARIETY VARCHAR2(2000),          -- 品种
    PRODUCT_SPECIFICATION VARCHAR2(2000),          -- 规格
    bmcl VARCHAR2(2000),        -- 表面处理
    qsdwjc NUMBER,              -- 欠数单位结存
    drjqqs NUMBER,              -- 当日交期欠数
    qgxqs NUMBER,               -- 前工序欠数
    qsdwjssj DATE,              -- 欠数单位接收时间
    etl_crt_dt DATE,            -- ETL创建时间
    etl_upd_dt DATE             -- ETL更新时间
);

-- 表注释
COMMENT ON TABLE MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL IS '工序间欠数明细表';

-- 字段注释
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.qsdw IS '欠数单位';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.order_id IS '订单号';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.PRODUCT_VARIETY IS '品种';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.PRODUCT_SPECIFICATION IS '规格';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.bmcl IS '表面处理';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.qsdwjc IS '欠数单位结存';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.drjqqs IS '当日交期欠数';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.qgxqs IS '前工序欠数';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.qsdwjssj IS '欠数单位接收时间';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL.etl_upd_dt IS 'ETL更新时间';



INSERT INTO MDDWD.DWD_FM_JHJDCX_DP_B7_DETAIL (
    qsdw,
    order_id,
    PRODUCT_VARIETY,
    PRODUCT_SPECIFICATION,
    bmcl,
    qsdwjc,
    drjqqs,
    qgxqs,
    qsdwjssj,
    etl_crt_dt,
    etl_upd_dt
)
SELECT 
    ftdw AS qsdw, -- 欠数单位
    ddh AS ddh, -- 订单号
    ftpz AS pz, -- 品种
    ftgg AS gg, -- 规格
    ftbmcl AS bmcl, -- 表面处理
    ftjc AS qsdwjc, -- 欠数单位结存
    ftddqs AS drjqqs, -- 当日交期欠数
    CASE WHEN ftddqs-ftjc < 0 THEN 0 ELSE ftddqs-ftjc END AS "前工序欠数",
    gxsj AS "欠数单位接收时间" ,
    ETL_CRT_DT,
    SYSDATE
FROM 
    ODS_ERP.ODS_FM_JHJDCX_DP_B7