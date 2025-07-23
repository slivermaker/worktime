/*
  Description：入库/留账成本
  Author：岳耀哲
  Create date：2024.12.09
  Modify：岳耀哲
  Update date：2024.12.11
  UPDATE date：2025.3.10
  Update note:  迈克阀门和艾瓦兹的入库成本和留账成本产品类型只显示(阀门：阀门、阀门铸件、灰铁污水管件  艾瓦兹：工业软管 、燃气软管、消防软管)
*/



truncate table  ADS_INVENTORY_COST ;


insert  into  ADS_INVENTORY_COST(
yperiod, 
company_name, 
product_form, 
measurement_units, 
product_sort_h, 
storage_cost, 
retention_cost, 
STORAGE_COST_MOM,
RETENTION_COST_MOM,
etl_crt_dt, 
etl_upd_dt

)
-------------EBS数据--------------------管树鹏数据对接人
SELECT  
A.PERIOD --日期
,SUBSTR(
    A.COMPANY, 
    INSTR(A.COMPANY, '_', 1, 2) + 1
  ) AS COMPANY  --公司
,A.MATERIAL_TYPE  --产品类型 
,'元/吨' -- 单位
,A.PRODUCT_SORT --产品大类
, sum(case  when  A.MATERIAL_TYPE = '产成品' then nvl(A.INWARE_PRODUCT,0)   
        when A.MATERIAL_TYPE = '半成品' then  nvl(A.INWARE_BLANK,0) 
        else  0  end )   storage_cost    -- 入库成本
, sum(case  when A.MATERIAL_TYPE = '产成品' then  nvl(A.RETAIN_PRODUCT,0)   
        when A.MATERIAL_TYPE = '半成品' then  nvl(A.RETAIN_BLANK,0) 
        else  0  end )    storage_cost   --  留账成本   
, sum(case  when  A.MATERIAL_TYPE = '产成品' then nvl(B.INWARE_PRODUCT,0)   
        when A.MATERIAL_TYPE = '半成品' then  nvl(B.INWARE_BLANK,0) 
        else  0  end )   STORAGE_COST_MOM    -- 上月入库成本
, sum(case  when A.MATERIAL_TYPE = '产成品' then  nvl(B.RETAIN_PRODUCT,0)   
        when A.MATERIAL_TYPE = '半成品' then  nvl(B.RETAIN_BLANK,0) 
        else  0  end )    RETENTION_COST_MOM   --  上月留账成本                        
,sysdate 
,sysdate
FROM 
ODS_EBS.ODS_EBS_COST_V    A 
left join ODS_EBS.ODS_EBS_COST_V B  
   on A.PERIOD = TRUNC(ADD_MONTHS(B.PERIOD, +1), 'MM')
    and A.COMPANY = B.COMPANY
     and A.MATERIAL_TYPE = B.MATERIAL_TYPE 
      and a.PRODUCT_SORT = B.PRODUCT_SORT
group  by  A.PERIOD ,A.COMPANY,A.MATERIAL_TYPE,A.PRODUCT_SORT

union all
--------手工数据------------------ 于静数据对接人
SELECT   
to_date(A.YF,'YY.MM') 
,A.GSMC  --公司名称
,'产成品'   -- 产品类型
,case when A.GSMC = '山东晨晖电子科技有限公司'  then '元/台'  else   '元/吨'  end -- 单位
,A.CPFL --产品分类 
,nvl(A.RKCB_CCP,0) -- 入库成本
,nvl(A.LZCB_CCP,0) -- 留账成本
,nvl(B.RKCB_CCP,0) -- 上月入库成本
,nvl(B.LZCB_CCP,0) -- 上月留账成本
,sysdate 
,sysdate
FROM ODS_ERP.ODS_RKLZCBLRB  A 
left join ODS_ERP.ODS_RKLZCBLRB  B
 ON to_date(A.YF,'YY.MM')  = TRUNC(ADD_MONTHS(to_date(B.YF,'YY.MM'), +1), 'MM')
  and A.GSMC = B.GSMC
  and A.CPFL =  B.CPFL
union  all  

