-- 创建表
CREATE TABLE ADS_TGKB_HWJC_SUM (
    qckc NUMBER,
    qmkc NUMBER,
    lb VARCHAR2(2000),
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ADS_TGKB_HWJC_SUM IS '泰钢看板库存汇总表';

-- 添加字段注释
COMMENT ON COLUMN ADS_TGKB_HWJC_SUM.qckc IS '期初库存';
COMMENT ON COLUMN ADS_TGKB_HWJC_SUM.qmkc IS '期末库存';
COMMENT ON COLUMN ADS_TGKB_HWJC_SUM.lb IS '类别';
COMMENT ON COLUMN ADS_TGKB_HWJC_SUM.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ADS_TGKB_HWJC_SUM.etl_upd_dt IS 'ETL更新时间';

-- 插入语句
INSERT INTO ADS_TGKB_HWJC_SUM (qckc, qmkc, lb)
------ 库存 - 成品 - 期初库存与期末库存 
SELECT 
    SUM(zjc * dz / 1000) AS qckc,
    SUM(jjc * dz / 1000) AS qmkc,
    '总体' as lb
FROM ODS_ERP.ODS_tpc_hwjcb_CKYW_TG  
WHERE ckmc NOT LIKE '%待%'

UNION ALL

------ 出口、内销实时库存 
SELECT 
    SUM(qckc) AS qckc,
    SUM(qmkc) AS qmkc,
    lb 
FROM (
    SELECT 
        SUM(zjc * dz / 1000) AS qckc,
        SUM(jjc * dz / 1000) AS qmkc,
        CASE 
            WHEN ckmc LIKE '%出口%' THEN '出口' 
            ELSE '内销'  
        END AS lb  
    FROM ODS_ERP.ODS_tpc_hwjcb_CKYW_TG  
    WHERE ckmc LIKE '%出口%' OR ckmc LIKE '%内销%' 
    GROUP BY ckmc 
) a  
GROUP BY lb;