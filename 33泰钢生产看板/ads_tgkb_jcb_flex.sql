-- 创建表
CREATE TABLE ADS_TGKB_JCB_FLEX (
    period DATE,
    work_org_name VARCHAR2(2000),
    qckc NUMBER,
    qmkc NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ads_tgkb_jcb_flex IS '泰钢看板半成品库存表';

-- 添加字段注释
COMMENT ON COLUMN ads_tgkb_jcb_flex.period IS '期间';
COMMENT ON COLUMN ads_tgkb_jcb_flex.work_org_name IS '工作组织名称';
COMMENT ON COLUMN ads_tgkb_jcb_flex.qckc IS '期初库存';
COMMENT ON COLUMN ads_tgkb_jcb_flex.qmkc IS '期末库存';
COMMENT ON COLUMN ads_tgkb_jcb_flex.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_tgkb_jcb_flex.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ads_tgkb_jcb_flex (period, work_org_name, qckc, qmkc)
----- 库存 - 半成品 - 期初库存与期末库存 
SELECT 
    to_date(TABLE_TIME,'YYYYMM') as period,
    '总体' AS WORK_ORG_NAME,
    SUM(zjc * dz / 1000) AS qckc,
    SUM(jjc * dz / 1000) AS qmkc 
FROM ODS_ERP.ODS_JCB_CKYW_TG
WHERE bs IN (
    SELECT DISTINCT bs  
    FROM ODS_ERP.ODS_MLB_TG 
    WHERE jclb <> '芯子'
)
GROUP BY to_date(TABLE_TIME,'YYYYMM')

UNION ALL

------- 制造部维度 - 半成品库存
SELECT 
    period,
    c.zzb AS WORK_ORG_NAME,
    SUM(qckc) AS qckc,
    SUM(qmkc) AS qmkc 
FROM (
    SELECT 
        bs,
        SUM(zjc * dz / 1000) AS qckc,
        SUM(jjc * dz / 1000) AS qmkc,  
        to_date(TABLE_TIME,'YYYYMM') as period
    FROM ODS_ERP.ODS_JCB_CKYW_TG
    WHERE bs IN (
        SELECT DISTINCT bs  
        FROM ODS_ERP.ODS_MLB_TG 
        WHERE jclb <> '芯子'
    ) 
    AND bs IS NOT NULL
    AND bs <> ' '
    AND (jjc <> 0 OR zjc <> 0) 
    GROUP BY bs, to_date(TABLE_TIME,'YYYYMM')
) a 
JOIN ODS_ERP.ODS_MLB_TG b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb   
GROUP BY c.zzb, period;