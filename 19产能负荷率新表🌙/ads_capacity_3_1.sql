-- 创建表
CREATE TABLE ads_capacity_3_1 (
    PERIOD DATE,
    produce_company_name_sn VARCHAR2(2000),
    production_line VARCHAR2(2000),
    capacity_type VARCHAR2(2000),
    working_days NUMBER,
    monthly_capacity NUMBER,
    unit VARCHAR2(2000),
    OVER_weight_m_actual_t_save NUMBER,
    OVER_WEIGHT_M_ACTUAL_T_UNSAVE NUMBER,
    IN_WEIGHT_M_ACTUAL_T_SAVE NUMBER,
    IN_WEIGHT_M_ACTUAL_T_UNSAVE NUMBER,
    ETL_CRT_DT DATE,
    ETL_UPD_DT DATE
);

-- 添加表注释
COMMENT ON TABLE ads_capacity_3_1 IS '产线接单满负荷率报表';

-- 添加列注释
COMMENT ON COLUMN ads_capacity_3_1.PERIOD IS '日期';
COMMENT ON COLUMN ads_capacity_3_1.produce_company_name_sn IS '生产公司';
COMMENT ON COLUMN ads_capacity_3_1.production_line IS '生产线';
COMMENT ON COLUMN ads_capacity_3_1.capacity_type IS '产能类型';
COMMENT ON COLUMN ads_capacity_3_1.working_days IS '生产天数';
COMMENT ON COLUMN ads_capacity_3_1.monthly_capacity IS '月产能';
COMMENT ON COLUMN ads_capacity_3_1.unit IS '单位';
COMMENT ON COLUMN ads_capacity_3_1.OVER_weight_m_actual_t_save IS '海外正式订单';
COMMENT ON COLUMN ads_capacity_3_1.OVER_WEIGHT_M_ACTUAL_T_UNSAVE IS '海外储备订单';
COMMENT ON COLUMN ads_capacity_3_1.IN_WEIGHT_M_ACTUAL_T_SAVE IS '国内正式订单';
COMMENT ON COLUMN ads_capacity_3_1.IN_WEIGHT_M_ACTUAL_T_UNSAVE IS '国内生产储备订单';
COMMENT ON COLUMN ads_capacity_3_1.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN ads_capacity_3_1.ETL_UPD_DT IS 'ETL更新日期';

--正式和储备换一下位置，字段不变数据变    20250825为了避免bibug，不影响bi的数据集,如果出现储备订单数据和正式订单数据位置交换就是这个问题
TRUNCATE TABLE ADS_CAPACITY_3_1 ;


INSERT INTO ADS_CAPACITY_3_1 (
    PERIOD,
    produce_company_name_sn,
    production_line,
    capacity_type,
    working_days,
    monthly_capacity,
    unit,
    IN_WEIGHT_M_ACTUAL_T_SAVE,
    OVER_weight_m_actual_t_save,
    IN_WEIGHT_M_ACTUAL_T_UNSAVE,
    OVER_WEIGHT_M_ACTUAL_T_UNSAVE


)
 
 SELECT 
       A.period 
       ,A.PRODUCE_COMPANY_NAME_SN
       ,A.Production_Line
       ,A.capacity_type  
 SELECT 
       A.period 
       ,A.PRODUCE_COMPANY_NAME_SN
       ,A.Production_Line
       ,A.capacity_type  
       ,A.working_days 
       ,A.monthly_capacity 
       ,A.unit 
       ,SUM(C.IN_WEIGHT_M_ACTUAL_T_SAVE) AS IN_WEIGHT_M_ACTUAL_T_SAVE
       ,SUM(C.OVER_WEIGHT_M_ACTUAL_T_SAVE) AS OVER_WEIGHT_M_ACTUAL_T_SAVE
       ,SUM(C.IN_WEIGHT_M_ACTUAL_T_UNSAVE) AS IN_WEIGHT_M_ACTUAL_T_UNSAVE
       ,SUM(C.OVER_WEIGHT_M_ACTUAL_T_UNSAVE) AS OVER_WEIGHT_M_ACTUAL_T_UNSAVE
       
