-- 创建表
CREATE TABLE ADS_TGKB_FINISH_RATE (
    period DATE,
    zzb VARCHAR2(2000),
    weight_t NUMBER,
    rkmb NUMBER,
    finish_rate NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ads_tgkb_finish_rate IS '完成率分析表';

-- 添加字段注释
COMMENT ON COLUMN ads_tgkb_finish_rate.period IS '期间';
COMMENT ON COLUMN ads_tgkb_finish_rate.zzb IS '制造部';
COMMENT ON COLUMN ads_tgkb_finish_rate.weight_t IS '重量吨';
COMMENT ON COLUMN ads_tgkb_finish_rate.rkmb IS '入库目标';
COMMENT ON COLUMN ads_tgkb_finish_rate.finish_rate IS '完成率';
COMMENT ON COLUMN ads_tgkb_finish_rate.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_tgkb_finish_rate.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ads_tgkb_finish_rate (period, zzb, weight_t, rkmb, finish_rate)
WITH tmp_rk AS (
     SELECT period, ZZB, SUM(WEIGHT_T_M) AS WEIGHT_T 
     FROM ADS_TGKB_WAREHOUSING 
     GROUP BY PERIOD, ZZB
), tmp_mb AS (
     SELECT to_date(yf,'YY.MM') AS PERIOD, ZZB, RKMB 
     FROM ODS_ERP.ODS_TGRKMB_TG
)
SELECT 
    A.PERIOD,
    A.ZZB,
    A.WEIGHT_T,
    B.RKMB,
    A.WEIGHT_T / B.RKMB AS FINISH_RATE
FROM TMP_RK A 
LEFT JOIN TMP_MB B ON TRUNC(A.PERIOD,'MM') = B.PERIOD AND A.ZZB = B.ZZB;