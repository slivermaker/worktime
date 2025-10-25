-- 创建表
CREATE TABLE ADS_TGKB_WAREHOUSING_LINECHART (
    PERIOD DATE,
    PERIOD_M DATE,
    WORK_ORG_NAME VARCHAR2(2000),
    WEIGHT_T NUMBER,
    TYPE VARCHAR2(2000),
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ADS_TGKB_WAREHOUSING_LINECHART IS '泰钢看板入库折线图数据表';

-- 添加字段注释
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.PERIOD IS '日期';
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.PERIOD_M IS '月份';
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.WORK_ORG_NAME IS '工作组织';
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.WEIGHT_T IS '重量吨';
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.TYPE IS '类型';
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ADS_TGKB_WAREHOUSING_LINECHART.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ADS_TGKB_WAREHOUSING_LINECHART (PERIOD, PERIOD_M, WORK_ORG_NAME, WEIGHT_T, TYPE)
------ 折线图数据（总体）
SELECT 
    yyz_to_date(rq,'YY.MM.DD') AS PERIOD,
    trunc(yyz_to_date(rq,'YY.MM.DD'),'MM') AS PERIOD_M,
    '总体' as WORK_ORG_NAME,
    SUM(zl / 1000) WEIGHT_T,
    'zzb' as type 
FROM ods_erp.ods_bzrkb_tg  
GROUP BY yyz_to_date(rq,'YY.MM.DD'), trunc(yyz_to_date(rq,'YY.MM.DD'),'MM')   

UNION ALL

------ 折线图数据（制造部）
SELECT 
    a.PERIOD,
    TRUNC(A.PERIOD,'MM') AS PERIOD_M,
    c.zzb as WORK_ORG_NAME,
    SUM(zl) WEIGHT_T ,
    'zzb' as type
FROM (
    SELECT 
        bs,
        yyz_to_date(rq,'YY.MM.DD') AS PERIOD,
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg  
    GROUP BY bs, yyz_to_date(rq,'YY.MM.DD')   
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb  
GROUP BY a.PERIOD, c.zzb,TRUNC(A.PERIOD,'MM')

UNION ALL

------ 折线图数据（单位）
SELECT 
    yyz_to_date(rq,'YY.MM.DD') AS PERIOD,
    trunc(yyz_to_date(rq,'YY.MM.DD'),'MM') AS PERIOD_M,
    rkdw as WORK_ORG_NAME,
    SUM(zl / 1000) WEIGHT_T ,
    'dw'as type
FROM ods_erp.ods_bzrkb_tg 
GROUP BY yyz_to_date(rq,'YY.MM.DD'),
    trunc(yyz_to_date(rq,'YY.MM.DD'),'MM') ,
    rkdw;