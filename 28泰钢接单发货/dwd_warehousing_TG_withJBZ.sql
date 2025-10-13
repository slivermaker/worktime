with all_to_one as (
     select ddh ,
            case when KHJC='丛德贸易' then '1' else fjz end as isjbz,
            fbuynum AS jbz_cnt ,
            TOTALNW as jbz_wgt
            from  ods_erp.ods_soctrl_tg
)
select substr(a.rq,1,5),a.rkdw,sum(a.zl)/1000,max(b.isjbz),sum(b.jbz_cnt),sum(b.jbz_wgt)/1000 from ODS_BZRKB_TG A left join all_to_one b on a.ddh=b.ddh where rq>'25.08'
group by substr(a.rq,1,5),a.rkdw


