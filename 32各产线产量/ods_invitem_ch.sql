
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
FROM  MDDWD.DWD_PACK_INWARE where  pcs<0


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
  ,round(a.gxsj-b.ORDER_GET_DT) as cycle
from 
       tmp_dws_last a
left join mddwd.DWD_PRODUCT_ORDER_IMS_STG b on a.ddh=b. ORDER_CODE
left join ods_erp.ods_cbzzbb2 c on c.dw=a.rkdw
-------------------------------------------------------------------------------------------------------------------20251103

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
FROM  MDDWD.DWD_PACK_INWARE where  pcs<0


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
left join mddwd.DWD_PRODUCT_ORDER_IMS_STG b on a.ddh=b. ORDER_CODE
left join ods_erp.ods_cbzzbb2 c on c.dw=a.rkdw
left join (select distinct order_code from mddwd.DWD_PACK_ORDER where ORDER_OWE_CNT>0)d on a.ddh=d.order_code

