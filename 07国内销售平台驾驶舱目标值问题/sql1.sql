--销售公司按照完成率排名
WITH
    WGT_RK AS (
        SELECT
            actual_sales_company,
            SALE_REGION_NAME,
            CASE
                WHEN SUM(CUR_WGT_FACT) = 0 THEN 23 -- CUR_WGT_FACT 为 0 时，排名固定为 23
                WHEN SUM(CUR_WGT_TGT) = 0 THEN 24 -- CUR_WGT_TGT 为 0 时，排名固定为 24
                ELSE RANK() OVER (
                    ORDER BY ROUND(
                            SUM(CUR_WGT_FACT) / 
                            CASE
                                WHEN   ?{日期类型} =  'Y' THEN 
                                    CASE SUM(Y_WGT_TGT) WHEN 0 THEN NULL
                                        ELSE SUM(Y_WGT_TGT)
                                    END
                                WHEN ?{日期类型} =  'M' THEN                                  
                                   CASE SUM(CUR_WGT_TGT) WHEN 0 THEN NULL
                                        ELSE SUM(CUR_WGT_TGT)
                                   END 
                            END, 4
                        ) DESC
                )
            END AS RK_WGT,
            ROUND(
                SUM(CUR_WGT_FACT) / CASE
                    WHEN SUM(CUR_WGT_TGT) = 0 THEN NULL
                    ELSE SUM(CUR_WGT_TGT)
                END,
                4
            ) AS WGT_COMPLETION_RATE
        FROM ADS_REGION_SALTGT_SUM
        WHERE
            1 = 1
            -- <账期>and YPERIOD=?{账期}</账期>
            -- <日期类型>and period_type=?{日期类型}</日期类型>  
            -- <BG_销售目标达成>and customer_bg in ?{BG_销售目标达成}</BG_销售目标达成>   
            -- <产品大类>and product_sort_h = ?{产品大类}</产品大类> 
            -- <产品中类>and product_sort_m = ?{产品中类}</产品中类>
            and YPERIOD = date '2025-6-16'
            and period_type = 'Y'
        GROUP BY
            actual_sales_company,
            SALE_REGION_NAME
        HAVING
            SUM(CUR_WGT_TGT) <> 0
    ),
    AMT_RK AS (
        SELECT
            actual_sales_company,
            SALE_REGION_NAME,
            CASE
                WHEN SUM(CUR_AMT_FACT) = 0 THEN 23 -- CUR_AMT_FACT 为 0 时，排名固定为 23
                WHEN SUM(CUR_AMT_TGT) = 0 THEN 24 -- CUR_AMT_TGT 为 0 时，排名固定为 24
                ELSE RANK() OVER (
                    ORDER BY ROUND(
                            SUM(CUR_AMT_FACT) / 
                            CASE
                                WHEN   ?{日期类型} =  'Y' THEN 
                                    CASE SUM(Y_AMT_TGT) WHEN 0 THEN NULL
                                        ELSE SUM(Y_AMT_TGT)
                                    END
                                WHEN ?{日期类型} =  'M' THEN                                  
                                   CASE SUM(CUR_AMT_TGT) WHEN 0 THEN NULL
                                        ELSE SUM(CUR_AMT_TGT)
                                   END 
                            END, 4
                        ) DESC
                )
            END AS RK_AMT,
            ROUND(
                SUM(CUR_AMT_FACT) / CASE
                    WHEN SUM(CUR_AMT_TGT) = 0 THEN NULL
                    ELSE SUM(CUR_AMT_TGT)
                END,
                4
            ) AS AMT_COMPLETION_RATE
        FROM ADS_REGION_SALTGT_SUM
        WHERE
            1 = 1
            -- <账期>and YPERIOD=?{账期}</账期>
            -- <日期类型>and period_type=?{日期类型}</日期类型>  
            -- <BG_销售目标达成>and customer_bg in ?{BG_销售目标达成}</BG_销售目标达成>    
            -- <产品大类>and product_sort_h = ?{产品大类}</产品大类> 
            -- <产品中类>and product_sort_m = ?{产品中类}</产品中类>
            and YPERIOD = date '2025-6-16'
            and period_type = 'Y'
        GROUP BY
            actual_sales_company,
            SALE_REGION_NAME
        HAVING
            SUM(CUR_AMT_TGT) <> 0
    )

SELECT
    CASE
        WHEN AMT_RK.RK_AMT IS NULL THEN 24
        ELSE AMT_RK.RK_AMT
    END AS RK_AMT,
    CASE
        WHEN WGT_RK.RK_WGT IS NULL THEN 24
        ELSE WGT_RK.RK_WGT
    END AS RK_WGT,
    AMT_RK.AMT_COMPLETION_RATE,
    WGT_RK.WGT_COMPLETION_RATE,
    A.actual_sales_company,
    A.SALE_REGION_NAME,
    A.period_type,
    A.YPERIOD,
    A.customer_bg,
    A.product_sort_h,
    A.product_sort_m,
    A.CUR_AMT_FACT,
    A.CUR_WGT_FACT,
    A.CUR_WGT_TGT,
    A.CUR_AMT_TGT,
    A.Y_WGT_TGT,
    A.Y_AMT_TGT
FROM (
        select
            actual_sales_company,
            SALE_REGION_NAME,
            period_type,
            YPERIOD,
            customer_bg,
            product_sort_h,
            product_sort_m,
            SUM(CUR_AMT_FACT) CUR_AMT_FACT,
            SUM(CUR_WGT_FACT) CUR_WGT_FACT,
            SUM(CUR_WGT_TGT) CUR_WGT_TGT,
            SUM(CUR_AMT_TGT) CUR_AMT_TGT,
            SUM(Y_WGT_TGT) Y_WGT_TGT,
            SUM(Y_AMT_TGT) Y_AMT_TGT
        from ADS_REGION_SALTGT_SUM
        group by
            actual_sales_company,
            SALE_REGION_NAME,
            period_type,
            YPERIOD,
            customer_bg,
            product_sort_h,
            product_sort_m
    ) A
    LEFT JOIN AMT_RK AMT_RK ON A.actual_sales_company = AMT_RK.actual_sales_company
    LEFT JOIN WGT_RK WGT_RK ON A.actual_sales_company = WGT_RK.actual_sales_company
ORDER BY 1











---如果是0就为null
ROUND(SUM(CUR_AMT_FACT) / 
CASE WHEN SUM(CUR_AMT_TGT) = 0 THEN NULL ELSE SUM(CUR_AMT_TGT) END, 4) 
AS AMT_COMPLETION_RATE


ROUND(SUM(CUR_AMT_FACT)/
    NULLIF(SUM(CUR_AMT_TGT),0)
)AS AMT_COMPLETION_RATE