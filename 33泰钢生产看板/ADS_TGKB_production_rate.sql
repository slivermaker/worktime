-- 创建表
CREATE TABLE ADS_TGKB_production_rate (
    PERIOD DATE,
    WORK_ORG_NAME VARCHAR2(2000),
    LABEL VARCHAR2(2000),
    WEIGHT_T NUMBER,
    WEIGHT_RATE NUMBER,
    TYPE VARCHAR2(2000),
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ADS_TGKB_production_rate IS '泰钢看板产量占比';

-- 添加字段注释
COMMENT ON COLUMN ADS_TGKB_production_rate.PERIOD IS '期间';
COMMENT ON COLUMN ADS_TGKB_production_rate.WORK_ORG_NAME IS '工作组织';
COMMENT ON COLUMN ADS_TGKB_production_rate.LABEL IS '标示';
COMMENT ON COLUMN ADS_TGKB_production_rate.WEIGHT_T IS '重量吨';
COMMENT ON COLUMN ADS_TGKB_production_rate.WEIGHT_RATE IS '占比';
COMMENT ON COLUMN ADS_TGKB_production_rate.TYPE IS '类型';
COMMENT ON COLUMN ADS_TGKB_production_rate.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ADS_TGKB_production_rate.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ADS_TGKB_PRODUCTION_RATE (PERIOD, WORK_ORG_NAME, LABEL, WEIGHT_T, WEIGHT_RATE, TYPE)
SELECT 
    A.PERIOD,
    c.zzb AS WORK_ORG_NAME,
    NULL AS LABEL,
    SUM(a.zl) AS WEIGHT_T,
    SUM(a.zl) / SUM(SUM(A.ZL)) OVER(PARTITION BY A.PERIOD) AS WEIGHT_RATE,
    'zzb' as type
FROM (
    SELECT 
        TRUNC(yyz_to_date(rq,'YY.MM.DD'),'MM') AS PERIOD ,
        bs,
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg 
    GROUP BY bs ,TRUNC(yyz_to_date(rq,'YY.MM.DD'),'MM')
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb 
GROUP BY c.zzb,A.PERIOD

UNION ALL

SELECT 
    a.PERIOD,
    c.zzb,
    a.bs,
    a.zl,
    a.zl / SUM(a.zl) OVER(PARTITION BY c.zzb, a.PERIOD) AS zb,
    'dw' as type
FROM (
    SELECT 
        bs,
        trunc(yyz_to_date(rq,'YY.MM.DD'),'MM') AS PERIOD ,
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg 
    GROUP BY bs, trunc(yyz_to_date(rq,'YY.MM.DD'),'MM') 
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb;