
INSERT INTO MDDWD.DWD_FM_JHJDCX_DP_B7 (
    operation_name,
    ORDER_shortage,
    sjctgg,
    order_count,
    quantity_ratio,
    etl_crt_dt,
    etl_upd_dt
)
SELECT 
    gxmc,
    ddqs,
    sjctgg,
    ddgs,
    jszbl,
    SYSDATE,
    SYSDATE
FROM (
    SELECT
        '前工序汇总' AS gxmc, -- 工序名称
        SUM(ftddqs) AS ddqs, -- 订单欠数
        COUNT(DISTINCT pz || gg || xs) AS sjctgg, -- 涉及成套规格
        COUNT(DISTINCT ddh) AS ddgs, -- 订单个数
        '100%' AS jszbl, -- 件数占比率
        MIN(ETL_CRT_DT),
        SYSDATE
    FROM
        ODS_ERP.ODS_FM_JHJDCX_DP_B7
    
    UNION ALL
    
    SELECT
        ftdw AS gxmc,
        SUM(ftddqs) AS ddqs,
        COUNT(DISTINCT pz || gg || xs) AS sjctgg,
        COUNT(DISTINCT ddh) AS ddgs,
        TO_CHAR(
            ROUND(
                SUM(ftddqs) * 100.00 / (SELECT SUM(ftddqs) FROM ODS_ERP.ODS_FM_JHJDCX_DP_B7), 
                2
            )
        ) || '%' AS jszbl,
        MIN(ETL_CRT_DT),
        SYSDATE
    FROM
        ODS_ERP.ODS_FM_JHJDCX_DP_B7
    GROUP BY
        ftdw
)
ORDER BY
    ddqs DESC