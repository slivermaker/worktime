CREATE TABLE ODS_ERP.ODS_STKCFLB (
    ID     NUMBER        ,   
    CPLX   VARCHAR2(2000),               -- 产品类型
    CPBM   VARCHAR2(2000),               -- 产品编码
    KCZB   NUMBER,              -- 库存占比
    DXL    NUMBER,              -- 动销量
    KCXX   NUMBER,              -- 库存下限
    KCSX   NUMBER,              -- 库存上限
    BZ     VARCHAR2(2000),              -- 备注
    LRY    VARCHAR2(2000),               -- 录入人
    GXSJ   DATE                        -- 更新时间（日期时间）
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