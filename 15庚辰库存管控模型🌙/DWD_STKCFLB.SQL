CREATE TABLE MDDWD.DWD_STKCFLB (
    ID     NUMBER        ,   
    PRODUCT_TPYE_SC   VARCHAR2(2000),               -- 产品类型
    PRODUCT_CODE   VARCHAR2(2000),               -- 产品编码
    INVENTORY_RATIO   NUMBER,              -- 库存占比
    SALES_ACTIVITY_RATIO    NUMBER,              -- 动销率
    STOCK_FLOOR    NUMBER,              -- 库存下限
    STOCK_CEILING   NUMBER,              -- 库存上限
    REMARK     VARCHAR2(2000),              -- 备注
    LRY    VARCHAR2(2000),               -- 录入人
    UPDATE_TIME   DATE                        -- 更新时间（日期时间）
);



UPDATE ODS_ERP.ODS_STKCFLB T
SET 
    KCZB = COALESCE(KCZB, (
        SELECT KCZB 
        FROM ODS_ERP.ODS_STKCFLB A 
        WHERE A.CPLX = T.CPLX AND A.KCZB IS NOT NULL
    )),
    DXL = COALESCE(DXL, (
        SELECT DXL
        FROM ODS_ERP.ODS_STKCFLB A 
        WHERE A.CPLX = T.CPLX AND A.DXL IS NOT NULL
    ))
WHERE KCZB IS NULL OR DXL IS NULL;




TRUNCATE TABLE MDDWD.DWD_STKCFLB;
INSERT INTO MDDWD.DWD_STKCFLB(
    PERIOD,
    ID,   
    PRODUCT_TYPE_SC,               -- 产品类型
    PRODUCT_CODE,               -- 产品编码
    INVENTORY_RATIO,              -- 库存占比
    SALES_ACTIVITY_RATIO,              -- 动销率

    STOCK_FLOOR,              -- 库存下限
    STOCK_CEILING,              -- 库存上限
    REMARK,              -- 备注
    LRY,               -- 录入人
    UPDATE_TIME,   -- 更新时间（日期时间）
    START_DATE,    --开始日期
    END_DATE,    --结束日期                        
    ETL_CRT_DT,
    ETL_UPD_DT

)

SELECT 
    B.PERIOD_DATE AS PERIOD,  -- 新增：从日期维度表获取标准日期
    A.ID,
    A.CPLX AS PRODUCT_TYPE_SC,
    A.CPBM AS PRODUCT_CODE,
    A.KCZB AS INVENTORY_RATIO,
    A.DXL AS SALES_ACTIVITY_RATIO,
    A.KCXX AS STOCK_FLOOR,
    A.KCSX AS STOCK_CEILING,
    A.BZ AS REMARK,
    A.LRY,
    A.GXSJ AS UPDATE_TIME,
    TO_DATE(A.KSRQ,'YYYY.MM.DD'),
    TO_DATE(A.JZRQ,'YYYY.MM.DD'),
    A.ETL_CRT_DT,
    A.ETL_UPD_DT

FROM 
    ODS_ERP.ODS_STKCFLB A
    CROSS JOIN MDDIM.DIM_MONTH_D B
WHERE 
    B.PERIOD_DATE > DATE '2023-12-1'
    AND B.PERIOD_DATE < SYSDATE

