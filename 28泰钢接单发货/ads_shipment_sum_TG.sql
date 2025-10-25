CREATE TABLE ADS_SHIPMENT_SUM_TG (
    PERIOD DATE,
    PRODUCT_NAME VARCHAR2(2000),
    IN_WEIGHT_T NUMBER,
    OUT_WEIGHT_T NUMBER,
    SHIP_WGT_T_SAMEP NUMBER,
    ETL_CRT_DT DATE DEFAULT SYSDATE,
    ETL_UPD_DT DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ADS_SHIPMENT_SUM_TG IS '泰钢发货汇总表';

COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.PERIOD IS '发货日期';
COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.PRODUCT_NAME IS '材质';
COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.IN_WEIGHT_T IS '内销重量';
COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.OUT_WEIGHT_T IS '外销重量';
COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.SHIP_WGT_T_SAMEP IS '上月同期累计发货';
COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN ADS_SHIPMENT_SUM_TG.ETL_UPD_DT IS 'ETL更新日期';



iNSERT INTO MDADS.ADS_SHIPMENT_SUM_TG (
    PERIOD,
    PRODUCT_NAME,
    SALE_TYPE,
    WEIGHT_T,
    SHIP_WGT_T_ACC_MONTH

)
WITH TMP_DWD AS (
  SELECT 
       A.PERIOD_DAY as period,
       --A.ORDER_CODE,
       CASE WHEN A.CUSTOMER_COUNTRY='泰国' THEN '内销' else '外销' end as sale_type,
       B.CZBZ as TEXTURE_type,
       A.SALES_WEIGHT_KG as weight_kg
  FROM mddwd.DWD_SALE_REVENUE A 
       LEFT JOIN MDDIM.DIM_ORDER_TO_TEXTURE B
       ON SUBSTR(A.ORDER_CODE,1,3)=B.DDQZ
  WHERE CORPORATE_ENTITY_NAME_SN='泰钢管配件'  
  AND A.ORDER_CODE IS NOT NULL
  AND B.LX='fhcz'
),
tmp_dws as (
SELECT 
    period,
    sale_type,
    texture_type,
    SUM(weight_kg) / 1000 AS weight_t,
    SUM(SUM(weight_kg) / 1000) OVER (
        PARTITION BY 
            EXTRACT(YEAR FROM period),
            EXTRACT(MONTH FROM period),
            sale_type,
            texture_type
        ORDER BY period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS SHIP_WGT_T_ACC_month
FROM tmp_dwd
GROUP BY 
    period,
    sale_type,
    texture_type
)
  select period,
         TEXTURE_TYPE,
         SALE_TYPE,
         WEIGHT_T,
         SHIP_WGT_T_ACC_month
FROM TMP_DWS





WITH TMP AS(

    SELECT 
    DECODE(DTYPE.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * D.DELIVERY_FACT_NETWEIGHT_KG * DECODE(JLDW.NAME,'吨',1000,1)  AS sales_weight_kg,D.ACTUAL_DELIVERY_DT,f.IS_INTERNATIONAL_TRADE
    FROM ODS_IMS.crm_so_order_line A
    LEFT JOIN MDDWI.DWI_SALE_DELIVERY D
    ON A.ORDER_LINE_ID=D.ORDER_DTL_ID
    LEFT JOIN MDDIM.DIM_ORG_D E ON E.ORG_ID=D.ORG_ID 
    left join   ods_ims.crm_so_order_header  f
    ON A.ORDER_ID=f.ORDER_ID
    LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE DTYPE --取发货单类型
        ON D.DELIVERY_TYPE_ID = DTYPE.ORDER_TYPE_ID
    LEFT JOIN MDDIM.DIM_CODE_D JLDW --关联计量单位
        ON JLDW.SOURCE_SYS = 'IMS'
        AND JLDW.COMMENT1 = '单位'
        AND D.UNIT_OF_MEASURE = JLDW.CODE

    WHERE trunc(D.ACTUAL_DELIVERY_DT,'MM')>=DATE'2025-01-1' AND ORG_NAME ='68_泰钢管配件2402'

)

--------------------------------

       
INSERT INTO MDADS.ADS_SHIPMENT_SUM_TG (
    PERIOD,
    PRODUCT_NAME,
    SALE_TYPE,
    WEIGHT_T,
    SHIP_WGT_T_ACC_MONTH

)
       
SELECT a.PERIOD_DAY
,b.czbz
,sum(a.SALES_WEIGHT_KG)/1000 as weight_t
, (CASE WHEN CUSTOMER_COUNTRY='泰国' THEN '内销' else '外销' end )as SALE_TYPE
FROM DWD_DELIVERY a
left join(
     select ddqz
            ,czbz
     from
     MDDIM.DIM_ORDER_TO_TEXTURE
     where lx='fhcz'
)b
on SUBSTR(A.ORDER_CODE,1,3)=B.DDQZ
 where a.period_day>=date'2025-01-1' AND CZBZ IS NOT NULL
group by a.period_day,b.czbz,(CASE WHEN CUSTOMER_COUNTRY='泰国' THEN '内销' else '外销' end )

---------------------------------------------------------------20251020
       
SELECT distinct
       c.ORDER_NUM,
       d.czbz,
       --b.FACTORY_ID,
       a.REAL_CONFIRM_DATE,
       a.NET_WEIGHT,
       e.ddh
FROM ods_ims.crm_lg_delivery_header a LEFT JOIN ods_ims.CRM_LG_DELIVERY_LINE B ON A.DELIVERY_HEAD_ID = B.DELIVERY_HEAD_ID
LEFT JOIN ods_ims.CRM_SO_ORDER_HEADER C ON C.ORDER_ID = B.ORDER_ID
LEFT JOIN(
      select 
          czbz,
          ddqz
      from MDDIM.DIM_ORDER_TO_TEXTURE
      where lx='fhcz'
)  d
ON SUBSTR(c.ORDER_num,1,3)=d.DDQZ
left join ods_erp.ods_soctrl_tg e on e.ddh=c.order_num 
where a.REAL_CONFIRM_DATE >date'2025-10-1'   and d.czbz is not null
