
truncate table ads_package_warehouse_sum_tg
INSERT INTO ads_package_warehouse_sum_tg (
    period,
    warehousing_type,
    group_name,
    warehousing_weight_t,
    fine_packaging_cnt,
    fine_packaging_wgt_T

)

with all_to_one as (
     select ddh ,
            case when KHJC='丛德贸易' then '1' else fjz end as isjbz,
            fbuynum AS jbz_cnt ,
            TOTALNW as jbz_wgt
            from  ods_erp.ods_soctrl_tg
)
,order_clean as (
            select 
               to_date(rq,'YY.MM.DD') as period,
               ddh,
               rkdw,
               sum(zl) as zl
            from ods_erp.ODS_BZRKB_TG
            WHERE RQ NOT LIKE'  %'
            group by ddh,rkdw,to_date(rq,'YY.MM.DD')
            
)

--select count(*),ddh from order_clean group by ddh
select 
      a.PERIOD,
      C.RKCZ,
      a.rkdw,
      sum(a.zl)/1000,
      --max(b.isjbz),
      sum(case when b.isjbz='1' then b.jbz_cnt else 0 end) as fine_packaging_cnt,
      sum(case when b.isjbz='1'then b.jbz_wgt else 0 end)/1000 as fine_packaging_wgt_T
from order_clean A 
     left join all_to_one b on a.ddh=b.ddh 
     LEFT JOIN MDDIM.DIM_GROUP_TO_TYPE_TG C  ON C.BZDW=A.RKDW
group by a.period,C.RKCZ,a.rkdw



----------------------------------------------------------------------------------------------------


CREATE TABLE ads_package_warehouse_sum_tg (
    period DATE,
    warehousing_type VARCHAR2(2000),
    group_name VARCHAR2(2000),
    warehousing_weight_t NUMBER,
    fine_packaging_cnt NUMBER,
    fine_packaging_wgt_T NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ads_package_warehouse_sum_tg IS '包装入库汇总表';

COMMENT ON COLUMN ads_package_warehouse_sum_tg.period IS '日期';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.warehousing_type IS '入库材质';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.group_name IS '入库单位';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.warehousing_weight_t IS '入库重量';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.fine_packaging_cnt IS '精装件数';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.fine_packaging_wgt_T IS '精装吨位';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.etl_crt_dt IS 'ETL创建日期';
COMMENT ON COLUMN ads_package_warehouse_sum_tg.etl_upd_dt IS 'ETL更新日期';


----------------------------------------------------------------20251013

INSERT INTO ads_package_warehouse_sum_tg (
    period,
    warehousing_type,
    group_name,
    warehousing_weight_t,
    fine_packaging_cnt,
    fine_packaging_wgt_T

)
with all_to_one as (
     select ddh ,
            case when KHJC='丛德贸易' then '1' else fjz end as isjbz,
            fbuynum AS jbz_cnt ,
            TOTALNW as jbz_wgt
            from  ods_erp.ods_soctrl_tg
)
,order_clean as (
            select 
               to_date(rq,'YY.MM.DD') as period,
               ddh,
               rkdw,
               sum(js) as js,
               sum(zl) as zl
            from ods_erp.ODS_BZRKB_TG
            WHERE RQ NOT LIKE'  %'
            group by ddh,rkdw,to_date(rq,'YY.MM.DD')
            
            
)

select 
      a.PERIOD,
      C.RKCZ,
      a.rkdw,
      sum(a.zl)/1000,
      sum(case when (b.isjbz='1' and d.ddqz is not null) then a.js else 0 end) as fine_packaging_cnt,
      sum(case when (b.isjbz='1' and d.ddqz is not null) then a.zl else 0 end)/1000 as fine_packaging_wgt_T
from order_clean A 
     left join all_to_one b on a.ddh=b.ddh 
     LEFT JOIN MDDIM.DIM_GROUP_TO_TYPE_TG C  ON C.BZDW=A.RKDW
     left join (
        select 
        ddqz
        from MDDIM.DIM_ORDER_TO_TEXTURE
        WHERE LX='bz'
     ) d  ON SUBSTR(A.DDH, 1, 3) = d.DDQZ

group by a.period,C.RKCZ,a.rkdw



---------------------------------------------------------20251013

INSERT INTO ads_package_warehouse_sum_tg (
    period,
    warehousing_type,
    group_name,
    warehousing_weight_t,
    fine_packaging_cnt,
    fine_packaging_wgt_T

)
with all_to_one as (
     select ddh ,
            case when KHJC='丛德贸易' then '1' else fjz end as isjbz,
            fbuynum AS jbz_cnt ,
            TOTALNW as jbz_wgt
            from  ods_erp.ods_soctrl_tg
)
,order_clean as (
            select 
               to_date(rq,'YY.MM.DD') as period,
               ddh,
               rkdw,
               sum(case when KHXSH<0  then js*-1 else js end ) as js,
               sum(case when KHXSH<0 then zl*-1 else zl end) as zl
            from ods_erp.ODS_BZRKB_TG
            WHERE RQ NOT LIKE'  %'
            group by ddh,rkdw,to_date(rq,'YY.MM.DD')
            
            
)

select 
      a.PERIOD,
      C.RKCZ,
      a.rkdw,
      sum(a.zl)/1000,
      sum(case when (b.isjbz='1' and d.ddqz is not null) then a.js else 0 end) as fine_packaging_cnt,
      sum(case when (b.isjbz='1' and d.ddqz is not null) then a.zl else 0 end)/1000 as fine_packaging_wgt_T
from order_clean A 
     left join all_to_one b on a.ddh=b.ddh 
     LEFT JOIN MDDIM.DIM_GROUP_TO_TYPE_TG C  ON C.BZDW=A.RKDW
     left join (
        select 
        ddqz
        from MDDIM.DIM_ORDER_TO_TEXTURE
        WHERE LX='bz'
     ) d  ON SUBSTR(A.DDH, 1, 3) = d.DDQZ
--where a.period >=date'2025-10-7' and a.rkdw='泰钢包装一线B1'
group by a.period,C.RKCZ,a.rkdw
