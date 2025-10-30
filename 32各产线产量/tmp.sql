

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
        ,a.CPLB
        , SFRKDW AS IS_RKDW
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
union all
select rq,rkdw,zl,null from  ods_mom.ods_product_warehouse_wh
)
,tmp_dwd_trans as(
       select 
              PERIOD,
              OUTWARE_ORG as zcdw,
              WEIGHT_KG as zl,
              TRANSFER_PCS as js
       from mddwd.DWD_TRANSFER_ALL
  union all
  select rq,zcdw,zl,js from ods_mom.ODS_BI_PRODUCT_SEMI_WH
    

)
,tmp_dwd_join as(
        select A.PERIOD
            ,a.scx as production_line
            ,A.ZZB
            ,A.CB
            ,A.DW
            ,A.JLDW
            ,A.CPLB
            ,A.IS_RKDW
            ,SUM(ZL)/1000 AS WEIGHT_T
            ,sum(js) as cnt
           ,SUM(SUM(ZL)/1000) OVER(PARTITION BY A.scx, A.ZZB, A.CB, A.DW, A.JLDW, A.CPLB, A.IS_RKDW 
                             ORDER BY A.PERIOD 
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS NETPRODUCTION_QTY_ACC
            ,SUM(SUM(js)) OVER(PARTITION BY A.scx, A.ZZB, A.CB, A.DW, A.JLDW, A.CPLB, A.IS_RKDW 
                        ORDER BY A.PERIOD 
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS NETPRODUCTION_WGT_ACC

        from tmp_dim A LEFT JOIN(
            select * from TMP_DWD_BZRKB
            union all
            select * from tmp_dwd_trans

        )B
  ON A.DW=B.RKDW AND A.PERIOD=B.PERIOD
  GROUP BY A.PERIOD,A.DW,A.ZZB,a.scx,A.CB,A.GX,A.JLDW,A.IS_RKDW,A.CPLB
  )  
  select a.period
         ,a.production_line
         ,a.zzb
         ,a.cb
		 ,a.cplb
         ,a.dw
         ,A.JLDW
         ,a.weight_t
         ,a.cnt
        ,A.IS_RKDW
        ,A.NETPRODUCTION_QTY_ACC
        ,a.NETPRODUCTION_WGT_ACC
        
         ,c.COUNT_LM_WPCS
         ,c.WEIGHT_LM_T
         ,c.COUNT_M_WPCS
         ,c.WEIGHT_M_T
   from tmp_dwd_join a
    left join (
        select 
            period,
            workshop,
            COUNT_LM_WPCS,
            WEIGHT_LM_T,
            COUNT_M_WPCS,
            WEIGHT_M_T
        from 
        ADS_FINISH_GOOD_STOCK
        where STOCK_TYPE='工序半成品'
    ) c
    on c.period=trunc(a.period,'MM') and  c.WORKSHOP=a.dw;
    
    
    
    
