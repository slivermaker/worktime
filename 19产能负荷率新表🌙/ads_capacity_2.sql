create table ADS_CAPACITY_2
(
  period                     DATE,
  produce_company_name_sn    VARCHAR2(2000),
  production_line            VARCHAR2(2000),
  capacity_type              VARCHAR2(2000),
  working_days               NUMBER,
  monthly_capacity           NUMBER,
  unit                       VARCHAR2(2000),
  in_sale_weight             NUMBER,
  out_sale_weight            NUMBER,
  in_sale_weight_acc         NUMBER,
  out_sale_weight_acc        NUMBER,
  in_amount_m_actual_wy      NUMBER,
  out_amount_m_actual_wy     NUMBER,
  in_amount_m_acc_actual_wy  NUMBER,
  out_amount_m_acc_actual_wy NUMBER,
  etl_crt_dt                 DATE,
  etl_upd_dt                 DATE,
  in_amount_m_target_wy      NUMBER,
  out_amount_m_target_wy     NUMBER,
  in_amount_m_acc_target_wy  NUMBER,
  out_amount_m_acc_target_wy NUMBER
)
tablespace MDADS_DAT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table ADS_CAPACITY_2
  is '各产线发货产能满负荷率报表';
-- Add comments to the columns 
comment on column ADS_CAPACITY_2.period
  is '日期';
comment on column ADS_CAPACITY_2.produce_company_name_sn
  is '生产公司';
comment on column ADS_CAPACITY_2.production_line
  is '生产线';
comment on column ADS_CAPACITY_2.capacity_type
  is '产能类型';
comment on column ADS_CAPACITY_2.working_days
  is '生产天数';
comment on column ADS_CAPACITY_2.monthly_capacity
  is '月产能';
comment on column ADS_CAPACITY_2.unit
  is '单位';
comment on column ADS_CAPACITY_2.in_sale_weight
  is '国内发货量';
comment on column ADS_CAPACITY_2.out_sale_weight
  is '海外发货量';
comment on column ADS_CAPACITY_2.in_sale_weight_acc
  is '国内累计发货量';
comment on column ADS_CAPACITY_2.out_sale_weight_acc
  is '海外累计发货量';
comment on column ADS_CAPACITY_2.in_amount_m_actual_wy
  is '国内发货金额';
comment on column ADS_CAPACITY_2.out_amount_m_actual_wy
  is '海外发货金额';
comment on column ADS_CAPACITY_2.in_amount_m_acc_actual_wy
  is '国内累计发货金额';
comment on column ADS_CAPACITY_2.out_amount_m_acc_actual_wy
  is '海外累计发货金额';
comment on column ADS_CAPACITY_2.etl_crt_dt
  is 'ETL创建日期';
comment on column ADS_CAPACITY_2.etl_upd_dt
  is 'ETL更新日期';
comment on column ADS_CAPACITY_2.in_amount_m_target_wy
  is '国内月度金额目标';
comment on column ADS_CAPACITY_2.out_amount_m_target_wy
  is '国外月度金额目标';
comment on column ADS_CAPACITY_2.in_amount_m_acc_target_wy
  is '国内月累计金额目标';
comment on column ADS_CAPACITY_2.out_amount_m_acc_target_wy
  is '国外月累计金额目标';





IN_WEIGHT_M_ACTUAL_T, --重量月度实际_吨  
IN_WEIGHT_M_ACC_ACTUAL_T--重量月累计实际
IN_AMOUNT_M_ACTUAL_WY,--金额月度实际
IN_AMOUNT_M_TARGET_WY--金额月度目标
IN_AMOUNT_M_ACC_ACTUAL_WY--金额月累计实际
IN_AMOUNT_M_ACC_TARGET_WY--金额月累计目标



OUT_WEIGHT_M_ACTUAL_T, --重量月度实际_吨
OUT_WEIGHT_M_ACC_ACTUAL_T--重量月累计实际
OUT_AMOUNT_M_ACTUAL_WY,--金额月度实际
OUT_AMOUNT_M_TARGET_WY--金额月度目标
OUT_AMOUNT_M_ACC_ACTUAL_WY--金额月累计实际
OUT_AMOUNT_M_ACC_TARGET_WY--金额月累计目标

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
    WHERE
        ASR.SALE_PLATFORM_NAME IN ('国内销售平台', '海外销售平台')
        AND TO_CHAR(PERIOD, 'yyyy') >= '2024'
        AND (ASR.IS_MONTH = '是' OR ASR.IS_DAY = '是')
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