
 with date_range as (
    select to_date('20250910','YYYYMMDD') - 90 as start_date,
            to_date('20250910','YYYYMMDD') as end_date
      from dual
  ),all_tab as (
    select distinct tab_name
      from mddwd.tf_dwd_dwm_data_change
  ),recent_stats as (
    select tab_name,
            count(period) as change_days,
            avg(abs(growth_rate)) as avg_abs_growth
      from mddwd.tf_dwd_dwm_data_change
      where period between (
        select start_date
          from date_range
    ) and (
        select end_date
          from date_range
    )
      group by tab_name
  ),first_occurrence as (
    select tab_name,
            min(period) as first_date
      from mddwd.tf_dwd_dwm_data_change
      group by tab_name
  )
  select a.tab_name as name,
        nvl(
            r.change_days,
            0
        ) as "变化天数",
        nvl(
            r.avg_abs_growth,
            0
        ) as "平均变化率",
        case
            when r.tab_name is null then
              '无记录'
            when r.change_days <= 1 then
              '低变化率'
        end as "REASON",
        f.first_date as "首次出现日期"
    from all_tab a
    left join recent_stats r
  on a.tab_name = r.tab_name
    left join first_occurrence f
  on a.tab_name = f.tab_name
  where ( r.tab_name is null
      or ( r.change_days <= 3
    and r.avg_abs_growth < 0.001 ) )
    and f.first_date < (
    select start_date
      from date_range
  )
    and a.tab_name not like '%DIM%'
    and a.tab_name in (
       SELECT  TABLE_NAME FROM all_tables tt
               where tt.OWNER in('MDADS','ODS_ERP','MDDW','ODS_MOM','ODS_ERP2013','ODS_EBS','ODS_PS','ODS_IMS','MDDM','MDDWD')
        )
  order by "变化天数" asc,
            "平均变化率" asc













------------------------------------
  SELECT T2.DIRECTORY_NAME 作业目录,
        T1.NAME 作业,
        TO_CHAR(T1.DESCRIPTION) 作业描述,
        T3.NAME 组件名,
        NVL(T6.NAME, TO_CHAR(T5.VALUE_STR)) 转换名
    FROM KETTLE_BI.R_JOB T1
LEFT JOIN KETTLE_BI.R_DIRECTORY T2
      ON T1.ID_DIRECTORY = T2.ID_DIRECTORY
    JOIN KETTLE_BI.R_JOBENTRY T3
      ON T3.ID_JOBENTRY_TYPE = 47
    AND T1.ID_JOB = T3.ID_JOB
    JOIN KETTLE_BI.R_JOBENTRY_ATTRIBUTE T5
      ON T1.ID_JOB = T5.ID_JOB
    AND T3.ID_JOBENTRY = T5.ID_JOBENTRY
    AND T5.CODE IN ('name', 'trans_object_id')
LEFT JOIN KETTLE_BI.R_TRANSFORMATION T6
      ON TO_CHAR(T5.VALUE_STR) = TO_CHAR(T6.ID_TRANSFORMATION)
  WHERE T5.CODE IS NOT NULL
    AND T5.VALUE_STR IS NOT NULL 
    -- AND NVL(T6.NAME, TO_CHAR(T5.VALUE_STR)) = 'JOB_ODS_OA_D';
    
    
  SELECT *
  -- T.*,T1.NAME,VALUE_STR 
    FROM R_STEP_ATTRIBUTE T 
LEFT JOIN R_TRANSFORMATION T1 
      ON T.ID_TRANSFORMATION=T1.ID_TRANSFORMATION
  --= WHERE UPPER(T.VALUE_STR) LIKE UPPER('%DT_USER%')  
   
   
SELECT * FROM R_JOBENTRY
SELECT * FROM R_TRANSFORMATION
SELECT * FROM  R_TRANSFORMATION
SELECT 
  t.NAME AS "转换名称",
  t.ID_TRANSFORMATION AS "转换ID",
  t.MODIFIED_USER AS "最后修改用户",
  t.MODIFIED_DATE AS "最后修改时间"
FROM 
  R_TRANSFORMATION t
LEFT JOIN 
  R_JOBENTRY j ON (
    j.ID_TRANSFORMATION = t.ID_TRANSFORMATION  
    AND j.TYPE = 'TRANS'                      
  )
WHERE 
  j.ID_JOB IS NULL 
ORDER BY 
  t.NAME;





