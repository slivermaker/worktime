DELETE FROM ADS_INVENTORY_STATISTICS WHERE YPERIOD = TRUNC (SYSDATE);

INSERT INTO
    ADS_INVENTORY_STATISTICS (
        YPERIOD, --账期期间 
        COMPANY_NAME, --公司名称 
        MANUFACTURING_DEPT_NAME, --制造部名称 
        FACTORY_NAME, --厂区名称 
        MEASUREMENT_UNITS, --计量单位 
        PRODUCT_FORM, --产品形态 
        INV_BM_WGT, --库存基准 
        INV_ACT_WGT, --实际库存量 
        INV_BEN_M_WGT, --期初库存量 
        ETL_CRT_DT,
        ETL_UPD_DT
    )
SELECT
    TRUNC (SYSDATE) AS YPERIOD, --账期期间 
    T1.SCX AS COMPANY_NAME, --公司名称 
    T1.ZZB AS MANUFACTURING_DEPT_NAME, --制造部名称 
    T1.CQ AS FACTORY_NAME, --厂区名称 
    T1.JLDW AS MEASUREMENT_UNITS, --计量单位 
    T1.PRODUCT_FORM AS PRODUCT_FORM, --产品形态 
    T1.INV_BM_WGT AS INV_BM_WGT, --库存基准 
    NVL (T2.INV_ACT_WGT, 0) AS INV_ACT_WGT, --实际库存量 
    NVL (T2.INV_BEN_M_WGT, 0) AS INV_BEN_M_WGT, --期初库存量 
    SYSDATE AS ETL_CRT_DT,
    SYSDATE AS ETL_UPD_DT
FROM (
        SELECT
            SCX, ZZB, CQ, JLDW, BCPKCJZ AS INV_BM_WGT, '半成品' AS PRODUCT_FORM, ROW_NUMBER() OVER (
                PARTITION BY
                    SCX, ZZB, CQ
                ORDER BY SXRQ DESC
            ) RN
        FROM ODS_ERP.ODS_ERP_ERPSJWHJCB
        UNION ALL
        SELECT
            SCX, ZZB, CQ, JLDW, CPKCJZ AS INV_BM_WGT, '成品' AS PRODUCT_FORM, ROW_NUMBER() OVER (
                PARTITION BY
                    SCX, ZZB, CQ
                ORDER BY SXRQ DESC
            ) RN
        FROM ODS_ERP.ODS_ERP_ERPSJWHJCB
    ) T1
    LEFT JOIN (
        SELECT
            FACTORY_NAME, --厂区名称 
            PRODUCT_FORM, --产品形态 
            SUM(INV_ACT_WGT) AS INV_ACT_WGT, --实际库存量 
            SUM(INV_BEN_M_WGT) AS INV_BEN_M_WGT --期初库存量 
        FROM (
                SELECT
                    CQ AS FACTORY_NAME, --厂区名称 
                    '半成品' AS PRODUCT_FORM, --产品形态 
                    BXCL AS INV_ACT_WGT, --实际库存量 
                    BQCKC AS INV_BEN_M_WGT --期初库存量  
                FROM ODS_ERP.ODS_SCBB_KCSJ --ERP
                WHERE
                    RQ = TO_CHAR (SYSDATE, 'YY.MM.DD')
                UNION ALL
                SELECT
                    CQ AS FACTORY_NAME, '成品' AS PRODUCT_FORM, CXCL AS INV_ACT_WGT, CQCKC AS INV_BEN_M_WGT
                FROM ODS_ERP.ODS_SCBB_KCSJ --ERP
                WHERE
                    RQ = TO_CHAR (SYSDATE, 'YY.MM.DD')
                UNION ALL
                SELECT
                    FACTORY AS FACTORY_NAME, '半成品' AS PRODUCT_FORM, TO_NUMBER (HALFINVENTORY) AS INV_ACT_WGT, TO_NUMBER (HALFBEGIN) AS INV_BEN_M_WGT
                FROM ODS_ERP.ODS_PROD_INVENTORY --管道
                WHERE
                    RQ = TO_CHAR (TRUNC (SYSDATE), 'YY.MM.DD')
                UNION ALL
                SELECT
                    FACTORY AS FACTORY_NAME, '成品' AS PRODUCT_FORM, TO_NUMBER (INVENTORY) AS INV_ACT_WGT, TO_NUMBER (BEGIN) AS INV_BEN_M_WGT
                FROM ODS_ERP.ODS_PROD_INVENTORY --管道
                WHERE
                    RQ = TO_CHAR (TRUNC (SYSDATE), 'YY.MM.DD')
                UNION ALL
                SELECT
                    DECODE (
                        制造部, '铸造事业部', '铸造事业部', '炼铁事业部', '炼铁事业部'
                    ) AS FACTORY_NAME, '半成品' AS PRODUCT_FORM, --产品形态 （配重）
                    半成品当月现存量 AS INV_ACT_WGT, 半成品期初库存 AS INV_BEN_M_WGT
                FROM ODS_MOM.ODS_V_MOM_BANCHENGPIN --威海
                WHERE
                    报表日期 = TO_CHAR (
                        TRUNC (SYSDATE, 'MM'), 'YY.MM'
                    )
                UNION ALL
                SELECT
                    DECODE (
                        制造部, '铸造事业部', '铸造事业部', '炼铁事业部', '炼铁事业部'
                    ) AS FACTORY_NAME, '成品' AS PRODUCT_FORM, --产品形态 （生铁）
                    成品当月现存量 AS INV_ACT_WGT, 成品期初库存 AS INV_BEN_M_WGT
                FROM ODS_MOM.ODS_V_MOM_CHENGPIN --威海
                WHERE
                    报表日期 = TO_CHAR (
                        TRUNC (SYSDATE, 'MM'), 'YY.MM'
                    )
            )
        GROUP BY
            FACTORY_NAME, PRODUCT_FORM
    ) T2 ON T1.CQ = T2.FACTORY_NAME
    AND T1.PRODUCT_FORM = T2.PRODUCT_FORM
WHERE
    T1.RN = 1;

COMMIT;