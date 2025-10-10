WITH TMP_CB AS(
     SELECT distinct dw,cb FROM ods_erp.ODS_FRGXGB where cb in('孝直分厂','玫德临沂')
),
TMP_in AS(
       SELECT distinct dw FROM ods_erp.ODS_FRGXGB
)

,
tmp_dwd as(
  SELECT trunc(a.period,'MM') as period 
         ,case when a.work_org_name not in (select dw from tmp_in) then '外协'
               else (case when b.cb ='孝直分厂' then '孝直分厂'
                          when b.cb='玫德临沂' then '临沂分厂'
                     end)
          end AS WORK_ORG_NAME
          ,WEIGHT
          ,PIECE_COUNT
  FROM mddwd.DWD_MAIN_TRANSFER_SUMMARY A 
  left JOIN TMP_CB B
  ON A.work_org_name=b.dw 
  WHERE 
      A.RECEIVING_ORG IN('迈克阀门毛坯周转组','迈克阀门分流组')

)
SELECT PERIOD
       ,WORK_ORG_NAME
       ,SUM(WEIGHT)/1000 AS NOW_INVENTOY
       ,LAG(SUM(WEIGHT)/1000,1) OVER(PARTITION BY WORK_ORG_NAME ORDER BY PERIOD) NOW_INVENTOY_LAST
       --,SUM(PIECE_COUNT)
   FROM TMP_DWD 
   where WORK_ORG_NAME IS NOT NULL  
GROUP BY PERIOD,WORK_ORG_NAME