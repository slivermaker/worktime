期初：select cpbm,sum(qc) from tpc_hwjcb where cpbm in(基础表) group by cpbm

入库：select cpbm,sum(lq) from tpc_hwjcb where cpbm in(基础表) and hwh<>’f’ group by cpbm

出库：select cpbm,sum(zc) from tpc_hwjcb where cpbm in(基础表) and hwh=’f’ group by cpbm

今结存：select cpbm,sum(jjc) from tpc_hwjcb where cpbm in(基础表) and hwh<>’f’ group by cpbm






WITH TMP AS (
    SELECT 
        B.PERIOD,
        A.PRODUCT_TYPE_SC,
        A.PRODUCT_CODE,
        SUM(B.BEGINNING_INVENTORY) AS BEGINNING_INVENTORY
    FROM 
        MDDWD.DWD_STKCFLB A
        LEFT JOIN MDDWD.DWD_TPC_HWJCB B
        ON A.PRODUCT_CODE = (CASE WHEN B.PRODUCT_SPECIFICATION IS NULL OR B.PRODUCT_SPECIFICATION='' 
                               THEN B.PRODUCT_VARIETY 
                               ELSE B.PRODUCT_VARIETY ||'_'|| B.PRODUCT_SPECIFICATION END)  
    WHERE
        A.PRODUCT_CODE IN (
            SELECT PRODUCT_CODE
            FROM MDDWD.DWD_XSGXDYB C
            WHERE
                C.PRODUCT_SORT1 = '球铁'
                AND C.START_TIME <= SYSDATE
                AND C.END_TIME >= SYSDATE
        )
    GROUP BY 
        B.PERIOD,
        A.PRODUCT_TYPE_SC,
        A.PRODUCT_CODE
)



SELECT 
    PERIOD,             --日期
    PRODUCT_TYPE_SC,    --产品类型
    PRODUCT_CODE,
    BEGINNING_INVENTORY, --期初结存
    LAG(BEGINNING_INVENTORY, 12) OVER (PARTITION BY PRODUCT_TYPE_SC, PRODUCT_CODE ORDER BY PERIOD) AS SAMEP_MONTH_INVENTORY,  --同期结存
    LAG(BEGINNING_INVENTORY, 1) OVER (PARTITION BY PRODUCT_TYPE_SC, PRODUCT_CODE ORDER BY PERIOD) AS LAST_MONTH_INVENTORY       --上月结存  
FROM TMP
