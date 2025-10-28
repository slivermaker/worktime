CREATE TABLE ADS_MKFM_PRODUTION_SUM (
    PERIOD DATE,
    WORK_ORG_NAME VARCHAR2(2000),
    NOW_INVENTORY_LAST NUMBER,
    NON_PLANNED_INVENTORY_LAST NUMBER,
    NOW_INVENTORY NUMBER,
    NON_PLANNED_INVENTORY NUMBER,
    SELF_PRODUCED_PIECE_COUNT NUMBER,
    SELF_PRODUCED_WEIGHT_T NUMBER,
    PURCHASED_PIECE_COUNT NUMBER,
    PURCHASED_WEIGHT_T NUMBER,
    SELF_PRODUCED_PIECE_M NUMBER,
    SELF_PRODUCED_M_T NUMBER,
    PURCHASED_PIECE_M NUMBER,
    PURCHASED_M_T NUMBER,
    ETL_CRT_DT DATE DEFAULT SYSDATE,
    ETL_UPD_DT DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ADS_MKFM_PRODUTION_SUM IS 'MKFM生产汇总表';

COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.PERIOD IS '日期';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.WORK_ORG_NAME IS '工作组';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.NOW_INVENTORY_LAST IS '上月今结存';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.NON_PLANNED_INVENTORY_LAST IS '上月计外存';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.NOW_INVENTORY IS '今结存';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.NON_PLANNED_INVENTORY IS '计外存';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.SELF_PRODUCED_PIECE_COUNT IS '日自产件数';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.SELF_PRODUCED_WEIGHT_T IS '日自产重量（吨）';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.PURCHASED_PIECE_COUNT IS '日外购件数';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.PURCHASED_WEIGHT_T IS '日外购重量（吨）';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.SELF_PRODUCED_PIECE_M IS '自产件数汇总';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.SELF_PRODUCED_M_T IS '月自产重量汇总（吨）';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.PURCHASED_PIECE_M IS '月外购件数汇总';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.PURCHASED_M_T IS '月外购重量汇总（吨）';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN ADS_MKFM_PRODUTION_SUM.ETL_UPD_DT IS 'ETL更新日期';


--------------------------------------------------------------



INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)
SELECT
    COALESCE(A.PERIOD, B.PERIOD_M) AS PERIOD,
    COALESCE(A.WORK_ORG_NAME, B.RKDW) AS WORK_ORG_NAME,
    A.NOW_INVENTORY_LAST,
    A.NON_PLANNED_INVENTORY_LAST,
    A.NOW_INVENTORY,
    A.NON_PLANNED_INVENTORY,
    B.SELF_PRODUCED_PIECE_COUNT,
    B.SELF_PRODUCED_WEIGHT_T,
    B.PURCHASED_PIECE_COUNT,
    B.PURCHASED_WEIGHT_T,
    B.SELF_PRODUCED_PIECE_M,
    B.SELF_PRODUCED_M_T,
    B.PURCHASED_PIECE_M,
    B.PURCHASED_M_T,
    SYSDATE,
    SYSDATE
FROM
    MDDWS.DWS_MKFM_SEMIFINISH_INVENTORY A
FULL JOIN MDDWS.DWS_MKFM_PRODUCTION_MONTHLY B
    ON A.PERIOD = B.PERIOD_M
    AND A.WORK_ORG_NAME = B.RKDW;

    -------------------------------------------------------------------------------



INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,NOW_INVENTORY
       ,NOW_INVENTORY_LAST
       
)

WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT TRUNC(A.PERIOD,'MM') AS PERIOD 
         ,CASE WHEN A.WORK_ORG_NAME NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE WHEN B.CB ='孝直分厂' THEN '孝直分厂'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM MDDWD.DWD_MAIN_TRANSFER_SUMMARY A 
  LEFT JOIN TMP_CB B
  ON A.WORK_ORG_NAME=B.DW 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   WHERE WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME

SELECT * FROM ADS_FINISH_GOOD_STOCK
SELECT * FROM ODS_JNMD.BZRKB



--------------------------------------20251016


SELECT
    COALESCE(a.period, E.period_m) AS period,
    COALESCE(a.work_org_name, E.rkdw) AS work_org_name,
    a.now_inventory_last,
    a.non_planned_inventory_last,
    a.now_inventory,
    a.non_planned_inventory,
    E.self_produced_piece_count,
    E.self_produced_weight_t,
    E.purchased_piece_count,
    E.purchased_weight_t,
    E.self_produced_piece_m,
    E.self_produced_m_t,
   E.purchased_piece_m,
    E.purchased_m_t,
	SYSDATE,
	SYSDATE

FROM
    mddws.dws_mkfm_semifinish_inventory a
