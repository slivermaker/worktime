



INSERT INTO ADS_CAPACITY_2 (
    period,                     -- 日期
    produce_company_name_sn,    -- 生产公司
    production_line,            -- 生产线
    capacity_type,              -- 产能类型
    working_days,               -- 生产天数
    monthly_capacity,           -- 月产能
    unit,                       -- 单位
    in_weight_m_actual_t,       -- 国内发货量
    out_weight_m_actual_t,      -- 海外发货量
    in_weight_m_acc_actual_t,   -- 国内累计发货量
    out_weight_m_acc_actual_t,  -- 海外累计发货量
    in_amount_m_actual_wy,      -- 国内发货金额
    out_amount_m_actual_wy,     -- 海外发货金额
    in_amount_m_acc_actual_wy, -- 国内累计发货金额
    out_amount_m_acc_actual_wy, -- 海外累计发货金额
    in_amount_m_target_wy,      -- 国内月度金额目标
    out_amount_m_target_wy,     -- 国外月度金额目标
    in_amount_m_acc_target_wy,  -- 国内月累计金额目标
    out_amount_m_acc_target_wy,  -- 国外月累计金额目标
    etl_crt_dt,                 -- ETL创建日期
    etl_upd_dt                 -- ETL更新日期

)


SELECT
    A.period --日期
    ,A.PRODUCE_COMPANY_NAME_SN--生产公司
    ,A.Production_Line--生产线
    ,A.capacity_type  --产能类型
    ,A.working_days --生产天数
    ,A.monthly_capacity --月产能
    ,A.unit --单位
    ,B.IN_WEIGHT_M_ACTUAL_T  --国内重量月度实际
    ,B.OUT_WEIGHT_M_ACTUAL_T  --海外重量月度实际
    ,B.IN_WEIGHT_M_ACC_ACTUAL_T  --国内重量月累计实际
    ,B.OUT_WEIGHT_M_ACC_ACTUAL_T  --海外重量月累计实际
    ,B.IN_AMOUNT_M_ACTUAL_WY  --国内金额月度实际
    ,B.OUT_AMOUNT_M_ACTUAL_WY  --海外金额月度实际
    ,B.IN_AMOUNT_M_ACC_ACTUAL_WY  --国内金额月累计实际
    ,B.OUT_AMOUNT_M_ACC_ACTUAL_WY  --海外金额月累计实际
    ,B.IN_AMOUNT_M_TARGET_WY  --国内金额月度目标
    ,B.OUT_AMOUNT_M_TARGET_WY  --海外金额月度目标
    ,B.IN_AMOUNT_M_ACC_TARGET_WY  --国内金额月累计目标
    ,B.OUT_AMOUNT_M_ACC_TARGET_WY  --海外金额月累计目标
    ,SYSDATE
    ,SYSDATE