FROM (
    SELECT  DISTINCT 
            PERIOD 
            ,PRODUCE_COMPANY_NAME_SN
            ,PRODUCTION_LINE
            ,CAPACITY_TYPE  
            ,WORKING_DAYS 
            ,MONTHLY_CAPACITY 
            ,UNIT 
    FROM    MDDWS.DWS_CAPACITY_ALL
) A
LEFT JOIN 
(
    SELECT B.PERIOD 
         ,B.product_line AS production_line
         ,B.product_sort1 
         ,B.product_sort2
         ,B.product_sort3 
         ,B.product_sort4
         ,B.capacity_type  
         ,SUM(CASE WHEN  ORG_NAME1 = '国内销售平台' THEN B.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS IN_WEIGHT_M_ACTUAL_T_SAVE
         ,SUM(CASE WHEN ORG_NAME1 = '海外销售平台' THEN B.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS OVER_WEIGHT_M_ACTUAL_T_SAVE
         ,SUM(CASE WHEN EX_IN_ORDER = '内销'  THEN B.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS IN_WEIGHT_M_ACTUAL_T_UNSAVE
         ,SUM(CASE WHEN EX_IN_ORDER = '外销'  THEN B.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS OVER_WEIGHT_M_ACTUAL_T_UNSAVE
         
    FROM MDDWS.DWS_PRODUCT_ORDER_REVENUE B 
    GROUP BY B.period 
            ,B.org_name1 
            ,B.product_line 
            ,B.product_sort1 
            ,B.product_sort2
            ,B.product_sort3 
            ,B.product_sort4
            ,B.capacity_type  
) C ON A.PERIOD=C.PERIOD AND A.production_line =C.production_line AND A.capacity_type =C.capacity_type

GROUP BY 
       A.period 
       ,A.PRODUCE_COMPANY_NAME_SN
       ,A.Production_Line
       ,A.capacity_type  
       ,A.working_days 
       ,A.monthly_capacity 
       ,A.unit
;

       ,A.working_days 
       ,A.monthly_capacity 
       ,A.unit 
       ,SUM(C.IN_WEIGHT_M_ACTUAL_T_SAVE) AS IN_WEIGHT_M_ACTUAL_T_SAVE
       ,SUM(C.OVER_WEIGHT_M_ACTUAL_T_SAVE) AS OVER_WEIGHT_M_ACTUAL_T_SAVE
       ,SUM(C.IN_WEIGHT_M_ACTUAL_T_UNSAVE) AS IN_WEIGHT_M_ACTUAL_T_UNSAVE
       ,SUM(C.OVER_WEIGHT_M_ACTUAL_T_UNSAVE) AS OVER_WEIGHT_M_ACTUAL_T_UNSAVE
       
FROM (
    SELECT  DISTINCT 
            PERIOD 
            ,PRODUCE_COMPANY_NAME_SN
            ,PRODUCTION_LINE
            ,CAPACITY_TYPE  
            ,WORKING_DAYS 
            ,MONTHLY_CAPACITY 
            ,UNIT 
    FROM    MDDWS.DWS_CAPACITY_ALL
) A
LEFT JOIN 
(
    SELECT B.PERIOD 
         ,B.product_line AS production_line
         ,B.product_sort1 
         ,B.product_sort2
         ,B.product_sort3 
         ,B.product_sort4
         ,B.capacity_type  
         ,SUM(CASE WHEN EX_IN_ORDER = '内销' THEN B.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS IN_WEIGHT_M_ACTUAL_T_SAVE
         ,SUM(CASE WHEN EX_IN_ORDER = '外销' THEN B.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS OVER_WEIGHT_M_ACTUAL_T_SAVE
         ,SUM(CASE WHEN ORG_NAME1 = '国内销售平台' THEN B.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS IN_WEIGHT_M_ACTUAL_T_UNSAVE
         ,SUM(CASE WHEN ORG_NAME1 = '海外销售平台' THEN B.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS OVER_WEIGHT_M_ACTUAL_T_UNSAVE--正式和储备换一下位置，字段不变数据变    20250825为了不影响bi的数据集
       
    FROM MDDWS.DWS_PRODUCT_ORDER_REVENUE B 
    GROUP BY B.period 
            ,B.org_name1 
            ,B.product_line 
            ,B.product_sort1 
            ,B.product_sort2
            ,B.product_sort3 
            ,B.product_sort4
            ,B.capacity_type  
) C ON A.PERIOD=C.PERIOD AND A.production_line =C.production_line AND A.capacity_type =C.capacity_type

GROUP BY 
       A.period 
       ,A.PRODUCE_COMPANY_NAME_SN
       ,A.Production_Line
       ,A.capacity_type  
       ,A.working_days 
       ,A.monthly_capacity 
       ,A.unit
;