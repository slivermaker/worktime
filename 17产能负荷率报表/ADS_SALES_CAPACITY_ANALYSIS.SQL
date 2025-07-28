
TRUNCATE TABLE MDADS.ADS_SALES_CAPACITY_ANALYSIS;
INSERT INTO
    MDADS.ADS_SALES_CAPACITY_ANALYSIS (
        PERIOD,  ---日期
        SALE_PLATFORM_NAME, -- 销售平台全称
        SALE_REGION_NAME, -- 销售大区全称
        SALE_COMPANY_NAME, -- 区域组织
        CUSTOMER_NAME, -- 客户名称
        PRODUCTION_NAME, -- 生产线
        CAPACITY_TYPE, -- 产能类型
        BASE_M_FINISH_RATE, -- 月基准完成率
        WEIGHT_M_TARGET_T, -- 重量月度目标_吨
        WEIGHT_M_ACTUAL_T, -- 重量月度实际_吨
        BASE_Q_FINISH_RATE, -- 季度基准完成率
        WEIGHT_Q_TARGET_T, -- 重量季度目标_吨
        WEIGHT_Q_ACTUAL_T, -- 重量季度实际_吨
        BASE_ACC_FINISH_RATE, -- 月累计基准完成率
        WEIGHT_ACC_TARGET_T, -- 重量月累计目标_吨
        WEIGHT_ACC_ACTUAL_T, -- 重量月累计实际_吨
        WEIGHT_SAMEP_M_ACTUAL_T, -- 同期重量月度实际_吨
        WEIGHT_SAMEP_Q_ACTUAL_T, -- 同期重量季度实际_吨
        WEIGHT_SAMEP_ACC_ACTUAL_T ,-- 同期重量月累计实际_吨
MIN_CAPACITY_T
    )
    
 select      PERIOD,  ---日期
        a.SALE_PLATFORM_NAME, -- 销售平台全称
        a.SALE_REGION_NAME, -- 销售大区全称
        a.SALE_COMPANY_NAME, -- 区域组织
        CUSTOMER_NAME, -- 客户名称
        PRODUCTION_NAME, -- 生产线
        CAPACITY_TYPE, -- 产能类型   
    
    CASE
        WHEN A.WEIGHT_M_TARGET_T <= MIN_CAPACITY_T THEN 100
        ELSE MIN_CAPACITY_T / A.WEIGHT_M_TARGET_T * 100
    END AS BASE_M_FINISH_RATE, -- BASE_M_FINISH_RATE ,                -- 月基准完成率
       WEIGHT_M_TARGET_T, -- 重量月度目标_吨
        WEIGHT_M_ACTUAL_T, -- 重量月度实际_吨
            CASE
        WHEN A.WEIGHT_Q_TARGET_T <= MIN_CAPACITY_T * 3 THEN 100
        ELSE MIN_CAPACITY_T * 3 / A.WEIGHT_Q_TARGET_T * 100
    END AS BASE_Q_FINISH_RATE, -- BASE_Q_FINISH_RATE ,                -- 季度基准完成率
         WEIGHT_Q_TARGET_T, -- 重量季度目标_吨
        WEIGHT_Q_ACTUAL_T, -- 重量季度实际_吨
        CASE
        WHEN A.WEIGHT_ACC_TARGET_T <= MIN_CAPACITY_T * (
            EXTRACT(
                MONTH
                FROM ADD_MONTHS (SYSDATE, -1)
            )
        ) THEN 100
        ELSE MIN_CAPACITY_T * (
            EXTRACT(
                MONTH
                FROM ADD_MONTHS (SYSDATE, -1)
            )
        ) / A.WEIGHT_ACC_TARGET_T * 100
    END AS BASE_ACC_FINISH_RATE, -- BASE_ACC_FINISH_RATE ,              -- 月累计基准完成率
            WEIGHT_ACC_TARGET_T, -- 重量月累计目标_吨
        WEIGHT_ACC_ACTUAL_T, -- 重量月累计实际_吨
        WEIGHT_SAMEP_M_ACTUAL_T, -- 同期重量月度实际_吨
        WEIGHT_SAMEP_Q_ACTUAL_T, -- 同期重量季度实际_吨
        WEIGHT_SAMEP_ACC_ACTUAL_T ,-- 同期重量月累计实际_吨