FROM (
    SELECT  DISTINCT
            PERIOD --日期
            ,PRODUCE_COMPANY_NAME_SN--生产公司
            ,PRODUCTION_LINE--生产线
            ,PRODUCT_SORT1  --产品大类
            ,PRODUCT_SORT2  --产品中类
            ,PRODUCT_SORT3  --产品小类
            ,CAPACITY_TYPE  --产能类型
            ,WORKING_DAYS --生产天数
            ,MONTHLY_CAPACITY --月产能
            ,UNIT --单位
    FROM    MDDWS.DWS_CAPACITY_ALL
) A
LEFT JOIN (
    SELECT
        TRUNC(PERIOD, 'MM') AS PERIOD,
        CORPORATE_ENTITY_NAME_SN AS PRODUCTION_LINE,
        product_sort1,
        product_sort2,
        product_sort3,
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='国内销售平台' THEN tmp.WEIGHT_M_ACTUAL_T ELSE 0 END )AS IN_WEIGHT_M_ACTUAL_T,--国内重量月度实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='海外销售平台' THEN tmp.WEIGHT_M_ACTUAL_T ELSE 0 END )AS OUT_WEIGHT_M_ACTUAL_T,--海外重量月度实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='国内销售平台' THEN tmp.WEIGHT_M_ACC_ACTUAL_T ELSE 0 END )AS IN_WEIGHT_M_ACC_ACTUAL_T,--国内重量月累计实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='海外销售平台' THEN tmp.WEIGHT_M_ACC_ACTUAL_T ELSE 0 END )AS OUT_WEIGHT_M_ACC_ACTUAL_T,--海外重量月累计实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='国内销售平台' THEN tmp.AMOUNT_M_ACTUAL_WY ELSE 0 END )AS IN_AMOUNT_M_ACTUAL_WY,--国内金额月度实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='海外销售平台' THEN tmp.AMOUNT_M_ACTUAL_WY ELSE 0 END )AS OUT_AMOUNT_M_ACTUAL_WY,--海外金额月度实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='国内销售平台' THEN tmp.AMOUNT_M_ACC_ACTUAL_WY ELSE 0 END )AS IN_AMOUNT_M_ACC_ACTUAL_WY,--国内金额月累计实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='海外销售平台' THEN tmp.AMOUNT_M_ACC_ACTUAL_WY ELSE 0 END )AS OUT_AMOUNT_M_ACC_ACTUAL_WY,--海外金额月累计实际
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='国内销售平台' THEN tmp.AMOUNT_M_TARGET_WY ELSE 0 END )AS IN_AMOUNT_M_TARGET_WY,--国内金额月度目标
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='海外销售平台' THEN tmp.AMOUNT_M_TARGET_WY ELSE 0 END )AS OUT_AMOUNT_M_TARGET_WY,--海外金额月度目标
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='国内销售平台' THEN tmp.AMOUNT_M_ACC_TARGET_WY ELSE 0 END )AS IN_AMOUNT_M_ACC_TARGET_WY,--国内金额金额月累计目标
        SUM(CASE WHEN tmp.SALE_PLATFORM_NAME='海外销售平台' THEN tmp.AMOUNT_M_ACC_TARGET_WY ELSE 0 END )AS OUT_AMOUNT_M_ACC_TARGET_WY--海外金额金额月累计目标

    FROM tmp tmp
    WHERE
        tmp.SALE_PLATFORM_NAME IN ('国内销售平台', '海外销售平台')
        AND TO_CHAR(PERIOD, 'yyyy') >= '2024'
        AND (tmp.IS_MONTH = '是' OR tmp.IS_DAY = '是')
        AND SALES_TARGET_TYPE = '挑战目标'
        --AND WEIGHT_M_ACTUAL_T + WEIGHT_M_TARGET_T + WEIGHT_M_SAMEP_T <> 0
		
    GROUP BY    TRUNC(PERIOD, 'MM'),
            CORPORATE_ENTITY_NAME_SN,
            product_sort1,
            product_sort2,
            product_sort3
)B
ON  B.PERIOD = A.PERIOD
    AND B.PRODUCTION_LINE = A.PRODUCE_COMPANY_NAME_SN
    AND B.PRODUCT_SORT1 = A.PRODUCT_SORT1
    AND B.PRODUCT_SORT2 = A.PRODUCT_SORT2
    AND B.PRODUCT_SORT3 = A.PRODUCT_SORT3

WHERE  A.period<trunc(SYSDATE,'DD')






