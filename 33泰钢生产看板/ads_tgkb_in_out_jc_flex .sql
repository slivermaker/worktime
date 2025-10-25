-- 创建表
CREATE TABLE ADS_TGKB_IN_OUT_JC_FLEX (
    period DATE,
    work_org_name VARCHAR2(2000),
    jncz NUMBER,
    jwcz NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ads_tgkb_in_out_jc_flex IS '泰钢看板计内存计外存表';

-- 添加字段注释
COMMENT ON COLUMN ads_tgkb_in_out_jc_flex.period IS '期间';
COMMENT ON COLUMN ads_tgkb_in_out_jc_flex.work_org_name IS '工作组织名称';
COMMENT ON COLUMN ads_tgkb_in_out_jc_flex.jncz IS '计内存重';
COMMENT ON COLUMN ads_tgkb_in_out_jc_flex.jwcz IS '计外存重';
COMMENT ON COLUMN ads_tgkb_in_out_jc_flex.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_tgkb_in_out_jc_flex.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ads_tgkb_in_out_jc_flex (period, work_org_name, jncz, jwcz)
------------ 计内存 - 计外存
SELECT 
    to_date(TABLE_TIME,'YYYYMM') AS PERIOD,
    '总体' AS WORK_ORG_NAME,
    SUM(jnc * dz / 1000) AS jncz,
    SUM(jwc * dz / 1000) AS jwcz  
FROM ODS_ERP.ODS_JCB_CKYW_TG
WHERE bs IN (
    SELECT DISTINCT bs  
    FROM ODS_ERP.ODS_MLB_TG 
    WHERE jclb <> '芯子'
)
GROUP BY to_date(TABLE_TIME,'YYYYMM')

UNION ALL

------- 制造部维度 - 计内存计外存
SELECT 
    A.PERIOD,
    c.zzb,
    SUM(jncz) AS jncz,
    SUM(jwcz) AS jwcz 
FROM (
    SELECT 
        to_date(TABLE_TIME,'YYYYMM') AS PERIOD,
        bs,
        SUM(jnc * dz / 1000) AS jncz,
        SUM(jwc * dz / 1000) AS jwcz  
    FROM ODS_ERP.ODS_JCB_CKYW_TG
    WHERE bs IN (
        SELECT DISTINCT bs  
        FROM ODS_ERP.ODS_MLB_TG 
        WHERE jclb <> '芯子'
    ) 
    GROUP BY bs, to_date(TABLE_TIME,'YYYYMM')
) a 
JOIN ODS_ERP.ODS_MLB_TG b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb   
GROUP BY c.zzb, A.PERIOD;