MIN_CAPACITY_T
        
        
        from (
    

SELECT
    A.PERIOD,      ---日期
    A.ORG_NAME1 SALE_PLATFORM_NAME, -- SALE_PLATFORM_NAME ,       -- 销售平台全称
    A.ORG_NAME2 SALE_REGION_NAME, -- SALE_REGION_NAME ,                  -- 销售大区全称
    A.ORG_NAME3 SALE_COMPANY_NAME, -- SALE_COMPANY_NAME ,                 -- 区域组织
    A.CUSTOMER_NAME, -- CUSTOMER_NAME ,                     -- 客户名称
    A.PRODUCT_LINE PRODUCTION_NAME , -- PRODUCTION_NAME ,          -- 生产线
    B.CAPACITY_TYPE, -- CAPACITY_TYPE ,            -- 产能类型
    
   sum(A.WEIGHT_M_TARGET_T) WEIGHT_M_TARGET_T, -- WEIGHT_M_TARGET_T ,               -- 重量月度目标_吨
    sum(A.WEIGHT_M_ACTUAL_T_SAVE + A.WEIGHT_M_ACTUAL_T_UNSAVE) WEIGHT_M_ACTUAL_T,  -- WEIGHT_M_ACTUAL_T ,               -- 重量月度实际_吨

    sum(A.WEIGHT_Q_TARGET_T) WEIGHT_Q_TARGET_T,  -- WEIGHT_Q_TARGET_T ,               -- 重量季度目标_吨
    sum(A.WEIGHT_Q_ACTUAL_T_SAVE + A.WEIGHT_Q_ACTUAL_T_UNSAVE) WEIGHT_Q_ACTUAL_T,  -- WEIGHT_Q_ACTUAL_T ,               -- 重量季度实际_吨

    sum(A.WEIGHT_M_ACC_TARGET_T) WEIGHT_ACC_TARGET_T, -- WEIGHT_ACC_TARGET_T ,              -- 重量月累计目标_吨
    sum(A.WEIGHT_SAMEP_MACC_ACT_T_SAVE + A.WEIGHT_SAMEP_MACC_ACT_T_UNSAVE) WEIGHT_ACC_ACTUAL_T,  -- WEIGHT_ACC_ACTUAL_T                -- 重量月累计实际_吨
    sum(A.WEIGHT_SAMEP_M_ACTUAL_T_SAVE + WEIGHT_SAMEP_M_ACTUAL_T_UNSAVE ) WEIGHT_SAMEP_M_ACTUAL_T, -- 同期重量月度实际_吨
    sum(A.WEIGHT_SAMEP_Q_ACTUAL_T_SAVE + A.WEIGHT_SAMEP_Q_ACTUAL_T_UNSAVE) WEIGHT_SAMEP_Q_ACTUAL_T,  -- 同期重量季度实际_吨
    sum(A.WEIGHT_SAMEP_MACC_ACT_T_SAVE + A.WEIGHT_SAMEP_MACC_ACT_T_UNSAVE) WEIGHT_SAMEP_ACC_ACTUAL_T, -- 同期重量月累计实际_吨
    min(MIN_CAPACITY_T) as MIN_CAPACITY_T
FROM
    MDDWS.DWS_PRODUCT_ORDER_REVENUE A --生产订单业绩汇总表
LEFT JOIN  (
    SELECT DISTINCT PRODUCTION_LINE, PRODUCT_SORT1,PRODUCT_SORT2,PRODUCT_SORT3,PRODUCT_SORT4,CAPACITY_TYPE
    FROM MDDWD.DWD_CNLXDZB
)B
    ON A.PRODUCT_LINE = B.PRODUCTION_LINE
    AND A.PRODUCT_SORT1=B.PRODUCT_SORT1
    AND A.PRODUCT_SORT2=B.PRODUCT_SORT2
    AND A.PRODUCT_SORT3=B.PRODUCT_SORT3
    AND A.PRODUCT_SORT4=B.PRODUCT_SORT4
    LEFT JOIN MDDWD.DWD_CNJCB C ON A.PRODUCT_LINE = C.PRODUCTION_LINE
    AND B.CAPACITY_TYPE = C.CAPACITY_TYPE
    group by      A.PERIOD,      ---日期
    A.ORG_NAME1, -- SALE_PLATFORM_NAME ,       -- 销售平台全称
    A.ORG_NAME2, -- SALE_REGION_NAME ,                  -- 销售大区全称
    A.ORG_NAME3, -- SALE_COMPANY_NAME ,                 -- 区域组织
    A.CUSTOMER_NAME, -- CUSTOMER_NAME ,                     -- 客户名称
    A.PRODUCT_LINE, -- PRODUCTION_NAME ,          -- 生产线
    B.CAPACITY_TYPE -- CAPACITY_TYPE ,            -- 产能类型
    ) a