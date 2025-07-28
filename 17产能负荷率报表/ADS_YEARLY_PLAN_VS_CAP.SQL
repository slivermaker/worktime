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
    NVL(A.PERIOD, TRUNC(SYSDATE,'MM'))-- 日期
    ,nvl(A.PRODUCT_LINE,C.PRODUCTION_LINE)-- 生产线
    ,null-- 厂区名称
    ,a.CAPACITY_TYPE-- 产能类型
    ,C.WORKING_DAYS --月生产天数
    ,C.MONTHLY_CAPACITY--月产能
    ,C.MONTHLY_CAPACITY*12--年产能
    ,max(C.UNIT) MEASUREMENT_NAME --计量单位
    ,SUM(CASE 
        WHEN  A.ORG_NAME1 = '国内销售平台'
            THEN WEIGHT_M_ACC_TARGET_T
        ELSE 0
    END)
    ,SUM(CASE 
        WHEN   A.ORG_NAME1 ='海外销售平台' 
            THEN WEIGHT_M_ACC_TARGET_T
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
 full JOIN MDDWD.DWD_CNJCB C
ON A.PRODUCT_LINE=C.PRODUCTION_LINE
   AND a.CAPACITY_TYPE=C.CAPACITY_TYPE
GROUP BY NVL(A.PERIOD, TRUNC(SYSDATE,'MM')), nvl(A.PRODUCT_LINE,C.PRODUCTION_LINE), a.CAPACITY_TYPE,C.WORKING_DAYS,C.MONTHLY_CAPACITY,C.MONTHLY_CAPACITY*12;