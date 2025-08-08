CREATE OR REPLACE PROCEDURE proc_fun_fmdpyq1_2 (
    p_bs IN VARCHAR2,
    p_th IN VARCHAR2
)
AS
BEGIN
    IF p_th = '车间汇总' THEN
        -- 车间汇总逻辑
        FOR rec IN (
            SELECT * FROM (
                SELECT a.th, a.jhscrq, pz, gg, xs, SUM(pcjs) pcjs,
                       ROUND(SUM(pcjs)/de, 2) pcgs, SUM(wcsl) wcsl,
                       ROUND(SUM(NVL(wcsl,0))/de, 2) wcgs,
                       ROUND(SUM(wcsl)*100/SUM(pcjs)) jswcl,
                       TO_CHAR(MAX(gxsj), 'MM-DD HH24:MI:SS') gxsj  
                FROM (
                    SELECT jhscrq, th, scrq, pz, gg, xs, COUNT(1) pcjs, 
                           MAX(gxsj) gxsj, 
                           SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END) wcsl,
                           ROUND(SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END)*100.00/COUNT(1), 2) wcl 
                    FROM qtkblsbzj 
                    WHERE jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1'
                    GROUP BY jhscrq, scrq, pz, gg, xs, th
                ) a
                JOIN (
                    SELECT DISTINCT th, jhscrq 
                    FROM qtkblsbzj 
                    WHERE (scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(scrq, ' ') = ' ') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1' 
                    AND jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                ) b ON a.jhscrq = b.jhscrq AND a.th = b.th
                JOIN (
                    SELECT scxh th, a.pz1, gg1, bhxs, de 
                    FROM (
                        SELECT jtlx, pz pz1, gg gg1, bhxs, de 
                        FROM jgjtdeb 
                        WHERE bs = p_bs 
                        AND ksrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                        AND jzrq >= TO_CHAR(SYSDATE, 'YYMMDD')
                    ) a 
                    JOIN (
                        SELECT DISTINCT scxh, jtlx 
                        FROM jgjtsl 
                        WHERE bs = p_bs
                    ) b ON a.jtlx = b.jtlx
                ) d ON SUBSTR(a.pz, 2, 100) = d.pz1 
                    AND a.gg = d.gg1 
                    AND INSTR(d.bhxs, a.xs) > 0 
                    AND a.th = d.th
                WHERE a.scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(a.scrq, ' ') = ' '
                GROUP BY a.jhscrq, a.pz, a.gg, a.xs, d.de, a.th
            )
            UNION ALL
            SELECT '车间合计', '23.12.20', '车间合计', ' ', ' ', 
                   SUM(排产件数) pcjs, SUM(排产工时) gs, SUM(完成数量) wcsl, 
                   SUM(完成工时), 
                   CASE WHEN SUM(排产件数) = 0 THEN 0 
                   ELSE SUM(完成数量)/SUM(排产件数) END,
                   TO_CHAR(SYSDATE, 'MM-DD HH24:MI:SS') 
            FROM (
                SELECT a.th, a.jhscrq 计划生产日期, pz 品种, gg 规格, xs 形式, 
                       SUM(pcjs) 排产件数,
                       ROUND(SUM(pcjs)/de, 2) 排产工时, 
                       SUM(wcsl) 完成数量,
                       ROUND(SUM(NVL(wcsl,0))/de, 2) 完成工时,
                       ROUND(SUM(wcsl)*100/SUM(pcjs)) 件数完成率,
                       TO_CHAR(MAX(gxsj), 'MM-DD HH24:MI:SS') 更新时间  
                FROM (
                    SELECT jhscrq, th, scrq, pz, gg, xs, COUNT(1) pcjs, 
                           MAX(gxsj) gxsj, 
                           SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END) wcsl,
                           ROUND(SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END)*100.00/COUNT(1), 2) wcl 
                    FROM qtkblsbzj 
                    WHERE jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1'
                    GROUP BY jhscrq, scrq, pz, gg, xs, th
                ) a
                JOIN (
                    SELECT DISTINCT th, jhscrq 
                    FROM qtkblsbzj 
                    WHERE (scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(scrq, ' ') = ' ') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1' 
                    AND jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                ) b ON a.jhscrq = b.jhscrq AND a.th = b.th
                JOIN (
                    SELECT scxh th, a.pz1, gg1, bhxs, de 
                    FROM (
                        SELECT jtlx, pz pz1, gg gg1, bhxs, de 
                        FROM jgjtdeb 
                        WHERE bs = p_bs 
                        AND ksrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                        AND jzrq >= TO_CHAR(SYSDATE, 'YYMMDD')
                    ) a 
                    JOIN (
                        SELECT DISTINCT scxh, jtlx 
                        FROM jgjtsl 
                        WHERE bs = p_bs
                    ) b ON a.jtlx = b.jtlx
                ) d ON SUBSTR(a.pz, 2, 100) = d.pz1 
                    AND a.gg = d.gg1 
                    AND INSTR(d.bhxs, a.xs) > 0 
                    AND a.th = d.th
                WHERE a.scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(a.scrq, ' ') = ' '
                GROUP BY a.jhscrq, a.pz, a.gg, a.xs, d.de, a.th
            )
        ) LOOP
            -- 处理结果集
            NULL;
        END LOOP;
    ELSE
        -- 非车间汇总逻辑
        FOR rec IN (
            SELECT 序号 id, p_th th, 计划生产日期 jhscrq, 品种 pz, 规格 gg, 形式 xs, 
                   排产件数 pcjs, 排产工时 pcgs, 完成数量 wcsl, 完成工时 wcgs, 
                   TO_CHAR(件数完成率) || '%' jswcl, 更新时间 gxsj 
            FROM (
                SELECT ROW_NUMBER() OVER(ORDER BY pz) AS 序号, 
                       a.jhscrq 计划生产日期, pz 品种, gg 规格, xs 形式, 
                       SUM(pcjs) 排产件数,
                       ROUND(SUM(pcjs)/de, 2) 排产工时, 
                       SUM(wcsl) 完成数量,
                       ROUND(SUM(NVL(wcsl,0))/de, 2) 完成工时,
                       ROUND(SUM(wcsl)*100/SUM(pcjs)) 件数完成率,
                       TO_CHAR(MAX(gxsj), 'MM-DD HH24:MI:SS') 更新时间 
                FROM (
                    SELECT jhscrq, scrq, pz, gg, xs, COUNT(1) pcjs, 
                           MAX(gxsj) gxsj, 
                           SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END) wcsl,
                           ROUND(SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END)*100.00/COUNT(1), 2) wcl 
                    FROM qtkblsbzj 
                    WHERE th = p_th 
                    AND jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1'
                    GROUP BY jhscrq, scrq, pz, gg, xs
                ) a
                JOIN (
                    SELECT DISTINCT jhscrq 
                    FROM qtkblsbzj 
                    WHERE th = p_th 
                    AND (scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(scrq, ' ') = ' ') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1' 
                    AND jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                ) b ON a.jhscrq = b.jhscrq
                JOIN (
                    SELECT pz pz1, gg gg1, bhxs, de 
                    FROM jgjtdeb 
                    WHERE bs = p_bs 
                    AND ksrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                    AND jzrq >= TO_CHAR(SYSDATE, 'YYMMDD')
                ) d ON SUBSTR(a.pz, 2, 100) = d.pz1 
                    AND a.gg = d.gg1 
                    AND INSTR(d.bhxs, a.xs) > 0
                WHERE a.scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(a.scrq, ' ') = ' '
                GROUP BY a.jhscrq, a.pz, a.gg, a.xs, d.de
            )
            UNION ALL
            SELECT ' ', ' ', ' ', '合计', ' ', ' ', 
                   SUM(排产件数), SUM(排产工时), SUM(完成数量), 
                   ROUND(SUM(完成工时), 2), 
                   TO_CHAR(ROUND(SUM(完成数量)*100.00/SUM(排产件数))) || '%', 
                   TO_CHAR(SYSDATE, 'MM-DD HH24:MI:SS') 
            FROM (
                SELECT ROW_NUMBER() OVER(ORDER BY pz) AS 序号, 
                       a.jhscrq 计划生产日期, pz 品种, gg 规格, xs 形式, 
                       SUM(pcjs) 排产件数,
                       ROUND(SUM(pcjs)/de, 2) 排产工时, 
                       SUM(wcsl) 完成数量,
                       ROUND(SUM(NVL(wcsl,0))/de, 2) 完成工时,
                       ROUND(SUM(wcsl)*100/SUM(pcjs)) 件数完成率,
                       TO_CHAR(MAX(gxsj), 'MM-DD HH24:MI:SS') 更新时间 
                FROM (
                    SELECT jhscrq, scrq, pz, gg, xs, COUNT(1) pcjs, 
                           MAX(gxsj) gxsj, 
                           SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END) wcsl,
                           ROUND(SUM(CASE WHEN NVL(sfwc, ' ') = 'T' THEN 1 ELSE 0 END)*100.00/COUNT(1), 2) wcl 
                    FROM qtkblsbzj 
                    WHERE th = p_th 
                    AND jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1'
                    GROUP BY jhscrq, scrq, pz, gg, xs
                ) a
                JOIN (
                    SELECT DISTINCT jhscrq 
                    FROM qtkblsbzj 
                    WHERE th = p_th 
                    AND (scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(scrq, ' ') = ' ') 
                    AND bs = p_bs
                    AND NVL(hxbj, ' ') <> '1' 
                    AND jhscrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                ) b ON a.jhscrq = b.jhscrq
                JOIN (
                    SELECT pz pz1, gg gg1, bhxs, de 
                    FROM jgjtdeb 
                    WHERE bs = p_bs 
                    AND ksrq <= TO_CHAR(SYSDATE, 'YYMMDD')
                    AND jzrq >= TO_CHAR(SYSDATE, 'YYMMDD')
                ) d ON SUBSTR(a.pz, 2, 100) = d.pz1 
                    AND a.gg = d.gg1 
                    AND INSTR(d.bhxs, a.xs) > 0
                WHERE a.scrq = TO_CHAR(SYSDATE, 'YYMMDD') OR NVL(a.scrq, ' ') = ' '
                GROUP BY a.jhscrq, a.pz, a.gg, a.xs, d.de
            )
        ) LOOP
            -- 处理结果集
            NULL;
        END LOOP;
    END IF;
END proc_fun_fmdpyq1_2;
/