## 入库目标
~~~SQL
SELECT * FROM ODS_TGRKMB_TG
~~~


##  入库flex

~~~sql
×--制造部/单位维度每一日入库
with tmp as (
select 
      to_date(a.rq,'YY.MM.DD') AS PERIOD
      ,A.RKDW
      ,A.BS
      ,c.ZZB  
      ,a.zl
from ods_erp.ods_bzrkb_tg a
left join ods_erp.ods_mlb_tg b on a.bs=b.bs
left join ods_erp.ods_cbzzbb_tg c on b.cb=c.cb
)
select
     period,
     rkdw as org,
     sum(zl),
     'dw' type
from tmp 
group by period,rkdw,'dw'
union all
select
     period,
     zzb as org,
     sum(zl),
     'zzb' type
from tmp 
group by period,zzb,'zzb'
~~~


~~~sql
--制造部/单位维度每一日入库/月累计入库
with tmp as (
select 
      yyz_to_date(a.rq,'YY.MM.DD') AS PERIOD
      ,A.RKDW
      ,A.BS
      ,c.ZZB  
      ,a.zl
from ods_erp.ods_bzrkb_tg a
left join ods_erp.ods_mlb_tg b on a.bs=b.bs
left join ods_erp.ods_cbzzbb_tg c on b.cb=c.cb

)
select
    PERIOD,
    bs,
    rkdw,
    sum(zl/1000) zl ,
    ' dw' as type,
    SUM(sum(zl))OVER(
        PARTITION BY RKDW,BS,EXTRACT(YEAR FROM PERIOD), EXTRACT(MONTH FROM PERIOD) order by period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )/1000 as zl_sum
from  TMP 
group by  PERIOD, bs,rkdw ,'dw'
union all
select
    PERIOD,
    null,
    zzb,
    sum(zl/1000) zl ,
    ' zzb' as type,
    SUM(sum(zl))OVER(
        PARTITION BY zzb,EXTRACT(YEAR FROM PERIOD), EXTRACT(MONTH FROM PERIOD) order by period
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )/1000 as zl_sum
from  TMP 
group by  PERIOD,zzb ,'zzb'
~~~


~~~ sql
------- 各厂区入库占比
SELECT 
    c.zzb,
    100 * SUM(a.zl) / (SELECT SUM(zl / 1000) zl FROM ods_erp.ods_bzrkb_tg) zb 
