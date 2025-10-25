√-------每月入库目标          
select *  from   tggl.ckyw.dbo.tgrkmb 


-----------------------------------------------------------------------------------------bzrkb---------------------------------------
√-------本月累计入库
select sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb
√----某一日入库 
select sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb  where  rq='25.10.20' 

√-------本月累计入库 制造部维度
select c.zzb,sum(a.zl) zl from (
    select bs,
        sum(zl/1000) zl 
    from  tggl.ckyw.dbo.bzrkb  
    group by  bs ) a 
join tggl.ckyw.dbo.mlb b on a.bs=b.bs 
join  tggl.ckyw.dbo.cbzzbb c on   b.cb=c.cb   
group  by c.zzb 
 
√----某一日入库  制造部维度 
select c.zzb,sum(a.zl) zl from (
        select 
            bs,
            sum(zl/1000) zl 
        from  tggl.ckyw.dbo.bzrkb  
        where  rq='25.10.20'   
        group by  bs ) a 
    join tggl.ckyw.dbo.mlb b on a.bs=b.bs 
    join  tggl.ckyw.dbo.cbzzbb c on   b.cb=c.cb   
    group  by c.zzb 
 
√-------本月累计入库 单位维度
select bs,rkdw,sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb  group by  bs,rkdw 
 
√----某一日入库  单位维度 
select bs,rkdw,sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb  where  rq='25.10.20'   group by  bs,rkdw 

√------- 各厂区入库占比
SELECT 
    c.zzb,
    100 * SUM(a.zl) / (SELECT SUM(zl / 1000) zl FROM tggl.ckyw.dbo.bzrkb) zb 
FROM (
    SELECT 
        bs,
        SUM(zl / 1000) zl 
    FROM tggl.ckyw.dbo.bzrkb 
    GROUP BY bs 
) a 
JOIN tggl.ckyw.dbo.mlb b ON a.bs = b.bs 
JOIN tggl.ckyw.dbo.cbzzbb c ON b.cb = c.cb 
GROUP BY c.zzb

√------- 各单位入库占比
SELECT 
    c.zzb,
    a.bs,
    100 * a.zl / (
        SELECT SUM(zl) 
        FROM (
            SELECT 
                bs,
                SUM(zl / 1000) zl 
            FROM tggl.ckyw.dbo.bzrkb 
            GROUP BY bs 
        ) a 
        JOIN tggl.ckyw.dbo.mlb b ON a.bs = b.bs 
        JOIN tggl.ckyw.dbo.cbzzbb c ON b.cb = c.cb 
        WHERE c.zzb = '玛钢制造部'
    ) zb 
FROM (
    SELECT 
        bs,
        SUM(zl / 1000) zl 
    FROM tggl.ckyw.dbo.bzrkb 
    GROUP BY bs 
) a 
JOIN tggl.ckyw.dbo.mlb b ON a.bs = b.bs 
JOIN tggl.ckyw.dbo.cbzzbb c ON b.cb = c.cb 
WHERE c.zzb = '玛钢制造部'

√------折线图数据  
select rq,sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb  group by  rq    order by rq

√------折线图数据--制造部  
select a.rq,c.zzb,sum(zl) zl from (
select bs,rq,sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb  group by  bs,rq   ) a join tggl.ckyw.dbo.mlb b on a.bs=b.bs join  tggl.ckyw.dbo.cbzzbb c on   b.cb=c.cb  where   c.zzb='玛钢制造部'   group by rq ,c.zzb

√------折线图数据--单位·
select rq,sum(zl/1000) zl from  tggl.ckyw.dbo.bzrkb where rkdw='QZ包装组B9'    group by  rq    order by rq
其它月份就是  tggl.ckyw.dbo.bzrkb ------tggl.ckyw2025.dbo.bzrkb2509 







√-----库存 ---成品 -----期初库存与期末库存 
select sum(zjc*dz/1000) qckc,sum(jjc*dz/1000) qmkc  from  ckyw.dbo.tpc_hwjcb  where ckmc  not like'%待%'

√------出口 内销  实时库存 
select sum(qckc) qckc,sum(qmkc) qmkc,lb from (
select sum(zjc*dz/1000) qckc,sum(jjc*dz/1000) qmkc,case when ckmc like'%出口%' then '出口' else    '内销'  end lb  from  ckyw.dbo.tpc_hwjcb  where ckmc  like'%出口%'   or   ckmc  like'%内销%' 
 group  by  ckmc ) a  group  by lb 
√----------

select * from   ckyw.dbo.cpkcbi






-----库存 ---半成品 -----期初库存与期末库存 
select sum(zjc*dz/1000) qckc,sum(jjc*dz/1000) qmkc  from  ckyw.dbo.jcb  where  bs in (select distinct bs  from  ckyw.dbo.mlb  where  jclb<>'芯子'  )

-------制造部维度
select c.zzb,sum(qckc) qckc,sum(qmkc) qmkc from (
select bs,sum(zjc*dz/1000) qckc,sum(jjc*dz/1000) qmkc  from  ckyw.dbo.jcb  where  bs in (select distinct bs  from  ckyw.dbo.mlb  where  jclb<>'芯子'  ) 
and  isnull(bs,'')<>'' and (jjc<>0 or zjc<>0) group by  bs  ) a join ckyw.dbo.mlb b on a.bs=b.bs join  ckyw.dbo.cbzzbb c on   b.cb=c.cb   group  by c.zzb 

------库存  盈亏数据

select sum(js*dz/1000) yks from  ckyw.dbo.tzdsjb  where  bs in (select distinct bs  from  ckyw.dbo.mlb  where  jclb<>'芯子'  )

-------制造部维度
select c.zzb,sum(yks) yks from (
select bs,sum(js*dz/1000) yks from  ckyw.dbo.tzdsjb  where  bs in (select distinct bs  from  ckyw.dbo.mlb  where  jclb<>'芯子'  ) group by  bs  ) a 
join ckyw.dbo.mlb b on a.bs=b.bs join  ckyw.dbo.cbzzbb c on   b.cb=c.cb   group  by c.zzb 
------------计内存----计外存

select sum(jnc*dz/1000) jncz,sum(jwc*dz/1000) jwcz  from  ckyw.dbo.jcb  where  bs in (select distinct bs  from  ckyw.dbo.mlb  where  jclb<>'芯子'  )

-------制造部维度
select c.zzb,sum(jncz) jncz,sum(jwcz) jwcz from (
select bs,sum(jnc*dz/1000) jncz,sum(jwc*dz/1000) jwcz  from  ckyw.dbo.jcb  where  bs in (select distinct bs  from  ckyw.dbo.mlb  where  jclb<>'芯子'  ) group by  bs  ) a 
join ckyw.dbo.mlb b on a.bs=b.bs join  ckyw.dbo.cbzzbb c on   b.cb=c.cb   group  by c.zzb 

-------折线图数据

select rq,sum(zl) jjcz,sum(zl-jwcz) jncz,sum(jwcz) jwcz   from   ckyw2025.dbo.jchzjlb2510  group  by  rq 

-------制造部维度
select a.rq,c.zzb,sum(jjcz) jjcz,sum(jncz) jncz,sum(jwcz) jwcz from (
 select rq,cb,sum(zl) jjcz,sum(zl-jwcz) jncz,sum(jwcz) jwcz   from   ckyw2025.dbo.jchzjlb2510  group  by  rq  ,  cb  ) a 
join   ckyw.dbo.cbzzbb c on   a.cb=c.cb   group  by c.zzb,a.rq  order  by a.rq 