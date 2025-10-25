CREATE TABLE DWD_MAIN_TRANSFER_SUMMARY (
    PERIOD DATE,                      -- 日期
    WORK_ORG_NAME VARCHAR2(2000),     -- 转出单位/工作组织名称
    WEIGHT NUMBER,                    -- 重量(原始单位)
    PIECE_COUNT NUMBER,               -- 件数
    SURFACE_TREATMENT,
    PRODUCT_TEXTURE,
    PRODUCT_VARIETY,
    PRODUCT_SPECIFICATION,
    PRODUCT_FORM,
    ETL_CRT_DT DATE DEFAULT SYSDATE,  -- ETL创建日期
    ETL_UPD_DT DATE DEFAULT SYSDATE   -- ETL更新日期
);

-- 表注释
COMMENT ON TABLE DWD_MAIN_TRANSFER_SUMMARY IS '统一领转重量件数汇总表';

-- 列注释
COMMENT ON COLUMN DWD_MAIN_TRANSFER_SUMMARY.PERIOD IS '日期';
COMMENT ON COLUMN DWD_MAIN_TRANSFER_SUMMARY.WORK_ORG_NAME IS '转出单位';
COMMENT ON COLUMN DWD_MAIN_TRANSFER_SUMMARY.WEIGHT IS '重量';
COMMENT ON COLUMN DWD_MAIN_TRANSFER_SUMMARY.PIECE_COUNT IS '件数';
COMMENT ON COLUMN DWD_MAIN_TRANSFER_SUMMARY.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN DWD_MAIN_TRANSFER_SUMMARY.ETL_UPD_DT IS 'ETL更新日期';

-- 从ODS层抽取并转换数据到DWD层
INSERT INTO DWD_MAIN_TRANSFER_SUMMARY (
    PERIOD, 
    WORK_ORG_NAME, 
    WEIGHT, 
    PIECE_COUNT,
    SURFACE_TREATMENT,
    PRODUCT_TEXTURE,
    PRODUCT_VARIETY,
    PRODUCT_SPECIFICATION,
    PRODUCT_FORM
)
SELECT 
    TO_DATE(RQ,'YY.MM.DD') AS PERIOD,
    ZCDW AS WORK_ORG_NAME,
    ZL AS WEIGHT,
    JS AS PIECE_COUNT,
    BMCL AS SURFACE_TREATMENT,
    CZFL AS PRODUCT_TEXTURE,
    PZ AS PRODUCT_VARIETY,
    GG AS PRODUCT_SPECIFICATION,
    XS AS PRODUCT_FORM
FROM 
    ODS_QCSJB_CKYW


--------------------------------------------------------------------

WITH TMP_Dim AS
(
    SELECT
        B.PERIOD_DATE AS PERIOD
        ,A.GX
        ,A.DW
        FROM ods_erp.ODS_CBZZBB2 A
        CROSS JOIN MDDIM.dim_day_d B
        WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1  
        and nvl(scx,zzb) = '迈克阀门'
        and gx in ('半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件' )
        and sfjscl is not null
    )
SELECT 
    TO_DATE(RQ,'YY.MM.DD') AS PERIOD,
    ZCDW AS WORK_ORG_NAME,
    SUM(ZL) AS WEIGHT,
    SUM(JS) AS PIECE_COUNT,
    BMCL AS SURFACE_TREATMENT,
    CZFL AS PRODUCT_TEXTURE,
    PZ AS PRODUCT_VARIETY,
    GG AS PRODUCT_SPECIFICATION,
    XS AS PRODUCT_FORM,
    SUM(case when bmcl='B01' then zl else 0 end) AS B01_WEIGHT,
	LQDW,
	CPBM
    
FROM 
    ODS_ERP.ODS_QCSJB_CKYW
GROUP BY TO_DATE(RQ,'YY.MM.DD')
,ZCDW
,BMCL
,CZFL
,PZ
,GG
,XS
,LQDW
,CPBM

----------------------------------------------------------------------------
WITH TMP_Dim AS (
    SELECT
        B.PERIOD_DATE AS PERIOD,
        A.GX,
        A.DW
    FROM ods_erp.ODS_CBZZBB2 A
    CROSS JOIN MDDIM.dim_day_d B
    WHERE B.PERIOD_DATE >= DATE '2025-01-01' 
        AND b.period_date < SYSDATE - 1  
        AND nvl(scx, zzb) = '迈克阀门'
        AND gx IN ('半加工工序', '半成品库工序', '加工工序', '包胶工序', '表面处理工序', '配件')
        AND sfjscl IS NOT NULL
),
Production_Data AS (
    SELECT 
        TO_DATE(RQ, 'YY.MM.DD') AS PERIOD,  -- 修正日期格式，根据实际格式调整
        ZCDW AS WORK_ORG_NAME,
        BMCL AS SURFACE_TREATMENT,
        CZFL AS PRODUCT_TEXTURE,
        PZ AS PRODUCT_VARIETY,
        GG AS PRODUCT_SPECIFICATION,
        XS AS PRODUCT_FORM,
        LQDW,
        CPBM,
        SUM(ZL) AS WEIGHT,
        SUM(JS) AS PIECE_COUNT,
        SUM(CASE WHEN bmcl = 'B01' THEN zl ELSE 0 END) AS B01_WEIGHT
    FROM ODS_ERP.ODS_QCSJB_CKYW
    WHERE TO_DATE(RQ, 'YY.MM.DD') >= DATE '2025-01-01'  -- 添加日期过滤
    GROUP BY 
        TO_DATE(RQ, 'YY.MM.DD'),
        ZCDW,
        BMCL,
        CZFL,
        PZ,
        GG,
        XS,
        LQDW,
        CPBM
)
SELECT 
    dim.PERIOD,
    dim.DW,
    pd.WORK_ORG_NAME,
    COALESCE(pd.WEIGHT, 0) AS WEIGHT,
    COALESCE(pd.PIECE_COUNT, 0) AS PIECE_COUNT,
    pd.SURFACE_TREATMENT,
    pd.PRODUCT_TEXTURE,
    pd.PRODUCT_VARIETY,
    pd.PRODUCT_SPECIFICATION,
    pd.PRODUCT_FORM,
    COALESCE(pd.B01_WEIGHT, 0) AS B01_WEIGHT,
    pd.LQDW,
    pd.CPBM,
FROM TMP_Dim dim
LEFT JOIN Production_Data pd 
    ON dim.PERIOD = pd.PERIOD
     AND dim.DW = pd.WORK_ORG_NAME  
ORDER BY 
    dim.PERIOD,
    dim.DW,
    pd.WORK_ORG_NAME;