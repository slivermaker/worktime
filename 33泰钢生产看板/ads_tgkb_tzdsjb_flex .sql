-- 创建表
CREATE TABLE ADS_TGKB_TZDSJB_FLEX (
    period DATE,
    work_org_name VARCHAR2(2000),
    yks NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ads_tgkb_tzdsjb_flex IS '泰钢看板盈亏数据表';

-- 添加字段注释
COMMENT ON COLUMN ads_tgkb_tzdsjb_flex.period IS '期间';
COMMENT ON COLUMN ads_tgkb_tzdsjb_flex.work_org_name IS '工作组织名称';
COMMENT ON COLUMN ads_tgkb_tzdsjb_flex.yks IS '盈亏数';
COMMENT ON COLUMN ads_tgkb_tzdsjb_flex.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_tgkb_tzdsjb_flex.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ads_tgkb_tzdsjb_flex (period, work_org_name, yks)
------ 库存 - 盈亏数据
SELECT 
    TRUNC(to_date(rq,'YY.MM.DD'),'MM') AS PERIOD,
    '总体' as WORK_ORG_NAME,
    SUM(js * dz / 1000) AS yks 
FROM ods_erp.ods_tzdsjb_tg  
WHERE bs IN (
    SELECT DISTINCT bs  
    FROM ODS_ERP.ODS_MLB_TG 
    WHERE jclb <> '芯子'
)
GROUP BY TRUNC(to_date(rq,'YY.MM.DD'),'MM')

UNION ALL

------- 制造部维度 - 盈亏数据
SELECT 
    TRUNC(PERIOD,'MM') AS PERIOD,
    c.zzb as WORK_ORG_NAME,
    SUM(yks) AS yks 
FROM (
    SELECT 
        to_date(rq,'YY.MM.DD') AS PERIOD,
        bs,
        SUM(js * dz / 1000) AS yks 
    FROM ODS_ERP.ODS_tzdsjb_TG  
    WHERE bs IN (
        SELECT DISTINCT bs  
        FROM ODS_ERP.ODS_MLB_TG 
        WHERE jclb <> '芯子'
    ) 
    GROUP BY bs, to_date(rq,'YY.MM.DD')
) a 
JOIN ODS_ERP.ODS_MLB_TG b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb   
GROUP BY c.zzb, TRUNC(PERIOD,'MM');