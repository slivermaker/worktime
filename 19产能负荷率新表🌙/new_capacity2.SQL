
SELECT
    nvl(A.period,b.period) as period  --日期
    ,A.PRODUCE_COMPANY_NAME_SN--生产公司
    ,nvl(A.Production_Line,c.production_line)as production_line --生产线
    ,nvl(A.capacity_type,b.product_sort2) as capacity_type  --产能类型
    ,MAX(A.working_days) --生产天数
    ,MAX(A.monthly_capacity) --月产能
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
full JOIN (
    SELECT
        TRUNC(PERIOD, 'MM') AS PERIOD,
        CORPORATE_ENTITY_NAME_SN AS PRODUCTION_LINE,
        product_sort1,
        product_sort2,
        product_sort3,
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='国内销售平台' THEN ASR.WEIGHT_M_ACTUAL_T ELSE 0 END )AS IN_WEIGHT_M_ACTUAL_T,--国内重量月度实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='海外销售平台' THEN ASR.WEIGHT_M_ACTUAL_T ELSE 0 END )AS OUT_WEIGHT_M_ACTUAL_T,--海外重量月度实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='国内销售平台' THEN ASR.WEIGHT_M_ACC_ACTUAL_T ELSE 0 END )AS IN_WEIGHT_M_ACC_ACTUAL_T,--国内重量月累计实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='海外销售平台' THEN ASR.WEIGHT_M_ACC_ACTUAL_T ELSE 0 END )AS OUT_WEIGHT_M_ACC_ACTUAL_T,--海外重量月累计实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='国内销售平台' THEN ASR.AMOUNT_M_ACTUAL_WY ELSE 0 END )AS IN_AMOUNT_M_ACTUAL_WY,--国内金额月度实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='海外销售平台' THEN ASR.AMOUNT_M_ACTUAL_WY ELSE 0 END )AS OUT_AMOUNT_M_ACTUAL_WY,--海外金额月度实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='国内销售平台' THEN ASR.AMOUNT_M_ACC_ACTUAL_WY ELSE 0 END )AS IN_AMOUNT_M_ACC_ACTUAL_WY,--国内金额月累计实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='海外销售平台' THEN ASR.AMOUNT_M_ACC_ACTUAL_WY ELSE 0 END )AS OUT_AMOUNT_M_ACC_ACTUAL_WY,--海外金额月累计实际
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='国内销售平台' THEN ASR.AMOUNT_M_TARGET_WY ELSE 0 END )AS IN_AMOUNT_M_TARGET_WY,--国内金额月度目标
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='海外销售平台' THEN ASR.AMOUNT_M_TARGET_WY ELSE 0 END )AS OUT_AMOUNT_M_TARGET_WY,--海外金额月度目标
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='国内销售平台' THEN ASR.AMOUNT_M_ACC_TARGET_WY ELSE 0 END )AS IN_AMOUNT_M_ACC_TARGET_WY,--国内金额金额月累计目标
        SUM(CASE WHEN ASR.SALE_PLATFORM_NAME='海外销售平台' THEN ASR.AMOUNT_M_ACC_TARGET_WY ELSE 0 END )AS OUT_AMOUNT_M_ACC_TARGET_WY--海外金额金额月累计目标

    FROM MDADS.ADS_SALE_REVENUE ASR
    right JOIN (
        SELECT distinct
            production_line,
            produce_company_name_sn
        FROM mddwd.dwd_cnlxdzb
    ) bb
    on bb.produce_company_name_sn=asr.CORPORATE_ENTITY_NAME_SN 
    WHERE
        ASR.SALE_PLATFORM_NAME IN ('国内销售平台', '海外销售平台')
        AND TO_CHAR(PERIOD, 'yyyy') >= '2024'
        AND (ASR.IS_MONTH = '是' OR ASR.IS_DAY = '是')
        AND SALES_TARGET_TYPE = '挑战目标'
		and ASR.CORPORATE_ENTITY_NAME_SN NOT IN('金润德','越南对焊管件','泰国达美')
    
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

LEFT JOIN (
        SELECT distinct
            production_line,
            produce_company_name_sn
        FROM mddwd.dwd_cnlxdzb
    ) C
on C.produce_company_name_sn=b.PRODUCTION_LINE 
WHERE  A.period<trunc(SYSDATE,'DD') 
and nvl(A.Production_Line,c.production_line) not in ('金润德','泰国达美','越南对焊管件') OR A.Production_Line IS NULL

GROUP BY nvl(A.period,b.period) as period  --日期
    ,A.PRODUCE_COMPANY_NAME_SN--生产公司
    ,nvl(A.Production_Line,c.production_line)as production_line --生产线
    ,nvl(A.capacity_type,b.product_sort2) as capacity_type  --产能类型
    ,A.unit --单位









