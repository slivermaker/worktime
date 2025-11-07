     
WITH TMP_DWD AS (
  SELECT TRUNC(ORDER_SHIP_DT,'MM') AS PERIOD
         ,PRODUCTION_LINE
         ,FACTORY
         ,COUNT(ORDER_CODE) AS ORDER_CNT
         ,SUM(DELIVERY_CYCLE) AS CYCLE_SUM
  FROM ads_delivery_cycle_rkdw
  GROUP BY TRUNC(ORDER_SHIP_DT,'MM'),PRODUCTION_LINE,FACTORY
)
,main as(SELECT A.PERIOD
        ,A.PRODUCTION_LINE
        ,A.FACTORY
        ,A.ORDER_CNT
        ,A.CYCLE_SUM
        ,B.ORDER_CNT AS ORDER_CNT_LAST_M
        ,B.CYCLE_SUM AS CYCLE_SUM_LAST_M
        ,C.ORDER_CNT AS ORDER_CNT_LAST_Y
        ,C.CYCLE_SUM AS CYCLE_SUM_LAST_Y
FROM TMP_DWD A 
LEFT JOIN TMP_DWD B ON A.PERIOD=ADD_MONTHS(B.PERIOD,1) AND A.PRODUCTION_LINE=B.PRODUCTION_LINE AND A.FACTORY=B.FACTORY
LEFT JOIN TMP_DWD C ON A.PERIOD=ADD_MONTHS(C.PERIOD,12) AND A.PRODUCTION_LINE=C.PRODUCTION_LINE AND A.FACTORY=C.FACTORY
)
select * from main where period>=date'2025-01-1'



-------------------------------------------------------------------------------20251103排除一对多
with tmp_dws as (
select 
      rq
      ,rkdw
      ,khm
      ,ddh
      ,yyz_to_date(jhq,'YYYY-MM-DD') as jhq
      ,pz
      ,gg
      ,xs
      ,czfl
      ,bmcl
      ,gxsj
      ,null js
from  ods_mom.ods_product_warehouse_wh
union all 

SELECT 
       period
       ,inware_org 
       ,customer_name  
       ,order_code  
       ,ship_dt  
       ,product_variety 
       ,product_specification  
       ,product_form  
       ,product_texture  
       ,surface_treatment  
       ,update_dt
       ,PCS
FROM  MDDWD.DWD_PACK_INWARE where  pcs>0


)
,tmp_dws_last as (
  SELECT  
     *
   FROM(    
     select
       rq
      ,rkdw
      ,khm
      ,ddh
      ,jhq
      ,pz
      ,gg
      ,xs
      ,czfl
      ,bmcl
      ,gxsj
      ,ROW_NUMBER() over(partition by ddh order by gxsj desc) as rn
    from tmp_dws
    )   where rn=1 and substr(ddh,7,1)!='A' and substr(ddh,7,1)!='4' and substr(ddh,7,1)!='8'  AND KHM!='销售科内销' and khm !='自用订单' 
)





select 
    c.scx
    ,c.cb
  ,a.rkdw
  ,a.khm
  ,a.ddh
  ,a.jhq
  ,a.pz
  ,a.gg
  ,a.xs
  ,a.czfl
  ,a.bmcl
  ,a.gxsj
  ,b.ORDER_GET_DT
  ,case when d.order_code is not null then round(a.gxsj-b.ORDER_GET_DT) else round(sysdate-b.order_get_dt) end  as cycle
from 
       tmp_dws_last a
left join(
     select order_code,min(order_get_dt)as order_get_dt from mddwd.DWD_PRODUCT_ORDER_IMS_STG group by order_code
)  b on a.ddh=b. ORDER_CODE
left join ods_erp.ods_cbzzbb2 c on c.dw=a.rkdw
left join (select distinct order_code from mddwd.DWD_PACK_ORDER where ORDER_OWE_CNT>0)d on a.ddh=d.order_code





--------------------------------------------------------------20251103添加内外销
   
