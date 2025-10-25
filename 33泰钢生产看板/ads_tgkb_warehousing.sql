-- 创建表
CREATE TABLE ADS_TGKB_WAREHOUSING (
    PERIOD DATE,
    label VARCHAR2(2000),
    work_org_name VARCHAR2(2000),
    weight_t NUMBER,
    type VARCHAR2(2000),
    weight_t_m NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ads_tgkb_warehousing IS '泰钢制造部/单位入库';

-- 添加字段注释
COMMENT ON COLUMN ads_tgkb_warehousing.PERIOD IS '日期';
COMMENT ON COLUMN ads_tgkb_warehousing.label IS '标签';
COMMENT ON COLUMN ads_tgkb_warehousing.work_org_name IS '工作组织名称';
COMMENT ON COLUMN ads_tgkb_warehousing.weight_t IS '重量吨';
COMMENT ON COLUMN ads_tgkb_warehousing.type IS '类型';
COMMENT ON COLUMN ads_tgkb_warehousing.weight_t_m IS '月度累计重量吨';
COMMENT ON COLUMN ads_tgkb_warehousing.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_tgkb_warehousing.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ads_tgkb_warehousing (PERIOD, label, work_org_name, weight_t, type, weight_t_m)
WITH tmp AS (
    SELECT 
        yyz_to_date(a.rq, 'YY.MM.DD') AS PERIOD,
        A.RKDW,
        A.BS,
        c.ZZB,
        a.zl
    FROM ods_erp.ods_bzrkb_tg a
    LEFT JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs
    LEFT JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb
)
SELECT
    PERIOD,
    bs as label,
    rkdw as work_org_name,
    sum(zl/1000) as weight_t,
    ' dw' as type,
    SUM(sum(zl)) OVER(
        PARTITION BY RKDW, BS, EXTRACT(YEAR FROM PERIOD), EXTRACT(MONTH FROM PERIOD) 
        ORDER BY period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )/1000 as weight_t_m
FROM TMP 
GROUP BY PERIOD, bs, rkdw, 'dw'

UNION ALL

SELECT
    PERIOD,
    null,
    zzb,
    sum(zl/1000) zl,
    ' zzb' as type,
    SUM(sum(zl)) OVER(
        PARTITION BY zzb, EXTRACT(YEAR FROM PERIOD), EXTRACT(MONTH FROM PERIOD) 
        ORDER BY period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )/1000 as zl_sum
FROM TMP 
GROUP BY PERIOD, zzb, 'zzb';