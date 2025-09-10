SELECT SCX,CQ,COUNT(*) TQGS 
FROM (
    SELECT * 
        FROM (
                SELECT *,
                    ROW_NUMBER() OVER (PARTITION BY DDH ORDER BY KHRQ DESC) AS ROWNUM  
                    FROM CKYW.DBO.DDTQKHHZB 
                    WHERE SUBSTRING(KHRQ,1,5)='25.09' AND TQLB IN(SELECT DISTINCT TQLB FROM DDTQZRBMJCK))M 
        WHERE M.ROWNUM = 1   
        AND M.TQLB 
        NOT LIKE '%剔除%' 
        AND M.TQLB<>'漏收托' 
        AND M.TQLB<>'晚核销' 
        AND JHQ>='25.09.01')N GROUP BY N.SCX, N.CQ