LEFT JOIN(
    SELECT
        B.PERIOD_M,
        B.RKDW,
        SUM(b.self_produced_piece_count)AS self_produced_piece_count,
        SUM(b.self_produced_weight_t) AS self_produced_weight_t,
        SUM(b.purchased_piece_count) AS purchased_piece_count,
        SUM(b.purchased_weight_t) AS purchased_weight_t,
        SUM(b.self_produced_piece_m) AS self_produced_piece_m,
        SUM(b.self_produced_m_t) AS self_produced_m_t,
        SUM(b.purchased_piece_m) AS purchased_piece_m,
        SUM(b.purchased_m_t) AS purchased_m_t
    FROM mddws.dws_mkfm_production_monthly b 
    GROUP BY B.PERIOD_M,
           B.RKDW
    UNION ALL
    SELECT 
          TRUNC(PERIOD,'MM') AS PERIOD_M,
          WORK_ORG_NAME AS RKDW,
          NULL,
          SUM(CASE WHEN D.UT!='SETW' THEN WEIGHT ELSE 0 END) AS self_produced_weight_t,
          NULL,
          SUM(CASE WHEN D.UT='SETW' THEN WEIGHT ELSE 0 END) AS purchased_weight_t,
          NULL,
          NULL,
          NULL,
          NULL
          
     FROM 
          MDDWD.DWD_Main_TRANSFER_SUMMARY C
     LEFT JOIN ODS_ERP.ODS_INVITEM D 
     ON C.PRODUCT_CODE=D.XCLBM
     GROUP BY TRUNC(PERIOD,'MM'),WORK_ORG_NAME
    
) E
    ON a.period = E.period_m
    AND a.work_org_name = E.rkdw;
    



    -------------------------------------
    
INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PROCESS_TYPE,
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)


SELECT
     f.gx,
    COALESCE(a.period, E.period_m) AS period,
    COALESCE(a.work_org_name, E.rkdw) AS work_org_name,
    a.now_inventory_last,
    a.non_planned_inventory_last,
    a.now_inventory,
    a.non_planned_inventory,
    E.self_produced_piece_count,
    E.self_produced_weight_t,
    E.purchased_piece_count,
    E.purchased_weight_t,
    E.self_produced_piece_m,
    E.self_produced_m_t,
   E.purchased_piece_m,
    E.purchased_m_t,
	SYSDATE,
	SYSDATE

FROM
    mddws.dws_mkfm_semifinish_inventory a
LEFT JOIN(
    SELECT

        B.PERIOD_M,
        B.RKDW,
        SUM(b.self_produced_piece_count)AS self_produced_piece_count,
        SUM(b.self_produced_weight_t) AS self_produced_weight_t,
        SUM(b.purchased_piece_count) AS purchased_piece_count,
        SUM(b.purchased_weight_t) AS purchased_weight_t,
        SUM(b.self_produced_piece_m) AS self_produced_piece_m,
        SUM(b.self_produced_m_t) AS self_produced_m_t,
        SUM(b.purchased_piece_m) AS purchased_piece_m,
        SUM(b.purchased_m_t) AS purchased_m_t
    FROM mddws.dws_mkfm_production_monthly b 
    GROUP BY B.PERIOD_M,
           B.RKDW
    UNION ALL
    SELECT 
          TRUNC(PERIOD,'MM') AS PERIOD_M,
          WORK_ORG_NAME AS RKDW,
          NULL,
          SUM(CASE WHEN D.UT!='SETW' THEN WEIGHT ELSE 0 END) AS self_produced_weight_t,
          NULL,
          SUM(CASE WHEN D.UT='SETW' THEN WEIGHT ELSE 0 END) AS purchased_weight_t,
          NULL,
          NULL,
          NULL,
          NULL
          
     FROM 
          MDDWD.DWD_Main_TRANSFER_SUMMARY C
     LEFT JOIN ODS_ERP.ODS_INVITEM D 
     ON C.PRODUCT_CODE=D.XCLBM
     GROUP BY TRUNC(PERIOD,'MM'),WORK_ORG_NAME
    
) E
    ON a.period = E.period_m
    AND a.work_org_name = E.rkdw
    
left join (
     select gx,dw from ods_erp.ods_cbzzbb2 where sfjscl=1 and zzb='迈克阀门'

) f on f.dw=a.WORK_ORG_NAME


-------------------------------------------------------------20251017


INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PROCESS_TYPE,
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)
select f.gx,
       coalesce(
          e.period,
          a.period
       ) as period,
       coalesce(
          a.work_org_name,
          e.rkdw
       ) as work_org_name,
       a.now_inventory_last,
       a.non_planned_inventory_last,
       a.now_inventory,
       a.non_planned_inventory,
       e.self_produced_piece_count,
       e.self_produced_weight_t,
       e.purchased_piece_count,
       e.purchased_weight_t,
       e.self_produced_piece_m,
       e.self_produced_m_t,
       e.purchased_piece_m,
       e.purchased_m_t,
       sysdate,
       sysdate
  from mddws.dws_mkfm_semifinish_inventory a
  left join (
   select b.period,
          b.rkdw,
          sum(b.self_produced_piece_count) as self_produced_piece_count,
          sum(b.self_produced_weight_t) as self_produced_weight_t,
          sum(b.purchased_piece_count) as purchased_piece_count,
          sum(b.purchased_weight_t) as purchased_weight_t,
          sum(b.self_produced_piece_m) as self_produced_piece_m,
          sum(b.self_produced_m_t) as self_produced_m_t,
          sum(b.purchased_piece_m) as purchased_piece_m,
          sum(b.purchased_m_t) as purchased_m_t
     from mddws.dws_mkfm_production_monthly b
     left join (
      select gx,
             dw,
             scx
        from ods_erp.ods_cbzzbb2
       where nvl(
            scx,
            zzb
         ) = '迈克阀门'
         and gx in ( '包装工序' )--,'半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件'
   ) bb
   on b.rkdw = bb.dw
    where bb.gx is not null
    group by b.period,
             b.rkdw
   union all
   select 
          --TRUNC(PERIOD,'MM') AS PERIOD_M,
    period,
          work_org_name as rkdw,
          null,
          sum(weight) / 1000 as self_produced_weight_t,
          null,
          null,
          null,
          sum(sum(weight))
          over(partition by trunc(
             period,
             'MM'
          ),
              work_org_name
               order by period
             rows between unbounded preceding and current row
          ) / 1000 as self_produced_m_t,
          null,
          null
     from mddwd.dwd_main_transfer_summary c
     left join (
      select gx,
             dw,
             scx
        from ods_erp.ods_cbzzbb2
       where nvl(
            scx,
            zzb
         ) = '迈克阀门'
         and gx in ( '半加工工序',
                     '半成品库工序',
                     '加工工序',
                     '包胶工序',
                     '表面处理工序',
                     '配件' )--,包装工序
   ) cc
   on c.work_org_name = cc.dw
    where cc.gx is not null
    group by trunc(
      period,
      'MM'
   ),
             period,
             work_org_name
) e
on a.period = trunc(
      e.period,
      'MM'
   )
   and a.work_org_name = e.rkdw
  left join (
   select gx,
          dw,
          scx
     from ods_erp.ods_cbzzbb2
    where nvl(
         scx,
         zzb
      ) = '迈克阀门'
      and gx in ( '包装工序',
                  '半加工工序',
                  '半成品库工序',
                  '加工工序',
                  '包胶工序',
                  '表面处理工序',
                  '配件' )
) f
on f.dw = a.work_org_name;

INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,NOW_INVENTORY
       ,NOW_INVENTORY_LAST
       
)

WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT TRUNC(A.PERIOD,'MM') AS PERIOD 
         ,CASE WHEN A.WORK_ORG_NAME NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE WHEN B.CB ='孝直分厂' THEN '孝直分厂'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM MDDWD.DWD_MAIN_TRANSFER_SUMMARY A 
  LEFT JOIN TMP_CB B
  ON A.WORK_ORG_NAME=B.DW 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   WHERE WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME




-----------------------------------------------


INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PROCESS_TYPE,
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)



WITH TMP_Dim AS
(
SELECT
       B.PERIOD_DATE AS PERIOD
       ,A.GX
       ,A.DW
       FROM ods_erp.ODS_CBZZBB2 A
       CROSS JOIN MDDIM.dim_day_d B
       WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1  
       and nvl(
         scx,
         zzb
      ) = '迈克阀门'
      and gx in ( '包装工序',
                  '半加工工序',
                  '半成品库工序',
                  '加工工序',
                  '包胶工序',
                  '表面处理工序',
                  '配件' )
       and sfjscl is not null
)



select dim.gx,
       dim.period,
       dim.dw,
       a.now_inventory_last,
       a.non_planned_inventory_last,
       a.now_inventory,
       a.non_planned_inventory,
       e.self_produced_piece_count,
       e.self_produced_weight_t,
       e.purchased_piece_count,
       e.purchased_weight_t,
       e.self_produced_piece_m,
       e.self_produced_m_t,
       e.purchased_piece_m,
       e.purchased_m_t,
       sysdate,
       sysdate
  from TMP_Dim dim left join 
    mddws.dws_mkfm_semifinish_inventory a
    on dim.period=a.period and a.work_org_name=dim.dw
  left join (
   select b.period,
          b.rkdw,
          sum(b.self_produced_piece_count) as self_produced_piece_count,
          sum(b.self_produced_weight_t) as self_produced_weight_t,
          sum(b.purchased_piece_count) as purchased_piece_count,
          sum(b.purchased_weight_t) as purchased_weight_t,
          sum(b.self_produced_piece_m) as self_produced_piece_m,
          sum(b.self_produced_m_t) as self_produced_m_t,
          sum(b.purchased_piece_m) as purchased_piece_m,
          sum(b.purchased_m_t) as purchased_m_t
     from mddws.dws_mkfm_production_monthly b
     left join (
      select gx,
             dw,
             scx
        from ods_erp.ods_cbzzbb2
       where nvl(
            scx,
            zzb
         ) = '迈克阀门'
         and gx in ( '包装工序' )--,'半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件'
   ) bb
   on b.rkdw = bb.dw
    where bb.gx is not null
    group by b.period,
             b.rkdw
   union all
   select 
          period,
          work_org_name as rkdw,
          null,
          sum(weight) / 1000 as self_produced_weight_t,
          null,
          null,
          null,
          sum(sum(weight))
          over(partition by trunc(
             period,
             'MM'
          ),
              work_org_name
               order by period
             rows between unbounded preceding and current row
          ) / 1000 as self_produced_m_t,
          null,
          null
     from mddwd.dwd_main_transfer_summary c
     left join (
      select gx,
             dw,
             scx
        from ods_erp.ods_cbzzbb2
       where nvl(
            scx,
            zzb
         ) = '迈克阀门'
         and gx in ( '半加工工序',
                     '半成品库工序',
                     '加工工序',
                     '包胶工序',
                     '表面处理工序',
                     '配件' )--,包装工序
   ) cc
   on c.work_org_name = cc.dw
    where cc.gx is not null
    group by trunc(period,'MM'),
             period,
             work_org_name
) e
on dim.period = e.period

   and dim.dw = e.rkdw;



INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,NOW_INVENTORY
       ,NOW_INVENTORY_LAST
       
)


WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT a.PERIOD 
         ,CASE WHEN A.WORK_ORG_NAME NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE WHEN B.CB ='孝直分厂' THEN '孝直分厂'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM MDDWD.DWD_MAIN_TRANSFER_SUMMARY A 
  LEFT JOIN TMP_CB B
  ON A.WORK_ORG_NAME=B.DW 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')
    union all
    
    SELECT period,
    '孝直分厂',
    WEIGHT,
    PIECE_COUNT
    FROM mddwd.DWD_MAIN_TRANSFER_SUMMARY where WORK_ORG_NAME='半成品加工七组'

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   WHERE WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME




-------------------------------------------------------diqi

WITH TMP_Dim AS
(
    SELECT
        B.PERIOD_DATE AS PERIOD
        ,A.GX
        ,A.DW
        FROM ods_erp.ODS_CBZZBB2 A
        CROSS JOIN MDDIM.dim_day_d B
        WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1  
        and nvl(
            scx,
            zzb
        ) = '迈克阀门'
        and gx in ( '包装工序',
                    '半加工工序',
                    '半成品库工序',
                    '加工工序',
                    '包胶工序',
                    '表面处理工序',
                    '配件' )
        and sfjscl is not null
    ),
    main as(
    select f.gx,
        coalesce(
            e.period,
            a.period
        ) as period,
        coalesce(
            a.work_org_name,
            e.rkdw
        ) as work_org_name,
        a.now_inventory_last,
        a.non_planned_inventory_last,
        a.now_inventory,
        a.non_planned_inventory,
        e.self_produced_piece_count,
        e.self_produced_weight_t,
        e.purchased_piece_count,
        e.purchased_weight_t,
        e.self_produced_piece_m,
        e.self_produced_m_t,
        e.purchased_piece_m,
        e.purchased_m_t

    from mddws.dws_mkfm_semifinish_inventory a
    left join (
    select b.period,
            b.rkdw,
            sum(b.self_produced_piece_count) as self_produced_piece_count,
            sum(b.self_produced_weight_t) as self_produced_weight_t,
            sum(b.purchased_piece_count) as purchased_piece_count,
            sum(b.purchased_weight_t) as purchased_weight_t,
            sum(b.self_produced_piece_m) as self_produced_piece_m,
            sum(b.self_produced_m_t) as self_produced_m_t,
            sum(b.purchased_piece_m) as purchased_piece_m,
            sum(b.purchased_m_t) as purchased_m_t
        from mddws.dws_mkfm_production_monthly b
        left join (
        select gx,
                dw,
                scx
            from ods_erp.ods_cbzzbb2
        where nvl(
                scx,
                zzb
            ) = '迈克阀门'
            and gx in ( '包装工序' )--,'半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件'
    ) bb
    on b.rkdw = bb.dw
        where bb.gx is not null
        group by b.period,
                b.rkdw
    union all
    select 
            --TRUNC(PERIOD,'MM') AS PERIOD_M,
        period,
            work_org_name as rkdw,
            null,
            sum(weight) / 1000 as self_produced_weight_t,
            null,
            null,
            null,
            sum(sum(weight))
            over(partition by trunc(
                period,
                'MM'
            ),
                work_org_name
                order by period
                rows between unbounded preceding and current row
            ) / 1000 as self_produced_m_t,
            null,
            null
        from mddwd.dwd_main_transfer_summary c
        left join (
        select gx,
                dw,
                scx
            from ods_erp.ods_cbzzbb2
        where nvl(
                scx,
                zzb
            ) = '迈克阀门'
            and gx in ( '半加工工序',
                        '半成品库工序',
                        '加工工序',
                        '包胶工序',
                        '表面处理工序',
                        '配件' )--,包装工序
    ) cc
    on c.work_org_name = cc.dw
        where cc.gx is not null
        group by trunc(
        period,
        'MM'
    ),
                period,
                work_org_name
    ) e
    on a.period = trunc(
        e.period,
        'MM'
    )
    and a.work_org_name = e.rkdw
    left join (
    select gx,
            dw,
            scx
        from ods_erp.ods_cbzzbb2
        where nvl(
            scx,
            zzb
        ) = '迈克阀门'
        and gx in ( '包装工序',
                    '半加工工序',
                    '半成品库工序',
                    '加工工序',
                    '包胶工序',
                    '表面处理工序',
                    '配件' )
    ) f
    on f.dw = a.work_org_name
    
)