SELECT   
to_date(A.YF,'YY.MM') 
,A.GSMC  --公司名称
,'半成品'   -- 产品类型
,case when A.GSMC = '山东晨晖电子科技有限公司'  then '元/台'  else   '元/吨'  end  -- 单位
,A.CPFL --产品分类 
,nvl(A.RKCB_BCP,0) -- 入库成本
,nvl(A.LZCB_BCP,0) -- 留账成本
,nvl(B.RKCB_BCP,0) -- 上月入库成本
,nvl(B.LZCB_BCP,0) -- 上月留账成本
,sysdate 
,sysdate
 FROM ODS_ERP.ODS_RKLZCBLRB  A 
left join ODS_ERP.ODS_RKLZCBLRB  B
 ON to_date(A.YF,'YY.MM')  = TRUNC(ADD_MONTHS(to_date(B.YF,'YY.MM'), +1), 'MM')
  and A.GSMC = B.GSMC
  and A.CPFL =  B.CPFL

------------U9-------侯宁数据对接人
union  all

select  PERIOD, ORGANIZATION,PRODUCTION,measurement_units,BIGCLASS,sum(storage_cost),sum(retention_cost),sum(storage_cost_MOM) ,sum(retention_cost_MOM),sysdate,sysdate from  
(
SELECT 
to_date(A.PERIOD,'YYYY-MM') PERIOD 
,A.ORGANIZATION  ORGANIZATION  --公司名称
,A.PRODUCTION    PRODUCTION -- 产品类型
,'元/吨'     measurement_units -- 单位
,A.BIGCLASS    --产品分类 
,nvl(A.COST,0)  as storage_cost  -- 入库成本
,0  retention_cost -- 留账成本
,nvl(B.COST,0)  as storage_cost_MOM  -- 上月入库成本
,0  retention_cost_MOM -- 上月留账成本
FROM    ODS_ERP.ODS_Finan_StorageCost A 
left join  ODS_ERP.ODS_Finan_StorageCost B 
on   to_date(A.PERIOD,'YYYY-MM') = TRUNC(ADD_MONTHS(to_date(B.PERIOD,'YYYY-MM'), +1), 'MM')
 and  A.ORGANIZATION  =  B.ORGANIZATION 
  and A.PRODUCTION = B.PRODUCTION
   and A.BIGCLASS = b.BIGCLASS
union  all
SELECT 
to_date(A.PERIOD,'YYYY-MM')  PERIOD
,A.ORGANIZATION  --公司名称
,A.PRODUCTION   -- 产品类型
,'元/吨' -- 单位
,A.BIGCLASS --产品分类 
,0  -- 入库成本
,nvl(A.COST,0) -- 留账成本
,0  -- 入库成本
,nvl(B.COST,0) -- 留账成本
FROM    ODS_ERP.ODS_FINAN_RETENTIONCOST A
left join  ODS_ERP.ODS_FINAN_RETENTIONCOST B 
on   to_date(A.PERIOD,'YYYY-MM') = TRUNC(ADD_MONTHS(to_date(B.PERIOD,'YYYY-MM'), +1), 'MM')
 and  A.ORGANIZATION  =  B.ORGANIZATION 
  and A.PRODUCTION = B.PRODUCTION
   and A.BIGCLASS = b.BIGCLASS
) group by  PERIOD, ORGANIZATION,PRODUCTION,measurement_units,BIGCLASS ;
commit ;



update ADS_INVENTORY_COST set company_name_sn = (select SCXJC FROM ODS_ERP.ODS_GJZBSCX WHERE company_name = SCX);
delete  from ADS_INVENTORY_COST  where COMPANY_NAME in ( '玫德集团有限公司') and  PRODUCT_SORT_H not in  ('玛钢管件');

delete  from ADS_INVENTORY_COST  where COMPANY_NAME in ( '玫德集团临沂有限公司')  and  PRODUCT_SORT_H not in  ('球铁沟槽管件','钢帽');

delete  from ADS_INVENTORY_COST  where COMPANY_NAME  = '济南迈克阀门科技有限公司' and   PRODUCT_SORT_H not in ('阀门','阀门铸件','灰铁污水管件');


delete  from ADS_INVENTORY_COST  where COMPANY_NAME  = '玫德艾瓦兹（济南）金属制品有限公司' and   PRODUCT_SORT_H not in ('工业软管','燃气软管','消防软管');

COMMIT;