WITH TMP_DWD AS (
  select 
    ,PERIOD
    ,PRODUCTION_LINE
    ,FACTORY
    ,sum(case when sale_type='内销' then 1 else 0 ) as order_cnt_in
    ,sum(case when sale_type='外销' then 1 else 0 ) as order_cnt_over
    ,sum(case when sale_type='内销' then DELIVERY_CYCLE else 0) as cycle_sum_in
    ,sum(case when sale_type='外销' then DELIVERY_CYCLE else 0) as cycle_sum_over
   from (

    SELECT TRUNC(ORDER_SHIP_DT,'MM') AS PERIOD
          ,PRODUCTION_LINE
          ,FACTORY
          ,case when substr(order_code,7,1)='0' then '内销'
                when substr(order_code,7,1)='1' or substr(order_code,7,1)='2' or substr(order_code,7,1)='6' or substr(order_code,7,1)='B' THEN '外销'
                else 'other'
                end as sale_type
          ,ORDER_CODE
          ,DELIVERY_CYCLE
    FROM ads_delivery_cycle_rkdw
  )
  GROUP BY period,PRODUCTION_LINE,FACTORY
)
,main as(SELECT A.PERIOD
        ,A.PRODUCTION_LINE
        ,A.FACTORY
        ,A.ORDER_CNT_in 
        ,A.CYCLE_SUM_in
        ,a.order_cnt_over
        ,a.cycle_sum_over
        ,b.ORDER_CNT_in  as  ORDER_CNT_in_last_m
        ,b.CYCLE_SUM_in  as  CYCLE_SUM_in_last_m
        ,b.order_cnt_over as order_cnt_over_last_m
        ,b.cycle_sum_over as cycle_sum_over_last_m
        ,c.ORDER_CNT_in  as  ORDER_CNT_in_last_y
        ,c.CYCLE_SUM_in  as  CYCLE_SUM_in_last_y
        ,c.order_cnt_over as order_cnt_over_last_y
        ,c.cycle_sum_over as cycle_sum_over_last_y
        /*
        ,B.ORDER_CNT AS ORDER_CNT_LAST_M
        ,B.CYCLE_SUM AS CYCLE_SUM_LAST_M
        ,C.ORDER_CNT AS ORDER_CNT_LAST_Y
        ,C.CYCLE_SUM AS CYCLE_SUM_LAST_Y
        */
FROM TMP_DWD A 
LEFT JOIN TMP_DWD B ON A.PERIOD=ADD_MONTHS(B.PERIOD,1) AND A.PRODUCTION_LINE=B.PRODUCTION_LINE AND A.FACTORY=B.FACTORY
LEFT JOIN TMP_DWD C ON A.PERIOD=ADD_MONTHS(C.PERIOD,12) AND A.PRODUCTION_LINE=C.PRODUCTION_LINE AND A.FACTORY=C.FACTORY
)

SELECT PERIOD
      ,PRODUCTION_LINE
      ,FACTORY
      ,ORDER_CNT_in
      ,CYCLE_SUM_in
      ,order_cnt_over
      ,cycle_sum_over
      ,ORDER_CNT_in_last_m
      ,CYCLE_SUM_in_last_m
      ,order_cnt_over_last_m
      ,cycle_sum_over_last_m
      ,ORDER_CNT_in_last_y
      ,CYCLE_SUM_in_last_y
      ,order_cnt_over_last_y
      ,cycle_sum_over_last_y
FROM main