select dim.period
        ,dim.gx
        ,dim.dw,
        main.now_inventory_last,
        main.non_planned_inventory_last,
        main.now_inventory,
        main.non_planned_inventory,
        main.self_produced_piece_count,
        main.self_produced_weight_t,
        main.purchased_piece_count,
        main.purchased_weight_t,
        main.self_produced_piece_m,
        main.self_produced_m_t,
        main.purchased_piece_m,
        main.purchased_m_t,
        sysdate,
        sysdate
     from TMP_Dim dim left join main on dim.period=main.period and dim.dw=main.work_org_name;



INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,NOW_INVENTORY
       ,NOW_INVENTORY_LAST
       
)


WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT a.PERIOD 
         ,CASE WHEN A.WORK_ORG_NAME NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE WHEN B.CB ='孝直分厂' THEN '孝直分厂'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM MDDWD.DWD_MAIN_TRANSFER_SUMMARY A 
  LEFT JOIN TMP_CB B
  ON A.WORK_ORG_NAME=B.DW 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')
    union all
    
    SELECT period,
    '孝直分厂',
    WEIGHT,
    PIECE_COUNT
    FROM mddwd.DWD_MAIN_TRANSFER_SUMMARY where WORK_ORG_NAME='半成品加工七组'

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   WHERE WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME














TRUNCATE TABLE ADS_MKFM_PRODUTION_SUM;




INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PROCESS_TYPE,
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)


WITH TMP_Dim AS
(
    SELECT
        B.PERIOD_DATE AS PERIOD
        ,A.GX
        ,A.DW
        FROM ods_erp.ODS_CBZZBB2 A
        CROSS JOIN MDDIM.dim_day_d B
        WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1  
        and nvl(
            scx,
            zzb
        ) = '迈克阀门'
        and gx in ( '包装工序',
                    '半加工工序',
                    '半成品库工序',
                    '加工工序',
                    '包胶工序',
                    '表面处理工序',
                    '配件' )
        and sfjscl is not null
    ),
    main as(
    select f.gx,
        coalesce(
            e.period,
            a.period
        ) as period,
        coalesce(
            a.work_org_name,
            e.rkdw
        ) as work_org_name,
        a.now_inventory_last,
        a.non_planned_inventory_last,
        a.now_inventory,
        a.non_planned_inventory,
        e.self_produced_piece_count,
        e.self_produced_weight_t,
        e.purchased_piece_count,
        e.purchased_weight_t,
        e.self_produced_piece_m,
        e.self_produced_m_t,
        e.purchased_piece_m,
        e.purchased_m_t

    from mddws.dws_mkfm_semifinish_inventory a
    left join (
    select b.period,
            b.rkdw,
            sum(b.self_produced_piece_count) as self_produced_piece_count,
            sum(b.self_produced_weight_t) as self_produced_weight_t,
            sum(b.purchased_piece_count) as purchased_piece_count,
            sum(b.purchased_weight_t) as purchased_weight_t,
            sum(b.self_produced_piece_m) as self_produced_piece_m,
            sum(b.self_produced_m_t) as self_produced_m_t,
            sum(b.purchased_piece_m) as purchased_piece_m,
            sum(b.purchased_m_t) as purchased_m_t
        from mddws.dws_mkfm_production_monthly b
        left join (
        select gx,
                dw,
                scx
            from ods_erp.ods_cbzzbb2
        where nvl(
                scx,
                zzb
            ) = '迈克阀门'
            and gx in ( '包装工序' )--,'半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件'
    ) bb
    on b.rkdw = bb.dw
        where bb.gx is not null
        group by b.period,
                b.rkdw
    union all
    select 
            --TRUNC(PERIOD,'MM') AS PERIOD_M,
        period,
            work_org_name as rkdw,
            null,
            sum(weight) / 1000 as self_produced_weight_t,
            null,
            null,
            null,
            sum(sum(weight))
            over(partition by trunc(
                period,
                'MM'
            ),
                work_org_name
                order by period
                rows between unbounded preceding and current row
            ) / 1000 as self_produced_m_t,
            null,
            null
        from mddwd.dwd_main_transfer_summary c
        left join (
        select gx,
                dw,
                scx
            from ods_erp.ods_cbzzbb2
        where nvl(
                scx,
                zzb
            ) = '迈克阀门'
            and gx in ( '半加工工序',
                        '半成品库工序',
                        '加工工序',
                        '包胶工序',
                        '表面处理工序',
                        '配件' )--,包装工序
    ) cc
    on c.work_org_name = cc.dw
        where cc.gx is not null
        group by trunc(
        period,
        'MM'
    ),
                period,
                work_org_name
    ) e
    on a.period = trunc(
        e.period,
        'MM'
    )
    and a.work_org_name = e.rkdw
    left join (
    select gx,
            dw,
            scx
        from ods_erp.ods_cbzzbb2
        where nvl(
            scx,
            zzb
        ) = '迈克阀门'
        and gx in ( '包装工序',
                    '半加工工序',
                    '半成品库工序',
                    '加工工序',
                    '包胶工序',
                    '表面处理工序',
                    '配件' )
    ) f
    on f.dw = a.work_org_name
    
)