WITH tmp AS (
    SELECT
        period_day AS period,
        EXTRACT(YEAR FROM period_day) AS year,
        EXTRACT(MONTH FROM period_day) AS month,
        sale_platform_name,
        corporate_entity_name_sn,
        product_sort1,
        product_sort2,
        product_sort3,
        SUM(sales_amount_y) / 1000 AS sales_amount_k,
        SUM(sales_weight_kg) / 1000 AS sales_weight_ton
    FROM mddwd.dwd_SALE_REVENUE
    where sale_platform_name IN('国内销售平台','海外销售平台')
    GROUP BY
        period_day,
        sale_platform_name,
        corporate_entity_name_sn,
        product_sort1,
        product_sort2,
        product_sort3
)
SELECT
    period,
    sale_platform_name,
    corporate_entity_name_sn,
    product_sort1,
    product_sort2,
    product_sort3,
    sales_amount_k,
    sales_weight_ton,
    -- 当月数据
    sales_amount_k AS monthly_sales_amount_k,
    sales_weight_ton AS monthly_sales_weight_ton,
    -- 月累计(年初至今)
    SUM(sales_amount_k) OVER (
        PARTITION BY year, sale_platform_name, corporate_entity_name_sn, 
                    product_sort1, product_sort2, product_sort3
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_sales_amount_k,
    SUM(sales_weight_ton) OVER (
        PARTITION BY year, sale_platform_name, corporate_entity_name_sn, 
                    product_sort1, product_sort2, product_sort3
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_sales_weight_ton
FROM tmp




WITH sales_data AS (
    SELECT 
        PERIOD,
        EXTRACT(YEAR FROM PERIOD) AS year,
        EXTRACT(MONTH FROM PERIOD) AS month,
        SALE_PLATFORM_NAME,
        CORPORATE_ENTITY_NAME_SN,
        PRODUCT_SORT1,
        PRODUCT_SORT2,
        PRODUCT_SORT3,
        SUM(SALES_AMOUNT_WY) AS sales_amount,
        SUM(SALES_WEIGHT_T) AS sales_weight
    FROM MDDWD.DWD_SALES_TARGET
    WHERE SALE_PLATFORM_NAME IN ('国内销售平台', '海外销售平台')
    AND SALES_TARGET_TYPE = '挑战'
  --  and period>=date'2025-01-01'
    GROUP BY 
        PERIOD,
        SALE_PLATFORM_NAME,
        CORPORATE_ENTITY_NAME_SN,
        PRODUCT_SORT1,
        PRODUCT_SORT2,
        PRODUCT_SORT3
)
SELECT
    PERIOD,
    SALE_PLATFORM_NAME,
    CORPORATE_ENTITY_NAME_SN,
    PRODUCT_SORT1,
    PRODUCT_SORT2,
    PRODUCT_SORT3,
    sales_amount AS monthly_sales_amount,
    sales_weight AS monthly_sales_weight,
    -- 月累计(年初至今)
    SUM(sales_amount) OVER (
        PARTITION BY year, SALE_PLATFORM_NAME, CORPORATE_ENTITY_NAME_SN, 
                    PRODUCT_SORT1, PRODUCT_SORT2, PRODUCT_SORT3
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_sales_amount,
    SUM(sales_weight) OVER (
        PARTITION BY year, SALE_PLATFORM_NAME, CORPORATE_ENTITY_NAME_SN, 
                    PRODUCT_SORT1, PRODUCT_SORT2, PRODUCT_SORT3
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_sales_weight
FROM sales_data


-----------------------------------------------------





SELECT 
       nvl(A.period,c.period) as period 
       ,A.PRODUCE_COMPANY_NAME_SN
       ,nvl(A.Production_Line,c.production_line) as production_line
       ,nvl(A.capacity_type,c.product_sort2) as capacity_type
       ,max(A.working_days) 
       ,max(A.monthly_capacity) 
       ,A.unit 
       ,SUM(C.IN_WEIGHT_M_ACTUAL_T_SAVE) AS IN_WEIGHT_M_ACTUAL_T_SAVE
       ,SUM(C.OVER_WEIGHT_M_ACTUAL_T_SAVE) AS OVER_WEIGHT_M_ACTUAL_T_SAVE
       ,SUM(C.IN_WEIGHT_M_ACTUAL_T_UNSAVE) AS IN_WEIGHT_M_ACTUAL_T_UNSAVE
       ,SUM(C.OVER_WEIGHT_M_ACTUAL_T_UNSAVE) AS OVER_WEIGHT_M_ACTUAL_T_UNSAVE
       
              
FROM (
    SELECT  DISTINCT 
            PERIOD 
             ,product_sort1 
            ,product_sort2
            ,product_sort3 
            ,PRODUCE_COMPANY_NAME_SN
            ,PRODUCTION_LINE
            ,CAPACITY_TYPE  
            ,WORKING_DAYS 
            ,MONTHLY_CAPACITY 
            ,UNIT 
    FROM    MDDWS.DWS_CAPACITY_ALL
) A
full JOIN 
(
    SELECT B.PERIOD 
         ,B.product_line AS production_line
         ,B.product_sort1 
         ,B.product_sort2
         ,B.product_sort3 
         ,B.product_sort4
         ,B.capacity_type  
         ,SUM(CASE WHEN  EX_IN_ORDER = '内销'  THEN B.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS IN_WEIGHT_M_ACTUAL_T_SAVE
         ,SUM(CASE WHEN EX_IN_ORDER = '外销' THEN B.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS OVER_WEIGHT_M_ACTUAL_T_SAVE
         ,SUM(CASE WHEN EX_IN_ORDER = '内销'  THEN B.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS IN_WEIGHT_M_ACTUAL_T_UNSAVE
         ,SUM(CASE WHEN EX_IN_ORDER = '外销'  THEN B.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS OVER_WEIGHT_M_ACTUAL_T_UNSAVE
         
    FROM MDDWS.DWS_PRODUCT_ORDER_REVENUE B 
     right join(
        select DISTINCT PRODUCTION_LINE from mddwd.dwd_cnjcb
    )bb on bb.PRODUCTION_LINE =b.PRODUCT_LINE 
    
    where B.product_line not in ('金润德','泰国达美','越南对焊管件')
    GROUP BY B.period 
            ,B.org_name1 
            ,B.product_line 
            ,B.product_sort1 
            ,B.product_sort2
            ,B.product_sort3 
            ,B.product_sort4
            ,B.capacity_type  
) C ON A.PERIOD=C.PERIOD AND A.production_line =C.production_line
 and nvl(a.capacity_type,'@') =nvl(C.capacity_type,'@')
--  left join(
--         select DISTINCT PRODUCTION_LINE from mddwd.dwd_cnjcb
--     )bb on bb.PRODUCTION_LINE =c.PRODUCTION_LINE and bb.PRODUCTION_LINE is not null


where (A.PRODUCTION_LINE NOT IN('金润德','泰国达美','越南对焊管件') and c.PRODUCTION_LINE not in ('金润德','泰国达美','越南对焊管件')  )or a.PRODUCTION_LINE is null
GROUP BY 
       nvl(A.period,c.period) 
       ,A.PRODUCE_COMPANY_NAME_SN
       ,nvl(A.Production_Line,c.production_line)
       ,nvl(A.capacity_type,c.product_sort2)
       ,A.unit
;
