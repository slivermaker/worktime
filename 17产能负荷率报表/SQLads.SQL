WITH CNJCB_DATE AS( --假如带日期产能基础表的做主表
    SELECT A.PERIOD_DATE,B.*
        FROM  MDDIM.DIM_MONTH_D A FULL JOIN DWD_CNJCB B ON 1=1
        WHERE A.PERIOD_DATE BETWEEN TO_DATE('2025-01','YYYY-MM') AND ADD_MONTHS(SYSDATE,-1)

)
--------------------------------------------------------------------------------
TRUNCATE TABLE ADS_YEARLY_PLAN_VS_CAP;

INSERT INTO ADS_YEARLY_PLAN_VS_CAP(
    PERIOD ,                             -- 日期
    PRODUCTION_NAME ,           -- 生产线
    FACTORY_NAME ,              -- 厂区名称
    CAPACITY_TYPE ,             -- 产能类型
    MONTHLY_WORKING_DAYS ,             -- 月生产天数
    MONTHLY_CAPACITY ,                 -- 月产能
    YEAR_CAPACITY ,                    -- 年产能
    MEASUREMENT_NAME ,           -- 计量单位
    SALE_TAR_INTER ,                  -- 国内销量目标_吨
    SALE_TAR_OVER ,                   -- 国外销量目标_吨
    ORDER_QTY_INTER ,                  -- 月累计国内接单量
    ORDER_QTY_OVER ,                   -- 月累计国外接单量
    ORDER_QTY_INTER_LAST ,             -- 同期月累计国内接单量
    ORDER_QTY_OVER_LAST ,              -- 同期月累计国外接单量
    ORDER_QTY_INTER_SUM_LAST ,         -- 去年国内接单量
    ORDER_QTY_OVER_SUM_LAST ,          -- 去年海外接单量
    ETL_CRT_DT ,
    ETL_UPD_DT 

)



SELECT
    A.PERIOD-- 日期
    ,A.PRODUCT_LINE-- 生产线
    ,A.FACTORY_NAME-- 厂区名称
    ,B.CAPACITY_TYPE-- 产能类型
    ,C.WORKING_DAYS --月生产天数
    ,C.MONTHLY_CAPACITY--月产能
    ,C.MONTHLY_CAPACITY*12--年产能
    ,C.UNIT --计量单位
    ,SUM(CASE 
        WHEN  D.SALE_PLATFORM_NAME='国内销售平台' 
            THEN ZL
        ELSE 0
    END)
    ,SUM(CASE 
        WHEN  D.SALE_PLATFORM_NAME='海外销售平台' 
            THEN ZL
        ELSE 0
    END)    
    ,SUM(
        CASE
            WHEN A.ORG_NAME1 = '国内销售平台' THEN (
                A.WEIGHT_M_ACC_ACTUAL_T_SAVE + A.WEIGHT_M_ACC_ACTUAL_T_UNSAVE
            )
            ELSE 0
        END
    ) AS ORDER_QTY_INTER, -- 月累计国内接单量

    SUM(
        CASE
            WHEN A.ORG_NAME1 = '海外销售平台' THEN (
                A.WEIGHT_M_ACC_ACTUAL_T_SAVE + A.WEIGHT_M_ACC_ACTUAL_T_UNSAVE
            )
            ELSE 0
        END
    ) AS ORDER_QTY_OVER, -- 月累计国外接单量
    SUM(
        CASE
            WHEN A.ORG_NAME1 = '国内销售平台' THEN (
                A.WEIGHT_SAMEP_MACC_ACT_T_SAVE + A.WEIGHT_SAMEP_MACC_ACT_T_UNSAVE
            )
            ELSE 0
        END
    ) AS ORDER_QTY_INTER_LAST, -- 同期月累计国内接单
    SUM(
        CASE
            WHEN A.ORG_NAME1 = '海外销售平台' THEN (
                A.WEIGHT_SAMEP_MACC_ACT_T_SAVE + A.WEIGHT_SAMEP_MACC_ACT_T_UNSAVE
            )
            ELSE 0
        END
    ) AS ORDER_QTY_OVER_LAST, -- 同期月累计国外接单
    SUM(
        CASE
            WHEN A.ORG_NAME1 = '国内销售平台' THEN (A.WEIGHT_LY_ACTUAL_T_SAVE + A.WEIGHT_LY_ACTUAL_T_UNSAVE)
            ELSE 0
        END
    ) AS ORDER_QTY_INTER_SUM_LAST, -- 去年国内接单量
    SUM(
        CASE
            WHEN A.ORG_NAME1 = '海外销售平台' THEN (A.WEIGHT_LY_ACTUAL_T_SAVE + A.WEIGHT_LY_ACTUAL_T_UNSAVE)
            ELSE 0
        END
    ) AS ORDER_QTY_OVER_SUM_LAST -- 去年国内接单量
    ,SYSDATE AS ETL_CRT_DT
    ,SYSDATE AS ETL_UPD_DT



FROM
    MDDWS.DWS_PRODUCT_ORDER_REVENUE A--生产订单业绩汇总表


    LEFT JOIN  (
    SELECT DISTINCT PRODUCTION_LINE, PRODUCT_SORT1,PRODUCT_SORT2,PRODUCT_SORT3,PRODUCT_SORT4,CAPACITY_TYPE
    FROM MDDWD.DWD_CNLXDZB
    )B
    ON A.PRODUCT_SORT1=B.PRODUCT_SORT1
    AND A.PRODUCT_SORT2=B.PRODUCT_SORT2
    AND A.PRODUCT_SORT3=B.PRODUCT_SORT3
    LEFT JOIN MDDWD.DWD_CNJCB C

    ON A.PRODUCT_LINE=C.PRODUCTION_LINE
        AND A.FACTORY_NAME=C.FACTORY
        AND B.CAPACITY_TYPE=C.CAPACITY_TYPE
LEFT JOIN (
    SELECT
        SALE_PLATFORM_NAME,
        CORPORATE_ENTITY_NAME_SN,
        PERIOD,
        SUM(sales_weight_t) ZL
    FROM MDDWD.DWD_SALES_TARGET
    WHERE
        SALES_TARGET_TYPE = '挑战'
    GROUP BY
        SALE_PLATFORM_NAME,
        CORPORATE_ENTITY_NAME_SN,
        PERIOD
) D  
ON D.CORPORATE_ENTITY_NAME_SN=A.PRODUCT_LINE AND D.PERIOD=A.PERIOD
GROUP BY A.PERIOD , A.PRODUCT_LINE,A.FACTORY_NAME, B.CAPACITY_TYPE,C.WORKING_DAYS,C.MONTHLY_CAPACITY,C.MONTHLY_CAPACITY*12,C.UNIT ;