select 
        dim.gx
        ,dim.period
        ,dim.dw,
        main.now_inventory_last,
        main.non_planned_inventory_last,
        main.now_inventory,
        main.non_planned_inventory,
        main.self_produced_piece_count,
        main.self_produced_weight_t,
        main.purchased_piece_count,
        main.purchased_weight_t,
        main.self_produced_piece_m,
        main.self_produced_m_t,
        main.purchased_piece_m,
        main.purchased_m_t,
        sysdate,
        sysdate
     from TMP_Dim dim left join main on dim.period=main.period and dim.dw=main.work_org_name;



INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,NOW_INVENTORY
       ,NOW_INVENTORY_LAST
       
)


WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT a.PERIOD 
         ,CASE WHEN A.WORK_ORG_NAME NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE WHEN B.CB ='孝直分厂' THEN '孝直分厂'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM MDDWD.DWD_MAIN_TRANSFER_SUMMARY A 
  LEFT JOIN TMP_CB B
  ON A.WORK_ORG_NAME=B.DW 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')
    union all
    
    SELECT period,
    '孝直分厂',
    WEIGHT,
    PIECE_COUNT
    FROM mddwd.DWD_MAIN_TRANSFER_SUMMARY where WORK_ORG_NAME='半成品加工七组'

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   WHERE WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME
-------------------------------------------------------------------------------20251018
TRUNCATE TABLE ADS_MKFM_PRODUTION_SUM;




INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PROCESS_TYPE,
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)


WITH TMP_Dim AS
(
    SELECT
        B.PERIOD_DATE AS PERIOD
        ,A.GX
        ,A.DW
        FROM ods_erp.ODS_CBZZBB2 A
        CROSS JOIN MDDIM.dim_day_d B
        WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1  
        and nvl(scx,zzb) = '迈克阀门'
        and gx in ( '包装工序','半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件' )
        and sfjscl is not null
    ),
main as(
    select f.gx,
        coalesce(e.period,a.period) as period,
        coalesce(a.work_org_name,e.rkdw) as work_org_name,
        a.now_inventory_last,
        a.non_planned_inventory_last,
        a.now_inventory,
        a.non_planned_inventory,
        e.self_produced_piece_count,
        e.self_produced_weight_t,
        e.purchased_piece_count,
        e.purchased_weight_t,
        e.self_produced_piece_m,
        e.self_produced_m_t,
        e.purchased_piece_m,
        e.purchased_m_t

    from mddws.dws_mkfm_semifinish_inventory a
    left join (
        select b.period,
                b.rkdw,
                sum(b.self_produced_piece_count) as self_produced_piece_count,
                sum(b.self_produced_weight_t) as self_produced_weight_t,
                sum(b.purchased_piece_count) as purchased_piece_count,
                sum(b.purchased_weight_t) as purchased_weight_t,
                sum(b.self_produced_piece_m) as self_produced_piece_m,
                sum(b.self_produced_m_t) as self_produced_m_t,
                sum(b.purchased_piece_m) as purchased_piece_m,
                sum(b.purchased_m_t) as purchased_m_t
            from mddws.dws_mkfm_production_monthly b
            left join (
                select gx,
                        dw,
                        scx
                from ods_erp.ods_cbzzbb2    
                where nvl(scx,zzb) = '迈克阀门'and gx in ( '包装工序' )--,'半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件'
            ) bb
            on b.rkdw = bb.dw
                where bb.gx is not null
                group by b.period,
                        b.rkdw
    union all
    select 
        period,
        work_org_name as rkdw,
        null,
        sum(case when cc.gx in('包胶工序','表面处理工序') then weight-B01_WEIGHT else weight END) / 1000 as self_produced_weight_t,
        null,
        null,
        null,
        sum(sum(case when cc.gx in('包胶工序','表面处理工序') then weight-B01_WEIGHT else weight END))over(partition by trunc(period,'MM'),work_org_name order by period
                rows between unbounded preceding and current row
            ) / 1000 as self_produced_m_t,
        null,
        null
    from mddwd.dwd_main_transfer_summary c
    left join (
    select gx,
            dw,
            scx
        from ods_erp.ods_cbzzbb2
    where nvl(scx,zzb) = '迈克阀门'and gx in ( '半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件' )--,包装工序
    ) cc
    on c.work_org_name = cc.dw
        where cc.gx is not null
        group by trunc(period,'MM'),
                period,
                work_org_name
    ) e
    on a.period = trunc(e.period,'MM')
    and a.work_org_name = e.rkdw
    left join (
    select gx,
            dw,
            scx
        from ods_erp.ods_cbzzbb2
        where nvl(scx,zzb) = '迈克阀门'
        and gx in ( '包装工序','半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件' )
    ) f
    on f.dw = a.work_org_name
    
)

select 
        dim.gx
        ,dim.period
        ,dim.dw,
        main.now_inventory_last,
        main.non_planned_inventory_last,
        main.now_inventory,
        main.non_planned_inventory,
        main.self_produced_piece_count,
        main.self_produced_weight_t,
        main.purchased_piece_count,
        main.purchased_weight_t,
        main.self_produced_piece_m,
        main.self_produced_m_t,
        main.purchased_piece_m,
        main.purchased_m_t,
        sysdate,
        sysdate
     from TMP_Dim dim left join main on dim.period=main.period and dim.dw=main.work_org_name;



INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,NOW_INVENTORY
       ,NOW_INVENTORY_LAST
       
)


WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT a.PERIOD 
         ,CASE WHEN A.WORK_ORG_NAME NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE WHEN B.CB ='孝直分厂' THEN '孝直分厂'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM MDDWD.DWD_MAIN_TRANSFER_SUMMARY A 
  LEFT JOIN TMP_CB B
  ON A.WORK_ORG_NAME=B.DW 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')
    union all
    
    SELECT period,
    '孝直分厂',
    WEIGHT,
    PIECE_COUNT
    FROM mddwd.DWD_MAIN_TRANSFER_SUMMARY where WORK_ORG_NAME='半成品加工七组'

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   WHERE WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME




----------------------------------------------------------------------------------------------------20251023




TRUNCATE TABLE ADS_MKFM_PRODUTION_SUM;




INSERT INTO ADS_MKFM_PRODUTION_SUM (
    PROCESS_TYPE,
    PERIOD,
    WORK_ORG_NAME,
    NOW_INVENTORY_LAST,
    NON_PLANNED_INVENTORY_LAST,
    NOW_INVENTORY,
    NON_PLANNED_INVENTORY,
    SELF_PRODUCED_PIECE_COUNT,
    SELF_PRODUCED_WEIGHT_T,
    PURCHASED_PIECE_COUNT,
    PURCHASED_WEIGHT_T,
    SELF_PRODUCED_PIECE_M,
    SELF_PRODUCED_M_T,
    PURCHASED_PIECE_M,
    PURCHASED_M_T,
    ETL_CRT_DT,
    ETL_UPD_DT
)


WITH TMP_Dim AS
(
    SELECT
        B.PERIOD_DATE AS PERIOD
        ,A.GX
        ,A.DW
        FROM ods_erp.ODS_CBZZBB2 A
        CROSS JOIN MDDIM.dim_day_d B
        WHERE B.PERIOD_DATE>=DATE '2025-01-1' and b.period_date<sysdate-1  
        and nvl(scx,zzb) = '迈克阀门'
        and gx in ( '包装工序','半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件' )
    ),
main as(
    select DIM.gx,
        DIM.period,
        DIM.DW,
        a.now_inventory_last,
        a.non_planned_inventory_last,
        a.now_inventory,
        a.non_planned_inventory,
        e.self_produced_piece_count,
        e.self_produced_weight_t,
        e.purchased_piece_count,
        e.purchased_weight_t,
        e.self_produced_piece_m,
        e.self_produced_m_t,
        e.purchased_piece_m,
        e.purchased_m_t
    --from TMP_Dim dim 
    --left join  mddws.dws_mkfm_semifinish_inventory a on trunc(dim.period,'MM')=a.period and dim.dw=a.work_org_name
FROM TMP_Dim dim
LEFT JOIN mddws.dws_mkfm_semifinish_inventory a 
ON dim.dw = a.work_org_name
AND (
    -- 当 period < 2025-10-25 时，使用月份截断匹配
    (dim.period < DATE '2025-10-25' AND TRUNC(dim.period, 'MM') = a.period)
    OR
    -- 当 period >= 2025-10-25 时，使用精确日期匹配
    (dim.period >= DATE '2025-10-25' AND dim.period = a.period)
)--添加每天的备份
    left join (
        select b.period,
                b.rkdw,
                sum(b.self_produced_piece_count) as self_produced_piece_count,
                sum(b.self_produced_weight_t) as self_produced_weight_t,
                sum(b.purchased_piece_count) as purchased_piece_count,
                sum(b.purchased_weight_t) as purchased_weight_t,
                sum(b.self_produced_piece_m) as self_produced_piece_m,
                sum(b.self_produced_m_t) as self_produced_m_t,
                sum(b.purchased_piece_m) as purchased_piece_m,
                sum(b.purchased_m_t) as purchased_m_t
            from mddws.dws_mkfm_production_monthly b
            left join (
                select gx,
                        dw,
                        scx
                from ods_erp.ods_cbzzbb2    
                where nvl(scx,zzb) = '迈克阀门'and gx in ( '包装工序' )--,'半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件'
            ) bb
            on b.rkdw = bb.dw
                where bb.gx is not null
                group by b.period,
                        b.rkdw
    union all
    select 
        period,
        work_org_name as rkdw,
        null,
        sum(case when cc.gx in('表面处理工序') then weight-B01_WEIGHT else weight END) / 1000 as self_produced_weight_t,
        null,
        null,
        null,
        sum(sum(case when cc.gx in('表面处理工序') then weight-B01_WEIGHT else weight END))over(partition by trunc(period,'MM'),work_org_name order by period
                rows between unbounded preceding and current row
            ) / 1000 as self_produced_m_t,
        null,
        null
    from mddwd.dwd_main_transfer_summary c
    left join (
    select gx,
            dw,
            scx
        from ods_erp.ods_cbzzbb2
    where nvl(scx,zzb) = '迈克阀门'and gx in ( '半加工工序','半成品库工序','加工工序','包胶工序','表面处理工序','配件' )--,包装工序
    ) cc
    on c.work_org_name = cc.dw
        where cc.gx is not null
        group by trunc(period,'MM'),
                period,
                work_org_name
    ) e
    on DIM.period = e.period
    and DIM.DW = e.rkdw
    
)

