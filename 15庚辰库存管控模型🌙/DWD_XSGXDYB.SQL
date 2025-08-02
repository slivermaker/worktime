CREATE TABLE MDDWD.DWD_XSGXDYB (
    ID NUMBER, -- 序号
    DQ VARCHAR2 (2000), -- 大区
    QY VARCHAR2 (2000), -- 区域
    YWY VARCHAR2 (2000), -- 业务员
    FDQY VARCHAR2 (2000), -- 风电区域
    CUSTOMER_NAME VARCHAR2 (2000), -- 客户名称
    DL VARCHAR2 (2000), -- 铁号大类
    FHXH VARCHAR2 (2000), -- 发货型号
    START_TIME DATE, -- 开始日期
    END_TIME DATE, -- 截止日期
    REMARK VARCHAR2 (2000), -- 备注
    LRY VARCHAR2 (2000), -- 录入员
    UPDATE_TIME DATE, -- 更新时间
    WFHFL VARCHAR2 (2000),
    SFXS VARCHAR2 (2000),
    PRODUCT_SORT1 VARCHAR2 (2000), -- 产品大类
    PRODUCT_SORT2 VARCHAR2 (2000), -- 产品中类
    PRODUCT_SORT3 VARCHAR2 (2000), -- 产品小类
    PRODUCT_CODE VARCHAR2 (2000), -- 产品编码
    PRODUCT_NEME VARCHAR2 (2000) -- 产品名称
    ETL_CRT_DT DATE,
    ETL_UPD_DT DATE
    
);


TRUNCATE TABLE MDDWD.DWD_XSGXDYB;
INSERT INTO MDDWD.DWD_XSGXDYB(
    ID , -- 序号
    DQ , -- 大区
    QY , -- 区域
    YWY , -- 业务员
    FDQY , -- 风电区域
    CUSTOMER_NAME , -- 客户名称
    DL , -- 铁号大类
    FHXH , -- 发货型号
    START_TIME , -- 开始日期
    END_TIME , -- 截止日期
    REMARK , -- 备注
    LRY , -- 录入员
    UP_TIME , -- 更新时间
    WFHFL ,
    SFXS ,
    PRODUCT_SORT1 , -- 产品大类
    PRODUCT_SORT2 , -- 产品中类
    PRODUCT_SORT3 , -- 产品小类
    PRODUCT_CODE , -- 产品编码
    PRODUCT_NEME  -- 产品名称
    ETL_CRT_DT ,
    ETL_UPD_DT 

)


SELECT 
    id 
    ,dq
    ,qy
    ,ywy
    ,fdqy
    ,khmc
    ,dl
    ,fhxh
    ,ksrq
    ,jzrq
    ,bz
    ,lry
    ,gxsj
    ,wfhfl
    ,sfxs
    ,cpdl
    ,cpzl
    ,cpxl
    ,cpbm
    ,cpmc
	,getdate() etl_crt_dt
	,getdate() etl_upd_dt
FROM ODS_XSGXDYB