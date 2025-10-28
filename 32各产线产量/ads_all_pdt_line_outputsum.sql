
CREATE TABLE ads_all_pdt_line_outputsum (
    period DATE,
    production_line VARCHAR2(2000),
    Manufacturing_Dept VARCHAR2(2000),
    factory VARCHAR2(2000),
    WORK_ORG_NAME VARCHAR2(2000),
    measurement_unit VARCHAR2(2000),
    daily_production_qty NUMBER,
    daily_production_wgt_kg NUMBER,
    daily_waste_qty NUMBER,
    daily_waste_wgt_kg NUMBER,
    inventory_shortage_d_qty NUMBER,
    inventory_shortage_d_wgt_kg NUMBER,
    inventory_surplus_d_qty NUMBER,
    inventory_surplus_d_wgt_kg NUMBER,
    daily_netproduction_qty NUMBER,
    daily_netproduction_wgt_kg NUMBER,
    netproduction_qty_acc NUMBER,
    netproduction_wgt_acc NUMBER,
    netproduction_qty_acc_last NUMBER,
    netproduction_wgt_acc_last NUMBER,
    inventoty_COUNT_LM_WPCS NUMBER,
    inventory_WEIGHT_LM_T NUMBER,
    inventory_COUNT_M_WPCS_ NUMBER,
    inventory_WEIGHT_M_T NUMBER,
    cls_balance_d_baseline_qty NUMBER,
    cls_balance_d_baseline_wgt NUMBER,
    production__d_baseline_qty NUMBER,
    production_d_baseline_wgt NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ads_all_pdt_line_outputsum IS '各产线产量汇总表';

COMMENT ON COLUMN ads_all_pdt_line_outputsum.period IS '日期';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.production_line IS '生产线';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.Manufacturing_Dept IS '制造部';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.factory IS '厂别';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.WORK_ORG_NAME IS '车间单位';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.measurement_unit IS '计量单位';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.daily_production_qty IS '日产数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.daily_production_wgt_kg IS '日产重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.daily_waste_qty IS '日产废料数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.daily_waste_wgt_kg IS '日产废料重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_shortage_d_qty IS '盘亏数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_shortage_d_wgt_kg IS '盘亏重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_surplus_d_qty IS '盘盈数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_surplus_d_wgt_kg IS '盘盈重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.daily_netproduction_qty IS '日净产数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.daily_netproduction_wgt_kg IS '日净产重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.netproduction_qty_acc IS '累计净产重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.netproduction_wgt_acc IS '累计净产数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.netproduction_qty_acc_last IS '上月当日累计净产重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.netproduction_wgt_acc_last IS '上月当日累计净产数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventoty_COUNT_LM_WPCS IS '库存期初件数（万）';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_WEIGHT_LM_T IS '库存期初重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_COUNT_M_WPCS_ IS '库存当前数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.inventory_WEIGHT_M_T IS '库存当前重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.cls_balance_d_baseline_qty IS '日结存基准数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.cls_balance_d_baseline_wgt IS '日结存基准重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.production__d_baseline_qty IS '日产量基准数量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.production_d_baseline_wgt IS '日产量基准重量';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.etl_crt_dt IS 'ETL创建日期';
COMMENT ON COLUMN ads_all_pdt_line_outputsum.etl_upd_dt IS 'ETL更新日期';














--------------------------------------


INSERT INTO ads_all_pdt_line_outputsum(
       PERIOD
       ,PRODUCTION_LINE
       ,MANUFACTURING_DEPT
       ,FACTORY
       ,WORK_ORG_NAME
       ,MEASUREMENT_UNIT
       ,DAILY_PRODUCTION_WGT_KG
       ,DAILY_PRODUCTION_QTY
       
       ,INVENTOTY_COUNT_LM_WPCS
       ,INVENTORY_WEIGHT_LM_T
       ,INVENTORY_COUNT_M_WPCS_
       ,INVENTORY_WEIGHT_M_T
      
)
WITH TMP_Dim AS
(
SELECT 
       B.PERIOD_DATE AS PERIOD
       ,trunc(b.period_date,'MM') AS PERIOD_M
       ,A.ZZB
       ,A.CB
       ,A.GX
       ,A.DW
       ,A.BS
       ,A.FR
       ,A.JLDW
       ,A.SFJSCL
       ,A.SFRKDW
       ,A.RCLJZ
       ,A.RJCJZ 
       FROM ods_erp.ODS_CBZZBB2 A
       CROSS JOIN MDDIM.dim_day_d B 
       WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate
       and sfjscl is not null
)
,tmp_dwd_bzrkb as(
SELECT   TO_DATE(rq,'YY.MM.DD') AS PERIOD
        ,rkdw
        ,zl
        ,js
 FROM ods_jnmd.bzrkb
)
,tmp_dwd_join as(
select A.PERIOD
       ,a.zzb as production_line
       ,A.ZZB
       ,A.CB
       ,A.DW
       ,A.JLDW
       ,SUM(ZL)/1000 AS WEIGHT_T
       ,sum(js) as cnt
       
from tmp_dim A LEFT JOIN 
     TMP_DWD_BZRKB  B
  ON A.DW=B.RKDW AND A.PERIOD=B.PERIOD 
  GROUP BY A.PERIOD,A.DW,A.ZZB,A.CB,A.GX,A.JLDW
  )
  select a.period
         ,a.scx
         ,a.zzb
         ,a.cb
         ,a.dw
         ,A.JLDW
         ,a.weight_t
         ,a.cnt
         ,c.COUNT_LM_WPCS
         ,c.WEIGHT_LM_T
         ,c.COUNT_M_WPCS
         ,c.WEIGHT_M_T
   from tmp_dwd_join a 
    left join ADS_FINISH_GOOD_STOCK c
  on c.period=trunc(a.period,'MM') and a.production_line=c.PRODUCT_LINE and a.cb=c.FACTORY_NAME and c.WORKSHOP=a.dw





----------------------------------20251017添加转产
DWD_MAIN_TRANSFER_SUMMARY

  

INSERT INTO ads_all_pdt_line_outputsum(
       PERIOD
       ,PRODUCTION_LINE
       ,MANUFACTURING_DEPT
       ,FACTORY
       ,WORK_ORG_NAME
       ,MEASUREMENT_UNIT
       ,DAILY_PRODUCTION_WGT_KG
       ,DAILY_PRODUCTION_QTY
       ,DAILY_WASTE_WGT_KG
       ,DAILY_WASTE_QTY

       ,INVENTOTY_COUNT_LM_WPCS
       ,INVENTORY_WEIGHT_LM_T
       ,INVENTORY_COUNT_M_WPCS_
       ,INVENTORY_WEIGHT_M_T

)
WITH TMP_Dim AS
(
SELECT
       B.PERIOD_DATE AS PERIOD
       ,trunc(b.period_date,'MM') AS PERIOD_M
       ,a.scx
       ,A.ZZB
       ,A.CB
       ,A.GX
       ,A.DW
       ,A.BS
       ,A.FR
       ,A.JLDW
       ,A.SFJSCL
       ,A.SFRKDW
       ,A.RCLJZ
       ,A.RJCJZ
       FROM ods_erp.ODS_CBZZBB2 A
       CROSS JOIN MDDIM.dim_day_d B
       WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate
       and sfjscl is not null
)
,tmp_dwd_bzrkb as(
SELECT   TO_DATE(rq,'YY.MM.DD') AS PERIOD
        ,rkdw
        ,zl
        ,js
 FROM ods_jnmd.bzrkb
)
,tmp_dwd_trans as(
       select 
              PERIOD,
              WORK_ORG_NAME as rkdw,
              WEIGHT as zl,
              PIECE_COUNT as js
       from mddwd.DWD_MAIN_TRANSFER_SUMMARY
    

)
,tmp_dwd_join as(
        select A.PERIOD
            ,a.scx as production_line
            ,A.ZZB
            ,A.CB
            ,A.DW
            ,A.JLDW
            ,SUM(ZL)/1000 AS WEIGHT_T
            ,sum(js) as cnt

        from tmp_dim A LEFT JOIN(
            select * from TMP_DWD_BZRKB
            union all
            select * from tmp_dwd_trans

        )B
  ON A.DW=B.RKDW AND A.PERIOD=B.PERIOD
  GROUP BY A.PERIOD,A.DW,A.ZZB,a.scx,A.CB,A.GX,A.JLDW
  ),
  tmp_fp as(
    select to_date(rq,'YY.MM.DD') as period,
            zfkdw as dw,
            sum(zl)/1000 as fp_weight,
            sum(js)/1000 as fp_cnt
    from ods_erp.ods_fpsjb_ckyw_all


  )
  select a.period
         ,a.production_line
         ,a.zzb
         ,a.cb
         ,a.dw
         ,A.JLDW
         ,a.weight_t
         ,a.cnt

         ,d.fp_weigth
         ,d.fp_cnt
         ,c.COUNT_LM_WPCS
         ,c.WEIGHT_LM_T
         ,c.COUNT_M_WPCS
         ,c.WEIGHT_M_T
   from tmp_dwd_join a
    left join ADS_FINISH_GOOD_STOCK c
    on c.period=trunc(a.period,'MM') and a.production_line=c.PRODUCT_LINE and a.cb=c.FACTORY_NAME and c.WORKSHOP=a.dw;
    left join tmp_fp d
    on d. period=a.period and a.dw=d.dw




---------------------------------------------------20251023



  

INSERT INTO ads_all_pdt_line_outputsum(
       PERIOD
       ,PRODUCTION_LINE
       ,MANUFACTURING_DEPT
       ,FACTORY
       ,WORK_ORG_NAME
       ,MEASUREMENT_UNIT
       ,DAILY_PRODUCTION_WGT_KG
       ,DAILY_PRODUCTION_QTY
       ,DAILY_WASTE_WGT_KG
       ,DAILY_WASTE_QTY

       ,INVENTOTY_COUNT_LM_WPCS
       ,INVENTORY_WEIGHT_LM_T
       ,INVENTORY_COUNT_M_WPCS_
       ,INVENTORY_WEIGHT_M_T

)
WITH TMP_Dim AS
(
SELECT
       B.PERIOD_DATE AS PERIOD
       ,trunc(b.period_date,'MM') AS PERIOD_M
       ,a.scx
       ,A.ZZB
       ,A.CB
       ,A.GX
       ,A.DW
       ,A.BS
       ,A.FR
       ,A.JLDW
       ,A.SFJSCL
       ,A.SFRKDW
       ,A.RCLJZ
       ,A.RJCJZ
       FROM ods_erp.ODS_CBZZBB2 A
       CROSS JOIN MDDIM.dim_day_d B
       WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate
       and sfjscl is not null
)
,tmp_dwd_bzrkb as(
SELECT   PERIOD
        ,INWARE_ORG as rkdw
        ,WEIGHT as zl
        ,PCS as js
 FROM MDDWD.DWD_PACK_INWARE
)
,tmp_dwd_trans as(
       select 
              PERIOD,
              WORK_ORG_NAME as rkdw,
              WEIGHT as zl,
              PIECE_COUNT as js
       from mddwd.DWD_MAIN_TRANSFER_SUMMARY
    

)
,tmp_dwd_join as(
        select A.PERIOD
            ,a.scx as production_line
            ,A.ZZB
            ,A.CB
            ,A.DW
            ,A.JLDW
            ,SUM(ZL)/1000 AS WEIGHT_T
            ,sum(js) as cnt

        from tmp_dim A LEFT JOIN(
            select * from TMP_DWD_BZRKB
            union all
            select * from tmp_dwd_trans

        )B
  ON A.DW=B.RKDW AND A.PERIOD=B.PERIOD
  GROUP BY A.PERIOD,A.DW,A.ZZB,a.scx,A.CB,A.GX,A.JLDW
  ),
  tmp_fp as(
    select to_date(rq,'YY.MM.DD') as period,
            zfkdw as dw,
            sum(zl)/1000 as fp_weight,
            sum(js)/1000 as fp_cnt
    from ods_erp.ods_fpsjb_ckyw_all


  )
  select a.period
         ,a.production_line
         ,a.zzb
         ,a.cb
         ,a.dw
         ,A.JLDW
         ,a.weight_t
         ,a.cnt

         ,d.fp_weigth
         ,d.fp_cnt
         ,c.COUNT_LM_WPCS
         ,c.WEIGHT_LM_T
         ,c.COUNT_M_WPCS
         ,c.WEIGHT_M_T
   from tmp_dwd_join a
    left join ADS_FINISH_GOOD_STOCK c
    on c.period=trunc(a.period,'MM') and a.production_line=c.PRODUCT_LINE and a.cb=c.FACTORY_NAME and c.WORKSHOP=a.dw;
    left join tmp_fp d
    on d. period=a.period and a.dw=d.dw



    ----------------------------------------------------------20251025

INSERT INTO ads_all_pdt_line_outputsum(
       PERIOD
       ,PRODUCTION_LINE
       ,MANUFACTURING_DEPT
       ,FACTORY
       ,WORK_ORG_NAME
       ,MEASUREMENT_UNIT
       ,DAILY_PRODUCTION_WGT_KG
       ,DAILY_PRODUCTION_QTY


       ,INVENTOTY_COUNT_LM_WPCS
       ,INVENTORY_WEIGHT_LM_T
       ,INVENTORY_COUNT_M_WPCS_
       ,INVENTORY_WEIGHT_M_T

)
WITH TMP_Dim AS
(
SELECT
       B.PERIOD_DATE AS PERIOD
       ,trunc(b.period_date,'MM') AS PERIOD_M
       ,a.scx
       ,A.ZZB
       ,A.CB
       ,A.GX
       ,A.DW
       ,A.BS
       ,A.FR
       ,A.JLDW
       ,A.SFJSCL
       ,A.SFRKDW
       ,A.RCLJZ
       ,A.RJCJZ
       FROM ods_erp.ODS_CBZZBB2 A
       CROSS JOIN MDDIM.dim_day_d B
       WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1
       and sfjscl is not null
)
,tmp_dwd_bzrkb as(
SELECT   PERIOD
        ,INWARE_ORG as rkdw
        ,WEIGHT as zl
        ,PCS as js
 FROM MDDWD.DWD_PACK_INWARE
)
,tmp_dwd_trans as(
       select 
              PERIOD,
              OUTWARE_ORG as zcdw,
              WEIGHT_KG as zl,
              TRANSFER_PCS as js
       from mddwd.DWD_TRANSFER_ALL
    

)
,tmp_dwd_join as(
        select A.PERIOD
            ,a.scx as production_line
            ,A.ZZB
            ,A.CB
            ,A.DW
            ,A.JLDW
            ,SUM(ZL)/1000 AS WEIGHT_T
            ,sum(js) as cnt

        from tmp_dim A LEFT JOIN(
            select * from TMP_DWD_BZRKB
            union all
            select * from tmp_dwd_trans

        )B
  ON A.DW=B.RKDW AND A.PERIOD=B.PERIOD
  GROUP BY A.PERIOD,A.DW,A.ZZB,a.scx,A.CB,A.GX,A.JLDW
  )
  select a.period
         ,a.production_line
         ,a.zzb
         ,a.cb
         ,a.dw
         ,A.JLDW
         ,a.weight_t
         ,a.cnt

        
         ,c.COUNT_LM_WPCS
         ,c.WEIGHT_LM_T
         ,c.COUNT_M_WPCS
         ,c.WEIGHT_M_T
   from tmp_dwd_join a
    left join ADS_FINISH_GOOD_STOCK c
    on c.period=trunc(a.period,'MM') and  c.WORKSHOP=a.dw;