select 
        main.gx
        ,main.period
        ,main.dw,
        main.now_inventory_last,
        main.non_planned_inventory_last,
        main.now_inventory,
        main.non_planned_inventory,
        main.self_produced_piece_count,
        main.self_produced_weight_t,
        main.purchased_piece_count,
        main.purchased_weight_t,
        main.self_produced_piece_m,
        main.self_produced_m_t,
        main.purchased_piece_m,
        main.purchased_m_t,
        sysdate,
        sysdate
     from   main ;


INSERT INTO ADS_MKFM_PRODUTION_SUM(
       PERIOD
       ,WORK_ORG_NAME
       ,self_produced_weight_t
       ,SELF_PRODUCED_M_T
       
)

WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT a.rq 
         ,CASE WHEN A.ZCDW NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE --WHEN B.CB ='孝直分厂' THEN '孝直分厂'  孝直全部去除只要'半成品加工七组'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,zl
  FROM ods_erp.ods_qcsjb_ckyw A 
  LEFT JOIN TMP_CB B
  ON A.ZCDW=B.DW 
  WHERE 
      A.LQDW IN('迈克阀门毛坯周转组','迈克阀门分流组')
    union all
    
    SELECT rq,
    '孝直分厂',
    zl
    FROM ods_erp.ods_qcsjb_ckyw where ZCDW='半成品加工七组' and LQDW IN('迈克阀门毛坯周转组','迈克阀门分流组')

)


SELECT to_date(rq,'YY.MM.DD') AS PERIOD,
       WORK_ORG_NAME,
       SUM(ZL)/1000 AS NOW_INVENTOY,
       SUM(SUM(ZL)/1000) OVER(PARTITION BY WORK_ORG_NAME, trunc(to_date(rq,'YY.MM.DD'),'MM')
                                 ORDER BY  to_date(rq,'YY.MM.DD')
                                 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS MONTHLY_CUMULATIVE
FROM TMP_DWD 
WHERE WORK_ORG_NAME IS NOT NULL-- AND to_date(rq,'YY.MM.DD')+0.5<SYSDATE-1
GROUP BY to_date(rq,'YY.MM.DD'), WORK_ORG_NAME












--------------------------------------------------------------------------------------20251027



WITH TMP_CB AS(
     SELECT DISTINCT DW,CB FROM ODS_ERP.ODS_FRGXGB WHERE CB IN('孝直分厂','玫德临沂')
),
TMP_IN AS(
       SELECT DISTINCT DW FROM ODS_ERP.ODS_FRGXGB
)

,
TMP_DWD AS(
  SELECT a.rq 
         ,CASE WHEN A.ZCDW NOT IN (SELECT DW FROM TMP_IN) THEN '外协'
               ELSE (CASE --WHEN B.CB ='孝直分厂' THEN '孝直分厂'  孝直全部去除只要'半成品加工七组'
                          WHEN B.CB='玫德临沂' THEN '临沂分厂'
                     END)
          END AS WORK_ORG_NAME
          ,zl
  FROM ods_erp.ods_qcsjb_ckyw A 
  LEFT JOIN TMP_CB B
  ON A.ZCDW=B.DW 
  WHERE 
      A.LQDW IN('迈克阀门毛坯周转组','迈克阀门分流组')
    union all
    
    SELECT rq,
    '孝直分厂',
    zl
    FROM ods_erp.ods_qcsjb_ckyw where ZCDW='半成品加工七组' and LQDW IN('迈克阀门毛坯周转组','迈克阀门分流组')

)
,
with tmp_dim as (
    SELECT A.WORK_ORG_NAME,B.PERIOD_DATE AS PERIOD FROM 
    (select '临沂分厂' as WORK_ORG_NAME from dual
    union all
    select '孝直分厂' as WORK_ORG_NAME from dual
    union all
    select '外协' as WORK_ORG_NAME from dual) A
    CROSS JOIN MDDIM.DIM_DAY_D B 
    WHERE B.PERIOD_DATE<SYSDATE-1 AND B.PERIOD_DATE>=DATE'2025-01-01'

)

SELECT DIM.PERIOD,
       DIM.WORK_ORG_NAME,
       SUM(ZL)/1000 AS NOW_INVENTOY,
       SUM(SUM(ZL)/1000) OVER(PARTITION BY WORK_ORG_NAME, trunc(to_date(rq,'YY.MM.DD'),'MM')
                                 ORDER BY  to_date(rq,'YY.MM.DD')
                                 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS MONTHLY_CUMULATIVE
FROM TMP_DIM DIM 
LEFT JOIN TMP_DWD DWD  
    ON DIM.PERIOD=DWD.to_date(DWD.rq,'YY.MM.DD')
    AND DIM.WORK_ORG_NAME=DWD.WORK_ORG_NAME

WHERE DWD.WORK_ORG_NAME IS NOT NULL-- AND to_date(rq,'YY.MM.DD')+0.5<SYSDATE-1
GROUP BY DIM.PERIOD,
       DIM.WORK_ORG_NAME