----------------------------------------------------------------------------------添加累计
WITH TMP_DWD AS (
  select 
    PERIOD
    ,PRODUCTION_LINE
    ,FACTORY
    ,sum(case when sale_type='内销' then 1 else 0 end) as order_cnt_in
    ,sum(case when sale_type='外销' then 1 else 0 end) as order_cnt_over
    ,sum(case when sale_type='内销' then DELIVERY_CYCLE else 0 end) as cycle_sum_in
    ,sum(case when sale_type='外销' then DELIVERY_CYCLE else 0 end) as cycle_sum_over
    ,sum(sum(case when sale_type='内销' then 1 else 0 end)) over(partition by production_line,factory order by period ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as acc_order_cnt_in
    ,sum(sum(case when sale_type='外销' then 1 else 0 end)) over(partition by production_line,factory order by period ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as acc_order_cnt_over
    ,sum(sum(case when sale_type='内销' then DELIVERY_CYCLE else 0 end)) over(partition by production_line,factory order by period ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as acc_cycle_sum_in
    ,sum(sum(case when sale_type='外销' then DELIVERY_CYCLE else 0 end)) over(partition by production_line,factory order by period ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as acc_cycle_sum_over


   from (

    SELECT TRUNC(ORDER_SHIP_DT,'MM') AS PERIOD
          ,PRODUCTION_LINE
          ,FACTORY
          ,case when substr(order_code,7,1)='0' then '内销'
                when substr(order_code,7,1)='1' or substr(order_code,7,1)='2' or substr(order_code,7,1)='6' or substr(order_code,7,1)='B' THEN '外销'
                else 'other'
                end as sale_type
          ,ORDER_CODE
          ,DELIVERY_CYCLE
    FROM ads_delivery_cycle_rkdw
  )
  GROUP BY period,PRODUCTION_LINE,FACTORY
)
,main as(SELECT A.PERIOD
        ,A.PRODUCTION_LINE
        ,A.FACTORY
        ,A.ORDER_CNT_in 
        ,A.CYCLE_SUM_in
        ,a.order_cnt_over
        ,a.cycle_sum_over
        ,b.ORDER_CNT_in  as  ORDER_CNT_in_last_m
        ,b.CYCLE_SUM_in  as  CYCLE_SUM_in_last_m
        ,b.order_cnt_over as order_cnt_over_last_m
        ,b.cycle_sum_over as cycle_sum_over_last_m
        ,c.ORDER_CNT_in  as  ORDER_CNT_in_last_y
        ,c.CYCLE_SUM_in  as  CYCLE_SUM_in_last_y
        ,c.order_cnt_over as order_cnt_over_last_y
        ,c.cycle_sum_over as cycle_sum_over_last_y
        ,a.acc_order_cnt_in
        ,a.acc_order_cnt_over
        ,a.acc_cycle_sum_in
        ,a.acc_cycle_sum_over
        /*
        ,B.ORDER_CNT AS ORDER_CNT_LAST_M
        ,B.CYCLE_SUM AS CYCLE_SUM_LAST_M
        ,C.ORDER_CNT AS ORDER_CNT_LAST_Y
        ,C.CYCLE_SUM AS CYCLE_SUM_LAST_Y
        */
FROM TMP_DWD A 
LEFT JOIN TMP_DWD B ON A.PERIOD=ADD_MONTHS(B.PERIOD,1) AND A.PRODUCTION_LINE=B.PRODUCTION_LINE AND A.FACTORY=B.FACTORY
LEFT JOIN TMP_DWD C ON A.PERIOD=ADD_MONTHS(C.PERIOD,12) AND A.PRODUCTION_LINE=C.PRODUCTION_LINE AND A.FACTORY=C.FACTORY
)

SELECT PERIOD
      ,PRODUCTION_LINE
      ,FACTORY
      ,ORDER_CNT_in
      ,CYCLE_SUM_in
      ,order_cnt_over
      ,cycle_sum_over
      ,ORDER_CNT_in_last_m
      ,CYCLE_SUM_in_last_m
      ,order_cnt_over_last_m
      ,cycle_sum_over_last_m
      ,ORDER_CNT_in_last_y
      ,CYCLE_SUM_in_last_y
      ,order_cnt_over_last_y
      ,cycle_sum_over_last_y
      ,acc_order_cnt_in
      ,acc_order_cnt_over
      ,acc_cycle_sum_in
      ,acc_cycle_sum_over
FROM main