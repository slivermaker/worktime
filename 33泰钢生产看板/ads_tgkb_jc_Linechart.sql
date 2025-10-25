-- 创建表
CREATE TABLE ads_tgkb_jc_Linechart (
    period DATE,
    period_m DATE,
    work_org_name VARCHAR2(2000),
    jjcz NUMBER,
    jncz NUMBER,
    jwcz NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ads_tgkb_jc_Linechart IS '泰钢看板结存折线图表';

-- 添加字段注释
COMMENT ON COLUMN ads_tgkb_jc_Linechart.period IS '日期';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.period_m IS '月份';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.work_org_name IS '工作组织名称';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.jjcz IS '计件存重';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.jncz IS '计内存重';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.jwcz IS '计外存重';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_tgkb_jc_Linechart.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ADS_TGKB_JC_LINECHART (period, period_m, work_org_name, jjcz, jncz, jwcz)
------- 折线图数据 - 库存汇总
SELECT 
    TO_DATE(RQ,'YY.MM.DD') AS PERIOD,
    TRUNC(TO_DATE(RQ,'YY.MM.DD'),'MM') AS PERIOD_M,
    '总体' AS WORK_ORG_NAME,
    SUM(zl) AS jjcz,
    SUM(zl - jwcz) AS jncz,
    SUM(jwcz) AS jwcz   
FROM ods_erp.ods_jchzjl_tg 
GROUP BY TO_DATE(RQ,'YY.MM.DD'), TRUNC(TO_DATE(RQ,'YY.MM.DD'),'MM')

UNION ALL

------- 制造部维度 - 折线图数据
SELECT 
    a.PERIOD,
    TRUNC(A.PERIOD,'MM') AS PERIOD_M,
    c.zzb,
    SUM(jjcz) AS jjcz,
    SUM(jncz) AS jncz,
    SUM(jwcz) AS jwcz 
FROM (
    SELECT 
        TO_DATE(RQ,'YY.MM.DD') AS PERIOD,
        cb,
        SUM(zl) AS jjcz,
        SUM(zl - jwcz) AS jncz,
        SUM(jwcz) AS jwcz   
    FROM ods_erp.ods_jchzjl_tg 
    GROUP BY rq, cb  
) a 
JOIN ods_erp.ods_cbzzbb_tg c ON a.cb = c.cb   
GROUP BY c.zzb, a.PERIOD, TRUNC(A.PERIOD,'MM');