FROM (
    SELECT 
        bs,
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg 
    GROUP BY bs 
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb 
GROUP BY c.zzb

------- 各单位入库占比
SELECT 
    c.zzb,
    a.bs,
    100 * a.zl / (
        SELECT SUM(zl) 
        FROM (
            SELECT 
                bs,
                SUM(zl / 1000) zl 
            FROM ods_erp.ods_bzrkb_tg 
            GROUP BY bs 
        ) a 
        JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
        JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb 
        WHERE c.zzb = '玛钢制造部'
    ) zb 
FROM (
    SELECT 
        bs,
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg 
    GROUP BY bs 
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb 
WHERE c.zzb = '玛钢制造部'


---总制造部-各制造部下内部单位占比
SELECT 
    c.zzb,
    a.bs,
    a.rq_month,
    a.zl,
    100 * a.zl / SUM(a.zl) OVER(PARTITION BY c.zzb, a.rq_month) AS zb
FROM (
    SELECT 
        bs,
        TO_CHAR(rq, 'YYYY-MM') AS rq_month,  -- 按月分组
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg 
    GROUP BY bs, TO_CHAR(rq, 'YYYY-MM')  -- 按bs和月份分组
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb
~~~

~~~sql


------ 折线图数据（总体）
SELECT 
    rq,
    '总体' as dw,
    SUM(zl / 1000) zl,
    'zzb' as type 
FROM ods_erp.ods_bzrkb_tg  
GROUP BY rq    
union all
------ 折线图数据（制造部）
SELECT 
    a.rq,
    c.zzb as dw,
    SUM(zl) zl ,
    'zzb' as type

FROM (
    SELECT 
        bs,
        rq,
        SUM(zl / 1000) zl 
    FROM ods_erp.ods_bzrkb_tg  
    GROUP BY bs, rq   
) a 
JOIN ods_erp.ods_mlb_tg b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb  
WHERE c.zzb = '玛钢制造部'   
GROUP BY rq, c.zzb
union all
------ 折线图数据（单位）
SELECT 
    rq,
    rkdw as dw,
    SUM(zl / 1000) zl ，
    'dw'as type
FROM ods_erp.ods_bzrkb_tg 
GROUP BY rq,rkdw    
~~~
## 成品flex


~~~sql
------ 库存 - 成品 - 期初库存与期末库存 

SELECT 
    SUM(zjc * dz / 1000) AS qckc,
    SUM(jjc * dz / 1000) AS qmkc  
FROM ODS_ERP.ODS_tpc_hwjcb_CKYW_TG  
WHERE ckmc NOT LIKE '%待%'

------ 出口、内销实时库存 
SELECT 
    SUM(qckc) AS qckc,
    SUM(qmkc) AS qmkc,
    lb 
FROM (
    SELECT 
        SUM(zjc * dz / 1000) AS qckc,
        SUM(jjc * dz / 1000) AS qmkc,
        CASE 
            WHEN ckmc LIKE '%出口%' THEN '出口' 
            ELSE '内销'  
        END AS lb  
    FROM ODS_ERP.ODS_tpc_hwjcb_CKYW_TG  
    WHERE ckmc LIKE '%出口%' OR ckmc LIKE '%内销%' 
    GROUP BY ckmc 
) a  
GROUP BY lb 

------ 查看成品库存表所有数据
SELECT * FROM ODS_ERP.ODS_CPKCBI_TG
~~~


## 半成品flex



~~~sql


----- 库存 - 半成品 - 期初库存与期末库存 
SELECT 
    to_date(TABLE_TIME,'YYYYMM') as period,
    SUM(zjc * dz / 1000) AS qckc,
    SUM(jjc * dz / 1000) AS qmkc  
FROM ODS_ERP.ODS_JCB_CKYW_TG
WHERE bs IN (
    SELECT DISTINCT bs  
    FROM ODS_ERP.ODS_MLB_TG 
    WHERE jclb <> '芯子'
)
group by to_date(TABLE_TIME,'YYYYMM')

------- 制造部维度 - 半成品库存
SELECT 
    period,
    c.zzb,
    SUM(qckc) AS qckc,
    SUM(qmkc) AS qmkc 
FROM (
    SELECT 
        bs,
        SUM(zjc * dz / 1000) AS qckc,
        SUM(jjc * dz / 1000) AS qmkc,  
        to_date(TABLE_TIME,'YYYYMM') as period
    FROM ODS_ERP.ODS_JCB_CKYW_TG
    WHERE bs IN (
        SELECT DISTINCT bs  
        FROM ODS_ERP.ODS_MLB_TG 
        WHERE jclb <> '芯子'
    ) 
   -- AND ISNULL(bs, '') <> '' 
    AND bs IS NOT NULL
    AND bs <> ' '
    AND (jjc <> 0 OR zjc <> 0) 
    GROUP BY bs,to_date(TABLE_TIME,'YYYYMM')
) a 
JOIN ODS_ERP.ODS_MLB_TG b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb   
GROUP BY c.zzb ,period

------ 库存 - 盈亏数据
SELECT 
    to_date(rq,'YY.MM.DD') AS PERIOD,
    SUM(js * dz / 1000) AS yks 
FROM ods_erp.ods_tzdsjb_tg  
WHERE bs IN (
    SELECT DISTINCT bs  
    FROM ODS_ERP.ODS_MLB_TG 
    WHERE jclb <> '芯子'
)
GROUP BY to_date(rq,'YY.MM.DD') 

------- 制造部维度 - 盈亏数据
SELECT 
    PERIOD,
    c.zzb,
    SUM(yks) AS yks 
FROM (
    SELECT 
        to_date(rq,'YY.MM.DD') AS PERIOD,
        bs,
        SUM(js * dz / 1000) AS yks 
    FROM ODS_ERP.ODS_tzdsjb_TG  
    WHERE bs IN (
        SELECT DISTINCT bs  
        FROM ODS_ERP.ODS_MLB_TG 
        WHERE jclb <> '芯子'
    ) 
    GROUP BY bs,to_date(rq,'YY.MM.DD')
) a 
JOIN ODS_ERP.ODS_MLB_TG b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb   
GROUP BY c.zzb ,PERIOD

------------ 计内存 - 计外存
SELECT 
    to_date(TABLE_TIME,'YYYYMM') AS PERIOD,
    SUM(jnc * dz / 1000) AS jncz,
    SUM(jwc * dz / 1000) AS jwcz  
FROM ODS_ERP.ODS_JCB_CKYW_TG
WHERE bs IN (
    SELECT DISTINCT bs  
    FROM ODS_ERP.ODS_MLB_TG 
    WHERE jclb <> '芯子'
)GROUP BY to_date(TABLE_TIME,'YYYYMM')

------- 制造部维度 - 计内存计外存
SELECT 
    c.zzb,
    SUM(jncz) AS jncz,
    SUM(jwcz) AS jwcz 
FROM (
    SELECT 
        to_date(TABLE_TIME,'YYYYMM') AS PERIOD,
        bs,
        SUM(jnc * dz / 1000) AS jncz,
        SUM(jwc * dz / 1000) AS jwcz  
    FROM ODS_ERP.ODS_JCB_CKYW_TG
    WHERE bs IN (
        SELECT DISTINCT bs  
        FROM ODS_ERP.ODS_MLB_TG 
        WHERE jclb <> '芯子'
    ) 
    GROUP BY bs,to_date(TABLE_TIME,'YYYYMM')
) a 
JOIN ODS_ERP.ODS_MLB_TG b ON a.bs = b.bs 
JOIN ods_erp.ods_cbzzbb_tg c ON b.cb = c.cb   
GROUP BY c.zzb 

------- 折线图数据 - 库存汇总
SELECT 
    rq,
    SUM(zl) AS jjcz,
    SUM(zl - jwcz) AS jncz,
    SUM(jwcz) AS jwcz   
FROM ods_erp.ods_jchzjl_tg 
WHERE TO_DATE(RQ,'YY.MM.DD')<SYSDATE-30
GROUP BY rq 

------- 制造部维度 - 折线图数据
SELECT 
    a.rq,
    c.zzb,
    SUM(jjcz) AS jjcz,
    SUM(jncz) AS jncz,
    SUM(jwcz) AS jwcz 
FROM (
    SELECT 
        rq,
        cb,
        SUM(zl) AS jjcz,
        SUM(zl - jwcz) AS jncz,
        SUM(jwcz) AS jwcz   
    FROM ods_erp.ods_jchzjl_tg 
    GROUP BY rq, cb  
) a 
JOIN ods_erp.ods_cbzzbb_tg c ON a.cb = c.cb   
WHERE TO_DATE(RQ,'YY.MM.DD')<SYSDATE-30
GROUP BY c.zzb, a.rq  

~~~