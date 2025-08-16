UPDATE ods_erp.stkcflb a
SET 
    (a.kczb, a.dxl) = (
        SELECT kczb, dxl
        FROM (
            SELECT 
                kczb, 
                dxl,
                ROW_NUMBER() OVER (
                    PARTITION BY cplx 
                    ORDER BY ksrq DESC, jzrq DESC
                ) AS rn
            FROM ods_erp.stkcflb b
            WHERE 
                b.cplx = a.cplx
                AND b.ksrq <= a.ksrq
                AND b.jzrq >= a.jzrq
                AND NVL(b.kczb, 0) <> 0
        )
        WHERE rn = 1 
    )
WHERE 
    NVL(a.kczb, 0) = 0;



update stkcflb a set kczb=b.kczb,dxl=b.dxl from stkcflb a join 
(select distinct cplx,kczb,dxl from stkcflb where ksrq<='2025.08.15' and jzrq>='2025.08.15' and isnull(kczb,0)<>0) b on a.cplx=b.cplx 
where isnull(a.kczb,0)=0 and a.ksrq<='2025.08.15' and a.jzrq>='2025.08.15'