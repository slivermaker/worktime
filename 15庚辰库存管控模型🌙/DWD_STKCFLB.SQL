CREATE TABLE MDDWD.DWD_STKCFLB (
    ID     NUMBER        ,   
    PRODUCT_TPYE_SC   VARCHAR2(2000),               -- 产品类型
    PRODUCT_CODE   VARCHAR2(2000),               -- 产品编码
    INVENTORY_RATIO   NUMBER,              -- 库存占比
    SALES_ACTIVITY_RATIO    NUMBER,              -- 动销率
    stock_floor    NUMBER,              -- 库存下限
    stock_ceiling   NUMBER,              -- 库存上限
    remark     VARCHAR2(2000),              -- 备注
    LRY    VARCHAR2(2000),               -- 录入人
    update_time   DATE                        -- 更新时间（日期时间）
);